Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC41BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A146620821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfAICN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:13:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17093 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728112AbfAICN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:13:58 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B28D6BA19D91DA99A7B9;
        Wed,  9 Jan 2019 10:13:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Wed, 9 Jan 2019 10:13:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Jorge Sanjuan" <jorge.sanjuan@codethink.co.uk>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andrew Chant <achant@google.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ALSA: usb-audio: Remove set but not used variable 'first_ch_bits'
Date:   Wed, 9 Jan 2019 02:20:16 +0000
Message-ID: <1547000416-144563-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/usb/mixer.c: In function 'parse_audio_feature_unit':
sound/usb/mixer.c:1838:28: warning:
 variable 'first_ch_bits' set but not used [-Wunused-but-set-variable]

It never used since 2.6

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/usb/mixer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index e7d441d..8ad1a24 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1835,7 +1835,7 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 {
 	int channels, i, j;
 	struct usb_audio_term iterm;
-	unsigned int master_bits, first_ch_bits;
+	unsigned int master_bits;
 	int err, csize;
 	struct uac_feature_unit_descriptor *hdr = _ftr;
 	__u8 *bmaControls;
@@ -1926,10 +1926,6 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 		break;
 
 	}
-	if (channels > 0)
-		first_ch_bits = snd_usb_combine_bytes(bmaControls + csize, csize);
-	else
-		first_ch_bits = 0;
 
 	if (state->mixer->protocol == UAC_VERSION_1) {
 		/* check all control types */



