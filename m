Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECEAFC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C247D20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jclIzmY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C247D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeINWtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:49:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34858 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbeINWtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:49:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so4624665pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LL138Uj6kNpVANrzjBhuqoddq/dnmJL60sUEdiKZnqA=;
        b=jclIzmY0y9mQx7aJndknUCv9N+ZGLsp/oMoT1ucFiYnwIsJECeA6Hz0U1fD+WvPkmu
         JRZ3yTieJpL4lskMu0wqQLP8GnuTBnYCNKUIR8s4qYkCGMCTI0iG4WdkSvBUdNtMiw19
         OZFshXCDvG7JJJOu1AZewnhvWPCcD0RR6zTaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LL138Uj6kNpVANrzjBhuqoddq/dnmJL60sUEdiKZnqA=;
        b=nh3Z45k5wMk96FO1web7vGYeipKyPC8l76mTC9UEius+ia1rU/KDdg4GOHJaIpf0+f
         Jn2HuKrp8fDXg5UpiJgI/vFfVJNzW8maynrXCe/+ZzHgzDLaevmnbxSgZSLwiZ5hfLIo
         YmxdEaY75lSWQXYmker1PMyBwZdSdA6o/7MIybc9gMwL+yTaldNeXO6gpgQsh4tDD5Ul
         cOL9x1U9bWLrSvwzNMAcOQNryqdWxyPxTwvvmLkPZVQGfb1zCvqPVbZsz+hF5Epocuzu
         48dxLziumwo/SbIcWiCv7KK0bBzn0D+jIOag/YbTsKBhPlt7SOBXILJJatlwOByK+Xgy
         qKiw==
X-Gm-Message-State: APzg51BMiOZs0aorYJSW+jVp8abqHoJhsAUpYLCqxPJKhwWkv+LGzumt
        eQGZBR9y4WYgo22mK7hUPImTxA==
X-Google-Smtp-Source: ANB0Vdb7mb0uDvd7tRjBVRyHYJ4YCGnVFhzWxaVDF/DmgJ2fioHiJUpnUGM7BilaBGVVj5edKusnOA==
X-Received: by 2002:a63:5321:: with SMTP id h33-v6mr12787219pgb.139.1536946428264;
        Fri, 14 Sep 2018 10:33:48 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d81-v6sm12531759pfj.122.2018.09.14.10.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 10:33:47 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v2 2/2] remoteproc: qcom: Rename Hexagon v5 modem driver
Date:   Fri, 14 Sep 2018 10:35:52 -0700
Message-Id: <20180914173552.20370-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914173552.20370-1-bjorn.andersson@linaro.org>
References: <20180914173552.20370-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom_q6v5_pil implements support for the self-authenticating modem
subsystem. With the introduction of other q6v5 based non-TZ based
remoteproc driver the current name is cause for confusion, so rename it
to be more specific.

No functional change.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/Kconfig  | 14 +++++++-------
 drivers/remoteproc/Makefile |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 425e502c6471..8894935583e2 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -92,30 +92,30 @@ config QCOM_Q6V5_COMMON
 	depends on ARCH_QCOM
 	depends on QCOM_SMEM
 
-config QCOM_Q6V5_PAS
-	tristate "Qualcomm Hexagon v5 Peripheral Authentication Service support"
+config QCOM_Q6V5_MSS
+	tristate "Qualcomm Hexagon V5 self-authenticating modem subsystem support"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
-	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
-	  Say y here to support the TrustZone based Peripherial Image Loader
-	  for the Qualcomm Hexagon v5 based remote processors.
+	  Say y here to support the Qualcomm self-authenticating modem
+	  subsystem based on Hexagon V5.
 
-config QCOM_Q6V5_PIL
-	tristate "Qualcomm Hexagon V5 Peripherial Image Loader"
+config QCOM_Q6V5_PAS
+	tristate "Qualcomm Hexagon v5 Peripheral Authentication Service support"
 	depends on OF && ARCH_QCOM
 	depends on QCOM_SMEM
 	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
+	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index eb86c8ba5a87..050f41ac93b0 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -16,8 +16,8 @@ obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
 obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
+obj-$(CONFIG_QCOM_Q6V5_MSS)		+= qcom_q6v5_mss.o
 obj-$(CONFIG_QCOM_Q6V5_PAS)		+= qcom_q6v5_pas.o
-obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
 obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
 obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
 obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss_pil.o
-- 
2.18.0

