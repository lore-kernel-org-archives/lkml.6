Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E09EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACCD20823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcP7txpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfAVIiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:38:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36396 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfAVIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:38:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so17423452lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 00:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QC6hI+o1F3bLp+jmcz5gH6/fp29Fuo/YO8irWTolOwQ=;
        b=dcP7txpkZVMC5PY8+fHNtQdRKOBS8HtscDAMHiI61ZMr9YXMRWPbnCeMSQKQjplSRA
         zS8h69fsjVE92EumcWExSrIQDdS5zdILWqxUZAqrzo3dCSjYEY6jCRuyHWeZb95GashH
         lvCRV2WGRAshMPHhZBp5KLM4a25TA5uewzzGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QC6hI+o1F3bLp+jmcz5gH6/fp29Fuo/YO8irWTolOwQ=;
        b=KyDJMzFGqVVYfEhnk/cIwyXtI41Bw18hw/+pwVRFmUCQgXum+Oah1AksZYe1joamL3
         BCy8GA5pl4wGH22WG6Qga+XT6iNIrFHKR9KQYcKyT3okD+fIJ5Lu2/J7qzqPww3dM/yb
         2prJu3K8VA3zVA5KXHzqH5opceJMzOnjbx9Of9GjPH/rAfhMZvLua6OE0unmPrNIv2zf
         hcBdglL0xPcYX0lCOPBSUoaLzKbnOfECKz9sOFXyv0DkHblUp6jE7BJrS0krJ6Hh97nU
         oB35pK2L184GxZ5tOs1d6RlRrVrC07sAfpykbLWss/OhM7M18uUgJpytH0lU+wRfoHMr
         oo1g==
X-Gm-Message-State: AJcUuke6ejaFmHra7EH/6HC5W5vKzMyeZ8XcV2Iw6k+vgdkAkNw/78AX
        uA9/OsVFI0Hrh50D8y/5/grJkw==
X-Google-Smtp-Source: ALg8bN7NXqsO4ewGzmrzFHHBEAl2b67scISSDlVnMTIWshlkEAsGlRUS6apPkw1LC14bE0zfNrMSIw==
X-Received: by 2002:a19:c203:: with SMTP id l3mr7312577lfc.113.1548146279423;
        Tue, 22 Jan 2019 00:37:59 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id c133sm2988651lfc.45.2019.01.22.00.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 00:37:58 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3] pinctrl: freescale: fix link errors
Date:   Tue, 22 Jan 2019 09:37:35 +0100
Message-Id: <20190122083735.13286-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix link errors when PINCTRL_IMX_SCU, PINCTRL_IMX8QM or PINCTRL_IMXBQXP
is enabled as a module and the dependent module is built-in.

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

Rework so that PINCTRL_IMX_SCU and the config's that 'select
PINCTRL_IMX_SCU' depends on IMX_SCU=y.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pinctrl/freescale/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index b318c24b61be..af141dd2331d 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -7,7 +7,7 @@ config PINCTRL_IMX
 
 config PINCTRL_IMX_SCU
 	bool
-	depends on IMX_SCU
+	depends on IMX_SCU=y
 	select PINCTRL_IMX
 
 config PINCTRL_IMX1_CORE
@@ -131,14 +131,14 @@ config PINCTRL_IMX8MQ
 
 config PINCTRL_IMX8QM
 	bool "IMX8QM pinctrl driver"
-	depends on ARCH_MXC && ARM64
+	depends on IMX_SCU && ARCH_MXC && ARM64
 	select PINCTRL_IMX_SCU
 	help
 	  Say Y here to enable the imx8qm pinctrl driver
 
 config PINCTRL_IMX8QXP
 	bool "IMX8QXP pinctrl driver"
-	depends on ARCH_MXC && ARM64
+	depends on IMX_SCU && ARCH_MXC && ARM64
 	select PINCTRL_IMX_SCU
 	help
 	  Say Y here to enable the imx8qxp pinctrl driver
-- 
2.19.2

