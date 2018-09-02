Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504FDC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DA2204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="J4lM1d6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DA2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbeIBRYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:53 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:56192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728758AbeIBRYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mQHqL5wyV4HPcFEAc00QO9KxxoZaUfR3b2uFP/Vz8o=;
 b=J4lM1d6+tsihIp2SAg5g6/onlU+K59ed7FrNrczS4Ioa2+VvYxsMteKz/a+sZnbvqQNQ4VCAaltiC/pofsIn4Epa4Wya4L2WrbfqlmBoaL3jC/9+5zbn3LDqT4boAk98HVpWKewBSOY4tuRJ4DnuU+mDOLuq308bNbciKycpMXo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 85/89] ALSA: sb: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.14 85/89] ALSA: sb: Fix sparse warning wrt PCM
 format type
Thread-Index: AQHUQr30uOito94LgUuuH/VDQuISHg==
Date:   Sun, 2 Sep 2018 13:07:52 +0000
Message-ID: <20180902064918.183387-85-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:w4PLBdD5sJOJsG+gfl7aQdywtotBwnHw/WJG4OyDEMvIvAIP+Rh926oMSLwK6FtXefM6t1tJiI70iSA3fMStvVvq4FRK7nzAkuctrV4nIQWTF0QzI1CMmIOjAI/VkFG5Cja7u+9kJFjLtNMAGTL1mqkK/KZW1GJChUHLba4KizLaax+hJVnFEYIdeWvDboX1Vez3Zewb6/iCCRUtSur2OpYB2xIxXX4Rr6eEgd25y46sB/RigrA5QXUAflPeMzRkgAZwjt0z2zZIkjCiz5vu4Mlz9trGPDEN3Q2IedxmgsHIvb8SC4tdYKM7TQh32tg5B/c8F/iUJgmUh6OeNhkax0X2M6FxmO26RxLIHaQgcbOCXG1GqgObt+xgS5Q/92HcU5jFbrEloYAwGvL0j0t+yr0jEEZd3iQn5FWBPEAcgU1qnl9395sOyisBlfC6rCCNf77la0Fa/E0zbMuggl2RcA==;5:gFe5vErFATtTelrlHMsZDyZLhBGXixafodO5R+M9+AannoNNee1g46JMrxiu8m2CciIBIGn7VlfdiGFPUnKqaYaurOHDybBNUO4O4lBbCscB9r4/shYfby1OLwOVLcVptC9UkIfve7feoVIXNtHlHaqJuX791mp/bfGkS6GVH/4=;7:iMgTNoW/cx3vuQ8PXasKO66H/HHP9Xmv727CCd5DSXVYhubZ8qRmTlo8SeLMojq66sd7VM3mXVnOWlt/d0tEq0qJL2PivKFeGkFMWMzTNZNE34VPwUC6UcBTwWpQ5eDCZWuS3N47NkFTCxxNL3Mh4zpJbjS+BcwipJ/N7SwiOqBpiJ1AfQCr45SEDBq9+QVYvnHg7vCw1LtF4Cw6Se7WMprPCw8rrwGCMmC37HtwjkMtydyw3kc/aLpcQeBjCHMC
x-ms-office365-filtering-correlation-id: c2cd8205-bb82-47fc-6173-08d610d53a60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469676B7B332F18999E9811FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(575784001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xYrcR5K8aLiPHQic7nM+an/+hM31TXNcTI2FU9QMoa0GRrpMWjRiM9YUONpVB75iMikv6wySxXGVquUz4rHV/6/wb/6cCdzGwQmlDM46f/L6pT2t8EIYR6Kyei579ZTVGRUQCbRwPFNOlGqxE8V03W2s2tzHuvAKXsT+UyYK3dWZS9ejcV4rvhtewHj2jz3R/CoqL4ga+atufjlEOZV3ipZmgZj/miFPLhjNaBs/8Ar1O4Z7Fy6CrJbcycFr5EOmzxkDXr96xtQArs2t5lCAe9pSCm5Cq7bTutEghJBqEX3AIt4vnKRMhOKKVWjLtRnoEp2LvFdj1cRMQsGZ5rNBoEd2bcEmcESPW+0RApkmFXE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cd8205-bb82-47fc-6173-08d610d53a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:52.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index fa5780bb0c68..2210e7c72787 100644
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
