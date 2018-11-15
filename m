Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A1EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809282245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdostA4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809282245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeKPFIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725742AbeKPFIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:08:46 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDAE52250E;
        Thu, 15 Nov 2018 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542308386;
        bh=4JSuB1P0puUF7poL2eNxhoLXWiOCaCfwEVWBBFCWCpA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pdostA4A0U7+cKEGnx9nZwlJgqsNxjKCFdPaIS3LwdtjtdC4vz1Q40bwfCgbqWg41
         Mr7VfAs9QusKMTjohCum39UHbMwpx9yCNoYr4BZLiQqXEmIh58zriMhNADs8r9x47Y
         jpdukYnJHRiDJDIZOvtsgKBSLX9+osnGIBcE4qAM=
Received: by mail-wm1-f42.google.com with SMTP id r63-v6so19942547wma.4;
        Thu, 15 Nov 2018 10:59:45 -0800 (PST)
X-Gm-Message-State: AGRZ1gJJgBjhx08ozzIgRDY63v+1EL5+fySObqvpPFs1BQhUiIKv/M8h
        IBWoY6SemHCKVB+f5UcpoBog85azJ38D3WgQn/s=
X-Google-Smtp-Source: AJdET5dD/Xt1PjEMKMXa0C1AlmhBowkbUVwA/vfqXNyT138fxgUPX/vvJQztZXjInOMMw+MsUdF6RPmJtZe1nvGvup4=
X-Received: by 2002:a1c:e07:: with SMTP id 7-v6mr6653916wmo.52.1542308384366;
 Thu, 15 Nov 2018 10:59:44 -0800 (PST)
MIME-Version: 1.0
References: <5d63d26156d2972b7e9f55c9743b66d7c6dac2ec.1541986223.git.ryder.lee@mediatek.com>
 <46ee25bb5ac7a7aa0245e2b02e9a0e870ff09551.1541986223.git.ryder.lee@mediatek.com>
In-Reply-To: <46ee25bb5ac7a7aa0245e2b02e9a0e870ff09551.1541986223.git.ryder.lee@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 15 Nov 2018 10:59:33 -0800
X-Gmail-Original-Message-ID: <CAGp9LzobgV2jiajPc+0m+zyq6qQDMRUZp8TMutRhp_5_8xE6dw@mail.gmail.com>
Message-ID: <CAGp9LzobgV2jiajPc+0m+zyq6qQDMRUZp8TMutRhp_5_8xE6dw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: pinctrl: update bindings for MT7629 SoC
To:     ryder.lee@mediatek.com
Cc:     Linus Walleij <linus.walleij@linaro.org>, robh+dt@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, weijie.gao@mediatek.com,
        cheng-hao.luo@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 5:45 PM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> This updates bindings for MT7629 pinctrl driver.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Reviewed-by: Sean Wang <sean.wang@kernel.org>

> ---
> Changes since v1:
> -add new function for wifi.
> -add more descriptions.
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt | 131 +++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
> index 3b69513..7a7aca1 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt7622.txt
> @@ -3,6 +3,7 @@
>  Required properties for the root node:
>   - compatible: Should be one of the following
>                "mediatek,mt7622-pinctrl" for MT7622 SoC
> +              "mediatek,mt7629-pinctrl" for MT7629 SoC
>   - reg: offset and length of the pinctrl space
>
>   - gpio-controller: Marks the device node as a GPIO controller.
> @@ -324,6 +325,136 @@ group.
>         "uart4_2_rts_cts"               "uart"          95, 96
>         "watchdog"                      "watchdog"      78
>
> +
> +== Valid values for pins, function and groups on MT7629 ==
> +
> +       Pin #:  Valid values for pins
> +       -----------------------------
> +       PIN 0: "TOP_5G_CLK"
> +       PIN 1: "TOP_5G_DATA"
> +       PIN 2: "WF0_5G_HB0"
> +       PIN 3: "WF0_5G_HB1"
> +       PIN 4: "WF0_5G_HB2"
> +       PIN 5: "WF0_5G_HB3"
> +       PIN 6: "WF0_5G_HB4"
> +       PIN 7: "WF0_5G_HB5"
> +       PIN 8: "WF0_5G_HB6"
> +       PIN 9: "XO_REQ"
> +       PIN 10: "TOP_RST_N"
> +       PIN 11: "SYS_WATCHDOG"
> +       PIN 12: "EPHY_LED0_N_JTDO"
> +       PIN 13: "EPHY_LED1_N_JTDI"
> +       PIN 14: "EPHY_LED2_N_JTMS"
> +       PIN 15: "EPHY_LED3_N_JTCLK"
> +       PIN 16: "EPHY_LED4_N_JTRST_N"
> +       PIN 17: "WF2G_LED_N"
> +       PIN 18: "WF5G_LED_N"
> +       PIN 19: "I2C_SDA"
> +       PIN 20: "I2C_SCL"
> +       PIN 21: "GPIO_9"
> +       PIN 22: "GPIO_10"
> +       PIN 23: "GPIO_11"
> +       PIN 24: "GPIO_12"
> +       PIN 25: "UART1_TXD"
> +       PIN 26: "UART1_RXD"
> +       PIN 27: "UART1_CTS"
> +       PIN 28: "UART1_RTS"
> +       PIN 29: "UART2_TXD"
> +       PIN 30: "UART2_RXD"
> +       PIN 31: "UART2_CTS"
> +       PIN 32: "UART2_RTS"
> +       PIN 33: "MDI_TP_P1"
> +       PIN 34: "MDI_TN_P1"
> +       PIN 35: "MDI_RP_P1"
> +       PIN 36: "MDI_RN_P1"
> +       PIN 37: "MDI_RP_P2"
> +       PIN 38: "MDI_RN_P2"
> +       PIN 39: "MDI_TP_P2"
> +       PIN 40: "MDI_TN_P2"
> +       PIN 41: "MDI_TP_P3"
> +       PIN 42: "MDI_TN_P3"
> +       PIN 43: "MDI_RP_P3"
> +       PIN 44: "MDI_RN_P3"
> +       PIN 45: "MDI_RP_P4"
> +       PIN 46: "MDI_RN_P4"
> +       PIN 47: "MDI_TP_P4"
> +       PIN 48: "MDI_TN_P4"
> +       PIN 49: "SMI_MDC"
> +       PIN 50: "SMI_MDIO"
> +       PIN 51: "PCIE_PERESET_N"
> +       PIN 52: "PWM_0"
> +       PIN 53: "GPIO_0"
> +       PIN 54: "GPIO_1"
> +       PIN 55: "GPIO_2"
> +       PIN 56: "GPIO_3"
> +       PIN 57: "GPIO_4"
> +       PIN 58: "GPIO_5"
> +       PIN 59: "GPIO_6"
> +       PIN 60: "GPIO_7"
> +       PIN 61: "GPIO_8"
> +       PIN 62: "SPI_CLK"
> +       PIN 63: "SPI_CS"
> +       PIN 64: "SPI_MOSI"
> +       PIN 65: "SPI_MISO"
> +       PIN 66: "SPI_WP"
> +       PIN 67: "SPI_HOLD"
> +       PIN 68: "UART0_TXD"
> +       PIN 69: "UART0_RXD"
> +       PIN 70: "TOP_2G_CLK"
> +       PIN 71: "TOP_2G_DATA"
> +       PIN 72: "WF0_2G_HB0"
> +       PIN 73: "WF0_2G_HB1"
> +       PIN 74: "WF0_2G_HB2"
> +       PIN 75: "WF0_2G_HB3"
> +       PIN 76: "WF0_2G_HB4"
> +       PIN 77: "WF0_2G_HB5"
> +       PIN 78: "WF0_2G_HB6"
> +
> +Valid values for function are:
> +       "eth", "i2c", "led", "flash", "pcie", "pwm", "spi", "uart",
> +       "watchdog", "wifi"
> +
> +Valid values for groups are:
> +       Valid value                     function        pins (in pin#)
> +       ----------------------------------------------------------------
> +       "mdc_mdio"                      "eth"           23, 24
> +       "i2c_0"                         "i2c"           19, 20
> +       "i2c_1"                         "i2c"           53, 54
> +       "ephy_leds"                     "led"           12, 13, 14, 15, 16,
> +                                                       17, 18
> +       "ephy0_led"                     "led"           12
> +       "ephy1_led"                     "led"           13
> +       "ephy2_led"                     "led"           14
> +       "ephy3_led"                     "led"           15
> +       "ephy4_led"                     "led"           16
> +       "wf2g_led"                      "led"           17
> +       "wf5g_led"                      "led"           18
> +       "snfi"                          "flash"         62, 63, 64, 65, 66, 67
> +       "spi_nor"                       "flash"         62, 63, 64, 65, 66, 67
> +       "pcie_pereset"                  "pcie"          51
> +       "pcie_wake"                     "pcie"          55
> +       "pcie_clkreq"                   "pcie"          56
> +       "pwm_0"                         "pwm"           52
> +       "pwm_1"                         "pwm"           61
> +       "spi_0"                         "spi"           21, 22, 23, 24
> +       "spi_1"                         "spi"           62, 63, 64, 65
> +       "spi_wp"                        "spi"           66
> +       "spi_hold"                      "spi"           67
> +       "uart0_txd_rxd"                 "uart"          68, 69
> +       "uart1_0_txd_rxd"               "uart"          25, 26
> +       "uart1_0_cts_rts"               "uart"          27, 28
> +       "uart1_1_txd_rxd"               "uart"          53, 54
> +       "uart1_1_cts_rts"               "uart"          55, 56
> +       "uart2_0_txd_rxd"               "uart"          29, 30
> +       "uart2_0_cts_rts"               "uart"          31, 32
> +       "uart2_1_txd_rxd"               "uart"          57, 58
> +       "uart2_1_cts_rts"               "uart"          59, 60
> +       "watchdog"                      "watchdog"      11
> +       "wf0_2g"                        "wifi"          70, 71, 72, 73, 74,
> +                                                       75, 76, 77, 78
> +       "wf0_5g"                        "wifi"          0, 1, 2, 3, 4, 5, 6,
> +                                                       7, 8, 9, 10
> +
>  Example:
>
>         pio: pinctrl@10211000 {
> --
> 1.9.1
>
