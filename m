Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AF8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAF92184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDG929pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfAWUam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:30:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38106 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfAWUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:30:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so1586908pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 12:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dQeGla4uY96qKmBJkDGL86JxP6wLAR5iTrjDEvM77oE=;
        b=EDG929pc2kX8wjhSzZnhcljnQKqDMWS2JVqUtTET/Ciis0H+v4kl+vTgQTaN+HhAhc
         +gzPy+0f20kamcWvxn8TbcaQvFwIvT2Up/6HjEBbUVdcsHC4KmLX4tr+IynGbGQKUcXX
         OGXqJ6a9y9XZn2n+6Hla3zwe6vQGcHVhNfeto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dQeGla4uY96qKmBJkDGL86JxP6wLAR5iTrjDEvM77oE=;
        b=O38CoGdlTbIsM0slym8EGpuF43Q3sg3lVRffIS13X1q2U/Jy89BJxVIA4vnM5K1AH6
         qVOjNuyZzufP0vACmzockweR6lHdPP3GVZJEkQDR8zKRj8o8fqsIqBasyPpmUftrUeZ7
         kfsYjQkXx0bTWwM4AN4356KusL8atgJEJmoaUK9uJ6iOQVapwo/TxCwBnClajsJ5xKKR
         3TgL9ZiJuI8JSCExDI/2anxoCDdLYNaYKIXnSHJorKGoPst8bGmdjhW8xZMEnWtRhAlT
         dq9WUAXp6UYUscihmdP4G6DFhvr/brVDRXJDDlfTOlcumd7/AVLurXzAKGTS4p3+GivG
         1nVA==
X-Gm-Message-State: AJcUukfIUdU60SmiXcd15RnUZ2V0P5RQSC/grt9PcnsGB/Uz9KodtKnu
        4ZWXTL73sNsgFs8XaVIFNqf9dP8qWPRNnQ==
X-Google-Smtp-Source: ALg8bN4D/kS9dfTmOaoCBMGZpc6PzYx617Qf74y0eMzFMdO4fA7DAdxjqYBygDQ91hm8+9zHgZgAiQ==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr3431308pgb.26.1548275440685;
        Wed, 23 Jan 2019 12:30:40 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id e86sm29132416pfb.6.2019.01.23.12.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 12:30:39 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH][RESEND] arm64: dts: hikey: Add DMA entries for Bluetooth UART
Date:   Wed, 23 Jan 2019 12:30:37 -0800
Message-Id: <1548275437-6022-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma0 references for bluetooth uart to enable dma
for bt transfers.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index aec9e37..fa15a08 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -319,6 +319,8 @@
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func1 &uart1_cfg_func2>;
+			dmas = <&dma0 8 &dma0 9>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.7.4

