Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969FD2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lsitec-org-br.20150623.gappssmtp.com header.i=@lsitec-org-br.20150623.gappssmtp.com header.b="BQnMWHSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969FD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lsitec.org.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbeGRQWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:22:03 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:42731 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbeGRQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:22:02 -0400
Received: by mail-ed1-f44.google.com with SMTP id r4-v6so4630366edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lsitec-org-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uTItuvm5kMxar8lKstQm+1HfiBoCmIuPj3TcUZgy4VU=;
        b=BQnMWHSqc+/7aBpOLsLMb9YhFVaO7xUFQoIgQZecGsWSb3o7jhuKbABTBSumOeQSxa
         UzL3hgarlGOGFY3z+owpVN7+k5Sm11wGJCvYifU3aHK1MABHjbxhcW/5MWQxfq3uvhhE
         1aZt5lwrs39zIeEHIAhOGchzCY1RYdQaAQq15HJ1/X8NJsP6ZSmrBfgmN0sAco65kkpp
         +i0YLEce5cnz4NPpvcp62fmD2t3SVBxRgh5xZNl2agH5eEwTzYOYJDvp9fv/80ffdFAL
         77J5eiJu7tes5f+ukmy8jS9ZhEl+v2bkXnqyxGPE9QWT2eSVb21aeEFCCyoSF6EDFREr
         rPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uTItuvm5kMxar8lKstQm+1HfiBoCmIuPj3TcUZgy4VU=;
        b=Ecar5YSlNHkWmOqbZwwImc3uHNCoz7oN1xuyRZ/h+YJOMXqQcM3hmXxLKi1PcQVdVu
         bulhBV2AouSAd/gUFv6W+ereXy3uq2pG61UeBi3IOqRv7c+qhmYk6mQp1HdwzT8XQ7JT
         OaL5bLSv1AnoM/zI9g23Y2oPMNG7AY16hd+j1WnIWaF39wyH2pC++AbC+Rj6fzafKMW6
         AwRftDdTSn5qq5LgFR1NTgGngBsNhRBzSLjvwAmaKHxBMzCVCeU7Q40TN5ZvYEHCYdbl
         DZTRUaGGCvT3NeSJoicGhaoJ8Sp2EDFFmyAHXDaAYY6HVX8rudflFJXGU7FnqSR3whHI
         /TtA==
X-Gm-Message-State: AOUpUlF7lz4yq9Vz01N+BXE+M6rI8g2B1J3sX2UZwN3RyWUHi+8Reb5H
        HO+P32A3ARoji3jCBq7x9xSKn3cTN9gBikg9in96zA==
X-Google-Smtp-Source: AAOMgpe6fViD79y61XZ9jnYEVEFDnoCc4+3R12MRWErrmHDXfHEIxFBvjGur6x7gPac0eyM9N/sBgynfGnhbOkBR96g=
X-Received: by 2002:a50:b723:: with SMTP id g32-v6mr7746178ede.139.1531928612097;
 Wed, 18 Jul 2018 08:43:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:d1cd:0:0:0:0 with HTTP; Wed, 18 Jul 2018 08:43:31
 -0700 (PDT)
From:   Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Date:   Wed, 18 Jul 2018 12:43:31 -0300
Message-ID: <CADHB5bAD6A6U1Gk0kzVse1n-g2ONQtoMoOYxpMwGZuExvqsYKA@mail.gmail.com>
Subject: [PATCH v1 02/04] dt-bindings: clock: Add Clock Management Unit for
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

File(s) created: "/include/dt-bindings/clock/actions,s500-cmu.h"

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>

diff -uprN -X vanilla/Documentation/dontdiff
vanilla/include/dt-bindings/clock/actions,s500-cmu.h
linux/include/dt-bindings/clock/actions,s500-cmu.h
--- vanilla/include/dt-bindings/clock/actions,s500-cmu.h    1969-12-31
21:00:00.000000000 -0300
+++ linux/include/dt-bindings/clock/actions,s500-cmu.h    2018-07-18
12:42:13.002448774 -0300
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
