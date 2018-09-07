Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E956C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ABE2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTuS0xgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ABE2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeIGKNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:13:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35104 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeIGKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:13:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so6448747pfh.2;
        Thu, 06 Sep 2018 22:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cNAvsKq1UaOq3Ai5trsfRYL1iR5jZv8QbyIU5z/Lx+Y=;
        b=qTuS0xguxTJxIFRD9/WI36gTCRzNKDUGlURVLQu5s+a1laVRaJN37YHGp6EX00/kNJ
         f+u8Are8owZP4Oyt9qG/6VYxId4/s7+nmlO8j8D4QPmpin7epIxMTIsCPgAqiJqFo/Gq
         QciZLfO35mq9Uj0S/itN8ph3J29j+aXMkxjgsFONDAYmmxxNlRlPF1/QnVNhI8SC2+Pd
         YfUlI/OwSlkgfrNA/FvbwIDeSe8+yVWO1VQgi5u2+PVa9frC6rFl1qCLLVsoQ73yf5Qx
         P3XoHLfgDBLN0ZTRaeNL7zzjLlbpzLyZvf+nNdGbfqz56RvfXkeV2Sqh4qVDkd/ma7ms
         oo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cNAvsKq1UaOq3Ai5trsfRYL1iR5jZv8QbyIU5z/Lx+Y=;
        b=H3UsIe2ufAc/rxR/GXLG/JHEzJDdmTI6RT5snjUeu2eClQlI8lZbIOre8fXLizMMzL
         xLE1qTPnOl2DFJw0LRToudnxeozByKZB3/fVenUYxBzCZBUUI5pzaqwRZn+5JqPA/kCw
         eZa6F4fpKSZZYT+K1p08a3Tp8bVQ4Mc9rWGV+1h8CApxH5VZwA2IYZ136XKiUrOGW52p
         jPe3BMCliNZZkj9714whSQxEPX2e7ml1hMjNXvAtFdtRnVtBL22Cvm3AuzIG77exDst2
         3s3dx75YBpYWiy2q3Rl3pvsCljxtd2lglWlb/lsDmbJuB2yBHDpWYKCOVX+kbYgXJtW4
         wP5w==
X-Gm-Message-State: APzg51ArgrxAY/Cem0wd0EhUo2Rp2N/Fmc+pUF4dbYboppqBhKf352YS
        wCoRqz/wxzbl3RTB+JIDGd8=
X-Google-Smtp-Source: ANB0VdbqrtYCLUOHw69EOYfGCmAEKfDHBeY+RTr1poDbFyWwTlwo5BTgmO274bOTUzENO4bn5GZ0aQ==
X-Received: by 2002:a62:d2c4:: with SMTP id c187-v6mr6700256pfg.8.1536298464296;
        Thu, 06 Sep 2018 22:34:24 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b203-v6sm9291581pfb.174.2018.09.06.22.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 22:34:23 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/6] ARM: dts: qcom-msm8974: use named constant for interrupt type GIC_PPI
Date:   Thu,  6 Sep 2018 22:33:09 -0700
Message-Id: <1536298394-5548-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
References: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Cosmetic change of integer value "1" in the first field of the
"interrupts" property to the correct named constant.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index d9019a49b292..f4f5e2df4c03 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -67,7 +67,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		interrupts = <1 9 0xf04>;
+		interrupts = <GIC_PPI 9 0xf04>;
 
 		CPU0: cpu@0 {
 			compatible = "qcom,krait";
@@ -214,7 +214,7 @@
 
 	cpu-pmu {
 		compatible = "qcom,krait-pmu";
-		interrupts = <1 7 0xf04>;
+		interrupts = <GIC_PPI 7 0xf04>;
 	};
 
 	clocks {
@@ -233,10 +233,10 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <1 2 0xf08>,
-			     <1 3 0xf08>,
-			     <1 4 0xf08>,
-			     <1 1 0xf08>;
+		interrupts = <GIC_PPI 2 0xf08>,
+			     <GIC_PPI 3 0xf08>,
+			     <GIC_PPI 4 0xf08>,
+			     <GIC_PPI 1 0xf08>;
 		clock-frequency = <19200000>;
 	};
 
-- 
Frank Rowand <frank.rowand@sony.com>

