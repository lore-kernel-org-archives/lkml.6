Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FA8C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3812064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k41j+uOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3812064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeJIBtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJIBtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:49:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAEA120C0A;
        Mon,  8 Oct 2018 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023769;
        bh=Ym6pHhThQGOhuSsLJmO7NyOcH4dprLc9Pycfh8ZfLLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k41j+uOz33KvCJwtKbKRTenQAi18eAJ5YWskR+ey/ZLLA/KQMYoq/59pAMn8PfPu5
         6533UFT5Mq0aj0uOFp3a1TzRvCX9JJl0TNFpmjwzU/bdRkSex+VIbBmF3fP+/oTrtc
         vHC3WOl8kfgVz3D/JdzGYaGNVykA3Qq4lMMLbr9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ming_qian <ming_qian@realsil.com.cn>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ana Guerrero Lopez <ana.guerrero@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.4 053/113] media: uvcvideo: Support realteks UVC 1.5 device
Date:   Mon,  8 Oct 2018 20:30:54 +0200
Message-Id: <20181008175533.815886989@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ming_qian <ming_qian@realsil.com.cn>

commit f620d1d7afc7db57ab59f35000752840c91f67e7 upstream.

media: uvcvideo: Support UVC 1.5 video probe & commit controls

The length of UVC 1.5 video control is 48, and it is 34 for UVC 1.1.
Change it to 48 for UVC 1.5 device, and the UVC 1.5 device can be
recognized.

More changes to the driver are needed for full UVC 1.5 compatibility.
However, at least the UVC 1.5 Realtek RTS5847/RTS5852 cameras have been
reported to work well.

[laurent.pinchart@ideasonboard.com: Factor out code to helper function, update size checks]

Cc: stable@vger.kernel.org
Signed-off-by: ming_qian <ming_qian@realsil.com.cn>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Ana Guerrero Lopez <ana.guerrero@collabora.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/uvc/uvc_video.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -163,14 +163,27 @@ static void uvc_fixup_video_ctrl(struct
 	}
 }
 
+static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)
+{
+	/*
+	 * Return the size of the video probe and commit controls, which depends
+	 * on the protocol version.
+	 */
+	if (stream->dev->uvc_version < 0x0110)
+		return 26;
+	else if (stream->dev->uvc_version < 0x0150)
+		return 34;
+	else
+		return 48;
+}
+
 static int uvc_get_video_ctrl(struct uvc_streaming *stream,
 	struct uvc_streaming_control *ctrl, int probe, __u8 query)
 {
+	__u16 size = uvc_video_ctrl_size(stream);
 	__u8 *data;
-	__u16 size;
 	int ret;
 
-	size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
 	if ((stream->dev->quirks & UVC_QUIRK_PROBE_DEF) &&
 			query == UVC_GET_DEF)
 		return -EIO;
@@ -225,7 +238,7 @@ static int uvc_get_video_ctrl(struct uvc
 	ctrl->dwMaxVideoFrameSize = get_unaligned_le32(&data[18]);
 	ctrl->dwMaxPayloadTransferSize = get_unaligned_le32(&data[22]);
 
-	if (size == 34) {
+	if (size >= 34) {
 		ctrl->dwClockFrequency = get_unaligned_le32(&data[26]);
 		ctrl->bmFramingInfo = data[30];
 		ctrl->bPreferedVersion = data[31];
@@ -254,11 +267,10 @@ out:
 static int uvc_set_video_ctrl(struct uvc_streaming *stream,
 	struct uvc_streaming_control *ctrl, int probe)
 {
+	__u16 size = uvc_video_ctrl_size(stream);
 	__u8 *data;
-	__u16 size;
 	int ret;
 
-	size = stream->dev->uvc_version >= 0x0110 ? 34 : 26;
 	data = kzalloc(size, GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
@@ -275,7 +287,7 @@ static int uvc_set_video_ctrl(struct uvc
 	put_unaligned_le32(ctrl->dwMaxVideoFrameSize, &data[18]);
 	put_unaligned_le32(ctrl->dwMaxPayloadTransferSize, &data[22]);
 
-	if (size == 34) {
+	if (size >= 34) {
 		put_unaligned_le32(ctrl->dwClockFrequency, &data[26]);
 		data[30] = ctrl->bmFramingInfo;
 		data[31] = ctrl->bPreferedVersion;


