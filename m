Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FFBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163AF20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhIPD/xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfANJ5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:57:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36714 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfANJ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:57:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so18446527ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wfaWNb2b+4rhgwfXb/ymqYiM5h5NpIm3LLHjGWRlmy8=;
        b=QhIPD/xggrsyG6bM2Jtax8BmR0+YMpQLOA7lXMEdCMV6tLoZvEvjgpoiyDrjBrE/Jg
         l7PihnO3HJgueg3SO7zYGEuamtTAJ/m8uTmJHViEjxvrI6sbS8V5o9tq6hVtrbmRoFBO
         CwG49w4k0ANEBC6rpr/O/b91jgu9BsmYlV4kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wfaWNb2b+4rhgwfXb/ymqYiM5h5NpIm3LLHjGWRlmy8=;
        b=eRA4gBaVeTr6CVEDacoSI211usswAJPc/cH5b9ov4R/iAeCQJgv5az+7tyr7OztEiu
         1vzHWtRRNcSxW/ETk5fnC43apOUlOQZryrCFkKyL0fr/vwd+GQLq8EE2kwvRAKQKgJ+3
         Wbkc9WDrIUVGkUDAOZKyy0UQCUIYEMWKUiJeQGFX4pRnuS7/XaYCAt9MGXD6Fq/bCNvJ
         +YqxtbdBnlD3pcm/OiMIUCMwKPSu26ZR1upEHfh+cMcoIIze5P1GmmWKjSHaZ+fHZfc7
         qL5EMwMoKjCkuzMO079EmEOnWvhpZpDgC27R9aXvlH/Cyt/9lpxa+LSTx1V65kAPN5Hz
         0KQA==
X-Gm-Message-State: AJcUukd0MFAnXzDmX8ZtYj1gJyHE/AV0UbAyzgv6PoUVCfpyB48VcvzS
        K1ibKXHSFgrcxm6SOB1XOj+fhg==
X-Google-Smtp-Source: ALg8bN4Ufifi/lQKFNFlfyHp/mDWPcx/2YKEzAdRpj9lcfk8gQD7F3cnf4g0eWQhk96D61hWvO6WoA==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26-v6mr15274568lju.8.1547459822786;
        Mon, 14 Jan 2019 01:57:02 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id 4-v6sm17077049ljw.84.2019.01.14.01.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 01:57:02 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/3] pinctrl: freescale: fix link errors
Date:   Mon, 14 Jan 2019 10:56:59 +0100
Message-Id: <20190114095659.23082-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix link errors when PINCTRL_IMX_SCU or PINCTRL_IMXBQXP is enabled as a
module and the dependent module is built-in.

ld: drivers/pinctrl/freescale/pinctrl-scu.o: in function `imx_pinctrl_sc_ipc_init':
pinctrl-scu.c:(.text+0x10): undefined reference to `imx_scu_get_handle'
ld: pinctrl-scu.c:(.text+0x10): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `imx_scu_get_handle'
ld: drivers/pinctrl/freescale/pinctrl-scu.o: in function `imx_pinconf_get_scu':
pinctrl-scu.c:(.text+0xa0): undefined reference to `imx_scu_call_rpc'
ld: pinctrl-scu.c:(.text+0xa0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `imx_scu_call_rpc'
ld: drivers/pinctrl/freescale/pinctrl-scu.o: in function `imx_pinconf_set_scu':
pinctrl-scu.c:(.text+0x1b4): undefined reference to `imx_scu_call_rpc'
ld: pinctrl-scu.c:(.text+0x1b4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `imx_scu_call_rpc'
ld: drivers/pinctrl/freescale/pinctrl-imx8qxp.o: in function `imx8qxp_pinctrl_probe':
pinctrl-imx8qxp.c:(.text+0x28): undefined reference to `imx_pinctrl_probe'
ld: pinctrl-imx8qxp.c:(.text+0x28): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `imx_pinctrl_probe'

Rework so both depends on IMX_SCU=y.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pinctrl/freescale/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index b318c24b61be..ac158309cfe9 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -7,7 +7,7 @@ config PINCTRL_IMX
 
 config PINCTRL_IMX_SCU
 	bool
-	depends on IMX_SCU
+	depends on IMX_SCU=y
 	select PINCTRL_IMX
 
 config PINCTRL_IMX1_CORE
@@ -138,7 +138,7 @@ config PINCTRL_IMX8QM
 
 config PINCTRL_IMX8QXP
 	bool "IMX8QXP pinctrl driver"
-	depends on ARCH_MXC && ARM64
+	depends on IMX_SCU=y && ARCH_MXC && ARM64
 	select PINCTRL_IMX_SCU
 	help
 	  Say Y here to enable the imx8qxp pinctrl driver
-- 
2.19.2

