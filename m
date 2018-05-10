Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2679656-1525981385-2-17491403767975275669
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES encafr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981384; b=WS1JHkneoNoiz8kYZ3WjA8Ja9fKLfsSdeM2PQKd1df3meWTBWn
    UfoZhYl0tnLZau8LFtztzO0YGGZ6Xm6x0zlR+gcsDPRo+suz9mbSswlE4T9yLxBd
    VwY+4Vdg1iQkoPbzBI5oZhK7YNYx6OA3sGo+LNpti4oeGm7OCdx3fS81vVZdef+R
    As7rXr4VEgO0+Hl9cenDUguFvQ9N7LiPPZYiaJxbXe7EM5UgzGmnuqbfZklDTcrJ
    lpCJBklnZi+q9V4a8W2jXAwpqfNjN0m15/P6o3A7rMEzxbHkRjIiAfCT6BBmcdMC
    39LJiNqW0dinsxH3JdY4trH8bgFDsuE/oN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981384; bh=WqWgs
    GLS9E0NJce0lftMBRiUnwDATtWKTcbmly6TjY0=; b=caqrn3bFODk9n+/u+8Rrs
    nEv7jdogyAb4J1C5gmjPZQXfXSroAwmAO6eAY9WtIvmi0O17RfcRi2wRnr7/v0BZ
    y7Fjn7xf+S/gmfMUPg4QhswWu8FKIJIN59xOk4LPEI5oKTJcY5bfdHWGsg/SpO7m
    adaHJ6VRpxtgUrNbx/ed8AxBw22c4Ki6evYvLqZv+a/l8sMuTP6EjDtdApeV1OlY
    rsZBg4N2ZeUGH9vhR6ekIhqZhk7EmouXSbkzuOgYwcbRCR5KOvb9o8tEqdDYiEug
    t9RANkTaWqQmDGrqKzLTTVd3fVB+YEMwa3YI9F7vpg0HneHEVW51sEIIRnE8P2YT
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMlQSfytovL2HdPbq8eoYWGYii2DKCQ0mPCBUl1ccPNyT30aEQavvp30k6DguGQZnOn+83u9cUONnTfhzuYMDmRNf825IRW1DzzTx7HiZ8uFvgRkrLH9
    YoHBU0nkNxIZNWqipL4W1mbQQPxJLy8GXCCrypLaNr38lM9Th5mgiARoyNKZL08OJKII3GxZuhaOJ2yRv1FlrsBDD0DDOiorL0924viG3pSakBsf0KUYzwn0
    MoE+/qHJclyPmUxxPkZBvg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=WFZIRff2AAAA:8 a=-VAfIpHNAAAA:8
    a=DDOyTI_5AAAA:8 a=PKYeVk12mt981RKGCcIA:9 a=CjuIK1q_8ugA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 12/12] staging: bcm2835-camera: Fix identation of tables
Date: Thu, 10 May 2018 12:42:16 -0700
Message-Id: <20180510194220.30675-13-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510194220.30675-1-eric@anholt.net>
References: <20180510194220.30675-1-eric@anholt.net>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Eric Anholt <eric@anholt.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

As requested by Mauro Carvalho Chehab in review.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bcm2835-camera/bcm2835-camera.c           | 289 +++++++++---------
 1 file changed, 139 insertions(+), 150 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index bd6bf3d991ef..ad53bce5c786 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -79,145 +79,132 @@ static const struct v4l2_fract
 /* video formats */
 static struct mmal_fmt formats[] = {
 	{
-	 .name = "4:2:0, planar, YUV",
-	 .fourcc = V4L2_PIX_FMT_YUV420,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_I420,
-	 .depth = 12,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 1,
-	 .remove_padding = 1,
-	 },
-	{
-	 .name = "4:2:2, packed, YUYV",
-	 .fourcc = V4L2_PIX_FMT_YUYV,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_YUYV,
-	 .depth = 16,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 2,
-	 .remove_padding = 0,
-	 },
-	{
-	 .name = "RGB24 (LE)",
-	 .fourcc = V4L2_PIX_FMT_RGB24,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_RGB24,
-	 .depth = 24,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 3,
-	 .remove_padding = 0,
-	 },
-	{
-	 .name = "JPEG",
-	 .fourcc = V4L2_PIX_FMT_JPEG,
-	 .flags = V4L2_FMT_FLAG_COMPRESSED,
-	 .mmal = MMAL_ENCODING_JPEG,
-	 .depth = 8,
-	 .mmal_component = MMAL_COMPONENT_IMAGE_ENCODE,
-	 .ybbp = 0,
-	 .remove_padding = 0,
-	 },
-	{
-	 .name = "H264",
-	 .fourcc = V4L2_PIX_FMT_H264,
-	 .flags = V4L2_FMT_FLAG_COMPRESSED,
-	 .mmal = MMAL_ENCODING_H264,
-	 .depth = 8,
-	 .mmal_component = MMAL_COMPONENT_VIDEO_ENCODE,
-	 .ybbp = 0,
-	 .remove_padding = 0,
-	 },
-	{
-	 .name = "MJPEG",
-	 .fourcc = V4L2_PIX_FMT_MJPEG,
-	 .flags = V4L2_FMT_FLAG_COMPRESSED,
-	 .mmal = MMAL_ENCODING_MJPEG,
-	 .depth = 8,
-	 .mmal_component = MMAL_COMPONENT_VIDEO_ENCODE,
-	 .ybbp = 0,
-	 .remove_padding = 0,
-	 },
-	{
-	 .name = "4:2:2, packed, YVYU",
-	 .fourcc = V4L2_PIX_FMT_YVYU,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_YVYU,
-	 .depth = 16,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 2,
-	 .remove_padding = 0,
-	 },
-	{
-	 .name = "4:2:2, packed, VYUY",
-	 .fourcc = V4L2_PIX_FMT_VYUY,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_VYUY,
-	 .depth = 16,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 2,
-	 .remove_padding = 0,
-	 },
-	{
-	 .name = "4:2:2, packed, UYVY",
-	 .fourcc = V4L2_PIX_FMT_UYVY,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_UYVY,
-	 .depth = 16,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 2,
-	 .remove_padding = 0,
-	 },
-	{
-	 .name = "4:2:0, planar, NV12",
-	 .fourcc = V4L2_PIX_FMT_NV12,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_NV12,
-	 .depth = 12,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 1,
-	 .remove_padding = 1,
-	 },
-	{
-	 .name = "RGB24 (BE)",
-	 .fourcc = V4L2_PIX_FMT_BGR24,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_BGR24,
-	 .depth = 24,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 3,
-	 .remove_padding = 0,
-	 },
-	{
-	 .name = "4:2:0, planar, YVU",
-	 .fourcc = V4L2_PIX_FMT_YVU420,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_YV12,
-	 .depth = 12,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 1,
-	 .remove_padding = 1,
-	 },
-	{
-	 .name = "4:2:0, planar, NV21",
-	 .fourcc = V4L2_PIX_FMT_NV21,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_NV21,
-	 .depth = 12,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 1,
-	 .remove_padding = 1,
-	 },
-	{
-	 .name = "RGB32 (BE)",
-	 .fourcc = V4L2_PIX_FMT_BGR32,
-	 .flags = 0,
-	 .mmal = MMAL_ENCODING_BGRA,
-	 .depth = 32,
-	 .mmal_component = MMAL_COMPONENT_CAMERA,
-	 .ybbp = 4,
-	 .remove_padding = 0,
-	 },
+		.name = "4:2:0, planar, YUV",
+		.fourcc = V4L2_PIX_FMT_YUV420,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_I420,
+		.depth = 12,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 1,
+		.remove_padding = 1,
+	}, {
+		.name = "4:2:2, packed, YUYV",
+		.fourcc = V4L2_PIX_FMT_YUYV,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_YUYV,
+		.depth = 16,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 2,
+		.remove_padding = 0,
+	}, {
+		.name = "RGB24 (LE)",
+		.fourcc = V4L2_PIX_FMT_RGB24,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_RGB24,
+		.depth = 24,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 3,
+		.remove_padding = 0,
+	}, {
+		.name = "JPEG",
+		.fourcc = V4L2_PIX_FMT_JPEG,
+		.flags = V4L2_FMT_FLAG_COMPRESSED,
+		.mmal = MMAL_ENCODING_JPEG,
+		.depth = 8,
+		.mmal_component = MMAL_COMPONENT_IMAGE_ENCODE,
+		.ybbp = 0,
+		.remove_padding = 0,
+	}, {
+		.name = "H264",
+		.fourcc = V4L2_PIX_FMT_H264,
+		.flags = V4L2_FMT_FLAG_COMPRESSED,
+		.mmal = MMAL_ENCODING_H264,
+		.depth = 8,
+		.mmal_component = MMAL_COMPONENT_VIDEO_ENCODE,
+		.ybbp = 0,
+		.remove_padding = 0,
+	}, {
+		.name = "MJPEG",
+		.fourcc = V4L2_PIX_FMT_MJPEG,
+		.flags = V4L2_FMT_FLAG_COMPRESSED,
+		.mmal = MMAL_ENCODING_MJPEG,
+		.depth = 8,
+		.mmal_component = MMAL_COMPONENT_VIDEO_ENCODE,
+		.ybbp = 0,
+		.remove_padding = 0,
+	}, {
+		.name = "4:2:2, packed, YVYU",
+		.fourcc = V4L2_PIX_FMT_YVYU,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_YVYU,
+		.depth = 16,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 2,
+		.remove_padding = 0,
+	}, {
+		.name = "4:2:2, packed, VYUY",
+		.fourcc = V4L2_PIX_FMT_VYUY,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_VYUY,
+		.depth = 16,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 2,
+		.remove_padding = 0,
+	}, {
+		.name = "4:2:2, packed, UYVY",
+		.fourcc = V4L2_PIX_FMT_UYVY,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_UYVY,
+		.depth = 16,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 2,
+		.remove_padding = 0,
+	}, {
+		.name = "4:2:0, planar, NV12",
+		.fourcc = V4L2_PIX_FMT_NV12,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_NV12,
+		.depth = 12,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 1,
+		.remove_padding = 1,
+	}, {
+		.name = "RGB24 (BE)",
+		.fourcc = V4L2_PIX_FMT_BGR24,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_BGR24,
+		.depth = 24,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 3,
+		.remove_padding = 0,
+	}, {
+		.name = "4:2:0, planar, YVU",
+		.fourcc = V4L2_PIX_FMT_YVU420,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_YV12,
+		.depth = 12,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 1,
+		.remove_padding = 1,
+	}, {
+		.name = "4:2:0, planar, NV21",
+		.fourcc = V4L2_PIX_FMT_NV21,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_NV21,
+		.depth = 12,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 1,
+		.remove_padding = 1,
+	}, {
+		.name = "RGB32 (BE)",
+		.fourcc = V4L2_PIX_FMT_BGR32,
+		.flags = 0,
+		.mmal = MMAL_ENCODING_BGRA,
+		.depth = 32,
+		.mmal_component = MMAL_COMPONENT_CAMERA,
+		.ybbp = 4,
+		.remove_padding = 0,
+	},
 };
 
 static struct mmal_fmt *get_format(struct v4l2_format *f)
@@ -676,17 +663,19 @@ static int set_overlay_params(struct bm2835_mmal_dev *dev,
 			      struct vchiq_mmal_port *port)
 {
 	struct mmal_parameter_displayregion prev_config = {
-	.set = MMAL_DISPLAY_SET_LAYER | MMAL_DISPLAY_SET_ALPHA |
-	    MMAL_DISPLAY_SET_DEST_RECT | MMAL_DISPLAY_SET_FULLSCREEN,
-	.layer = PREVIEW_LAYER,
-	.alpha = dev->overlay.global_alpha,
-	.fullscreen = 0,
-	.dest_rect = {
-		      .x = dev->overlay.w.left,
-		      .y = dev->overlay.w.top,
-		      .width = dev->overlay.w.width,
-		      .height = dev->overlay.w.height,
-		      },
+		.set =	MMAL_DISPLAY_SET_LAYER |
+			MMAL_DISPLAY_SET_ALPHA |
+			MMAL_DISPLAY_SET_DEST_RECT |
+			MMAL_DISPLAY_SET_FULLSCREEN,
+		.layer = PREVIEW_LAYER,
+		.alpha = dev->overlay.global_alpha,
+		.fullscreen = 0,
+		.dest_rect = {
+			.x = dev->overlay.w.left,
+			.y = dev->overlay.w.top,
+			.width = dev->overlay.w.width,
+			.height = dev->overlay.w.height,
+		},
 	};
 	return vchiq_mmal_port_parameter_set(dev->instance, port,
 					     MMAL_PARAMETER_DISPLAYREGION,
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
