Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1A4C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FD9208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jjOgUmzz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LH3zCQgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FD9208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeHQWQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:16:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbeHQWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:15:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 67A07625AA; Fri, 17 Aug 2018 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534533041;
        bh=bQETiLhZqSKTJmg/844rsftxBCVPpj2SQb/j29Mvqxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjOgUmzz+ALzAMf9KdkqpLr8MCfs3g5jG+8M3FJ/vZDjEFOwMFOA1QVkOaSv7Qw4T
         ZpOSpR7PMyIx+wTMiFijJ/e5L33IQ7eYZDiEB7ZxK/Nc/ECJNkUMvfZalDJ+zapP6U
         8iwj7hzqVwz8RrjXVCZidP0LFXPKWVysVI81y7Lw=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67138625AA;
        Fri, 17 Aug 2018 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534533040;
        bh=bQETiLhZqSKTJmg/844rsftxBCVPpj2SQb/j29Mvqxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LH3zCQgVw9WchAZoQMytQMEsl5nAs5sadxvpyInqB81n55HznV3aZcW8FOxJnPR6F
         qNh0j+F7JZLZZ1L8cnXT6hvvnospLNOSGYTNxRO2nZxx9/U56uHr5ig1p4Y+WYkDDd
         vfAMI1MzSa9Z5gz010L/ayWwY5HLDtLxlydvq5bE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67138625AA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH RESEND v1 4/5] arm64: dts: qcom: add wake up interrupts for GPIOs for SDM845
Date:   Fri, 17 Aug 2018 13:10:25 -0600
Message-Id: <20180817191026.32245-5-ilina@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817191026.32245-1-ilina@codeaurora.org>
References: <20180817191026.32245-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOs that are wakeup capable have interrupt lines that are routed to
the always-on interrupt controller (PDC) in parallel to the pinctrl. The
interrupts listed here are the wake up lines corresponding to GPIOs.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
Changes in v1:
	- Use interrupt-extended for all TLMM interrupts
	- Define GPIO-PDC map using interrupt-names
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 57 +++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 87ffc32dc597..2379684373d3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -712,11 +712,66 @@
 		tlmm: pinctrl@3400000 {
 			compatible = "qcom,sdm845-pinctrl";
 			reg = <0x03400000 0xc00000>;
-			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			interrupts-extended = <&intc GIC_SPI 208 0>,
+				<&pdc 510 0>, <&pdc 511 0>, <&pdc 512 0>,
+				<&pdc 513 0>, <&pdc 514 0>, <&pdc 515 0>,
+				<&pdc 516 0>, <&pdc 517 0>, <&pdc 518 0>,
+				<&pdc 519 0>, <&pdc 632 0>, <&pdc 639 0>,
+				<&pdc 521 0>, <&pdc 522 0>, <&pdc 523 0>,
+				<&pdc 524 0>, <&pdc 525 0>, <&pdc 526 0>,
+				<&pdc 527 0>, <&pdc 630 0>, <&pdc 637 0>,
+				<&pdc 529 0>, <&pdc 530 0>, <&pdc 531 0>,
+				<&pdc 532 0>, <&pdc 633 0>, <&pdc 640 0>,
+				<&pdc 534 0>, <&pdc 535 0>, <&pdc 536 0>,
+				<&pdc 537 0>, <&pdc 538 0>, <&pdc 539 0>,
+				<&pdc 540 0>, <&pdc 541 0>, <&pdc 542 0>,
+				<&pdc 543 0>, <&pdc 544 0>, <&pdc 545 0>,
+				<&pdc 546 0>, <&pdc 547 0>, <&pdc 548 0>,
+				<&pdc 549 0>, <&pdc 550 0>, <&pdc 551 0>,
+				<&pdc 552 0>, <&pdc 553 0>, <&pdc 554 0>,
+				<&pdc 555 0>, <&pdc 556 0>, <&pdc 557 0>,
+				<&pdc 631 0>, <&pdc 638 0>, <&pdc 559 0>,
+				<&pdc 560 0>, <&pdc 561 0>, <&pdc 562 0>,
+				<&pdc 563 0>, <&pdc 564 0>, <&pdc 565 0>,
+				<&pdc 566 0>, <&pdc 570 0>, <&pdc 571 0>,
+				<&pdc 572 0>, <&pdc 573 0>, <&pdc 609 0>,
+				<&pdc 610 0>, <&pdc 611 0>, <&pdc 612 0>,
+				<&pdc 613 0>, <&pdc 614 0>, <&pdc 615 0>,
+				<&pdc 617 0>, <&pdc 618 0>, <&pdc 619 0>,
+				<&pdc 620 0>, <&pdc 621 0>, <&pdc 622 0>,
+				<&pdc 623 0>;
+			interrupt-names = "summary-irq",
+				"gpio1", "gpio3", "gpio5",
+				"gpio10", "gpio11", "gpio20",
+				"gpio22", "gpio24", "gpio26",
+				"gpio30", "gpio31", "gpio31",
+				"gpio32", "gpio34", "gpio36",
+				"gpio37", "gpio38", "gpio39",
+				"gpio40", "gpio41", "gpio41",
+				"gpio43", "gpio44", "gpio46",
+				"gpio48", "gpio49", "gpio49",
+				"gpio52", "gpio53", "gpio54",
+				"gpio56", "gpio57", "gpio58",
+				"gpio59", "gpio60", "gpio61",
+				"gpio62", "gpio63", "gpio64",
+				"gpio66", "gpio68", "gpio71",
+				"gpio73", "gpio77", "gpio78",
+				"gpio79", "gpio80", "gpio84",
+				"gpio85", "gpio86", "gpio88",
+				"gpio89", "gpio89", "gpio91",
+				"gpio92", "gpio95", "gpio96",
+				"gpio97", "gpio101", "gpio103",
+				"gpio104", "gpio115", "gpio116",
+				"gpio117", "gpio118", "gpio119",
+				"gpio120", "gpio121", "gpio122",
+				"gpio123", "gpio124", "gpio125",
+				"gpio127", "gpio128", "gpio129",
+				"gpio130", "gpio132", "gpio133",
+				"gpio145";
 
 			qup_i2c0_default: qup-i2c0-default {
 				pinmux {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

