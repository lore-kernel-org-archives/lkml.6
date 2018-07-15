Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047DBECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AF220870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/a6qkS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AF220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeGOMyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:54:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44738 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeGOMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:54:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so29207105wrt.11;
        Sun, 15 Jul 2018 05:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SSxoovz6AtLg4s67+lXJdu1E7iFSavJ8Pwu8uBjftdY=;
        b=i/a6qkS5ha3O6vd1MhAm1whFW3fNlf/IwdM32j0r5nKO3RsYVXfVRBS26SkHYhp7Tt
         Ms3q7B0NKQgSHLtB72h2MxnpGeM+uHk0oAPJrdLcDWxAFdf17RPXV28WxTMT64U+E1q5
         8udGvw7IDUdYAaofoBF3nN+LgdTAzfTy5MHc6ysmkpomiY2zGn+81yQwslTQWL2vAxvJ
         BgBI/hoIe8cpjM18GNuc9wvLIdOZNETmlcIKN6R4mMTvHpu5TBsMmPI2LYfh4s07f/6E
         PIR+srLGfZhXgtFSe4BN+hfpx1c15R9HF5nwSeciYh22qpMCRdFV5Av6LBoA362gufBM
         YDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SSxoovz6AtLg4s67+lXJdu1E7iFSavJ8Pwu8uBjftdY=;
        b=RC5Q4CdKRmyLfTmrZpmJa/bhywKVzAwpKMj5DqlCK4OvbvdgBLkEGUrR8acoN62PC0
         aR1GFjVSAn12xcYqORIvOwdGreWzbxTdy1oRLRRATHDrZmE/UV1GFyzZWYboMrQCRHTD
         yMkEqmPcxd+NuGToRVdensEtvRn6Y9n5w1CnZpRINVRqYARwzD6Nn4PKhZgNGFAj4lsl
         gcO/pMuMZ0layX/CUnYkzpJzvEUMvPZeG0fvXz1Qkgle4o0PAMpyxGxmf3CJ27uyZ6TB
         dAgkCsp8dzbP/E5eOVUDn25qg8+R7CszTN+v0L5kPTRjuWrJIa/pS+UILG0CAstTpgZ4
         dNxQ==
X-Gm-Message-State: AOUpUlGUWC2700LqWEUXwolAPyYRzBeCyLk0Exrdpk2z4yRok6FmMwCG
        ajJCYgcS/F36sPdabFW1GHk=
X-Google-Smtp-Source: AAOMgpcPCIkw3yt9FCI6kQmpcdGTYChr3o8s9jAxe/VNAlLLmNojUiVGBVA5Nj6KSuTkKBLbDc1YRg==
X-Received: by 2002:adf:9996:: with SMTP id y22-v6mr10138154wrb.69.1531657914867;
        Sun, 15 Jul 2018 05:31:54 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id s10-v6sm16358688wmb.12.2018.07.15.05.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 05:31:54 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v4 4/5] arm64: dts: actions: Enable clock controller for S700
Date:   Sun, 15 Jul 2018 14:31:44 +0200
Message-Id: <20180715123145.16975-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715123145.16975-1-sravanhome@gmail.com>
References: <20180715123145.16975-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added clock management controller for S700

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 66dd5309f0a2..19998f19af60 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/actions,s700-cmu.h>
 
 / {
 	compatible = "actions,s700";
@@ -44,6 +45,13 @@
 		};
 	};
 
+	clock: clock-controller@e0168000 {
+		compatible = "actions,s700-cmu";
+		reg = <0 0xe0168000 0 0x1000>;
+		clocks = <&hosc>, <&losc>;
+		#clock-cells = <1>;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -87,6 +95,12 @@
 		#clock-cells = <0>;
 	};
 
+	losc: losc {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.18.0

