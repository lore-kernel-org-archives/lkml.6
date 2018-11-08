Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4B5ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF4A20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="0H3dHthp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF4A20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKHXLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:11:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45699 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHXLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:11:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id k15-v6so18296935wre.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 05:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=385oGMXjfTu5juuCHtT+aHsKY76Dx3tjl7MO1N8tJvI=;
        b=0H3dHthpjafwHV9/wxF6+5JKJ+12dy8H2FPbilKM1OyjTCNGYZJwyYxG2iF8a+qOKD
         3iu8rcqIIuh66b4PAr0wpNs4q6+Sea8ldHjlRXQ17Sm7qpVN7SUtgH8+13AybeGhogX6
         p8rfocZaf7MvLRpHj66333Lnr8RvffDgLm5RgUPpoizGasuDH6h+VbArr3q9uTMJ8r21
         tEoUydP7h2Lu4Cv7rZnUPyeA4Ypx0RZ53dHB242FCWnPll30Tt6v/L4ZljN7J9GsbIJU
         xaRk63wzAzh8ze64sGT9PoXg44NPdsJhoqcqnCVK1vhwXdsgyvnBD0uQv3vrKBqyGTNR
         0svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=385oGMXjfTu5juuCHtT+aHsKY76Dx3tjl7MO1N8tJvI=;
        b=NJ+9I/cT0CGjmrb/X4xTFJkZ+X+iAk2Wn56t/wCL1Xs3EVn/QhTEXijsNIafefs3sl
         ul5wDPv6gDbJVx1Zs0nZMgI8spM9RSBnaK7Jj3rlnp6XKsrG2XI7OnGAoiAOi5MHvdMK
         /2zOojie1wbUDyfPfXiUp8p4fuWMj7tYYQ+HrrFg2VRr6ZyAQt/VOcSqUhTVQgMl8/fB
         mOiHTasF6HoA4ML4jGoQSJz8FisMvkzUVlYw/aVURBA0G6D1HYSIfmVhgLRSJBuNU8JN
         eqSsH5+TEz+B47RI6IN/fGgWPVq6cNsmE8+uFq7ED+TPIv6BdHixImFNUXdl7861HGZj
         e/nw==
X-Gm-Message-State: AGRZ1gLEH3yP9pcDe5de9HIoU03Ty8od5qwcuSCw1xpWyKqLZy+t276f
        neyjhpckTKSWDP5CXmQReRCtvg==
X-Google-Smtp-Source: AJdET5dLUWEtsJUy8PlP8NczXJQl8cNB1vOx/W3RlraTOON47Bmlj+zs03hENNI9sw3gdmdwnuitLQ==
X-Received: by 2002:adf:9403:: with SMTP id 3-v6mr4178716wrq.54.1541684148666;
        Thu, 08 Nov 2018 05:35:48 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id m9-v6sm4367807wrn.36.2018.11.08.05.35.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 05:35:47 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Rob Herring <robherring2@gmail.com>
Cc:     monstr@monstr.eu, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: Add missing gpio-controller to ps gpio
Date:   Thu,  8 Nov 2018 14:35:46 +0100
Message-Id: <74a9934eab231714e65f74e442ad79cab0475267.1541684144.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing gpio-controller property to ps gpio.
This was found via DT schema validation.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 07f2dd13ab33..ae3c1b929648 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -410,6 +410,7 @@
 			compatible = "xlnx,zynqmp-gpio-1.0";
 			status = "disabled";
 			#gpio-cells = <0x2>;
+			gpio-controller;
 			interrupt-parent = <&gic>;
 			interrupts = <0 16 4>;
 			interrupt-controller;
-- 
1.9.1

