Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC212192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKheqm56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfBONt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:49:56 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:35422 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbfBONtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:49:53 -0500
Received: by mail-pf1-f170.google.com with SMTP id j5so371704pfa.2;
        Fri, 15 Feb 2019 05:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uccmsO0qVZau17wPhnmEOlY4fogBW79/IYa238V6d90=;
        b=KKheqm56wSJPNiObAsGRMR7nrwuSfrpChRtT2s+Z6r4ZCn17x5n/EYfI51tsXdaqpG
         FCBLKJLo6I2Z8v1+YZEXb/oB6nCinG3V/usVnVfxVeEKUmuWhIS/ALxIxvVu0BYaE9z7
         irViSXv7Tn2WD0Naf2S9WObt6PPqL9d+oz0dbN0MdICsRoD/VBq0f4eXqeqKFDeq/FiR
         lQoP6F03APlT4zzYFTleBlQTVrWTaqcbdeVDoBEJ8LlHA+Pw+MbKRVa4PzesSimEjapk
         Jv1WUUbbkVwEbe+oFyCJ0+KzKvWDBF6rBLSNyEe4dOXe/ur4Jy15/ZyDR+Me6nW9dMoW
         B+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uccmsO0qVZau17wPhnmEOlY4fogBW79/IYa238V6d90=;
        b=JVfgL1vHG8oXwUpiOe4ExevngH/gafxKx+BR9YV+7YvaI5Kfy2eYvCpfdaACZ7PYUG
         SPHzk1vshfbFpLwBlv+xa6UJ5oPneYqqAMz+mFsa3k6qn+8v7bKW2/Lljnp0g/8DPVOf
         8SL8BA2tB2J3eid1+xXJ8Wa6OABNcympNpnH+ECQnYOy1JTQREXMB+sUU4ChSBkhv12M
         MAB/ZvdrrRsT/7kudQjCDb4GXVM/fEnVnUQICft8QPRvwvPO6RRG8k8eFfy7gxXKhzGG
         Yi1Wu1QXNAtU+3KzrFeksTh3iEGMRp+chYj9rfso0XmQFCo8qs7mVoYimf80aX8UTzBG
         0XbQ==
X-Gm-Message-State: AHQUAuZKecXM9KOG6R/YEhCB+pzCJuxmeABs6/hBzN079UQb2LaxKn7d
        1F3jO6tH3zDJIsv9CbZO/Cs=
X-Google-Smtp-Source: AHgI3IYakrreBuSO4RtFWN/QeHmDAv0CIXF8Jmh5Tj8DSnyIC2iF243BrWxBRJj+AtrXTXroF3jijg==
X-Received: by 2002:a63:c204:: with SMTP id b4mr5442261pgd.335.1550238593092;
        Fri, 15 Feb 2019 05:49:53 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id m7sm12430968pfj.162.2019.02.15.05.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 05:49:52 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATVH v2 3/4] arm64: dts: allwinner: h6: Add clock to CPU cores
Date:   Fri, 15 Feb 2019 08:49:36 -0500
Message-Id: <20190215134937.10259-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215134937.10259-1-tiny.windzz@gmail.com>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM CPU cores are fed by the CPU clock from the CCU. Add a
reference to the clock for each CPU core, along with the clock
transition latency.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d93a7add67e7..723f5d991a74 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -26,6 +26,8 @@
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu1: cpu@1 {
@@ -33,6 +35,8 @@
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu2: cpu@2 {
@@ -40,6 +44,8 @@
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu3: cpu@3 {
@@ -47,6 +53,8 @@
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.17.0

