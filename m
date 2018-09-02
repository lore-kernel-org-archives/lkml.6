Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD03CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C4220652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jd4M98v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C4220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbeIBRcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:32:55 -0400
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:9515
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727573AbeIBRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtFtdbYJyMklV0CweKc8Ei2lIrR7C8DGiwCwmq1l8mY=;
 b=jd4M98v3nTARIzNvQkI0iswyBPVHRSFkcbaxrBE1ongvkwHP/IWb6OIXtb4PmdzinnYPa69f+6clpNpkNCvNcpBExLOAI1wpbLd3Ti792UGBLCUA8bi8DDfCgC+52zOqgrt+BTiGcJqJr8NWM5oTIuwfiAIg9EmuFpm8XWxrkUk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:17:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:17:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 44/47] ALSA: sb: Fix sparse warning wrt PCM format
 type
Thread-Topic: [PATCH AUTOSEL 4.4 44/47] ALSA: sb: Fix sparse warning wrt PCM
 format type
Thread-Index: AQHUQr8qvs/xVq8V90iV0YfteTzN8w==
Date:   Sun, 2 Sep 2018 13:16:31 +0000
Message-ID: <20180902131533.184092-44-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:bLEycBG8QySPtoTepx6pkEAKqqmHbOHQRF+Se9q4HHB79xuCRs7Nb7tQm6rpje9uaBpuv/8NG5rsXss5mqIoUvG+1ALBGa9JZZYQyV2uaHeFsDkXvddOaA4FTmOhIQ9zOjgrv97rYGgLp0ngvCjK9yRhR6nDP0xBp2Y+Kuosuq/WkV70lV9QZ1kxrrAvToMOB8KQ0FUMv7LudXX6vKhbNOhCKkFKn+5ImT2EHs/rn+rVeeoLSAv/Te5wtYsOTR3gZPP84TFjM2p7iOH+BRtlttaw98xpBkcsAbltlKtIxudesLZ2RlhEkonLhPuEjeNeuIf9W9C54fpDioQt7YxYZz72lDBn9jevQhEUJupb8GmGGEYKINwYdsUpAtTJJHMwf1+oE1Z/KvFnkObow9gNV+Td1wMOa26dD6yF/BnylgCJ3BT0fTV9JuKBjXX8i+3gwAUYKty+erEqs5msjKRLEw==;5:Vehj33sBmFhGTtTfJDYPl6szSnvv1dXcVLZguEQVAXAqrjF9fWbdzZTnbyxzZf0oKckoKNY7VVYm8nYwPUv8T3U/SEFP7qdeVsG10tE9cG2ILQSWHeJVi87O/SHTremP1blb3UWKOUAV35SDrCW+PPIR0+1D9nB0fFCFijbHY6o=;7:dn4Q88TOSvPMQQhfMSUj5DN2aNintIWU9l/hO3mLIuIRGpenyQuy+6yhJ7yRGWDhe7uzaBgisq6B8AQXQQNZPbQBKbhh/stTN5j15/4H9VZUxuKDaBV4JvtynMLCu9NwSs41dAIPOYhutDxG3DdPOvwhJ611F9BHzqbmca82iW0EyhwRK1ouXNnd+6N49mSkHu6ELyH5zp5DAaMS0zpTedIS6azC3+a4ggygpOOfcHQHPLOT5T/wRYHrOilX9RQv
x-ms-office365-filtering-correlation-id: 11205d2c-a726-4c89-6d32-08d610d65f84
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB016767B5FDD75DD619576B47FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: F1lM26sofPydNzcLcTB+9s40KiSOoryVbiQQ53m7uW3WUejW/5b6ZUenKQt9MaF5mEqIyuw/f7rbBQM37k7+CmzRAMV5Fdt+5bChHCnc+QrLrLGmFcjMfjsqyWylK/ftGybc4/tcWbzJ8uSETqnet9dG0FFAECC3oYkvxxU7SdH/l7Uq6H0X70C8JIpBLhZ/XMGcc3xlhADrDhPAFDUFpF/kNDhDLYE/tGpJ0ZyKtyjuzZlvPZg3NUHIEPz1RDF31tvAlGMEUJ0ajp62YP6e0mY6dKV1vq55fzis2eQpV9kV2QQH5EskncakgQWCzsivjemmdc8b7mEJnA7Xo9sQ8UKvyjZIf/0lwvgxh8n0Ys4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11205d2c-a726-4c89-6d32-08d610d65f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:31.1930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
