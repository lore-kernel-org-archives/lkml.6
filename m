Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2679656-1525981377-2-31696446975458647
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES encafr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981376; b=TJVYO4OzRSLOrfBQWiVyXRY1GwWXJD7DpKQhAJZIQjdJXJUFmn
    gv7SlGTx5bu4Fjr9ExiEE1x7vQ0gYuf2+NOuoPzrEB0S8aGmq+06DZEmNKamtEzv
    Iy8xXLT1oSD3Y2VRGaRXpnIW8ODKAHAILuSieHhRx+15Esoaf0Y+LE3vsPkE85H4
    CfHHbUdTY+svWZftFahEW3BcpBzZqWVyWv/biknLyT91Koulej8y9Qr7lgZLMFza
    AQnH2zL03CFCOHeodg1tdjG3q2KkygqUKSWxwgwVmQfH8B6US5i/HarX+fNNiLZr
    sEXcwaxqcHacOUKTddzEFTC8xL43yooWwF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981376; bh=WqWgs
    GLS9E0NJce0lftMBRiUnwDATtWKTcbmly6TjY0=; b=Kno5dLZEAbH6IuJ/z09+v
    KLgXN/raGy+iRPgoqdEICFB5JSuTv+KQnm2aCXTWlW8cad17U1TW6ptswN01kcid
    AvvOw2v3Uv/HzndJc9meSz/YMnPzSnyvXHqUn5dmf2sz0SdG8C0pNApT9loWYtKW
    WgnFpmZr6uyBjGi7Qg6LRmqhNKLdgOCRXgs+b3BbTP4lL0JnuYqKncEwnGQ1e0W4
    areAC1Oq6B9sHVnc8458ZCLyJwY2RszlakxgCdsL50KPr/5sbqOqp9KyuZJABmM2
    nBeFi2JSx4op+V/Sk7z2XD9E0zG6YS5PqJA+2MxpEbDaNDllEwsw+1dgdBzMdNx+
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
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
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMXYNJvs4qicdmIKlnsb+iYPW9LAG99tfq4y3GBEAhr2zT4yqDSgdaxVXVtkqZ35/p82fC0slYr5qz+puFZLFOww+GOIj4+CzL73oasJRFDR4cU/RyE1
    R4ivukvIWwlOInvfOe6bQCaTgHiZU1M6so64svd/oTHPaCnPbs3KDqma762XwnGOn9qm6PCt2HsQBsCO7nkEdH/kIpc5ixJSYS7b9IeVAYLW+XCnJjBbUljd
    7pCwK36SAXYrkFBaV/VJcw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
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
Subject: [PATCH 12/15] staging: bcm2835-camera: Fix indentation of tables
Date: Thu, 10 May 2018 12:42:17 -0700
Message-Id: <20180510194220.30675-14-eric@anholt.net>
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
