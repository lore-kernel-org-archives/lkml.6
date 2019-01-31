Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E08C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAEC2184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/rzxnHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfAaFO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:14:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33713 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfAaFOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:14:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so963690pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 21:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iWzoEnzGzcfe+b5ad6jke+CHgTHgDATWN/9/ul39DW0=;
        b=g/rzxnHbktj4HQMOhBi4l3CyUafYYYB7Vb5m9L/GfEWAFE1aJdF0QrOyzg50aK91cf
         WsCovQYXrhd0N/AP9LrAyfTlmwziWPaMxoLBYo1tunQHcwcXTp5XhUc/vJ0SL9BugehO
         zSJaKsu8jtugHgw5xDT33dER2RMwGIAgyfVpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iWzoEnzGzcfe+b5ad6jke+CHgTHgDATWN/9/ul39DW0=;
        b=iLco4K41Wx8b5Eyvl5ZxdlJ5trWetPB2PMgzv2J8uYJohqMzeAf5L4dgmnt7HGETC4
         ypdnQAP2iDu3X6XJQ59sH4J0MrSiZ1ZZa8uqWihi91Hk6bNlH3RmNMMTeXt4/yY4GiOV
         YUlb/d0MkBxwWCHXbHtN9evJcycqWVrwJ4ysNhKYogy6VJTWh7U8ZL7yxoWeeS6rJLB9
         PvzQn0IGSXW79ykKiwxbdzZustLsVhWIfFmcYlr6NbsSh1r8Yd4Gacz8mIIYbdi4XPtv
         i6RAsAD0rHKFyQYNGqhDMSAUgCl3Tyim/JwshR4K6dfXjbYqErS2xPY8t3ktHzcr8fH7
         bQsg==
X-Gm-Message-State: AJcUukf8lAEQwDynXsdk4oMDBPWumPIy4rWBvxFvRkHClbrkKcamWujP
        KQz9d1X51JbJK+GnL+uRkuXK2w==
X-Google-Smtp-Source: ALg8bN4UzG4iGCMV1C/HjFr4Y7bE/AHQGBcIqXOIgKd+zSL07dTmTW+djJr6zHl3Qoye4RVQLbgK+g==
X-Received: by 2002:a63:f65:: with SMTP id 37mr29985418pgp.238.1548911694658;
        Wed, 30 Jan 2019 21:14:54 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s37sm5880483pgm.19.2019.01.30.21.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 21:14:53 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sdm845: Add clocks and iommus to WCN3990 WLAN node
Date:   Wed, 30 Jan 2019 21:14:38 -0800
Message-Id: <20190131051438.12867-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190119000016.139657-1-dianders@chromium.org>
References: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

When commit be7019103469 ("dts: arm64/sdm845: Add WCN3990 WLAN module
device node") was posted upstream no clocks were specified.  However,
when the pack was picked into the Chrome OS kernel tree (allegedly
directly from the mailing list post) it had clock properties.

I presume that the clock should be there, so let's add it.

Fixes: be7019103469 ("dts: arm64/sdm845: Add WCN3990 WLAN module device node")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
[bjorn: Add also the required iommus property]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Hijacking Doug's fixup patch to also add the missing iommus property. Without
this the MTP reboots once the ath10k is trying to exercise the copyengine.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cba09899282e..58f034664336 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2422,6 +2422,8 @@
 			reg = <0 0x18800000 0 0x800000>;
 			reg-names = "membase";
 			memory-region = <&wlan_msa_mem>;
+			clock-names = "cxo_ref_clk_pin";
+			clocks = <&rpmhcc RPMH_RF_CLK2>;
 			interrupts =
 				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
@@ -2435,6 +2437,7 @@
 				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&apps_smmu 0x0040 0x1>;
 		};
 	};
 
-- 
2.18.0

