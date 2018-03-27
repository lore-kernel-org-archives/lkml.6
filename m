Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeC0VHa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:07:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33870 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbeC0VGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:06:48 -0400
X-Google-Smtp-Source: AIpwx4+u2OXL1wWxvbbVdYUEKYh8TuvG01cSGxDx+5+OkiN/488f0VcW146kqzjr0d9uHqW4lhs0mw==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/3] rpmsg: smd: Fix container_of macros
Date: Tue, 27 Mar 2018 14:06:41 -0700
Message-Id: <20180327210643.3436-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180327210643.3436-1-bjorn.andersson@linaro.org>
References: <20180327210643.3436-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The container_of macros should not use the same name for the parameter
as the member to use for lookup, as this will result in a compilation
error unless the passed parameter has the same name as the member.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_smd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index dabd73bd5577..6bb9d21be6bc 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -167,9 +167,9 @@ struct qcom_smd_endpoint {
 	struct qcom_smd_channel *qsch;
 };
 
-#define to_smd_device(_rpdev)	container_of(_rpdev, struct qcom_smd_device, rpdev)
+#define to_smd_device(r)	container_of(r, struct qcom_smd_device, rpdev)
 #define to_smd_edge(d)		container_of(d, struct qcom_smd_edge, dev)
-#define to_smd_endpoint(ept)	container_of(ept, struct qcom_smd_endpoint, ept)
+#define to_smd_endpoint(e)	container_of(e, struct qcom_smd_endpoint, ept)
 
 /**
  * struct qcom_smd_channel - smd channel struct
-- 
2.16.2
