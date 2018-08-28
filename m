Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E370BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A364208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCKPjwFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A364208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeH1JAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:00:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44397 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1JAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:00:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id ba4-v6so208254plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 22:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZA64MSQ3aeuNLnsB2s5eHOfUbJDGcHtk0Lk+dhezN2Q=;
        b=cCKPjwFMwtyTO75NRT+fs9nO+UOei/8z9l/XOucZUEeL2GbcGDi1+ThGGiONBfPywq
         1hDDw4GyZe/xKOhhBWCRrMbFxjD+k89d/1dhMgRAcQ176VS+6eVF9mDQbdP8TvynBuc0
         37rx0UODC4WfmSC7btW/4Qq7shZGk/gtI6vYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZA64MSQ3aeuNLnsB2s5eHOfUbJDGcHtk0Lk+dhezN2Q=;
        b=QH3F6E6ZU0XBm2GYe7jgOMuWa/0RjHJOnSNMnePOrFy++mPn2dEq12eFw4z/xl+l8f
         zvtvypwLQtwEWbwgTGyfIQDAHcOun725ezerRLT7No03J5uXscHYf6cFuJsNfZP6/RR0
         jUhE8m5qNH3cEKTmIWAbCAg8kZqyPHdaiLCAlB3FyOUXRfTWKEVo0tv0gPAma+dH8Cq6
         yLpjPz6TSCvQKQVhHmSR1QQg84LuUrtzTb/w9PqjZkY0lj91g3u3XIapu0UP0G6SKpsW
         QaPialxbj6VGK7KVasA+k1aMOG6pIADm+j12FlnCRRbpht3N5gxsuIMARdMewIddFftR
         8JmQ==
X-Gm-Message-State: APzg51BBwP+T8t9bz56v+kOFv0ZCNC9T7PmN2dgvQzJcI1cun16WCHMe
        4hcYRzleGrh0JPBw08nr5tUC1Q==
X-Google-Smtp-Source: ANB0Vdbqz60ffuhakZI4UwsIfK4WA4dv8EVf60yAc/Ka8Ycn4Kr/Xk9huVvkOVojEOqCWtk0GJSd8g==
X-Received: by 2002:a17:902:7613:: with SMTP id k19-v6mr16205986pll.317.1535433026779;
        Mon, 27 Aug 2018 22:10:26 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 17-v6sm228316pgl.1.2018.08.27.22.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 22:10:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] remoteproc: qcom: Rename Hexagon v5 PAS driver
Date:   Mon, 27 Aug 2018 22:12:03 -0700
Message-Id: <20180828051203.22394-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
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
 drivers/remoteproc/Kconfig                    | 22 +++++++++----------
 drivers/remoteproc/Makefile                   |  2 +-
 .../{qcom_adsp_pil.c => qcom_q6v5_pas.c}      |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)
 rename drivers/remoteproc/{qcom_adsp_pil.c => qcom_q6v5_pas.c} (98%)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 052d4dd347f9..c98c0b2a2237 100644
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

