Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28B520652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bq2x1JBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28B520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbeIBRcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:31 -0400
Received: from mail-by2nam03on0116.outbound.protection.outlook.com ([104.47.42.116]:39210
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728738AbeIBRc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+EzuxZ8UZjGLNoDgUVfhfOKZjnD40KzYnTYtFulDLU=;
 b=bq2x1JBI/E7waAxLAcBnlfU945LCxV7DmaKZvAsYg724GyXeNuTsHmGsgyMZHR8NEULW40ccLwnZRsoSmpg7hO+vUKyHUkDFvERYWFlOSDJUdIiDjXo/iIjXzmFmNyQCucV6PpLfDXvtbrAypFN8VV0Wgusv1rz26WSxnI14Yp0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 38/47] ALSA: wss: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.4 38/47] ALSA: wss: Fix sparse warning wrt PCM
 format type
Thread-Index: AQHUQr8mu6gawYwrykq/MpoDsrrHgg==
Date:   Sun, 2 Sep 2018 13:16:24 +0000
Message-ID: <20180902131533.184092-38-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:BN6MNWZrQXMvrnje2O0R6BI+vnsM2Gvyi7+P1EZERV35GjgGRewxabS9dMDl3w/zaUTEcbAgi93Dyd44Ax6E/s1IR6cqwZgyKappxFvUakdN5BnwE4TxGvOJVMbosd8Jop/P2h2EfGegW0c69frremD86vJ9Zwr66lO1EUh9VHJVVgZAsE4ZtejRAS2sHWSArZmuS4ry2t9DzbotpEC4TN8KGgvoHpTiwNovkBc0PsTQUV3BoHqhMreRVk89XGmfIdogA1bQQwVge65rnAP4wo3c9+ASqIy1nLDWyA7nEoYXbVmCkNxa+v7SrqsNgv+B/r9YHt0GbqKwj9rmid+uGxp4wbWJcviFyu0+E5mkTf22GQ8i2+93nQMyrKALc+rYXMOhWYsBBe48lOKOfEMpyUN5Cg4alrZhK/yG7rI55kFeBOi3OqUBKyfadczTJ6KglGMMDB80V+8YwQJC4pt6AQ==;5:r7lR0bCXZ2TkqQ72emoqANRx3aDv7qvOe1EyuUSMBeIIQ1hCosi8UQ6JSKDd71IxDtNy7mUb4vW2nugJ2rXYz2tfxGNyuljPqWD9cjtal7a1hsPX9ZhYDvoDnqhruAjIvy0UYL1zn9ALJXcAoTtfyOvlAcch4yNr4ntRytf33wA=;7:lrwd4MosMsqpQnvYZmmgtHqUFlkWfqZGUVcHJB2GdqskIiuRTnkug1fpB3JLfGJiFAn3wZ7jWzFEEM6+LXuY0W35RgpVBF615oghvCu/Vom2lLBRUBGA4pKpK7jPZ+8oOxPCasBSssGTGG9BAk71HJqgrpnuTchytt2YraZokQf7CMQThUwCkAlz0/GnREph5APfyNQCWaZnDdQhhnLQRt2KEpFHfhXudXBKhwOPYsVXNdnQD5xZp6dHKdpo4+XY
x-ms-office365-filtering-correlation-id: b509ca33-ac6a-463e-7be3-08d610d64c3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167DF4C983260763D427906FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(575784001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: RdWaDv0zOxN9dZerEJDJFIeI+oqZsObIEQQHATvoGNF8qC5+Ob5YYLuDVrSVKPosMwYU4ILLrzmCvxBuuhVhTzR6tbxCo67LRZIRKC6NGS1ip/o9OoVi2a5dICYozmj0tzrbzxJ4BpT4xeGLwc7qZ0lm17W9oGJlHDOC809xgvCxXw5IABIsxdxR/y4cq12JHlf3fjse0Z8+e8kw5OXvcgg/p4AySAsPrfiMeKDYeKnw3ogQy/2Fe4k2fj5Bz2ZmOIZ2PdtdPVRi7+RG5QI3rqzMk4u8I44W4WHm3H0IGmxDAV29oBOyT3lcdzvcopBsflC8Qn89ZP5NQUI3D+j7ez1we6cOIQker29Cda2/02k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b509ca33-ac6a-463e-7be3-08d610d64c3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:24.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 6be9a60efb401487a4d658ef23d652a9e6860b34 ]

The PCM format type is with __bitwise, and it can't be converted from
integer implicitly.  Instead of an ugly cast, declare the function
argument of snd_wss_get_format() with the proper snd_pcm_format_t
type.

This fixes the sparse warnings like:
  sound/isa/wss/wss_lib.c:551:14: warning: restricted snd_pcm_format_t degr=
ades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/isa/wss/wss_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 913b731d2236..72b2cacc9e0e 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -541,7 +541,7 @@ static unsigned char snd_wss_get_rate(unsigned int rate=
)
 }
=20
 static unsigned char snd_wss_get_format(struct snd_wss *chip,
-					int format,
+					snd_pcm_format_t format,
 					int channels)
 {
 	unsigned char rformat;
--=20
2.17.1
