Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F09EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0B326A4B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DiCMCwDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0B326A4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935421AbeFZMMy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:12:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33728 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935265AbeFZMMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:12:14 -0400
Received: by mail-it0-f68.google.com with SMTP id k17-v6so15191650ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dml+my2/w2gAe9jnCW4w4fKNsyHGv1cJooRXIxNvLLk=;
        b=DiCMCwDfm45FgCCaAFvtTkfORC+UUxgLHZLqQv03tB39ijXozyk/RevAsUjUzWXdrx
         yqLBjiuAKAdGcYUdPQgM5aOebBziH3lahdxuTjE7bqoEJsCg5alCnzyVy5Oj28KPtHh2
         O6VWVxjkbqDT5gVWfsMLdRRuQDSRQOXJLci94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dml+my2/w2gAe9jnCW4w4fKNsyHGv1cJooRXIxNvLLk=;
        b=gcOk3jvVxG77A+br+ZH/Pkt6a6xVvBVh0bsAj7vNsy4tzmtpZzq0fD0DIjQw4E6vnu
         Zh2FB8nTGEkckvXJ2L8NrvMnw0rb5Lc6jXei2mmt8bq133yEaHZeqgz72X+FXGd5rlqB
         ZQu86Tb5H0YK//+YOzUtBv6vCrSLwwaCk/ZnDdujlk0XT6S2NDDQi7CsjrWWeJ6qxn+u
         6foEhJU5muiURNuX5/QSD+Qj54SxjHaYfY0jw3xskitieYLHGi/gmn/azQ3qK1q6F+iJ
         pvyY9+mMlY8fH/fQ8HmxNxavg3qwaiaeNCn5lLoj9M8306pHYz80M3uWd+gmnMZlYKDA
         AQNA==
X-Gm-Message-State: APt69E3HIaM3x3CkVmsI8xa07+JhiTWyUDzFVcbxYJPpuMg8RF/Oa18B
        CL5TJdnk3gzsQYEKoaWcHC8EsAdRHyk=
X-Google-Smtp-Source: AAOMgpdmoMrkxskKvZm3hDZU+K5IgLkxecT94lVOrhnGeE83N6P4aZk/DECA5SSxhvZmTzZa+wngiQ==
X-Received: by 2002:a02:9bc1:: with SMTP id f1-v6mr1028344jal.90.1530015133228;
        Tue, 26 Jun 2018 05:12:13 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id y62-v6sm902309ioy.88.2018.06.26.05.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 05:12:12 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] remoteproc: rename subdev probe and remove functions
Date:   Tue, 26 Jun 2018 07:11:58 -0500
Message-Id: <20180626121159.7267-5-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626121159.7267-1-elder@linaro.org>
References: <20180626121159.7267-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename functions used when subdevices are started and stopped to
reflect the new naming scheme.

Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by Alex Elder <elder@linaro.org>
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

