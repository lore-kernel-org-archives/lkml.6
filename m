Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0845BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA3F20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA3F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeKBUQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:16:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKBUQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:16:44 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MiIhU-1feW571P9C-00fP0i; Fri, 02 Nov 2018 12:09:47 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MiIhU-1feW571P9C-00fP0i; Fri, 02 Nov 2018 12:09:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: v4l: fix uapi mpeg slice params definition
Date:   Fri,  2 Nov 2018 12:09:07 +0100
Message-Id: <20181102110945.191868-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:35aLqRlZn9pNYPaRE+C1Bsdex63Cbxu7XrzdJ0e63v1RH2Bgonl
 j63cVvtXrzUBT7IoQkyJYgJjbxxvyVhh3zqtX6L/RRjteXm2MD0gQfhyy3sTYs34jxSdbn6
 vQmD2rO81Wf16xeVdveJRUxwTfZgqyA/B4DfDrbODsFxxIwz0qbOCz1FDRkug8gCi8mRlQr
 L+E1T322+1EwQ2dr/a7ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RuO3MS9HQxc=:97Ho3vEZaO2RgTysvCdlQ4
 uLF1NjkkwT/4v/BBvS2VdJESRxbrRGBA6DSCD5wz1rDDk1K++I2FP1eWe30N/zwCJmgaIprFW
 MDOqKwJJgNiOZFgOAVuq+r7ixf/zvT2n+TSSnQ4FbyJF+jr0FT3RYsmZNLDebDdqbuQ4W5QKw
 t7/PMoEWW+tL6kpqEmF+LOJ3GelxrhfSr9zxfikS6g1v1YJU13xfbntgn5RfabA7Gpge3ck4y
 +wdSeXBkCw3xQyF0mUKaBvvNML8iZbZbboYZ43Fyw7FKkgeA6sdYFuK2LatQbOHVvoH8P2wTA
 Wn2/CgtytaCA9FfuLX5IdmtFF39MoU0oo8DMjr8OQxCtO2ZWgvSD78UNvshHBuzVWGa1yWfQo
 ilzYQJhh8vTG2FQTrFHBb/INl12BfNvOHYR7UmNF/Hwou3jFBrIkd8jZMuDsDI/qPzkHA2Dqm
 GXe7nblxMsYrbw+m8+F3AWRXCV8SPL+eLsI+RigeM5tRoYGCSXhIoLzJ7jBmIGZXhWaodLFYT
 JSDRgUds4HuJhOHUcsIkcpw1SP7vRDzMVOJLF6jPEiBfQU1BG7V4g4J9rfG3k3STvgiQ2+elf
 /1IZvB/8Venlj9zrYDyDTBD9op7BmmF8S4QaUF+BxJq7ImfLy0o3ewM4nT9EjyUNf1IzGOaYf
 XjxsTf0Ssxa/zWBpTM8pbKkUusHUQbV0MAxz898SWRwWqWi67YVCtzXCpsmVp5u+lN4o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a headers_check warning about the newly defined ioctl command
structures:

./usr/include/linux/v4l2-controls.h:1105: found __[us]{8,16,32,64} type without #include <linux/types.h>

This is resolved by including linux/types.h, as suggested by the
warning, but there is another problem: Three of the four structures
have an odd number of __u8 headers, but are aligned to 32 bit in the
v4l2_ctrl_mpeg2_slice_params, so we get an implicit padding byte
for each one. To solve that, let's add explicit padding that can
be set to zero and verified in the kernel.

Fixes: c27bb30e7b6d ("media: v4l: Add definitions for MPEG-2 slice format and metadata")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 5 +++++
 include/uapi/linux/v4l2-controls.h   | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 6e37950292cd..5f2b033a7a42 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1664,6 +1664,11 @@ static int std_validate(const struct v4l2_ctrl *ctrl, u32 idx,
 		    p_mpeg2_slice_params->forward_ref_index >= VIDEO_MAX_FRAME)
 			return -EINVAL;
 
+		if (p_mpeg2_slice_params->pad ||
+		    p_mpeg2_slice_params->picture.pad ||
+		    p_mpeg2_slice_params->sequence.pad)
+			return -EINVAL;
+
 		return 0;
 
 	case V4L2_CTRL_TYPE_MPEG2_QUANTIZATION:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 51b095898f4b..998983a6e6b7 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -50,6 +50,8 @@
 #ifndef __LINUX_V4L2_CONTROLS_H
 #define __LINUX_V4L2_CONTROLS_H
 
+#include <linux/types.h>
+
 /* Control classes */
 #define V4L2_CTRL_CLASS_USER		0x00980000	/* Old-style 'user' controls */
 #define V4L2_CTRL_CLASS_MPEG		0x00990000	/* MPEG-compression controls */
@@ -1110,6 +1112,7 @@ struct v4l2_mpeg2_sequence {
 	__u8	profile_and_level_indication;
 	__u8	progressive_sequence;
 	__u8	chroma_format;
+	__u8	pad;
 };
 
 struct v4l2_mpeg2_picture {
@@ -1128,6 +1131,7 @@ struct v4l2_mpeg2_picture {
 	__u8	alternate_scan;
 	__u8	repeat_first_field;
 	__u8	progressive_frame;
+	__u8	pad;
 };
 
 struct v4l2_ctrl_mpeg2_slice_params {
@@ -1142,6 +1146,7 @@ struct v4l2_ctrl_mpeg2_slice_params {
 
 	__u8	backward_ref_index;
 	__u8	forward_ref_index;
+	__u8	pad;
 };
 
 struct v4l2_ctrl_mpeg2_quantization {
-- 
2.18.0

