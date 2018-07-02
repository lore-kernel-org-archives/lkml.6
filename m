Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7566C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B32A20C09
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B32A20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeGBVXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:23:34 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:41276 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752808AbeGBVXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:23:31 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fa6IB-00076s-Gl; Mon, 02 Jul 2018 23:23:27 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v7 2/6] cx25840: add kernel-doc description of struct cx25840_state
Date:   Mon,  2 Jul 2018 23:23:22 +0200
Message-Id: <761723d6712a2fe01b8118acfd9444ab9bcf917f.1530565770.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1530565770.git.mail@maciej.szmigiero.name>
References: <cover.1530565770.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit describes a device instance private data of the driver
(struct cx25840_state) in a kernel-doc style comment.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/media/i2c/cx25840/cx25840-core.h | 33 ++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/cx25840/cx25840-core.h b/drivers/media/i2c/cx25840/cx25840-core.h
index fb13a624d2e3..c323b1af1f83 100644
--- a/drivers/media/i2c/cx25840/cx25840-core.h
+++ b/drivers/media/i2c/cx25840/cx25840-core.h
@@ -45,6 +45,35 @@ enum cx25840_media_pads {
 	CX25840_NUM_PADS
 };
 
+/**
+ * struct cx25840_state - a device instance private data
+ * @c:			i2c_client struct representing this device
+ * @sd:		our V4L2 sub-device
+ * @hdl:		our V4L2 control handler
+ * @volume:		audio volume V4L2 control (non-cx2583x devices only)
+ * @mute:		audio mute V4L2 control (non-cx2583x devices only)
+ * @pvr150_workaround:	whether we enable workaround for Hauppauge PVR150
+ *			hardware bug (audio dropping out)
+ * @radio:		set if we are currently in the radio mode, otherwise
+ *			the current mode is non-radio (that is, video)
+ * @std:		currently set video standard
+ * @vid_input:		currently set video input
+ * @aud_input:		currently set audio input
+ * @audclk_freq:	currently set audio sample rate
+ * @audmode:		currently set audio mode (when in non-radio mode)
+ * @vbi_line_offset:	vbi line number offset
+ * @id:		exact device model
+ * @rev:		raw device id read from the chip
+ * @is_initialized:	whether we have already loaded firmware into the chip
+ *			and initialized it
+ * @vbi_regs_offset:	offset of vbi regs
+ * @fw_wait:		wait queue to wake an initalization function up when
+ *			firmware loading (on a separate workqueue) finishes
+ * @fw_work:		a work that actually loads the firmware on a separate
+ *			workqueue
+ * @ir_state:		a pointer to chip IR controller private data
+ * @pads:		array of supported chip pads (currently only a stub)
+ */
 struct cx25840_state {
 	struct i2c_client *c;
 	struct v4l2_subdev sd;
@@ -66,8 +95,8 @@ struct cx25840_state {
 	u32 rev;
 	int is_initialized;
 	unsigned vbi_regs_offset;
-	wait_queue_head_t fw_wait;    /* wake up when the fw load is finished */
-	struct work_struct fw_work;   /* work entry for fw load */
+	wait_queue_head_t fw_wait;
+	struct work_struct fw_work;
 	struct cx25840_ir_state *ir_state;
 #if defined(CONFIG_MEDIA_CONTROLLER)
 	struct media_pad	pads[CX25840_NUM_PADS];
