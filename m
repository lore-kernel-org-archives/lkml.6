Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9204C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675C92077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="k/TJUZaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675C92077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeIBRoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:44:37 -0400
Received: from mail-eopbgr680092.outbound.protection.outlook.com ([40.107.68.92]:55808
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728630AbeIBRVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsxMGUGrWubgHrm2U8OZq9rf/1TALdn9RxleSRs/Pgs=;
 b=k/TJUZaU/09lykexs9skqT+2BG6VZB0vAILhUzhwokbloyElvwnZIP8he/LYN0ZvRjy3Koo8MSSfOmhwNQQ7y5I15lzn7F492MyZqxyyvJONMnXMEBYBA/UecXC/bDEWlQs79FgspuzVsnTuEtPA11H41TjVjWWwsk/4Ks+qjRU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:05:41 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:41 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 116/131] ALSA: xen: Use standard
 pcm_format_to_bits() for ALSA format bits
Thread-Topic: [PATCH AUTOSEL 4.18 116/131] ALSA: xen: Use standard
 pcm_format_to_bits() for ALSA format bits
Thread-Index: AQHUQr2emjt+X4cKfkCzN6Z6xvflJg==
Date:   Sun, 2 Sep 2018 13:05:27 +0000
Message-ID: <20180902064601.183036-116-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:D9uVqMEXLVCaX2WQarfeBiRQEjBpa3fDMbEyU17IgGTboNMlUgKwj3Br03Eg6Zhud/NgKnsT1nPp6KeIUllH64Us95o+HGgtysDEmxgB8p8w5cmkekMvGNNavVaP4ji/rKl3BL6l1Q05lT/HnMYUPNypjsZFx5voiuLRmEXH46vGi+tIyfs+9N3IQKlAFkYG7EW3t2a5+C1LVarouvOrXSG4EjxVsYP84PafxrrQzIDpm8iP1YuwWjW3JNBBVhpcBzf8lrFJr7HmHlro+nXzhvfHL3jmLX3iU8lzvMSHfrEaSqmnza54Dcgn4zLb2LyoF/fo1g/gYJ9nJwxUOVeO3Fu+k2wVQw36He3HnMbcjFq6r3+vwhBd702J/YQgJw6gbGmgQ6L17u7qORLW2XWTnyjwf5Lvq/1zCB2fRgxEx3AOlrN7rDZJh1/7Kxq3nGhHtONSE1XzVAjhdz0p41w0fQ==;5:hMim+Cv9nkI6nIrUzUf3v8Iyq1sHPGknejlyIyke0gGjNiPJR5vBvYVf3Grkg7N9SBNkkknUX0XsJ31uYkD3g9DDhIIXsbaKdUj8+67P1MMoT7OtNH9PWs2HO988DuMiBdflVtHzlwYriQDOqY0JbqVBkQtM4VnAx6W66plZ+ac=;7:eUrFQdaNFzIBBQgaOEl1SjXtAxGfEWMvfLuAchsfi2vqorbhP5iSFl+2Wy5l3qJCWQesoeajyYSAu1ZKGRsWExYGkxi0LR6IXtGMOI8a+WlInM8slzg0CBCd7lj5HcxywCyFMkSkifTDmDeTYhKDylsCU3zLORY0jSqwUbpcQu+GIKDK5iojV4X44VHYk35UTE9UWlQNwElAIr3X9Ste7SQA9q3pwNQ0b8Z2YoPJ2CerJcgRfmpI+yFHoSfz54H9
x-ms-office365-filtering-correlation-id: 9a5ddb30-26e0-4465-1bb4-08d610d4c906
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629183F9294AB94CEF4989EFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: QcJyimnMs+WayIyrGm9LpNvHkPVQ/MovWPn7sQ3J+rYGP/Bzk78HeBTi0oimJ/Z1VB31apGwCTtJkLTX9+iFW7/J6MPCQQWf2UxjwJ2/AjOCQmHMLrRyGNXyIpot2bwzvFTzcn3c/n0LsVJpt4+6kqgVcRS3zVqJy2K+DLeF+pLpDZhKQAGCZBW/QuYC/LwFRWX9WLFMaaSRdMilnLkEVizLuz5dpRvMbbVWkaDXYK8Pn7Y96exgojV5Xp2NHPUv+icSNsAZBZl7Edey76ww4TuZgQSzCuZBgksUxsRdIMCKeA3EO19B7VYW3gEY63wyIR7EV1PCP4Qy3GtvAVp9eP3aro38OjDY3/Nse/IQaeU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5ddb30-26e0-4465-1bb4-08d610d4c906
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:27.6643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 3ac14b3960185d4c8a2f14b84042aa1aa8531d88 ]

The open codes with the bit shift in xen_snd_front_alsa.c give sparse
warnings as the PCM format type is with __bitwise.
There is already a standard macro to get the format bits, so let's use
it instead.

This fixes sparse warnings like:
  sound/xen/xen_snd_front_alsa.c:191:47: warning: restricted snd_pcm_format=
_t degrades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/xen/xen_snd_front_alsa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.=
c
index 5a2bd70a2fa1..129180e17db1 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -188,7 +188,7 @@ static u64 to_sndif_formats_mask(u64 alsa_formats)
=20
 	mask =3D 0;
 	for (i =3D 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
-		if (1 << ALSA_SNDIF_FORMATS[i].alsa & alsa_formats)
+		if (pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa) & alsa_formats)
 			mask |=3D 1 << ALSA_SNDIF_FORMATS[i].sndif;
=20
 	return mask;
@@ -202,7 +202,7 @@ static u64 to_alsa_formats_mask(u64 sndif_formats)
 	mask =3D 0;
 	for (i =3D 0; i < ARRAY_SIZE(ALSA_SNDIF_FORMATS); i++)
 		if (1 << ALSA_SNDIF_FORMATS[i].sndif & sndif_formats)
-			mask |=3D 1 << ALSA_SNDIF_FORMATS[i].alsa;
+			mask |=3D pcm_format_to_bits(ALSA_SNDIF_FORMATS[i].alsa);
=20
 	return mask;
 }
--=20
2.17.1
