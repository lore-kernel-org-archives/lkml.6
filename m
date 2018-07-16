Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A8FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDA1208FE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDA1208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeGPJBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:01:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42826 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbeGPJBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:01:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1feyy4-0000d3-Af; Mon, 16 Jul 2018 08:34:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: opl3: remove redundant pointer opl3
Date:   Mon, 16 Jul 2018 09:34:51 +0100
Message-Id: <20180716083451.15290-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable opl3 is being assigned but is never used hence it is
redundant and can be removed.

Cleans up several clang warnings:
warning: variable 'opl3' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/drivers/opl3/opl3_midi.c | 12 ------------
 sound/drivers/opl3/opl3_oss.c  |  6 ------
 2 files changed, 18 deletions(-)

diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index bb3f3a5a6951..71cd5a2fbe82 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -721,9 +721,6 @@ void snd_opl3_note_off(void *p, int note, int vel,
  */
 void snd_opl3_key_press(void *p, int note, int vel, struct snd_midi_channel *chan)
 {
-  	struct snd_opl3 *opl3;
-
-	opl3 = p;
 #ifdef DEBUG_MIDI
 	snd_printk(KERN_DEBUG "Key pressure, ch#: %i, inst#: %i\n",
 		   chan->number, chan->midi_program);
@@ -735,9 +732,6 @@ void snd_opl3_key_press(void *p, int note, int vel, struct snd_midi_channel *cha
  */
 void snd_opl3_terminate_note(void *p, int note, struct snd_midi_channel *chan)
 {
-  	struct snd_opl3 *opl3;
-
-	opl3 = p;
 #ifdef DEBUG_MIDI
 	snd_printk(KERN_DEBUG "Terminate note, ch#: %i, inst#: %i\n",
 		   chan->number, chan->midi_program);
@@ -861,9 +855,6 @@ void snd_opl3_control(void *p, int type, struct snd_midi_channel *chan)
 void snd_opl3_nrpn(void *p, struct snd_midi_channel *chan,
 		   struct snd_midi_channel_set *chset)
 {
-  	struct snd_opl3 *opl3;
-
-	opl3 = p;
 #ifdef DEBUG_MIDI
 	snd_printk(KERN_DEBUG "NRPN, ch#: %i, inst#: %i\n",
 		   chan->number, chan->midi_program);
@@ -876,9 +867,6 @@ void snd_opl3_nrpn(void *p, struct snd_midi_channel *chan,
 void snd_opl3_sysex(void *p, unsigned char *buf, int len,
 		    int parsed, struct snd_midi_channel_set *chset)
 {
-  	struct snd_opl3 *opl3;
-
-	opl3 = p;
 #ifdef DEBUG_MIDI
 	snd_printk(KERN_DEBUG "SYSEX\n");
 #endif
diff --git a/sound/drivers/opl3/opl3_oss.c b/sound/drivers/opl3/opl3_oss.c
index 22c3e4bca220..8a0ce3f43f42 100644
--- a/sound/drivers/opl3/opl3_oss.c
+++ b/sound/drivers/opl3/opl3_oss.c
@@ -233,11 +233,8 @@ static int snd_opl3_load_patch_seq_oss(struct snd_seq_oss_arg *arg, int format,
 static int snd_opl3_ioctl_seq_oss(struct snd_seq_oss_arg *arg, unsigned int cmd,
 				  unsigned long ioarg)
 {
-	struct snd_opl3 *opl3;
-
 	if (snd_BUG_ON(!arg))
 		return -ENXIO;
-	opl3 = arg->private_data;
 	switch (cmd) {
 		case SNDCTL_FM_LOAD_INSTR:
 			snd_printk(KERN_ERR "OPL3: "
@@ -261,11 +258,8 @@ static int snd_opl3_ioctl_seq_oss(struct snd_seq_oss_arg *arg, unsigned int cmd,
 /* reset device */
 static int snd_opl3_reset_seq_oss(struct snd_seq_oss_arg *arg)
 {
-	struct snd_opl3 *opl3;
-
 	if (snd_BUG_ON(!arg))
 		return -ENXIO;
-	opl3 = arg->private_data;
 
 	return 0;
 }
-- 
2.17.1

