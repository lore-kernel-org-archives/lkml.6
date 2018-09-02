Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF4FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DA7204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iciXxxut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DA7204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeIBRWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:11 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:24667
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728792AbeIBRWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mQHqL5wyV4HPcFEAc00QO9KxxoZaUfR3b2uFP/Vz8o=;
 b=iciXxxutCh83Z21whC7xrgOtMIqbEEPG2igueEjcB9pny+QMZmao7g7iLUFdBYzmZvPEoM4MlkuDkyf3dIvdNyh6RAryP0SyKuh2oXmQU3ElcG1cwri/31xpm/r0k8hljAPnhDT26VRq86rpo0bczgSMK5QdXR9yqBQmMKgj3Pk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 125/131] ALSA: sb: Fix sparse warning wrt PCM
 format type
Thread-Topic: [PATCH AUTOSEL 4.18 125/131] ALSA: sb: Fix sparse warning wrt
 PCM format type
Thread-Index: AQHUQr2mIVmrf9G6oUW2CAdA5FlFRw==
Date:   Sun, 2 Sep 2018 13:05:40 +0000
Message-ID: <20180902064601.183036-125-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:4LL6nDG+4M6GYEiVTlGBtHIrU/gNxzvPHlPmeUc5nFoTZJZV8I7mVmdV1fmf2AVBA2SV23Zad4cX+TNDmZg6Gzlx+KB/jMRGe7eJEFkHhf4wtznC/0vgyxPdOvlDHkCM968BwPRLpkEMUfvF/FI5pEt6PrMq6bwsYssgelRaJmGGUAG6tQyhKJSOVZATGMvIuXDokS05TZC+kqMdejrUfypFm+hLryy688tCzR0rnC/C/r8GQpMHuyRoJEcBVndAvIBmUvbgVAFgMb1msd8tvEnIZes89zll1/2E1DUdcb79/ggxJ1YXEzUUNxGjER2BW0YCnV9LtSu86KhYVHrWK+z47EMK2k6+aS0qivWvmFWtyWHx1InyvZGtJUqzrdMYYTbnmD44DVelAUM71+cYmmfqgBVohe7IhegIAsFnK9d3gApNXvCmCfjSYA2nAk3eTnzv+vpfMGS1hcH4yEV8lA==;5:aJ47ShzkNvg0iaj9EaVdXBIP+eqE+WNUgTRAPKgaXfIb2X3At9HtATn0YjRDczZ8e7V1evhExXcThSGN8uhgxevD3KeDO4EVtGZuOwTPWcZgSY0jUk3Dj9X3R9RSlgIBim5S6ekL/tcWs5AXsgJSTFRPZPWFhLpc4EvaTNo1kTI=;7:BKJOXVQ+yXcpZ7wX0EbSMn8Yc/bz/bw2hWWYvw9tSArWE87iupZ59XKIqHnxVQRtqnHrQZb2uUD6QgRELlu5L9cxI+DaqxYGpQ81O+WYOL7/0OwhaOuPwN5vO03XGDAT8P6O8JmO6+GoVqBiXnGSNOiLcf3mOWi80Ryjmpg+lnpdTVf+FNj+4x1BPfAnZMXJwvNoTNDPh0i4iNYbTdWVleLwvqRcUqLyJrA9PJyz0sA8Yy6+TETnYF+sOpRxJaz2
x-ms-office365-filtering-correlation-id: ac6190f6-4394-43b9-ca1e-08d610d4deba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062987561D48823CAEF06A58FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(575784001)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: O2dJUX1CyB14wABl1orgZt6xId4O/B7pexdAxVc6AEMpuT4hPQ2pmHhOt2s1l7gYFN8vSFrQfEKy3hreafFILWrSAtIq28+rkjfUIF1N3VhF/c6HVqku8SxZje5GkhcaLf1/MO9QL+f/rzY39ukAJteqvR0aq4Z5yZqBhLkqcPhi35zCv25KRKXhFejan5xaBsr6y7kcBbbEv0jX1rLNf+1jxd7+kajvy+GErglNqnTwV23vG7ZMYLJu6ECo7HAm4MnzZg8JGZ0NQYEzzP+QkWn3UQqDd7H13NnArBtPFgSgVVpshSz9MVYk5UqhbaYhljUzu0+DSt1mwbcO7W1pnwjqyBmYEXpPP1v62iJuiB8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6190f6-4394-43b9-ca1e-08d610d4deba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:40.7492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
