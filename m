Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3877C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A298A20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AjTAT1Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405250AbfAPQL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:11:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54334 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405228AbfAPQLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:11:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so2580821wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jinzyf9/O+SMx8INgN4EUNWLAGDQnyj+5fdQ+uj/Fb0=;
        b=AjTAT1BsYmaPC+ck8CpYqZVy5QMSxxLiU4/+Z3z4MhkagvUjAWUYVoiPq6eBH9qYA0
         nJkwADZpLT/dC7d07kuFthh50AqOSYg5bkOhNKGBQomqrjgDtIR6U4DPlBRryL5PQIT1
         BRsyQ1aD/Ows3h/6DAo2X7AraFlNcN6eq9N6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jinzyf9/O+SMx8INgN4EUNWLAGDQnyj+5fdQ+uj/Fb0=;
        b=d5FBVy/XSCUPkPs61rNjZD4VDGeLTGB8IU6KFNxow0+lo3SdzmfyKOWXaEUUFfX9/Z
         X1jkiBIZE6o8+7jdnQPKk1pF9qc1AOLQi6E0DyKDHWUOTUSYIkOiVxrlX0uB3R09c91X
         ZB8+6IwB0lcTg8irOchFChjxWsqAQm5T80TH3P2qAWnxkaF1s6z1PCM6+eCaJwPn/LXw
         wTcqvC+TgAvZZkkwMerhuHeuVdU+fzGO/6Q7HNsiz6Xfdfc0pdei3XrnLdWb4El012Ol
         9N8kW92EDGzrzL0Yw2gBW3Uywm5cU0MZIPeR0J2Vop7PcmLvqzzhoXfwSxe552650vei
         c2uQ==
X-Gm-Message-State: AJcUukencqyM6pjLRtr5CYi17yKOxI7PasObq7GeqhBWXwn5XUygbwMP
        C2aQqn3NTyRg7UutCTVIcTPOBw==
X-Google-Smtp-Source: ALg8bN6+OWLo23Zec1ggzBZW9SNn4OijgnXNuqhq1lo4rd9Kcqk7Gq947XzgiCxmwhPcOFg8yT3l/w==
X-Received: by 2002:a1c:20cb:: with SMTP id g194mr7947410wmg.77.1547655080868;
        Wed, 16 Jan 2019 08:11:20 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a17sm78193407wrs.58.2019.01.16.08.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 08:11:19 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     andy.gross@linaro.org, olof@lixom.net, arnd@arndb.de,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, abailon@baylibre.com,
        maxime.ripard@bootlin.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, georgi.djakov@linaro.org
Subject: [PATCH v13 6/8] arm64: dts: sdm845: Add interconnect provider DT nodes
Date:   Wed, 16 Jan 2019 18:11:01 +0200
Message-Id: <20190116161103.6937-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Add RSC (Resource State Coordinator) provider
dictating network-on-chip interconnect bus performance
found on SDM845-based platforms.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..5179cb94c95b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
@@ -1602,6 +1603,11 @@
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
 			};
+
+			rsc_hlos: interconnect {
+				compatible = "qcom,sdm845-rsc-hlos";
+				#interconnect-cells = <1>;
+			};
 		};
 
 		intc: interrupt-controller@17a00000 {
