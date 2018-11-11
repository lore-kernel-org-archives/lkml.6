Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A734C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F3620871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt7tATBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F3620871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbeKLISg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732908AbeKLISg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:36 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD262241B;
        Sun, 11 Nov 2018 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975320;
        bh=2/3ZVZAk5XQC/wxMitN4T/8b0Z/Lhp7Gc+LpyggEeUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bt7tATBItE34q9zFJWFwAdcpVbXr+t+cZec4AtMX9+mkz3NGQP6oUtOl4vI6rxXEp
         4LK2X6qCJAL6gEnk25iAlL1AnM/T8jqRyPQ7Jel0EyrZQlJ8RlbqkHjD6epA0LKRfV
         aUpbnwjn9CF5ctiVbg9L6AEiizjHJ/CSDh3WUEbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hansverk@cisco.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 315/361] media: hdmi.h: rename ADOBE_RGB to OPRGB and ADOBE_YCC to OPYCC
Date:   Sun, 11 Nov 2018 14:21:02 -0800
Message-Id: <20181111221658.621794364@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hansverk@cisco.com>

commit 463659a08d7999d5461fa45b35b17686189a70ca upstream.

These names have been renamed in the CTA-861 standard due to trademark
issues. Replace them here as well so they are in sync with the standard.

Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Cc: stable@vger.kernel.org
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/adv7511.c               |    4 ++--
 drivers/media/v4l2-core/v4l2-dv-timings.c |    4 ++--
 drivers/video/hdmi.c                      |    8 ++++----
 include/linux/hdmi.h                      |    4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/media/i2c/adv7511.c
+++ b/drivers/media/i2c/adv7511.c
@@ -1357,8 +1357,8 @@ static int adv7511_set_fmt(struct v4l2_s
 	switch (format->format.colorspace) {
 	case V4L2_COLORSPACE_OPRGB:
 		c = HDMI_COLORIMETRY_EXTENDED;
-		ec = y ? HDMI_EXTENDED_COLORIMETRY_ADOBE_YCC_601 :
-			 HDMI_EXTENDED_COLORIMETRY_ADOBE_RGB;
+		ec = y ? HDMI_EXTENDED_COLORIMETRY_OPYCC_601 :
+			 HDMI_EXTENDED_COLORIMETRY_OPRGB;
 		break;
 	case V4L2_COLORSPACE_SMPTE170M:
 		c = y ? HDMI_COLORIMETRY_ITU_601 : HDMI_COLORIMETRY_NONE;
--- a/drivers/media/v4l2-core/v4l2-dv-timings.c
+++ b/drivers/media/v4l2-core/v4l2-dv-timings.c
@@ -837,7 +837,7 @@ v4l2_hdmi_rx_colorimetry(const struct hd
 		switch (avi->colorimetry) {
 		case HDMI_COLORIMETRY_EXTENDED:
 			switch (avi->extended_colorimetry) {
-			case HDMI_EXTENDED_COLORIMETRY_ADOBE_RGB:
+			case HDMI_EXTENDED_COLORIMETRY_OPRGB:
 				c.colorspace = V4L2_COLORSPACE_OPRGB;
 				c.xfer_func = V4L2_XFER_FUNC_OPRGB;
 				break;
@@ -908,7 +908,7 @@ v4l2_hdmi_rx_colorimetry(const struct hd
 				c.ycbcr_enc = V4L2_YCBCR_ENC_601;
 				c.xfer_func = V4L2_XFER_FUNC_SRGB;
 				break;
-			case HDMI_EXTENDED_COLORIMETRY_ADOBE_YCC_601:
+			case HDMI_EXTENDED_COLORIMETRY_OPYCC_601:
 				c.colorspace = V4L2_COLORSPACE_OPRGB;
 				c.ycbcr_enc = V4L2_YCBCR_ENC_601;
 				c.xfer_func = V4L2_XFER_FUNC_OPRGB;
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -592,10 +592,10 @@ hdmi_extended_colorimetry_get_name(enum
 		return "xvYCC 709";
 	case HDMI_EXTENDED_COLORIMETRY_S_YCC_601:
 		return "sYCC 601";
-	case HDMI_EXTENDED_COLORIMETRY_ADOBE_YCC_601:
-		return "Adobe YCC 601";
-	case HDMI_EXTENDED_COLORIMETRY_ADOBE_RGB:
-		return "Adobe RGB";
+	case HDMI_EXTENDED_COLORIMETRY_OPYCC_601:
+		return "opYCC 601";
+	case HDMI_EXTENDED_COLORIMETRY_OPRGB:
+		return "opRGB";
 	case HDMI_EXTENDED_COLORIMETRY_BT2020_CONST_LUM:
 		return "BT.2020 Constant Luminance";
 	case HDMI_EXTENDED_COLORIMETRY_BT2020:
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -101,8 +101,8 @@ enum hdmi_extended_colorimetry {
 	HDMI_EXTENDED_COLORIMETRY_XV_YCC_601,
 	HDMI_EXTENDED_COLORIMETRY_XV_YCC_709,
 	HDMI_EXTENDED_COLORIMETRY_S_YCC_601,
-	HDMI_EXTENDED_COLORIMETRY_ADOBE_YCC_601,
-	HDMI_EXTENDED_COLORIMETRY_ADOBE_RGB,
+	HDMI_EXTENDED_COLORIMETRY_OPYCC_601,
+	HDMI_EXTENDED_COLORIMETRY_OPRGB,
 
 	/* The following EC values are only defined in CEA-861-F. */
 	HDMI_EXTENDED_COLORIMETRY_BT2020_CONST_LUM,


