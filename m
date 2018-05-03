Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2326437-1525342908-2-13198487497883249151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525342907; b=hEQvi7IIp1UoyHDZP1Q7CbuKuH44qhgSkWxDz1qHPWWFNNAn2f
    meU6RX2TIdJLxmQli2qothkVhGjxi9YHVMQr+jEXQMNSmVlg3J9+YI0H8rk9tHd1
    wM2XtftRPjXuhTul6g8BvcvGcbmfmR4Ya8W0Ti/Lt9HZgcPLi2qlm4DtZmtZ4v5/
    HXy5RoNK+hvdc/OLF5vxk2LOYsSEhMhc7WVsXOcri6BeM1ZgH7v9I9VGsnwKzEr+
    C+KF+NB9bmJghwl0t1Ik6ZtY4hgSSQ5hKE/dA3VHtyZj9svVYvuOUxQeffzdkuMu
    eoinchBraazLHC9qgnK7rV8YdHQunyLtLqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525342907; bh=yv7oc
    taSELPTePyYQdf/38LZgL2q33b0Zu//0NEGtsE=; b=TaAf0OJWkViOGion3nLoP
    AxuimeFV6sB25y5tA+2qScnIcI5Rz2TSieEF2X169eCHskil47LQHstHexS4hCB5
    o0j69HW4KyNVCV1edSrknsaRGe9w3K6GXolqKJ+cUb+bQWVYqfHUB81viVO6eIhE
    Mhi4iuVcCL4DL/EJR9L2subf6Q9Fj0U+0oCeFJw5qF5YD0EI3+gly89QqRw0cCgJ
    oqdzhWjU39AMceR9kQmbBiYCITWGSgIE1cqBAir2gwOJmWab7aJ1nyb1jjP/HTww
    hSpR0qiwKgpQg0GacCHmKLzSYw116wG7v3lcWohFaNW9mHLlF+NUrbgJd0qosRMZ
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=HEZWfL/m x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=YL/7dWHY;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=HEZWfL/m x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=YL/7dWHY;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJe83UnGFduAxwoBD1wMqxTLpSyi00L8CzgNAVhOLW5ncaA1bWAgfV5c1Ze318O6ItQZHepCT8BBNW1mAI+ESC12qV8Pmtz1u3OJM83r/RKzQfj1Sw6y
    CtZ04vIjryJVNPsyN9TJ127e7TNc9u0WA8oMSKi4CiBGqcgQk5iR9VOEprT/UMadmkm5sYzKxoJZFhbG4kceu0MbJ0oQC8peMOurdHMPA+G1hk2y/mFwjKhu
    skumvvOX2JBGwMgbLSMTpA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=MeXJJGO7C0gA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=yUvpWYMRTKMugl7loOcA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZofMbaVFLSERTyxYxcaeQamJmSnouC3vCiPCr2ZS+xMOx1Ivi8CcjnvXx4jqBmAZbvDDSQOJw==
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] staging: most: video: use __func__ instead of function name
Date: Thu,  3 May 2018 15:51:05 +0530
Message-Id: <20180503102105.13225-1-abdun.nihaal@gmail.com>
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
Cc: devel@driverdev.osuosl.org, Abdun Nihaal <abdun.nihaal@gmail.com>,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This fixes the following checkpatch warning in video.c:

WARNING: Prefer using '\"%s...\", __func__' to using function's name
in a string

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/most/video/video.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 9d7e747519d9..c85e289275a9 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -73,7 +73,7 @@ static int comp_vdev_open(struct file *filp)
 	struct most_video_dev *mdev = video_drvdata(filp);
 	struct comp_fh *fh;
 
-	v4l2_info(&mdev->v4l2_dev, "comp_vdev_open()\n");
+	v4l2_info(&mdev->v4l2_dev, "%s()\n", __func__);
 
 	switch (vdev->vfl_type) {
 	case VFL_TYPE_GRABBER:
@@ -122,7 +122,7 @@ static int comp_vdev_close(struct file *filp)
 	struct most_video_dev *mdev = fh->mdev;
 	struct mbo *mbo, *tmp;
 
-	v4l2_info(&mdev->v4l2_dev, "comp_vdev_close()\n");
+	v4l2_info(&mdev->v4l2_dev, "%s()\n", __func__);
 
 	/*
 	 * We need to put MBOs back before we call most_stop_channel()
@@ -250,7 +250,7 @@ static int vidioc_querycap(struct file *file, void *priv,
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	v4l2_info(&mdev->v4l2_dev, "vidioc_querycap()\n");
+	v4l2_info(&mdev->v4l2_dev, "%s()\n", __func__);
 
 	strlcpy(cap->driver, "v4l2_component", sizeof(cap->driver));
 	strlcpy(cap->card, "MOST", sizeof(cap->card));
@@ -270,7 +270,7 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	v4l2_info(&mdev->v4l2_dev, "vidioc_enum_fmt_vid_cap() %d\n", f->index);
+	v4l2_info(&mdev->v4l2_dev, "%s() %d\n", __func__, f->index);
 
 	if (f->index)
 		return -EINVAL;
@@ -289,7 +289,7 @@ static int vidioc_g_fmt_vid_cap(struct file *file, void *priv,
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	v4l2_info(&mdev->v4l2_dev, "vidioc_g_fmt_vid_cap()\n");
+	v4l2_info(&mdev->v4l2_dev, "%s()\n", __func__);
 
 	comp_set_format_struct(f);
 	return 0;
@@ -318,7 +318,7 @@ static int vidioc_g_std(struct file *file, void *priv, v4l2_std_id *norm)
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	v4l2_info(&mdev->v4l2_dev, "vidioc_g_std()\n");
+	v4l2_info(&mdev->v4l2_dev, "%s()\n", __func__);
 
 	*norm = V4L2_STD_UNKNOWN;
 	return 0;
@@ -355,7 +355,7 @@ static int vidioc_s_input(struct file *file, void *priv, unsigned int index)
 	struct comp_fh *fh = priv;
 	struct most_video_dev *mdev = fh->mdev;
 
-	v4l2_info(&mdev->v4l2_dev, "vidioc_s_input(%d)\n", index);
+	v4l2_info(&mdev->v4l2_dev, "%s(%d)\n", __func__, index);
 
 	if (index >= V4L2_CMP_MAX_INPUT)
 		return -EINVAL;
@@ -435,7 +435,7 @@ static int comp_register_videodev(struct most_video_dev *mdev)
 {
 	int ret;
 
-	v4l2_info(&mdev->v4l2_dev, "comp_register_videodev()\n");
+	v4l2_info(&mdev->v4l2_dev, "%s()\n", __func__);
 
 	init_waitqueue_head(&mdev->wait_data);
 
@@ -465,7 +465,7 @@ static int comp_register_videodev(struct most_video_dev *mdev)
 
 static void comp_unregister_videodev(struct most_video_dev *mdev)
 {
-	v4l2_info(&mdev->v4l2_dev, "comp_unregister_videodev()\n");
+	v4l2_info(&mdev->v4l2_dev, "%s()\n", __func__);
 
 	video_unregister_device(mdev->vdev);
 }
@@ -485,7 +485,7 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
 	int ret;
 	struct most_video_dev *mdev = get_comp_dev(iface, channel_idx);
 
-	pr_info("comp_probe_channel(%s)\n", name);
+	pr_info("%s(%s)\n", __func__, name);
 
 	if (mdev) {
 		pr_err("channel already linked\n");
@@ -531,7 +531,7 @@ static int comp_probe_channel(struct most_interface *iface, int channel_idx,
 	spin_lock_irq(&list_lock);
 	list_add(&mdev->list, &video_devices);
 	spin_unlock_irq(&list_lock);
-	v4l2_info(&mdev->v4l2_dev, "comp_probe_channel() done\n");
+	v4l2_info(&mdev->v4l2_dev, "%s() done\n", __func__);
 	return 0;
 
 err_unreg:
@@ -550,7 +550,7 @@ static int comp_disconnect_channel(struct most_interface *iface,
 		return -ENOENT;
 	}
 
-	v4l2_info(&mdev->v4l2_dev, "comp_disconnect_channel()\n");
+	v4l2_info(&mdev->v4l2_dev, "%s()\n", __func__);
 
 	spin_lock_irq(&list_lock);
 	list_del(&mdev->list);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
