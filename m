Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78493ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD352150C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NqIr2SG3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NqIr2SG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD352150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeIRXmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:42:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729907AbeIRXmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:42:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B0E64607C6; Tue, 18 Sep 2018 18:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537294115;
        bh=NRs1BTIKrLgBMl3U1lp4k2BzbatZlzjGjQHJay7tMdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqIr2SG334Anjn6HWOhdkJsKM+n/PFz+F4k9Y2KNFYc0WtApWw6cnEMD4wNWfWgv5
         IOcKWgCCHvwTUScz2pjalwujs0JOMd5dArJyFfYOKbuccafG+P+s+ehcXI4yyPZWq0
         BBOyFPByvVZmpIZalRof7ikYj0tvQ3WX7jUS23UI=
Received: from dkota-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dkota@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FB70607C6;
        Tue, 18 Sep 2018 18:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537294115;
        bh=NRs1BTIKrLgBMl3U1lp4k2BzbatZlzjGjQHJay7tMdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqIr2SG334Anjn6HWOhdkJsKM+n/PFz+F4k9Y2KNFYc0WtApWw6cnEMD4wNWfWgv5
         IOcKWgCCHvwTUScz2pjalwujs0JOMd5dArJyFfYOKbuccafG+P+s+ehcXI4yyPZWq0
         BBOyFPByvVZmpIZalRof7ikYj0tvQ3WX7jUS23UI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FB70607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=dkota@codeaurora.org
From:   Dilip Kota <dkota@codeaurora.org>
To:     swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Dilip Kota <dkota@codeaurora.org>
Subject: [PATCH V4 1/4] dt-bindings: soc: qcom: Remove SPI controller maximum frequency binding
Date:   Tue, 18 Sep 2018 23:37:23 +0530
Message-Id: <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI controller driver should maintain the maximum frequency
of the controller instead of relying on device tree bindings.
Because maximum frequency is specific property of SPI
controller.

Signed-off-by: Dilip Kota <dkota@codeaurora.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index 68b7d62..16467ed 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
@@ -60,7 +60,6 @@ Required properties:
 - interrupts:		Must contain SPI controller interrupts.
 - clock-names:		Must contain "se".
 - clocks:		Serial engine core clock needed by the device.
-- spi-max-frequency:	Specifies maximum SPI clock frequency, units - Hz.
 - #address-cells:	Must be <1> to define a chip select address on
 			the SPI bus.
 - #size-cells:		Must be <0>.
@@ -112,7 +111,6 @@ Example:
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&qup_1_spi_2_active>;
 			pinctrl-1 = <&qup_1_spi_2_sleep>;
-			spi-max-frequency = <19200000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

