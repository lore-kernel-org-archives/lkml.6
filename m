Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033103AbeEXTVu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:21:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39659 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967440AbeEXTVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:21:46 -0400
X-Google-Smtp-Source: AB8JxZrH9rO7P2sI2DlICcmojQluXtXCe1E5g9DsDuSL0nWfVAL0bCEJOBwOeKOmrF7xxwtO9C2hqA==
From: Ramon Fried <ramon.fried@gmail.com>
To: bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ramon Fried <ramon.fried@gmail.com>
Subject: [PATCH] remoteproc: qcom_q6v5: don't auto boot remote processor
Date: Thu, 24 May 2018 22:21:41 +0300
Message-Id: <20180524192141.20323-1-ramon.fried@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes that rmtfs userspace module is not brought
up fast enough and the modem crashes.
disabling automated boot in the driver and triggering
the boot from user-space sovles the problem.

Signed-off-by: Ramon Fried <ramon.fried@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index cbbafdcaaecb..719ee96445b3 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -1133,6 +1133,8 @@ static int q6v5_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	rproc->auto_boot = false;
+
 	qproc = (struct q6v5 *)rproc->priv;
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
-- 
2.17.0
