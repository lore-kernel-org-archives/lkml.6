Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D781DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4B720657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQRmR1H8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4B720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeKCG6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:58:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38935 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeKCG6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:58:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id n11-v6so1598483pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2FQHA8o1Fme+2rAuzvvgxRDeSLNcHISNPr1eN2MNIdQ=;
        b=XQRmR1H8fRSBLrHsY6ZNT4hXR895eg1B6ziymlSAxkdsh33bCROJXFc/vLat/EIo54
         lrFAtIfC26ITX15NZr6gBxqZdeOeb1WTz30D4PlFiB/mxipnGTfrYAsh/uu5rFiyVkAc
         pMG3FbUiCauPfaTKeVvC7XjkFQnNzz2rcLhSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2FQHA8o1Fme+2rAuzvvgxRDeSLNcHISNPr1eN2MNIdQ=;
        b=FRcGbLbVe2jYJqGg+SAb1PbIb8Auy37T/dky03giQNtE0jLfsDrS7K0lvxZk4njJjf
         EVhK3ehGBzJ4jXouFK3zl+6oEeuZep8yl2k6ifl+dk5+JCOz7PgQlUxWoLxO88stU+0e
         NfQcHz27jmh9KLb58xRwvz5k+FhlEsoN55JoC9yUj1mCKNiRUEhP3wz6k2MjicDupenZ
         sV2emQnd7VTnfeg+b3TVIGTHDK/aI+0HRJOYEmhWPF1YCnlBXBOiIWA5YdxM3BrRBTZP
         m51MSrThzdj4Eowm0oER4r7U0n+6lzpooDiV2t8j8lVH+hJ+5aisLix9CnzpyglEQQDX
         ktgg==
X-Gm-Message-State: AGRZ1gJ+TLJ/RIadkzZWFO8Vvk3qAi5hXxc5EQvOV7qiVctEk5qVy5UZ
        bfYUvcX2Uwkffd5vF030urFItA==
X-Google-Smtp-Source: AJdET5fWLf0Vg9xSLSUM+jZtTzyzyAhia6R1BusDu1/ZIWY/PzNyNnL5F4ZvXh5lSlUa00Nn1LbS8Q==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr5158626pgf.240.1541195370194;
        Fri, 02 Nov 2018 14:49:30 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i189-v6sm20009064pfg.156.2018.11.02.14.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 14:49:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable core Qualcomm SDM845 options
Date:   Fri,  2 Nov 2018 14:53:03 -0700
Message-Id: <20181102215303.18405-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable a few core config options to be able to boot SDM845 MTP.

The GCC, PINCTRL and GENI options are required to be able to boot to a
console. Several clocks from GCC are parented by the "bi_tcxo" clock
from the RPMH clock driver, so enable this to save others the time to
debug the missing parent clocks later. RPMH depends on the COMMAND_DB.
While we're enabling the others let's do RPMH regulators as well, as
everything beyond this point depends on that.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3cb995606e60..4d9425a2e0d1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -303,6 +303,8 @@ CONFIG_SERIAL_TEGRA=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
+CONFIG_SERIAL_QCOM_GENI=y
+CONFIG_SERIAL_QCOM_GENI_CONSOLE=y
 CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
@@ -347,6 +349,7 @@ CONFIG_PINCTRL_MSM8994=y
 CONFIG_PINCTRL_MSM8996=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
+CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_MT7622=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_MB86S7X=y
@@ -411,6 +414,7 @@ CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_PWM=y
+CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
@@ -593,10 +597,12 @@ CONFIG_COMMON_CLK_PWM=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_SMD_RPM=y
+CONFIG_QCOM_CLK_RPMH=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
+CONFIG_SDM_GCC_845=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
@@ -612,6 +618,9 @@ CONFIG_QCOM_IOMMU=y
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_GENI_SE=y
+CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
-- 
2.18.0

