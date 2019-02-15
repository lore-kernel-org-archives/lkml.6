Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39F9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B6C206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGrnrRtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfBOFuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:50:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44941 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbfBOFuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:50:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so4258665pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 21:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FgP1Av6WIa2OwRHRskBEOGvJeOoMNE23SqACDKpO5GA=;
        b=vGrnrRtOh+CFwVIsf5zXdpm3NO6QemlAqrI3DdzPURVLojYlwn0pRxREBrdseVUL5I
         g0dvRPCEy6lrPrwNc9L8x8Dm7adEnKmhAThoeFaBPqAxSizh4ytLuAYPxFuYAr4/NwnN
         cdsEK0R06AkbfcR8fdfWvD77eK/88XkUr/GIUk0Wrz+fGWqlvoaO2w1oEGZjHbD9r1Ha
         zQ85PGidEd2Fdw/iuwQv/yrfzv7HLsxnIagEbfEak9xDt6gdwGhRGnHI8HTu0oAcd1Bh
         w2kwtl749r4KkQ9cBBKuK/v9a8G7O5gYiLEEBod9+EQz8KLLeYZZZYxPvl8ZO1goAiMQ
         +lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FgP1Av6WIa2OwRHRskBEOGvJeOoMNE23SqACDKpO5GA=;
        b=suRMAAKs1ByOof0IgTbfhKlnhlAnNzI5ar5wEOYL9pKi5ILdXZYc6Oi9DrmqMoheyR
         YS3pEJCr2u2JaNsO/iQGKDJTFh88I1+M+hRnkmbbfO/PF04uLHmPBezTmdHEeIAkNWDf
         RfZGDLkilu7ptX6bNeI/uMckW7newZLoNWCEwkLN/KNsXT9m3U1jexizvbktg0EmbWAe
         WoV6UWq9ikgJidfbMpe/+mq+5aAv3tB3HRyL38LwLltBWUhrI/rwvWYRppHcIJWKzDMP
         R096fISMMmlxdkP1Erc9zAASisaTGhUJLRrZjY/AioomQBRBDe7huEytqeB1QFObmIDE
         PAgA==
X-Gm-Message-State: AHQUAuapl1l2G1qFbCC9EoT4T2jJtF3vwgFIO2kqu7uWLIZfOSdY0xdx
        dK15PR3nqL3hz7Dlo2dJhudn
X-Google-Smtp-Source: AHgI3IY1YLEQr63XAmBf0S/+piyK7nomI07zC/PaEqZz/zzepN1rt9s0hPp597nA8odFMTlFrKjDkg==
X-Received: by 2002:a63:e742:: with SMTP id j2mr3818961pgk.172.1550209814821;
        Thu, 14 Feb 2019 21:50:14 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98a:c91:14c4:f458:9909:7fad])
        by smtp.gmail.com with ESMTPSA id c18sm6160810pfc.63.2019.02.14.21.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 21:50:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org,
        john.stultz@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: reset: Add HI3670 reset controller binding
Date:   Fri, 15 Feb 2019 11:19:54 +0530
Message-Id: <20190215054955.788-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
References: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
driver is reused for HI3670 SoC and the binding is documented here which
uses the fallback approach.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt   | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
index 2bf3344b2a02..2df4bddeb688 100644
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
@@ -5,11 +5,12 @@ Please also refer to reset.txt in this directory for common reset
 controller binding usage.
 
 The reset controller registers are part of the system-ctl block on
-hi3660 SoC.
+hi3660 and hi3670 SoCs.
 
 Required properties:
-- compatible: should be
-		 "hisilicon,hi3660-reset"
+- compatible: should be one of the following:
+		 "hisilicon,hi3660-reset" for HI3660
+		 "hisilicon,hi3670-reset", "hisilicon,hi3660-reset" for HI3670
 - hisi,rst-syscon: phandle of the reset's syscon.
 - #reset-cells : Specifies the number of cells needed to encode a
   reset source.  The type shall be a <u32> and the value shall be 2.
-- 
2.17.1

