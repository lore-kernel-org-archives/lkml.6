Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC620ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905A320882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLRzdNMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905A320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeINWtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:49:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34997 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbeINWtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:49:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7-v6so4724042pgf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B/dRZA9zOXPnM21W/MxPUfdNwVzVbMm0qd87ikHJCz8=;
        b=gLRzdNMRIdXFYZpsw3J3pSB7kgdy8CYkd+VyBPMn4ORy0V0F9Lbxoeme3V6X1z26SI
         59jSBaMjdU6vaTy+1t9ZgtXb9Uu56EDUwts+LKMnIf3/+VjhIo2jQOeDbI6C2VsC7Bwg
         JpJq+NleBFesITeaeDGWfy/Hb4LMrHN1i85CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B/dRZA9zOXPnM21W/MxPUfdNwVzVbMm0qd87ikHJCz8=;
        b=kkYC7Ye4GMhxifivB/keKlCkhmsDa4xO44xkGv/UNVuYQgHcEb7FfkTc1qDCxa8GH8
         bAzd1WCdSVnkxlxNNFbF0e6N9oyfTHkq+7M0jo+tg2NZhrt86DbvO9U0GfGMdOn3wqMW
         b74MVgL3vU6vkdDGxcwfGsB/FBVEiwAk0bAGDZzUsx7q2sxowGhAvlJkDVSe+nY5llu8
         Rvi/3TC7RXyfYpJtAxhiE3RUrW6vWsXczob+rxlTtYKVc2S9lgr5ASC7RlTOd5g+8VzO
         UYDgKhDETaphdptbFKZTAZ9812S9wiM+Xr4+nfbw+ONrGhBo0LasNxIMU1+fqlo0qOZy
         2LMQ==
X-Gm-Message-State: APzg51Du3GkuqUkCG2bhd4odScFfo1cq7EetdlBxeD8aJsWWTpSY2vw1
        ldZ9zePZFC7KBkLaPVS8LMDiDA==
X-Google-Smtp-Source: ANB0Vdarfho8H2Z92Y9cwS3ZVj+m04mFdkYuL9v8MasiOWRPpr9WY3WeVTi2yy7ez/2ZltiTmk2Gxg==
X-Received: by 2002:a62:3909:: with SMTP id g9-v6mr13627773pfa.176.1536946426801;
        Fri, 14 Sep 2018 10:33:46 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d81-v6sm12531759pfj.122.2018.09.14.10.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 10:33:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v2 1/2] remoteproc: qcom: Rename Hexagon v5 PAS driver
Date:   Fri, 14 Sep 2018 10:35:51 -0700
Message-Id: <20180914173552.20370-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914173552.20370-1-bjorn.andersson@linaro.org>
References: <20180914173552.20370-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hexagon v5 ADSP driver is used for more than only the ADSP and
there's an upcoming non-PAS ADSP PIL for SDM845, so rename the driver to
qcom_q6v5_pas in order to better suite this.

Cc: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/Kconfig                    | 27 ++++++++++---------
 drivers/remoteproc/Makefile                   |  2 +-
 .../{qcom_q6v5_pil.c => qcom_q6v5_mss.c}      |  0
 .../{qcom_adsp_pil.c => qcom_q6v5_pas.c}      |  4 +--
 4 files changed, 17 insertions(+), 16 deletions(-)
 rename drivers/remoteproc/{qcom_q6v5_pil.c => qcom_q6v5_mss.c} (100%)
 rename drivers/remoteproc/{qcom_adsp_pil.c => qcom_q6v5_pas.c} (98%)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 052d4dd347f9..425e502c6471 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -84,8 +84,16 @@ config KEYSTONE_REMOTEPROC
 	  It's safe to say N here if you're not interested in the Keystone
 	  DSPs or just want to use a bare minimum kernel.
 
-config QCOM_ADSP_PIL
-	tristate "Qualcomm ADSP Peripheral Image Loader"
+config QCOM_RPROC_COMMON
+	tristate
+
+config QCOM_Q6V5_COMMON
+	tristate
+	depends on ARCH_QCOM
+	depends on QCOM_SMEM
+
+config QCOM_Q6V5_PAS
+	tristate "Qualcomm Hexagon v5 Peripheral Authentication Service support"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
@@ -98,15 +106,7 @@ config QCOM_ADSP_PIL
 	select QCOM_SCM
 	help
 	  Say y here to support the TrustZone based Peripherial Image Loader
-	  for the Qualcomm ADSP remote processors.
-
-config QCOM_RPROC_COMMON
-	tristate
-
-config QCOM_Q6V5_COMMON
-	tristate
-	depends on ARCH_QCOM
-	depends on QCOM_SMEM
+	  for the Qualcomm Hexagon v5 based remote processors.
 
 config QCOM_Q6V5_PIL
 	tristate "Qualcomm Hexagon V5 Peripherial Image Loader"
@@ -120,8 +120,9 @@ config QCOM_Q6V5_PIL
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
-	  Say y here to support the Qualcomm Peripherial Image Loader for the
-	  Hexagon V5 based remote processors.
+	  Say y here to support the TrustZone based Peripherial Image Loader
+	  for the Qualcomm Hexagon v5 based remote processors. This is commonly
+	  used to control subsystems such as ADSP, Compute and Sensor.
 
 config QCOM_Q6V5_WCSS
 	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 03332fa7e2ee..eb86c8ba5a87 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -14,9 +14,9 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
 obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
-obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
+obj-$(CONFIG_QCOM_Q6V5_PAS)		+= qcom_q6v5_pas.o
 obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
 obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
 obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_mss.c
similarity index 100%
rename from drivers/remoteproc/qcom_q6v5_pil.c
rename to drivers/remoteproc/qcom_q6v5_mss.c
diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_q6v5_pas.c
similarity index 98%
rename from drivers/remoteproc/qcom_adsp_pil.c
rename to drivers/remoteproc/qcom_q6v5_pas.c
index d4339a6da616..2478ef3cd519 100644
--- a/drivers/remoteproc/qcom_adsp_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -364,11 +364,11 @@ static struct platform_driver adsp_driver = {
 	.probe = adsp_probe,
 	.remove = adsp_remove,
 	.driver = {
-		.name = "qcom_adsp_pil",
+		.name = "qcom_q6v5_pas",
 		.of_match_table = adsp_of_match,
 	},
 };
 
 module_platform_driver(adsp_driver);
-MODULE_DESCRIPTION("Qualcomm MSM8974/MSM8996 ADSP Peripherial Image Loader");
+MODULE_DESCRIPTION("Qualcomm Hexagon v5 Peripheral Authentication Service driver");
 MODULE_LICENSE("GPL v2");
-- 
2.18.0

