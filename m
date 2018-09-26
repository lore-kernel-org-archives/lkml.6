Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44445C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA79C2152E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyTclIeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA79C2152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeIZWkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:40:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38274 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbeIZWkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:40:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so25818909ljc.5;
        Wed, 26 Sep 2018 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3OEVCjQooiByIrrH9TnuG8WzkNGWyNOBBdl/6u8GjtM=;
        b=gyTclIeITp4H60qBMX9pFxsdDOQdbcok9Pb3/tOyWmKgBaDz0fV3MqM6EG5Yo9nFFW
         7iCnHslREEovha1owsQ/7AQMfAogEezKEYrwXbmwpHUZwgLD/KtpXhj2P6k0bhbfQDPY
         ChToAwyN7P1GGxqldxIeR5UtxWihdDF80sB27Aj7K/qpahe8N4dX38rCr+CJ45WHbEmI
         QnjL1GDvwawQsqzv+FKqPslNTcKYRmyNCFAW25xFzBdjOIR2DWchYH6n6P4aV1oisUax
         ng2zG8Me8hG0KC3C39OhNNcdDoyyV9eJmicRg4H83TOrAOsfMMhueeHPz1WsxLBD5985
         FMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3OEVCjQooiByIrrH9TnuG8WzkNGWyNOBBdl/6u8GjtM=;
        b=NeWDs/5FbnGAVGmY40Ofe2avyebWHFaEK1U7NRSCkoLj2lXg5rf7CKrdfq9OA8/q7I
         o2wuKAQYuzU9cOsrp5COjn8Rc3jRGq+hd0ObMZrJrqRJsDP3eDakhmU2Q3MAuEl2T88s
         qW4sHONTtl4LLZexKRFcb9YG81XYd7ArfN+rS2O/Rm7dP7edPAvjiFoLAY2IsLFm/qGu
         I0v0MR9AmmaA/ZUGuw2XAMZ10p2qWcwwzfCEqr1kbS/sOSU5Svg9TgenCu/xMSlFDQWE
         JErrEsi6OAm7sx+vf7/EFIaiYafUSlCJFWW1seJ5QnWI/wNru6gqY5Az6Xj4EtC+mVez
         cDHg==
X-Gm-Message-State: ABuFfojALsTH+/WHKUljBOjgRX7gvfIUgFt+1rNM1LXJl1RTnHoch9ua
        t5c5B3YFVLVwNWhnMHPPaA==
X-Google-Smtp-Source: ACcGV63iJbMQ80C5iNjYbOps+CoHpfLMlqUD+fCUAi/pcehTDS5s6KDKxb9whSOkI+ZR0edcH9fsiA==
X-Received: by 2002:a2e:9a4d:: with SMTP id k13-v6mr1064473ljj.17.1537979219164;
        Wed, 26 Sep 2018 09:26:59 -0700 (PDT)
Received: from localhost.localdomain (host86-147-9-252.range86-147.btcentralplus.com. [86.147.9.252])
        by smtp.googlemail.com with ESMTPSA id a18-v6sm38235ljk.80.2018.09.26.09.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 09:26:58 -0700 (PDT)
From:   Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: pinctrl: qcom: Add SDM660 pinctrl binding
Date:   Wed, 26 Sep 2018 17:26:43 +0100
Message-Id: <20180926162644.10039-2-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926162644.10039-1-ctatlor97@gmail.com>
References: <20180925173801.3835-1-ctatlor97@gmail.com>
 <20180926162644.10039-1-ctatlor97@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding for the TLMM pinctrl block found in the SDM660 platform.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
Changes from v3: 
   Updated for tile structure
   change irq field

 .../bindings/pinctrl/qcom,sdm660-pinctrl.txt  | 181 ++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
new file mode 100644
index 000000000000..97e6622c0b85
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
@@ -0,0 +1,191 @@
+Qualcomm Technologies, Inc. SDM660 TLMM block
+
+This binding describes the Top Level Mode Multiplexer block found in the
+SDM660 platform.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,sdm660-pinctrl" or
+		    "qcom,sdm630-pinctrl".
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: the base address and size of the north, center and south
+		    TLMM tiles.
+
+- reg-names:
+       Usage: required
+       Value type: <stringlist>
+       Definition: names for the cells of reg, must contain "north", "center"
+                   and "south".
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: should specify the TLMM summary IRQ.
+
+- interrupt-controller:
+	Usage: required
+	Value type: <none>
+	Definition: identifies this node as an interrupt controller
+
+- #interrupt-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: must be 2. Specifying the pin number and flags, as defined
+		    in <dt-bindings/interrupt-controller/irq.h>
+
+- gpio-controller:
+	Usage: required
+	Value type: <none>
+	Definition: identifies this node as a gpio controller
+
+- gpio-ranges:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Specifies the mapping between gpio controller and
+		    pin-controller pins.
+
+- #gpio-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: must be 2. Specifying the pin number and flags, as defined
+		    in <dt-bindings/gpio/gpio.h>
+
+Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
+a general description of GPIO and interrupt bindings.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+The pin configuration nodes act as a container for an arbitrary number of
+subnodes. Each of these subnodes represents some desired configuration for a
+pin, a group, or a list of pins or groups. This configuration can include the
+mux function to select on those pin(s)/group(s), and various pin configuration
+parameters, such as pull-up, drive strength, etc.
+
+
+PIN CONFIGURATION NODES:
+
+The name of each subnode is not important; all subnodes should be enumerated
+and processed purely based on their content.
+
+Each subnode only affects those parameters that are explicitly listed. In
+other words, a subnode that lists a mux function but no pin configuration
+parameters implies no information about any pin configuration parameters.
+Similarly, a pin subnode that describes a pullup parameter implies no
+information about e.g. the mux function.
+
+
+The following generic properties as defined in pinctrl-bindings.txt are valid
+to specify in a pin configuration subnode:
+
+- pins:
+	Usage: required
+	Value type: <string-array>
+	Definition: List of gpio pins affected by the properties specified in
+		    this subnode.  Valid pins are:
+		    gpio0-gpio113,
+		        Supports mux, bias and drive-strength
+		    sdc1_clk, sdc1_cmd, sdc1_data sdc2_clk, sdc2_cmd, sdc2_data sdc1_rclk,
+		        Supports bias and drive-strength
+
+- function:
+	Usage: required
+	Value type: <string>
+	Definition: Specify the alternative function to be configured for the
+		    specified pins. Functions are only valid for gpio pins.
+		    Valid values are:
+		    adsp_ext, agera_pll, atest_char, atest_char0, atest_char1,
+		    atest_char2, atest_char3, atest_gpsadc0, atest_gpsadc1,
+		    atest_tsens, atest_tsens2, atest_usb1, atest_usb10,
+		    atest_usb11, atest_usb12, atest_usb13, atest_usb2,
+		    atest_usb20, atest_usb21, atest_usb22, atest_usb23,
+		    audio_ref, bimc_dte0, bimc_dte1, blsp_i2c1, blsp_i2c2,
+		    blsp_i2c3, blsp_i2c4, blsp_i2c5, blsp_i2c6, blsp_i2c7,
+		    blsp_i2c8_a, blsp_i2c8_b, blsp_spi1, blsp_spi2, blsp_spi3,
+		    blsp_spi3_cs1, blsp_spi3_cs2, blsp_spi4, blsp_spi5,
+		    blsp_spi6, blsp_spi7, blsp_spi8_a, blsp_spi8_b,
+		    blsp_spi8_cs1, blsp_spi8_cs2, blsp_uart1, blsp_uart2,
+		    blsp_uart5, blsp_uart6_a, blsp_uart6_b, blsp_uim1,
+		    blsp_uim2, blsp_uim5, blsp_uim6, cam_mclk, cci_async,
+		    cci_i2c, cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist,
+		    gcc_gp1, gcc_gp2, gcc_gp3, gpio, gps_tx_a, gps_tx_b, gps_tx_c,
+		    isense_dbg, jitter_bist, ldo_en, ldo_update, m_voc, mdp_vsync,
+		    mdss_vsync0, mdss_vsync1, mdss_vsync2, mdss_vsync3, mss_lte,
+		    nav_pps_a, nav_pps_b, nav_pps_c, pa_indicator, phase_flag0,
+		    phase_flag1, phase_flag10, phase_flag11, phase_flag12,
+		    phase_flag13, phase_flag14, phase_flag15, phase_flag16,
+		    phase_flag17, phase_flag18, phase_flag19, phase_flag2,
+		    phase_flag20, phase_flag21, phase_flag22, phase_flag23,
+		    phase_flag24, phase_flag25, phase_flag26, phase_flag27,
+		    phase_flag28, phase_flag29, phase_flag3, phase_flag30,
+		    phase_flag31, phase_flag4, phase_flag5, phase_flag6,
+		    phase_flag7, phase_flag8, phase_flag9, pll_bypassnl,
+		    pll_reset, pri_mi2s, pri_mi2s_ws, prng_rosc, pwr_crypto,
+		    pwr_modem, pwr_nav, qdss_cti0_a, qdss_cti0_b, qdss_cti1_a,
+		    qdss_cti1_b, qdss_gpio, qdss_gpio0, qdss_gpio1, qdss_gpio10,
+		    qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14, qdss_gpio15,
+		    qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6,
+		    qdss_gpio7, qdss_gpio8, qdss_gpio9, qlink_enable, qlink_request,
+		    qspi_clk, qspi_cs, qspi_data0, qspi_data1, qspi_data2,
+		    qspi_data3, qspi_resetn, sec_mi2s, sndwire_clk, sndwire_data,
+		    sp_cmu, ssc_irq, tgu_ch0, tgu_ch1, tsense_pwm1, tsense_pwm2,
+		    uim1_clk, uim1_data, uim1_present, uim1_reset, uim2_clk,
+		    uim2_data, uim2_present, uim2_reset, uim_batt, vfr_1,
+		    vsense_clkout, vsense_data0, vsense_data1, vsense_mode,
+		    wlan1_adc0, wlan1_adc1, wlan2_adc0, wlan2_adc1
+
+- bias-disable:
+	Usage: optional
+	Value type: <none>
+	Definition: The specified pins should be configued as no pull.
+
+- bias-pull-down:
+	Usage: optional
+	Value type: <none>
+	Definition: The specified pins should be configued as pull down.
+
+- bias-pull-up:
+	Usage: optional
+	Value type: <none>
+	Definition: The specified pins should be configued as pull up.
+
+- output-high:
+	Usage: optional
+	Value type: <none>
+	Definition: The specified pins are configured in output mode, driven
+		    high.
+		    Not valid for sdc pins.
+
+- output-low:
+	Usage: optional
+	Value type: <none>
+	Definition: The specified pins are configured in output mode, driven
+		    low.
+		    Not valid for sdc pins.
+
+- drive-strength:
+	Usage: optional
+	Value type: <u32>
+	Definition: Selects the drive strength for the specified pins, in mA.
+		    Valid values are: 2, 4, 6, 8, 10, 12, 14 and 16
+
+Example:
+
+	tlmm: pinctrl@3100000 {
+		compatible = "qcom,sdm660-pinctrl";
+		reg = <0x3100000 0x200000>,
+		      <0x3500000 0x200000>,
+		      <0x3900000 0x200000>;
+		reg-names = "south", "center", "north";
+		interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+		gpio-controller;
+		gpio-ranges = <&tlmm 0 0 114>;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
-- 
2.18.0
