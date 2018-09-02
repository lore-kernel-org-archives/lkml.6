Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6189AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A80F20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YRxRY/ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A80F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbeIBRbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:32 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728992AbeIBRbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtFtdbYJyMklV0CweKc8Ei2lIrR7C8DGiwCwmq1l8mY=;
 b=YRxRY/gal4FwsZmdH2NnhD2C+WbhQ0enafAdGIOYplkl7Zckrf0JSb7RXiuh+3H77XCIB+GkYHz3hbxNnCU9NEg3CjSlbOdF1dMHHE3AcYhGOMxfUii7msgKWcCet0HWzTP/1AtlK31AoqpnGAu6+LFF9MVAlpuGDUPgdvOrDGs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 58/62] ALSA: sb: Fix sparse warning wrt PCM format
 type
Thread-Topic: [PATCH AUTOSEL 4.9 58/62] ALSA: sb: Fix sparse warning wrt PCM
 format type
Thread-Index: AQHUQr77h0a3ziKQwk2ZEpDAbYMWQQ==
Date:   Sun, 2 Sep 2018 13:15:13 +0000
Message-ID: <20180902131411.183978-48-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:Z78D576ViRfA7QZUeKfW/vwt4Uaw9YTrMUrakmMn9CWyPVGu6I5b1BoSOo+EI824ycY/05ObyEhnxYTIX7RkmP2M/ESmiZ+hnnSNcbi2Qsy2erTYyAQmhIU1NEVCQGB4rkLWQs8tq/Y1R37DZFdMKDlI9j7ZGOL0x5Fr9Mk/MGCcW1uDHOPCBNDHIX98tENbXc7mIpdHd3Zou1RqmhjyFXSMvhFBN5MXhF9V50eNqMrw/T/YrNkY7Ef9fxyrInKl9XpziNuSfevdic0vpU220ysuTcvgQnRc7WqtfkmyVgqF+tm/g+rbXZWEByNerkT+NjmWGBJnadNWEHu9R4C0jy2PH3luxG30l3ecb0UPZCh+Efv+dRadrqJJ04j4ei60Yclyd1uy2lgnpRIvVz3D2TMBe540WdDO4hptGrfAK2rbycQnIlszHRF1zTYsBKEFP38c/2d6cSu8x2yeODN8AQ==;5:+n/AmxjfjHZB+GF1JLXhZYkfHrkgdgjXh76BRz8hIHsT1C798aDWg0ohh8uOugcbdTo9oAvEsztnuWNtErxG3hD9uc3de/oW9PqWJivc4w1r6QkORIx+PjQFXiSEZC5aFVqQtMp/nLaAsxv4WAGVBpz3dt3YG983Rb04txsbXtw=;7:MyHXsHNE7vKsyyjMY54jpKJswKtlXv8WFwwh/gDJI1T9nFRCXVyWapw2p7KpqDEhP+DzNQnuvN+/9HdXCrPMs/jWqdTYXCNSBq3ac4dWBEXTj8+PiBA5DNJcdf3NsJ5V/D00AVjscrlvcBhMkXDDnmDNK1mfYZl71IplxqJJI4JDxI0Y4e1YfYNpu8R1ze2tkzkQLnP0VqBEKj66ApIT3KXL7RBJbfV8k8XCtBLukxCMbjxnTK7yX4rgAo3tG3hi
x-ms-office365-filtering-correlation-id: b8d0eac0-9c26-4e78-1151-08d610d62a38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01841556F3655C0318808264FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ahXn/kdgZzfGmWgo5D/oL8tzaYyYyUXasAIIAjxhWW4NYSr9WWsX/5NT+sZaqQyE5o2F2XofjrLbrvEI/fwFJ+usC7C1GmwMk0nldZIN2pbKJI6rN8Zbl74y/2occ9eqauuzDFVFki8rCWVyLBvMkNbUmQiq80jMjkN5shsy5Zs+QgTKFnjfLztOA70jwuvfkrkf6tXiH6OrH0YWyyAvww9ERaobM9llkD0kBlA44h4vnB7LGrnGTQKCluHatrrlHjfQljuvWbC8MuTE39W7C9HuDXia72DQYPyrsvhJJpAqoPdsRwBA/FpDX/9v7YR2PbhCJV363wY0Y4qwdFqFkWmABTdK93OwFjyhd+iGDdQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d0eac0-9c26-4e78-1151-08d610d62a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:13.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit e5d3765b6c4cb3ba64295a4205a2f68a4e8fe083 ]

The PCM format type is with __bitwise, and it can't be converted from
integer implicitly.  Instead of an ugly cast, declare the function
argument of snd_sb_csp_autoload() with the proper snd_pcm_format_t
type.

This fixes the sparse warnings like:
  sound/isa/sb/sb16_csp.c:743:22: warning: restricted snd_pcm_format_t degr=
ades to integer

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/sound/sb16_csp.h | 2 +-
 sound/isa/sb/sb16_csp.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/sb16_csp.h b/include/sound/sb16_csp.h
index c7c7788005e4..7817e88bd08d 100644
--- a/include/sound/sb16_csp.h
+++ b/include/sound/sb16_csp.h
@@ -46,7 +46,7 @@ enum {
 struct snd_sb_csp_ops {
 	int (*csp_use) (struct snd_sb_csp * p);
 	int (*csp_unuse) (struct snd_sb_csp * p);
-	int (*csp_autoload) (struct snd_sb_csp * p, int pcm_sfmt, int play_rec_mo=
de);
+	int (*csp_autoload) (struct snd_sb_csp * p, snd_pcm_format_t pcm_sfmt, in=
t play_rec_mode);
 	int (*csp_start) (struct snd_sb_csp * p, int sample_width, int channels);
 	int (*csp_stop) (struct snd_sb_csp * p);
 	int (*csp_qsound_transfer) (struct snd_sb_csp * p);
diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index 48da2276683d..f9ad09eae74b 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -93,7 +93,7 @@ static int snd_sb_csp_riff_load(struct snd_sb_csp * p,
 				struct snd_sb_csp_microcode __user * code);
 static int snd_sb_csp_unload(struct snd_sb_csp * p);
 static int snd_sb_csp_load_user(struct snd_sb_csp * p, const unsigned char=
 __user *buf, int size, int load_flags);
-static int snd_sb_csp_autoload(struct snd_sb_csp * p, int pcm_sfmt, int pl=
ay_rec_mode);
+static int snd_sb_csp_autoload(struct snd_sb_csp * p, snd_pcm_format_t pcm=
_sfmt, int play_rec_mode);
 static int snd_sb_csp_check_version(struct snd_sb_csp * p);
=20
 static int snd_sb_csp_use(struct snd_sb_csp * p);
@@ -726,7 +726,7 @@ static int snd_sb_csp_firmware_load(struct snd_sb_csp *=
p, int index, int flags)
  * autoload hardware codec if necessary
  * return 0 if CSP is loaded and ready to run (p->running !=3D 0)
  */
-static int snd_sb_csp_autoload(struct snd_sb_csp * p, int pcm_sfmt, int pl=
ay_rec_mode)
+static int snd_sb_csp_autoload(struct snd_sb_csp * p, snd_pcm_format_t pcm=
_sfmt, int play_rec_mode)
 {
 	unsigned long flags;
 	int err =3D 0;
@@ -736,7 +736,7 @@ static int snd_sb_csp_autoload(struct snd_sb_csp * p, i=
nt pcm_sfmt, int play_rec
 		return -EBUSY;
=20
 	/* autoload microcode only if requested hardware codec is not already loa=
ded */
-	if (((1 << pcm_sfmt) & p->acc_format) && (play_rec_mode & p->mode)) {
+	if (((1U << (__force int)pcm_sfmt) & p->acc_format) && (play_rec_mode & p=
->mode)) {
 		p->running =3D SNDRV_SB_CSP_ST_AUTO;
 	} else {
 		switch (pcm_sfmt) {
--=20
2.17.1
