Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3079855-1525797066-2-15424927365437717755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525797065; b=ErvTkHx0LcfNN1aaeuxhiY8J27cKXPD9GAyQ+uzOTQS4fKt8qD
    Z2RIJSdOx/nE6leyhRSOGBgLXlaKMXnA8qAw8R1KxulCMlUHsniIOO8f7gwuhd9g
    +gilxrgfSNWQ6wWE5fZ87vtk5ARh+AwowRytu/KAjAB5wlwHQKNtgr2bpT2+ELJc
    rZwgWRdzXLx/fjX/0u/2ELIyijW2EWKin5clFW8e+MPihF0qDFLw61Yb7bTR0C3D
    mSKyq/NL4hZZ3TEPot7PzdxRodmH5z3OWinS7DTed2H45pB8Rd9yUOSd/9MqUj6T
    JN/mufCdaPxQHMezsCon85/LHhDpr1vab3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525797065; bh=msD8e
    zUJjl0zjV5GV4NscNC+qy631BgetHKIYSKktM8=; b=cAW7BSfuiU/gyGltYJ/FG
    YEqNhGy7PTnfLLsF2i++j1fwtea+9UC3PnDHnCYM295fvvFtRBvuSrE4fn8F6r8e
    I6kMqqdVA3sCUDYBbRZFyV9gLPPcXAOl1zOGvjdZ9OO4VNGYAOcdQa2kgCCQxT8C
    O57teToYStX6deeDcJ9ZdFqrSrWOdUvj99I3x/zJv5r+G2WgN93QQJpCxTaAkf21
    Q4Bu7C0btVVOqaYdlBtmohymfUAc2jPnfuFoFGcMM2MGz3Y9aw1ioRrJWLaYvNXV
    D+Y8aoaAX1wNPVXrxWMEYdTGkLzW0zLGaJNiFdx1HavZIR4O8aAGVJVEDllj7u/V
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=MiBrgFjN x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=W5aOW1BH;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=MiBrgFjN x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=W5aOW1BH;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHmdHfUirvvOqvXPwqKjFsJKF9WMtZVJSVXp6cq2yFnSo5j3ELodXyxZJ6qheX+savEF4DgIeacEbgDOO/Z5bZXy8nmh++F0fEsQ9EwXVRASPbqf+qgX
    d5jl7G3WBXYesj9GvI+lmoqIQ3meWso3stD0ElXYLUByicE0TLYayJd7ZZjt32buxlVf28ENunVynv7Fd8GgtSvqNdlhsXKYj04/Wymr11kBaYqCsKXDi7L2
    bmAc8KBF2pANVS3f+RFECQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=MeXJJGO7C0gA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=yll8hsJP9Prk1AZ90JoA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZreLbWGeS11zn2r04jfL4Qm8APi5Tv8uLd/FACaWHi/q2IYxXX3P4Kv+lKz/RN/xKzLCyKaKQ==
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] staging: most: video: remove debugging code
Date: Tue,  8 May 2018 22:00:40 +0530
Message-Id: <20180508163040.27616-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: devel@driverdev.osuosl.org, christian.gromm@microchip.com,
 linux-kernel@vger.kernel.org, Abdun Nihaal <abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch removes debugging code in video.c that causes the following
checkpatch warning:

WARNING: Prefer using '\"%s...\", __func__' to using function's name in a string

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/most/video/video.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 9d7e747519d9..fc374711fcc0 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -73,8 +73,6 @@ static int comp_vdev_open(struct file *filp)
 	struct most_video_dev *mdev = video_drvdata(filp);
 	struct comp_fh *fh;
 
-	v4l2_info(&mdev->v4l2_dev, "comp_vdev_open()\n");
-
 	switch (vdev->vfl_type) {
 	case VFL_TYPE_GRABBER:
 		break;
@@ -122,8 +120,6 @@ static int comp_vdev_close(struct file *filp)
 	struct most_video_dev *mdev = fh->mdev;
 	struct mbo *mbo, *tmp;
 
-	v4l2_info(&mdev->v4l2_dev, "comp_vdev_close()\n");
-
 	/*
 	 * We need to put MBOs back before we call most_stop_channel()
 	 * to deallocate MBOs.
@@ -250,8 +246,6 @@ static int vidioc_querycap(struct file *file, void *priv,
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	v4l2_info(&mdev->v4l2_dev, "vidioc_querycap()\n");
-
 	strlcpy(cap->driver, "v4l2_component", sizeof(cap->driver));
 	strlcpy(cap->card, "MOST", sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info),
@@ -270,8 +264,6 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	v4l2_info(&mdev->v4l2_dev, "vidioc_enum_fmt_vid_cap() %d\n", f->index);
-
 	if (f->index)
 		return -EINVAL;
 
@@ -289,8 +281,6 @@ static int vidioc_g_fmt_vid_cap(struct file *file, void *priv,
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	v4l2_info(&mdev->v4l2_dev, "vidioc_g_fmt_vid_cap()\n");
-
 	comp_set_format_struct(f);
 	return 0;
 }
@@ -318,8 +308,6 @@ static int vidioc_g_std(struct file *file, void *priv, v4l2_std_id *norm)
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	v4l2_info(&mdev->v4l2_dev, "vidioc_g_std()\n");
-
 	*norm = V4L2_STD_UNKNOWN;
 	return 0;
 }
@@ -355,8 +343,6 @@ static int vidioc_s_input(struct file *file, void *priv, unsigned int index)
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	v4l2_info(&mdev->v4l2_dev, "vidioc_s_input(%d)\n", index);
-
 	if (index >= V4L2_CMP_MAX_INPUT)
 		return -EINVAL;
 	mdev->ctrl_input = index;
@@ -435,8 +421,6 @@ static int comp_register_videodev(struct most_video_dev *mdev)
 {
 	int ret;
 
-	v4l2_info(&mdev->v4l2_dev, "comp_register_videodev()\n");
-
 	init_waitqueue_head(&mdev->wait_data);
 
 	/* allocate and fill v4l2 video struct */
@@ -465,8 +449,6 @@ static int comp_register_videodev(struct most_video_dev *mdev)
 
 static void comp_unregister_videodev(struct most_video_dev *mdev)
 {
-	v4l2_info(&mdev->v4l2_dev, "comp_unregister_videodev()\n");
-
 	video_unregister_device(mdev->vdev);
 }
 
@@ -485,8 +467,6 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
 	int ret;
 	struct most_video_dev *mdev = get_comp_dev(iface, channel_idx);
 
-	pr_info("comp_probe_channel(%s)\n", name);
-
 	if (mdev) {
 		pr_err("channel already linked\n");
 		return -EEXIST;
@@ -531,7 +511,6 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
 	spin_lock_irq(&list_lock);
 	list_add(&mdev->list, &video_devices);
 	spin_unlock_irq(&list_lock);
-	v4l2_info(&mdev->v4l2_dev, "comp_probe_channel() done\n");
 	return 0;
 
 err_unreg:
@@ -550,8 +529,6 @@ static int comp_disconnect_channel(struct most_interface *iface,
 		return -ENOENT;
 	}
 
-	v4l2_info(&mdev->v4l2_dev, "comp_disconnect_channel()\n");
-
 	spin_lock_irq(&list_lock);
 	list_del(&mdev->list);
 	spin_unlock_irq(&list_lock);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
