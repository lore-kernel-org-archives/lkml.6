Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D353C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB06B20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lsitec-org-br.20150623.gappssmtp.com header.i=@lsitec-org-br.20150623.gappssmtp.com header.b="X/bI+GRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB06B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lsitec.org.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIDUCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:02:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47061 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbeIDUCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:02:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so3588486edr.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lsitec-org-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bFVfBd+O8ye20bkrzs7uAGs/JqJfuMdRRKtKkYL9tp8=;
        b=X/bI+GRIAW1TLaOU+WKcW6SZ7v+YrfAP2wDGZsf9LWT5wPXcEW/5E71FVQN4BecBgv
         wfPluKd7o0WDY9nA9ch55+7MNkRf1nCH/ahKDXhNnVkMHy+koyOgF+bCHDj4RRFe/V/N
         iu1HwGc5NRPxa5vA/8PM6G3biuEf2EYQcXSVlXPobw/xNF90Ama23ZrBFSkFfRgbuwo6
         S7fHivAToazUjQ1lHv1zx8+es9VhQTJxwAQ5GDxSU7wscBDJrxHvIGy/uWpFIHTC0oYc
         WzVFys8rI7mRFw3AlK7u9b94oIPoolMFQ1N8yM80RokDx1wckMGFdA+2LhCJm10mcgzl
         MYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bFVfBd+O8ye20bkrzs7uAGs/JqJfuMdRRKtKkYL9tp8=;
        b=PWpa9tw1/ddXxaVCAU+mrEXGTjJiwPM8q3auSrOZCurBs279BFFsi0ghWHVomgAhT9
         sJee2SekdahGuzbas+18AsZJyKAWJjxOZDwFe/gj3F21NIZOQ248ZkxjxTBROukYMIkk
         qcA8Fa6xQLc/OvHL8/BRPQbBNeOKjjRoHeDzWK4lg9rmuRuX+l70Ty/vTXcrq2qJTuHx
         YdimUnk14uWfOSgqEiDrkCzWbOioCw/JZELJxva4tDkKLpAu4zvlFvYDYpraFU1L6QhH
         lBXLZ38vpGdF2nAPqpczDcnfHDdZ1E/mOydssj75bbvDWUzHbHuroQwiz5aaeRDILJIl
         oIHg==
X-Gm-Message-State: APzg51AKldi5Kaf4U6OMVHF+pwf/d+z/OoLPUq5/Im/Ln8ITmFX/6PfX
        oTvyRXwPkjYYA9ifoLE3qkUDMBmvOIIvUJL9+mhFoA==
X-Google-Smtp-Source: ANB0VdavH0BWvlwgcH65tSVOaFqbOPa0/XicwXfxQDq/8Pra2ZQID3rsS7SyJfhVzmwaKeC+wIWC8VkM/lAKWUxWfN8=
X-Received: by 2002:a50:a7a2:: with SMTP id i31-v6mr38590202edc.296.1536075397653;
 Tue, 04 Sep 2018 08:36:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:2443:0:0:0:0 with HTTP; Tue, 4 Sep 2018 08:36:36
 -0700 (PDT)
From:   Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Date:   Tue, 4 Sep 2018 12:36:36 -0300
Message-ID: <CADHB5bBkyE90LVrWjt0ziU+oe=4sc8G_513VGECc++6xQ2ACdA@mail.gmail.com>
Subject: [PATCH v2 01/03] dt-bindings: clock: Add Clock Management Unit for
 Actions Semi S500 SoC
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, linux@armlinux.org.uk,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Guilherme_G=2E_Sim=C3=B5es?= 
        <guilherme.simoes@lsitec.org.br>,
        Jon maddog Hall <jon.maddog.hall@gmail.com>,
        mkzuffo@lsi.usp.br,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        sboyd@kernel.org, mark.rutland@arm.com, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        will.deacon@arm.com, thomas liau <thomas.liau@actions-semi.com>,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, mp-cs@actions-semi.com,
        Laisa Costa - LSI-TEC <laisa.costa@lsitec.org.br>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Clock Management Unit for Actions Semi S500 SoC. Dt-Bindings
constants added.
Tested on a Lemaker Guitar board.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>

diff --git a/include/dt-bindings/clock/actions,s500-cmu.h
b/include/dt-bindings/clock/actions,s500-cmu.h
new file mode 100644
index 000000000000..34e5849ffcf1
--- /dev/null
+++ b/include/dt-bindings/clock/actions,s500-cmu.h
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Device Tree binding constants for Actions Semi S500 Clock Management Unit
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Copyright (c) 2018 Linaro Ltd.
+// Copyright (c) 2018 LSI-TEC - Caninos Loucos
+
+#ifndef __DT_BINDINGS_CLOCK_S500_CMU_H
+#define __DT_BINDINGS_CLOCK_S500_CMU_H
+
+#define CLK_NONE            0
+
+/* fixed rate clocks */
+#define CLK_LOSC            1
+#define CLK_HOSC            2
+
+/* pll clocks */
+#define CLK_CORE_PLL        3
+#define CLK_DEV_PLL            4
+#define CLK_DDR_PLL            5
+#define CLK_NAND_PLL        6
+#define CLK_DISPLAY_PLL        7
+#define CLK_ETHERNET_PLL    8
+#define CLK_AUDIO_PLL        9
+
+/* system clock */
+#define CLK_DEV                10
+#define CLK_H                11
+#define CLK_AHBPREDIV        12
+#define CLK_AHB                13
+#define CLK_DE                14
+#define CLK_BISP            15
+#define CLK_VCE                16
+#define CLK_VDE                17
+
+/* peripheral device clock */
+#define CLK_TIMER            18
+#define CLK_I2C0            19
+#define CLK_I2C1            20
+#define CLK_I2C2            21
+#define CLK_I2C3            22
+#define CLK_PWM0            23
+#define CLK_PWM1            24
+#define CLK_PWM2            25
+#define CLK_PWM3            26
+#define CLK_PWM4            27
+#define CLK_PWM5            28
+#define CLK_SD0                29
+#define CLK_SD1                30
+#define CLK_SD2                31
+#define CLK_SENSOR0            32
+#define CLK_SENSOR1            33
+#define CLK_SPI0            34
+#define CLK_SPI1            35
+#define CLK_SPI2            36
+#define CLK_SPI3            37
+#define CLK_UART0            38
+#define CLK_UART1            39
+#define CLK_UART2            40
+#define CLK_UART3            41
+#define CLK_UART4            42
+#define CLK_UART5            43
+#define CLK_UART6            44
+#define CLK_DE1                45
+#define CLK_DE2                46
+#define CLK_I2SRX            47
+#define CLK_I2STX            48
+#define CLK_HDMI_AUDIO        49
+#define CLK_HDMI            50
+#define CLK_SPDIF            51
+#define CLK_NAND            52
+#define CLK_ECC                53
+#define CLK_RMII_REF        54
+
+#define CLK_NR_CLKS            (CLK_RMII_REF + 1)
+
+#endif /* __DT_BINDINGS_CLOCK_S500_CMU_H */
-- 
2.11.0
