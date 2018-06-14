Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 31F02C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB16B208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyHtiwjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB16B208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755257AbeFNLNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:13:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39964 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755234AbeFNLNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:13:05 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so8784680lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=94LdHuH8GA2nQVdcWn1zqCD1mQ0udKnExVyGVrTlWgU=;
        b=IyHtiwjCBc7wtZnCgMlUH/h31pCInOjjctGoBPFPDt/Z7xoUbMluGOLNYWV+Xq7fbT
         ATu2lVizaQ+QPkCasEmty4NX94b7SGR3i9H5iAQ8Ur5XWOWG++mMQTbgJHMkbuLDqsF0
         /EEFa0b70FIbPlDrW0Y08XuGcB3UeebIiZXUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=94LdHuH8GA2nQVdcWn1zqCD1mQ0udKnExVyGVrTlWgU=;
        b=m0S963whGt7lLRfipA9WQRnTmVuF7YHT+4yl8zANB7QVj9/9agbm6UN/253or+2NvW
         Hp+owjfQTCGK1nhICMKVsVHh5jjbopsRLeXlfEoQLegZbOOZJs5qHRZi4OuTVAsuEWXh
         ImB5IzEk1xDcLeQFxCRdpVVnKjrLqOOmfRrt1wNHV1aKbYzkDSSQtvbZ8zE4Xjx93UJP
         4fSaOhb+1pH0rh8Qejk321ubmJbL50oSHQthuyd6W8BnT7hp7NKo62BGSI4Bp9xFMS/K
         MyqHYCnSbjTZVtzL6RZJcjbFiBooVN1Gb/HJFglbyvJR/eZtGk/BkUysLk83XhoFMN1w
         N4Ow==
X-Gm-Message-State: APt69E3Ap99xs35GSP39IQQfcsgbzGlBYcwWXzPxotjWGAMWzRoC8rjZ
        e3CNiryJYQEXxclRksVT5tAZyA==
X-Google-Smtp-Source: ADUXVKIRFinHB88LEDsEnOhJFv/q3b8cssEdEw3j4PRlxPPgsu5JAj4oYN9emeZyq77cvAZqUO6jmA==
X-Received: by 2002:a19:484b:: with SMTP id v72-v6mr5959996lfa.120.1528974784056;
        Thu, 14 Jun 2018 04:13:04 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id o9-v6sm1041490lfk.2.2018.06.14.04.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 04:13:03 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] soc: qcom: Allow COMPILE_TEST of all drivers
Date:   Thu, 14 Jun 2018 13:11:38 +0200
Message-Id: <20180614111138.8923-8-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614111138.8923-1-niklas.cassel@linaro.org>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
we unconditionally include the soc/qcom/Makefile.

This opens up the possibility to compile test the code even when
building for other architectures.

Add "depends on ARCH_QCOM || COMPILE_TEST" to the menu entry,
that way we can avoid adding it to every single Kconfig.

Remove the existing depend on ARCH_QCOM for all Kconfigs, except for
two Kconfigs that depend on QCOM_SCM, since that triggers lots of build
errors in qcom_scm.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 3f4036a6173f..fc5d11a6c0af 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -2,10 +2,10 @@
 # QCOM Soc drivers
 #
 menu "Qualcomm SoC drivers"
+	depends on ARCH_QCOM || COMPILE_TEST
 
 config QCOM_COMMAND_DB
 	bool "Qualcomm Command DB"
-	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Command DB queries shared memory by key string for shared system
 	  resources. Platform drivers that require to set state of a shared
@@ -14,7 +14,6 @@ config QCOM_COMMAND_DB
 
 config QCOM_GENI_SE
 	tristate "QCOM GENI Serial Engine Driver"
-	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  This driver is used to manage Generic Interface (GENI) firmware based
 	  Qualcomm Technologies, Inc. Universal Peripheral (QUP) Wrapper. This
@@ -32,7 +31,6 @@ config QCOM_GLINK_SSR
 
 config QCOM_GSBI
         tristate "QCOM General Serial Bus Interface"
-        depends on ARCH_QCOM
         select MFD_SYSCON
         help
           Say y here to enable GSBI support.  The GSBI provides control
@@ -55,7 +53,7 @@ config QCOM_PM
 
 config QCOM_QMI_HELPERS
 	tristate
-	depends on ARCH_QCOM && NET
+	depends on NET
 	help
 	  Helper library for handling QMI encoded messages.  QMI encoded
 	  messages are used in communication between the majority of QRTR
@@ -76,7 +74,6 @@ config QCOM_RMTFS_MEM
 
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
-	depends on ARCH_QCOM
 	depends on HWSPINLOCK
 	help
 	  Say y here to enable support for the Qualcomm Shared Memory Manager.
@@ -85,7 +82,6 @@ config QCOM_SMEM
 
 config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
-	depends on ARCH_QCOM
 	depends on RPMSG
 	help
 	  If you say yes to this option, support will be included for the
@@ -122,7 +118,6 @@ config QCOM_SMSM
 
 config QCOM_WCNSS_CTRL
 	tristate "Qualcomm WCNSS control driver"
-	depends on ARCH_QCOM
 	depends on RPMSG
 	help
 	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
@@ -130,7 +125,6 @@ config QCOM_WCNSS_CTRL
 
 config QCOM_APR
 	tristate "Qualcomm APR Bus (Asynchronous Packet Router)"
-	depends on ARCH_QCOM
 	depends on RPMSG
 	help
           Enable APR IPC protocol support between
-- 
2.17.1

