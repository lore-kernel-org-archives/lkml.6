Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2676370-1525981359-5-10845807907697739314
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981358; b=emEaNkMyeVDBPBFLkDRhtmqivI53HChrxwo6rQu1dwdGorhAMY
    PM4Li5uEwIGfmeokoU6M+oUNqCpyJHSlCWyrDFmqGIWDwva5Tu+2NStrWY7PPY4c
    XP8b+x57yzFLCkzY+Kw8vmPGuRQHRHXohp+ZR5tKJfMAythcEY0q3/fQTt3REUYP
    A0Xf7kVYzLUF7DfnfLmFBTsQcbY3stifu73ZS/aMGD/3rTNb3jgwaHJPb8/sFNJl
    DvuvrU0G7I6oFpjSgIsM4YCDZgf2/Nhe2LR/A7rEgv7i+9w/B/T41YxcLnA6jCOm
    a/8sH92Dr6Lj4elknLsxUKrgbxj7Q1Vja8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981358; bh=8VzRg
    wR2dwSNCTRU3jdk0jUacc6V/1PmmQuLRzCfbBw=; b=IjIsALXdwRieRqnB1wNcl
    1XgxJ08cebZdUc9MhhdXJsb1wGYW2iPsVnaGjiaJcWkqFV9BapESjPA1VM6WjIGL
    714DumikblV+qm9dLEKuXdeaDPScEw79epMr73Y25nHupOt2UtyUg4GrQa/+jpmy
    ieCE7IvFBK5683kCiBajRO2tDZ79U5mri0/lhvTflp52H0a0vslalLdrjCEoEhuM
    +aCxJC/zUUUAyiO7qfw4mL7iqeQmXVR1qIkcGipP2A93Eedtlekmz9QMwAFiC2De
    QujTTOh7aF8hVZnG1/P4iem3EwXdHeC5yndyRw+tueTelUBuGXgaWll2WXCNEcje
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
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
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGIDtnguoVqEmZ/27lQThGZwKuSWIKrXUIhaRpRN0tMCJBtX0eYEG8ztCbh3O5m3vWFvdJTifVVgIP0vrG6/6721rQJkJ6XWj4SmzUurcTSwUMXI94Oh
    kME22hX/hrsAilvIj52APyjDoFyfSJHY6LywpFnmS0+mLv2fXWvoxfOoGSpHww0XX5qqhhA7fEhWkn1c/yQMLcyuYJnMOYtu9hZINFekXm4/gNSf2C9z5MXu
    3vQQHHcaA1PyzGWNXlAZFg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=NEAV23lmAAAA:8 a=WFZIRff2AAAA:8
    a=-VAfIpHNAAAA:8 a=DDOyTI_5AAAA:8 a=U7VM7ceA6Wpb5NxDmfUA:9 a=CjuIK1q_8ugA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 03/15] staging: bcm2835-camera: Skip ISP pass to eliminate
 padding.
Date: Thu, 10 May 2018 12:42:07 -0700
Message-Id: <20180510194220.30675-4-eric@anholt.net>
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
 Dave Stevenson <6by9@users.noreply.github.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Stevenson <6by9@users.noreply.github.com>

Interleaved RGB and single plane YUV formats can be delivered by the
GPU without the secondary step of removing padding, as the
bytesperline field can be set appropriately.

Planar YUV needs the GPU to still remove padding, as there is no way
to report that there is padding between the planes (ie on the height).
The multi-planar formats are NOT applicable, as there is no easy way
to make them contiguous in memory (ie one large allocation that gets
broken up). The whole task is passed across to videobuf2 which has no
notion of that requirement.

v2: Changes by anholt from the downstream driver: Flag two more planar
    formats as needing padding removal, and remove broken userspace
    workaround.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bcm2835-camera/bcm2835-camera.c           | 44 ++++++++++++++-----
 .../bcm2835-camera/mmal-common.h              |  3 ++
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index aac876c35dea..7b32c3a93873 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -86,6 +86,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 12,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 1,
+	 .remove_padding = 1,
 	 },
 	{
 	 .name = "4:2:2, packed, YUYV",
@@ -95,6 +96,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 16,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 2,
+	 .remove_padding = 0,
 	 },
 	{
 	 .name = "RGB24 (LE)",
@@ -104,6 +106,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 24,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 3,
+	 .remove_padding = 0,
 	 },
 	{
 	 .name = "JPEG",
@@ -113,6 +116,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 8,
 	 .mmal_component = MMAL_COMPONENT_IMAGE_ENCODE,
 	 .ybbp = 0,
+	 .remove_padding = 0,
 	 },
 	{
 	 .name = "H264",
@@ -122,6 +126,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 8,
 	 .mmal_component = MMAL_COMPONENT_VIDEO_ENCODE,
 	 .ybbp = 0,
+	 .remove_padding = 0,
 	 },
 	{
 	 .name = "MJPEG",
@@ -131,6 +136,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 8,
 	 .mmal_component = MMAL_COMPONENT_VIDEO_ENCODE,
 	 .ybbp = 0,
+	 .remove_padding = 0,
 	 },
 	{
 	 .name = "4:2:2, packed, YVYU",
@@ -140,6 +146,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 16,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 2,
+	 .remove_padding = 0,
 	 },
 	{
 	 .name = "4:2:2, packed, VYUY",
@@ -149,6 +156,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 16,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 2,
+	 .remove_padding = 0,
 	 },
 	{
 	 .name = "4:2:2, packed, UYVY",
@@ -158,6 +166,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 16,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 2,
+	 .remove_padding = 0,
 	 },
 	{
 	 .name = "4:2:0, planar, NV12",
@@ -167,6 +176,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 12,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 1,
+	 .remove_padding = 1,
 	 },
 	{
 	 .name = "RGB24 (BE)",
@@ -176,6 +186,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 24,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 3,
+	 .remove_padding = 0,
 	 },
 	{
 	 .name = "4:2:0, planar, YVU",
@@ -185,6 +196,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 12,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 1,
+	 .remove_padding = 1,
 	 },
 	{
 	 .name = "4:2:0, planar, NV21",
@@ -194,6 +206,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 12,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 1,
+	 .remove_padding = 1,
 	 },
 	{
 	 .name = "RGB32 (BE)",
@@ -203,6 +216,7 @@ static struct mmal_fmt formats[] = {
 	 .depth = 32,
 	 .mmal_component = MMAL_COMPONENT_CAMERA,
 	 .ybbp = 4,
+	 .remove_padding = 0,
 	 },
 };
 
@@ -929,9 +943,19 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 			      &f->fmt.pix.height, MIN_HEIGHT, dev->max_height,
 			      1, 0);
 	f->fmt.pix.bytesperline = f->fmt.pix.width * mfmt->ybbp;
+	if (!mfmt->remove_padding) {
+		int align_mask = ((32 * mfmt->depth) >> 3) - 1;
+		/* GPU isn't removing padding, so stride is aligned to 32 */
+		f->fmt.pix.bytesperline =
+			(f->fmt.pix.bytesperline + align_mask) & ~align_mask;
+		v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
+			 "Not removing padding, so bytes/line = %d, "
+			 "(align_mask %d)\n",
+			 f->fmt.pix.bytesperline, align_mask);
+	}
 
 	/* Image buffer has to be padded to allow for alignment, even though
-	 * we then remove that padding before delivering the buffer.
+	 * we sometimes then remove that padding before delivering the buffer.
 	 */
 	f->fmt.pix.sizeimage = ((f->fmt.pix.height + 15) & ~15) *
 			(((f->fmt.pix.width + 31) & ~31) * mfmt->depth) >> 3;
@@ -964,6 +988,7 @@ static int mmal_setup_components(struct bm2835_mmal_dev *dev,
 	struct vchiq_mmal_port *port = NULL, *camera_port = NULL;
 	struct vchiq_mmal_component *encode_component = NULL;
 	struct mmal_fmt *mfmt = get_format(f);
+	u32 remove_padding;
 
 	BUG_ON(!mfmt);
 
@@ -1032,6 +1057,12 @@ static int mmal_setup_components(struct bm2835_mmal_dev *dev,
 			camera_port->format.encoding = MMAL_ENCODING_RGB24;
 	}
 
+	remove_padding = mfmt->remove_padding;
+	vchiq_mmal_port_parameter_set(dev->instance,
+				      camera_port,
+				      MMAL_PARAMETER_NO_IMAGE_PADDING,
+				      &remove_padding, sizeof(remove_padding));
+
 	camera_port->format.encoding_variant = 0;
 	camera_port->es.video.width = f->fmt.pix.width;
 	camera_port->es.video.height = f->fmt.pix.height;
@@ -1509,7 +1540,6 @@ static int __init mmal_init(struct bm2835_mmal_dev *dev)
 {
 	int ret;
 	struct mmal_es_format_local *format;
-	u32 bool_true = 1;
 	u32 supported_encodings[MAX_SUPPORTED_ENCODINGS];
 	int param_size;
 	struct vchiq_mmal_component  *camera;
@@ -1593,11 +1623,6 @@ static int __init mmal_init(struct bm2835_mmal_dev *dev)
 	format->es->video.frame_rate.num = 0; /* Rely on fps_range */
 	format->es->video.frame_rate.den = 1;
 
-	vchiq_mmal_port_parameter_set(dev->instance,
-				      &camera->output[MMAL_CAMERA_PORT_VIDEO],
-				      MMAL_PARAMETER_NO_IMAGE_PADDING,
-				      &bool_true, sizeof(bool_true));
-
 	format = &camera->output[MMAL_CAMERA_PORT_CAPTURE].format;
 
 	format->encoding = MMAL_ENCODING_OPAQUE;
@@ -1619,11 +1644,6 @@ static int __init mmal_init(struct bm2835_mmal_dev *dev)
 	dev->capture.enc_profile = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH;
 	dev->capture.enc_level = V4L2_MPEG_VIDEO_H264_LEVEL_4_0;
 
-	vchiq_mmal_port_parameter_set(dev->instance,
-				      &camera->output[MMAL_CAMERA_PORT_CAPTURE],
-				      MMAL_PARAMETER_NO_IMAGE_PADDING,
-				      &bool_true, sizeof(bool_true));
-
 	/* get the preview component ready */
 	ret = vchiq_mmal_component_init(
 			dev->instance, "ril.video_render",
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-common.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-common.h
index 800e4e7e5f96..e68ca1bf7222 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-common.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-common.h
@@ -28,6 +28,9 @@ struct mmal_fmt {
 	int   depth;
 	u32   mmal_component;  /* MMAL component index to be used to encode */
 	u32   ybbp;            /* depth of first Y plane for planar formats */
+	bool  remove_padding;  /* Does the GPU have to remove padding,
+				* or can we do hide padding via bytesperline.
+				*/
 };
 
 /* buffer for one video frame */
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
