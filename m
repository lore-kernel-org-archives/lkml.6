Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD6C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6F720855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IbcBtlpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6F720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeIBRV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:28 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:24667
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728601AbeIBRV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhwCNoM4BHlvGigxOoOVBE+ud4JF5yMlrif3q6v0A5k=;
 b=IbcBtlpKo/VtwziYSgmVW1C8OvLlW9hitqZXhtbBfF+nrGdueWbodjdoWkUcqoi020fpT3y+a+oJfmNJ24FJw4zuglG5NflOLhiSl9GatS4QWk73ydw30jH+83vjQGp+qzMh7CNg1ykHeTnTQ7CC7Tg7sLn7G9LJBmH5LXsjtl0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:05:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 114/131] ALSA: pcm: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.18 114/131] ALSA: pcm: Fix sparse warning wrt
 PCM format type
Thread-Index: AQHUQr2do3ISG4ji10e4shEYC1X1MQ==
Date:   Sun, 2 Sep 2018 13:05:25 +0000
Message-ID: <20180902064601.183036-114-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:bk+PGXRr2/q7dRNf6i3O8Bjoa5LYBPhSTL/SsNBPPwJgpC5+IpiYR8pBsjLFvpe9O+mSdYWvu5VrIoYqqcYiCHRdyRPKegcKuxuWgl39rRXwVN/Txuh1iMPYRIHMaWWBILGfwBLeFngyhtKBa1PWJgPz7jmtaNLHNlpYdfUAiqMfuR3kMfyh/CfynPFRyvXOUK5pJMo+7aQJI7eBDdKTTQpnTpqAqzMivGp/HgV4ixnNvkRlQ9+ZBvw89E+untLyWmeVHgtJrfoQdk3M7M2jPRnwYwU8rryVOT1W8tr+Az269CWqEb+XmOgDU+VI6rMMbKIOvDTdJugGiaLV681hFO6xMV5zfW6kFw3qXtdLhNJgfJD2mjzoCszXudzSFIvFOolZTY8auB7/9F9+e96rpwtmW+vvJlpaM9lwF7HDryGfJy2m9hru7twO2yagQgq95mGpfxPiwEbiSGHc0TsWDQ==;5:SRLYSLYoFY1DBVZek9Qyiq22rXuB1qfS5EwtKOs57Y4BNDaZybiJrDhsDnuR0vATJHFyyFfDXaqmrCZINl52U7E1/uo311IW/ERf3eFyh6RQrV/d2deeS1W9plJL0gdTuz6bgExSRE9rQnFWP8JVUVO3ZFJoMhU/VdxV2e9olBU=;7:g6+d/KAy8Tv4t/xm4RmeRg7yK2X5Ph1322S2sZv9bPvlZt+LxvHkaMaAIGJr7Njg6zZlwT7hmoldUOnNalSRZRMFVIk3kbiwQObCWi29hPOj63ZY5J1ii0BZ62puu2wOS/gGqTsHNqheg4krhC/XZoajW7mPxeItS+aJ3s3SPxAnNlU2TlG1MGwgH9ink2Z3aaVHRSV1RYCpgk4YYreZFiOs/P3DYeMzBVktYElCM1zVlVGHJDBh6mOaGf8r+7i2
x-ms-office365-filtering-correlation-id: f6ef622f-d8da-4c3b-2756-08d610d4c898
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06297FD53ADE336B67610CCFFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(575784001)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: LwK4sdI7TFdelpyv4RRr1ijq2zj75sxO+Seh8fffvPCAIbfq7de+ejxxwhMWTRdOMOtaI2QxI95XyO7GOKQrhSXd1hXXhYXJBBAxjqu5A+jcEITMhg+OmWaCQf6y7xZMsk3LF5kGcXXMycJBd5yKPmHFFOPMYXFDky6obXSoYdrqW1T48Zte1EccZ+CJP0UUN+mZbzTZ+UEQR56mxS8/a2sxb/MLbEiLmwkf39qLhCO830KeKBuPx4kSQoZVpEpWkC+FDN1AKBS2yITKOu2Ta/HNwoMvYpwS9Z93cMIKdp2CRLJHcJ3Qn+lkA8GIL6RQQ6L00pO1Fq2qvF4Dj2E04niBsO428CB6DU3PTV80q2g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ef622f-d8da-4c3b-2756-08d610d4c898
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:25.7878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit f8b6c0cfbdd7359db9bb4da38dd54217296f9264 ]

The PCM format type is with __bitwise, hence it needs the explicit
cast with __force.  It's ugly, but there is a reason for that cost...

This fixes the sparse warning:
  sound/core/oss/pcm_oss.c:1854:55: warning: incorrect type in argument 1 (=
different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/core/oss/pcm_oss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 905a53c1cde5..f8d4a419f3af 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1851,7 +1851,7 @@ static int snd_pcm_oss_get_formats(struct snd_pcm_oss=
_file *pcm_oss_file)
 	format_mask =3D hw_param_mask_c(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	for (fmt =3D 0; fmt < 32; ++fmt) {
 		if (snd_mask_test(format_mask, fmt)) {
-			int f =3D snd_pcm_oss_format_to(fmt);
+			int f =3D snd_pcm_oss_format_to((__force snd_pcm_format_t)fmt);
 			if (f >=3D 0)
 				formats |=3D f;
 		}
--=20
2.17.1
