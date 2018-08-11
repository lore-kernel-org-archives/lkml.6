Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2269C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BFC21E20
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDAjEi0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BFC21E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeHKWlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:41:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41734 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeHKWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:41:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so10987700wrr.8;
        Sat, 11 Aug 2018 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNM0zI6wYeKD4vnra9jXtYMqpohgR/GVN0J08BJTvGc=;
        b=oDAjEi0H31t0RRlUPuqYdsjycVIQBI/oExLpRroAs2crWdgwpL3l7hwOBc2FsWEwxH
         huUl31XLQYuOePrq2y72cT0OJF7J2LLxzkfApYt5fjfP19XbOtTiKhZN84u9pncXNzdW
         RTZRVzlm2YoE+UvLukNkmu9PfHMeQfnk0qQb9lrqF12VXjA56Fq0GtWHLsfXx4mX2MwK
         foVmDAgmUm3IkINszDziGZ7IZZfqpDZw9lXI+zTiam71HbblhxKH8QnCz2iEkzuMdO/j
         pPNPacWJyLo3GNiL8Jz9bBNu3GLi7nG0OQ4eKlv+5vkFh3LFvdyOPZzoaKrZqPSC57UK
         Zmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNM0zI6wYeKD4vnra9jXtYMqpohgR/GVN0J08BJTvGc=;
        b=hP9abW1wdbGNpsPr1PPxbeg8YRpxUwuvuaI2BZtiQ3AY+Bxf3bxGD2/6XQJlpOw6Hz
         eSjimcSdaaOHUGe+dAuuKWIEhfl3CV3vkn4EPfMHeNdqeGXe9wser0lgE/VW4UDYPUst
         sf6Zu5Rp4WQ7lcHibTwjOMMq1Qj+IXk1YxquVHQcGzQFN41mPyv5yeNnF3MGUiu0UqoM
         5QgehToVd7hiYAMv6MCTFaVbrLP18fOZX1QLSIU6/JL7EE6mzdUUIOqSZrOpsJ7usqOq
         /lgfpoFzDooWJ7Nasmq2S814kQ3UNf45dxELDwYub5jVp73fstWbB5q3C1YlmE9QY4kx
         nGpQ==
X-Gm-Message-State: AOUpUlFrTs5CGBxF3YVOHc2c+CbHv7uVy9jLYPNSM9BaIlGXuioMTyXa
        3gaFyUPlTVox0DX+xyf8B/Lkt6EL
X-Google-Smtp-Source: AA+uWPwUyhYYTDBS4gftCkCjnIjphQ9R8px6FFq1l9pLFh7X2HiKCYA4gbeyqpxqInhnQDxuZGfJvQ==
X-Received: by 2002:adf:f906:: with SMTP id b6-v6mr4302509wrr.28.1534008464673;
        Sat, 11 Aug 2018 10:27:44 -0700 (PDT)
Received: from debian64.daheim (p4FD092A7.dip0.t-ipconnect.de. [79.208.146.167])
        by smtp.gmail.com with ESMTPSA id j8-v6sm11953745wrp.11.2018.08.11.10.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Aug 2018 10:27:44 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.91)
        (envelope-from <chunkeey@gmail.com>)
        id 1foXfz-0002JZ-Dc; Sat, 11 Aug 2018 19:27:43 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Craig Tatlor <ctatlor97@gmail.com>, linux-arm-msm@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: Add sdm660 pinctrl driver
Date:   Sat, 11 Aug 2018 19:27:43 +0200
Message-ID: <2202961.SmUWKIdeCe@debian64>
In-Reply-To: <20180811162520.11641-1-ctatlor97@gmail.com>
References: <20180811162520.11641-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 11, 2018 6:25:19 PM CEST Craig Tatlor wrote:
> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for sdm660.
> Based off CAF implementation.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
> new file mode 100644
> index 000000000000..85e6c6c17c04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
> @@ -0,0 +1,195 @@
> +Qualcomm Technologies, Inc. SDM660 TLMM block
> +
> +This binding describes the Top Level Mode Multiplexer block found in the
> +SDM660 platform.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,sdm660-pinctrl"
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: the base address and size of the TLMM register space.
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify the TLMM summary IRQ.
> +
> +- interrupt-controller:
> +	Usage: required
> +	Value type: <none>
> +	Definition: identifies this node as an interrupt controller
> +
> +- #interrupt-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be 2. Specifying the pin number and flags, as defined
> +		    in <dt-bindings/interrupt-controller/irq.h>
> +
> +- gpio-controller:
> +	Usage: required
> +	Value type: <none>
> +	Definition: identifies this node as a gpio controller
> +
> +- #gpio-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be 2. Specifying the pin number and flags, as defined
> +		    in <dt-bindings/gpio/gpio.h>
> +
> +Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
> +a general description of GPIO and interrupt bindings.
You want to specify gpio-ranges here as well. The property is explained
in Section "2.1) gpio- and pin-controller interaction" in ../gpio/gpio.txt

Without it, the gpio-hogs construct (part of ../gpio/gpio.txt) will cause
the driver to fail during boot. (try it, ;-) )

> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices, including the meaning of the
> +phrase "pin configuration node".
> +
> +The pin configuration nodes act as a container for an arbitrary number of
> +subnodes. Each of these subnodes represents some desired configuration for a
> +pin, a group, or a list of pins or groups. This configuration can include the
> +mux function to select on those pin(s)/group(s), and various pin configuration
> +parameters, such as pull-up, drive strength, etc.
> +
> +
> +PIN CONFIGURATION NODES:
> +
> +The name of each subnode is not important; all subnodes should be enumerated
> +and processed purely based on their content.
> +
> +Each subnode only affects those parameters that are explicitly listed. In
> +other words, a subnode that lists a mux function but no pin configuration
> +parameters implies no information about any pin configuration parameters.
> +Similarly, a pin subnode that describes a pullup parameter implies no
> +information about e.g. the mux function.
> +
> +
> +The following generic properties as defined in pinctrl-bindings.txt are valid
> +to specify in a pin configuration subnode:
> +
> +- pins:
> +	Usage: required
> +	Value type: <string-array>
> +	Definition: List of gpio pins affected by the properties specified in
> +		    this subnode.  Valid pins are:
> +		    gpio0-gpio149,
> +		        Supports mux, bias and drive-strength
> +		    sdc1_clk, sdc1_cmd, sdc1_data sdc2_clk, sdc2_cmd, sdc2_data sdc1_rclk,
> +		        Supports bias and drive-strength
> +
> +- function:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Specify the alternative function to be configured for the
> +		    specified pins. Functions are only valid for gpio pins.
> +		    Valid values are:
> +
> +		    blsp_uart1, blsp_spi1, blsp_i2c1, blsp_uim1, atest_tsens,
> +		    bimc_dte1, dac_calib0, blsp_spi8, blsp_uart8, blsp_uim8,
> +		    qdss_cti_trig_out_b, bimc_dte0, dac_calib1, qdss_cti_trig_in_b,
> +		    dac_calib2, atest_tsens2, atest_usb1, blsp_spi10, blsp_uart10,
> +		    blsp_uim10, atest_bbrx1, atest_usb13, atest_bbrx0, atest_usb12,
> +		    mdp_vsync, edp_lcd, blsp_i2c10, atest_gpsadc1, atest_usb11,
> +		    atest_gpsadc0, edp_hot, atest_usb10, m_voc, dac_gpio, atest_char,
> +		    cam_mclk, pll_bypassnl, qdss_stm7, blsp_i2c8, qdss_tracedata_b,
> +		    pll_reset, qdss_stm6, qdss_stm5, qdss_stm4, atest_usb2, cci_i2c,
> +		    qdss_stm3, dac_calib3, atest_usb23, atest_char3, dac_calib4,
> +		    qdss_stm2, atest_usb22, atest_char2, qdss_stm1, dac_calib5,
> +		    atest_usb21, atest_char1, dbg_out, qdss_stm0, dac_calib6,
> +		    atest_usb20, atest_char0, dac_calib10, qdss_stm10,
> +		    qdss_cti_trig_in_a, cci_timer4, blsp_spi6, blsp_uart6, blsp_uim6,
> +		    blsp2_spi, qdss_stm9, qdss_cti_trig_out_a, dac_calib11,
> +		    qdss_stm8, cci_timer0, qdss_stm13, dac_calib7, cci_timer1,
> +		    qdss_stm12, dac_calib8, cci_timer2, blsp1_spi, qdss_stm11,
> +		    dac_calib9, cci_timer3, cci_async, dac_calib12, blsp_i2c6,
> +		    qdss_tracectl_a, dac_calib13, qdss_traceclk_a, dac_calib14,
> +		    dac_calib15, hdmi_rcv, dac_calib16, hdmi_cec, pwr_modem,
> +		    dac_calib17, hdmi_ddc, pwr_nav, dac_calib18, pwr_crypto,
> +		    dac_calib19, hdmi_hot, dac_calib20, dac_calib21, pci_e0,
> +		    dac_calib22, dac_calib23, dac_calib24, tsif1_sync, dac_calib25,
> +		    sd_write, tsif1_error, blsp_spi2, blsp_uart2, blsp_uim2,
> +		    qdss_cti, blsp_i2c2, blsp_spi3, blsp_uart3, blsp_uim3, blsp_i2c3,
> +		    uim3, blsp_spi9, blsp_uart9, blsp_uim9, blsp10_spi, blsp_i2c9,
> +		    blsp_spi7, blsp_uart7, blsp_uim7, qdss_tracedata_a, blsp_i2c7,
> +		    qua_mi2s, gcc_gp1_clk_a, ssc_irq, uim4, blsp_spi11, blsp_uart11,
> +		    blsp_uim11, gcc_gp2_clk_a, gcc_gp3_clk_a, blsp_i2c11, cri_trng0,
> +		    cri_trng1, cri_trng, qdss_stm18, pri_mi2s, qdss_stm17, blsp_spi4,
> +		    blsp_uart4, blsp_uim4, qdss_stm16, qdss_stm15, blsp_i2c4,
> +		    qdss_stm14, dac_calib26, spkr_i2s, audio_ref, lpass_slimbus,
> +		    isense_dbg, tsense_pwm1, tsense_pwm2, btfm_slimbus, ter_mi2s,
> +		    qdss_stm22, qdss_stm21, qdss_stm20, qdss_stm19, gcc_gp1_clk_b,
> +		    sec_mi2s, blsp_spi5, blsp_uart5, blsp_uim5, gcc_gp2_clk_b,
> +		    gcc_gp3_clk_b, blsp_i2c5, blsp_spi12, blsp_uart12, blsp_uim12,
> +		    qdss_stm25, qdss_stm31, blsp_i2c12, qdss_stm30, qdss_stm29,
> +		    tsif1_clk, qdss_stm28, tsif1_en, tsif1_data, sdc4_cmd, qdss_stm27,
> +		    qdss_traceclk_b, tsif2_error, sdc43, vfr_1, qdss_stm26, tsif2_clk,
> +		    sdc4_clk, qdss_stm24, tsif2_en, sdc42, qdss_stm23, qdss_tracectl_b,
> +		    sd_card, tsif2_data, sdc41, tsif2_sync, sdc40, mdp_vsync_p_b,
> +		    ldo_en, mdp_vsync_s_b, ldo_update, blsp11_uart_tx_b, blsp11_uart_rx_b,
> +		    blsp11_i2c_sda_b, prng_rosc, blsp11_i2c_scl_b, uim2, uim1, uim_batt,
> +		    pci_e2, pa_indicator, adsp_ext, ddr_bist, qdss_tracedata_11,
> +		    qdss_tracedata_12, modem_tsync, nav_dr, nav_pps, pci_e1, gsm_tx,
> +		    qspi_cs, ssbi2, ssbi1, mss_lte, qspi_clk, qspi0, qspi1, qspi2, qspi3,
> +		    gpio
> +
> +- bias-disable:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins should be configued as no pull.
> +
> +- bias-pull-down:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins should be configued as pull down.
> +
> +- bias-pull-up:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins should be configued as pull up.
> +
> +- output-high:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins are configured in output mode, driven
> +		    high.
> +		    Not valid for sdc pins.
> +
> +- output-low:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins are configured in output mode, driven
> +		    low.
> +		    Not valid for sdc pins.
> +
> +- drive-strength:
> +	Usage: optional
> +	Value type: <u32>
> +	Definition: Selects the drive strength for the specified pins, in mA.
> +		    Valid values are: 2, 4, 6, 8, 10, 12, 14 and 16
> +
> +Example:
> +
> +	tlmm: pinctrl@01010000 {
> +		compatible = "qcom,sdm660-pinctrl";
> +		reg = <0x01010000 0x300000>;
> +		interrupts = <0 208 0>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
+		gpio-ranges = <&tlmm 0 0 114>;

(please verify, I saw that sdm660_pinctrl sets .ngpios = 114.)

> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		uart_console_active: uart_console_active {
> +			mux {
> +				pins = "gpio4", "gpio5";
> +				function = "blsp_uart8";
> +			};
> +
> +			config {
> +				pins = "gpio4", "gpio5";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +		};
> +	};
[...]



