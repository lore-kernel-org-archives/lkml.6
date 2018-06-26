Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658CCC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBDD263F0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2iYIYiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBDD263F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935356AbeFZBej (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:34:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50508 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935251AbeFZBeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:34:16 -0400
Received: by mail-it0-f65.google.com with SMTP id u4-v6so15306956itg.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5QeWxqEpyDQcrAm1vuw7S6DJdzLkwTzI+oUogCtYFc=;
        b=a2iYIYiwPtOpeNCYlUlNTatUvNE6Oj5HspI6iCRgaCMg2F+XOQZJneS9e4tpd0s78c
         fg6sahQuZ9IBcSsJI9ah24B0oMNOTg6EuEJimX0i68jiJZa7aNGGXXBglQIQvH4k5lDE
         gGE8LMuG9bvojv4JZKDASnXvmZwTwj8lE70/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5QeWxqEpyDQcrAm1vuw7S6DJdzLkwTzI+oUogCtYFc=;
        b=HiQ3hOS2ihZpfxHSOKlafmRkjZ9nJMq0DjjMykih9nkNNvtoyH0rsRWOJHWCmPeE0B
         lGnWhb6KmZotk1vW9lspFI1OJ4AFGdkRpByI4E3rvI3ceDfC4eeToZH+zMn+aCtv0sFS
         YAZvXPTUl3VrceJE+8sk2TA+S/lI+U9j/M0VRO/V512n/S/8Wqc2ebu9UmXoC/p5kEK5
         +YfURH4iy0zA1suMSM6F5sHkJBzSRoiA7gV5Tc925qAxxFJ4wt0V1XI/e3PlffJmYSrS
         ZFCDKe/UfZBaKxnW7ScGg8VbYb2AqPsHAt1fKBqJptsl5CiNXbOZbxBNlrXyJUUNbW3+
         rIGw==
X-Gm-Message-State: APt69E0hYFdVfw3Y9CpcrnUwP3aK5Lmo0qhBXEo7rJeDti3Ipl96dgXl
        vbaVCg+zUP/jEpi3Ab6SPBhbXzg0Wuk=
X-Google-Smtp-Source: ADUXVKKT8eV1YeitxIXA4eXtU9mUZT7pwq90OMP3v7U7eIIuL+4spT9dMnc6QzCcuOnv+KbRoKIXug==
X-Received: by 2002:a02:a999:: with SMTP id q25-v6mr11796857jam.47.1529976856141;
        Mon, 25 Jun 2018 18:34:16 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id h62-v6sm184699ioa.22.2018.06.25.18.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 18:34:15 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend 4/5] remoteproc: rename subdev probe and remove functions
Date:   Mon, 25 Jun 2018 20:34:08 -0500
Message-Id: <20180626013409.5125-5-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626013409.5125-1-elder@linaro.org>
References: <20180626013409.5125-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename functions used when subdevices are started and stopped to
reflect the new naming scheme.

Signed-off-by: Alex Elder <elder@linaro.org>
Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/remoteproc/qcom_common.c     | 16 ++++++++--------
 drivers/remoteproc/remoteproc_core.c |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 4ae87c5b8793..6f77840140bf 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -33,7 +33,7 @@
 
 static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);
 
-static int glink_subdev_probe(struct rproc_subdev *subdev)
+static int glink_subdev_start(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
 
@@ -42,7 +42,7 @@ static int glink_subdev_probe(struct rproc_subdev *subdev)
 	return PTR_ERR_OR_ZERO(glink->edge);
 }
 
-static void glink_subdev_remove(struct rproc_subdev *subdev, bool crashed)
+static void glink_subdev_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
 
@@ -64,8 +64,8 @@ void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink)
 		return;
 
 	glink->dev = dev;
-	glink->subdev.start = glink_subdev_probe;
-	glink->subdev.stop = glink_subdev_remove;
+	glink->subdev.start = glink_subdev_start;
+	glink->subdev.stop = glink_subdev_stop;
 
 	rproc_add_subdev(rproc, &glink->subdev);
 }
@@ -129,7 +129,7 @@ int qcom_register_dump_segments(struct rproc *rproc,
 }
 EXPORT_SYMBOL_GPL(qcom_register_dump_segments);
 
-static int smd_subdev_probe(struct rproc_subdev *subdev)
+static int smd_subdev_start(struct rproc_subdev *subdev)
 {
 	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
 
@@ -138,7 +138,7 @@ static int smd_subdev_probe(struct rproc_subdev *subdev)
 	return PTR_ERR_OR_ZERO(smd->edge);
 }
 
-static void smd_subdev_remove(struct rproc_subdev *subdev, bool crashed)
+static void smd_subdev_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
 
@@ -160,8 +160,8 @@ void qcom_add_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
 		return;
 
 	smd->dev = dev;
-	smd->subdev.start = smd_subdev_probe;
-	smd->subdev.stop = smd_subdev_remove;
+	smd->subdev.start = smd_subdev_start;
+	smd->subdev.stop = smd_subdev_stop;
 
 	rproc_add_subdev(rproc, &smd->subdev);
 }
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ca39fad175f2..2ede7ae6f5bc 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -301,14 +301,14 @@ void rproc_free_vring(struct rproc_vring *rvring)
 	rsc->vring[idx].notifyid = -1;
 }
 
-static int rproc_vdev_do_probe(struct rproc_subdev *subdev)
+static int rproc_vdev_do_start(struct rproc_subdev *subdev)
 {
 	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
 
 	return rproc_add_virtio_dev(rvdev, rvdev->id);
 }
 
-static void rproc_vdev_do_remove(struct rproc_subdev *subdev, bool crashed)
+static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
 {
 	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
 
@@ -399,8 +399,8 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 
 	list_add_tail(&rvdev->node, &rproc->rvdevs);
 
-	rvdev->subdev.start = rproc_vdev_do_probe;
-	rvdev->subdev.stop = rproc_vdev_do_remove;
+	rvdev->subdev.start = rproc_vdev_do_start;
+	rvdev->subdev.stop = rproc_vdev_do_stop;
 
 	rproc_add_subdev(rproc, &rvdev->subdev);
 
-- 
2.17.1

