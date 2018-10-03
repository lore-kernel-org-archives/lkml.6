Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1749EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED7F21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aTHDF218";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dsZHbfet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED7F21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJCUd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:33:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:33:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4070F601D4; Wed,  3 Oct 2018 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538574297;
        bh=NGYVtV1dw2SfrZCvUbl054rt8I1ihSXYWaP5nI4MPoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTHDF218jjO4771SBA7/hlyywDBpgwRttdXMgamzJVg8I2OOBGxIFfZCa+hQ/e72M
         /vNWd5b6uWe/qKdNtk9XXzXHXfwTUOAHq0mqlI+ShjUlzjEIzYerxC5q6XxJtEua3F
         lM7KEpAUEJxQWa+Hij1QsDG5tLGJ4A5eG5P0awUk=
Received: from alokc-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7413860376;
        Wed,  3 Oct 2018 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538574296;
        bh=NGYVtV1dw2SfrZCvUbl054rt8I1ihSXYWaP5nI4MPoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dsZHbfet/KMDMsLEMcAhVNYbP6fC8noJR4Lfk8BX/M5HfZbt7sKvu/Oen8g787uE8
         koDiE8obkeOsCRaiECxWhql9R/yCQRNvSmg0oDxK1PpXwNXLQAiic2PH14m6XNO8oP
         mqX7lQ7JDmsXBvd+KhF+Wmzp9OEnfDsSwkyiWS3s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7413860376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=alokc@codeaurora.org
From:   Alok Chauhan <alokc@codeaurora.org>
To:     swboyd@chromium.org, dianders@chromium.org, broonie@kernel.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
Subject: [PATCH V5 1/3] dt-bindings: soc: qcom: Remove SPI controller maximum frequency binding
Date:   Wed,  3 Oct 2018 19:14:23 +0530
Message-Id: <1538574265-30235-2-git-send-email-alokc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dilip Kota <dkota@codeaurora.org>

SPI controller driver should maintain the maximum frequency
of the controller instead of relying on device tree bindings.
Because maximum frequency is specific property of SPI
controller.

Signed-off-by: Dilip Kota <dkota@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
index ff92e5a..b9d0c21 100644
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

