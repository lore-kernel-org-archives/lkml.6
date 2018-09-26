Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E234C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5607D214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="jGgw7K/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5607D214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeIZRwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:52:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38193 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbeIZRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:52:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id j8-v6so22912466wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=lknh4QlU11qBQ/FS0pDxrKqIjnK6sfUVdVCPKqfK4H4=;
        b=jGgw7K/ltiWfu/2WIQ25Qmk3g8XEAeaQ4dnl34vxFIYuFlz0Ijamu3nhj8rVu4c5cO
         2AvQRwQSxXCKkAAU3tYQm0hW1JJqCLhxiaw1oUEe3FFdzj6gniAHhbBBoWGvM/ZWUwHg
         yrxWHzayCsHVhNAxQRNfuoa96GZ9GMXOWzD/xZOt2pETXq+OVVIDq7qEF5iALnXkX4F5
         5N254pfdb6YqusZ6lZSfOkWTregODwLInZRdVdnzrl6JkzGK/nEs7EfB3NM9NmYdQkO3
         V9qC1IiL+x5bPZkDkYiqG4nbX5c97Q/5RfjPJJkrZwJMVo8/q7R2btq24shJ0NYpF2Bh
         pNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lknh4QlU11qBQ/FS0pDxrKqIjnK6sfUVdVCPKqfK4H4=;
        b=WS4MD2ayTS9hGscUddD+qQUHXdz7akYXF8FzolyXV8yMZ/eyK/3gq0LF/CgTqfxy9Y
         mK2dkrQwpizcz5Zi0d4zjjFSTEs4DJwlfbuNfzZZEZ0Ug31xNgQ++BxopmHNBgbTiJdv
         L+sBHBZ6wH+LXuSrcCEOC4apjbGkFhT4z2JYprW+c76D7TLgOPZ6uUsVyN1LdFwWViXl
         sdHHS6mNjMZsiPgl3o0G/BNGaz9D1rqRH4u3L/PGghTmzizoNbpMkaQsfA92f8AVbNb1
         b77CeBrm8R+w724LBzK5nlyRELI2fdiO+9deuiFMytqWSkpjhtnHay3crftF1P+UE7H7
         PpgA==
X-Gm-Message-State: ABuFfohC/PGf5gKqIcPRUVWxvDOWyhNWLC9596av2Gp/VlfA3N2dTCGg
        AdEROO5ALlDc3VZ3QlVaRwMoC3hJFJFy0Q==
X-Google-Smtp-Source: ACcGV60TjOZkanc9POaV3I+Qz71DX98+Nwp9ZIY55ajegPvG8OF63dHNGElI/eVRG8udGCRZTLgCLA==
X-Received: by 2002:adf:df09:: with SMTP id y9-v6mr4241162wrl.26.1537961980900;
        Wed, 26 Sep 2018 04:39:40 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 75-v6sm8841137wml.21.2018.09.26.04.39.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 04:39:40 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: Use mmc@ instead sdhci@
Date:   Wed, 26 Sep 2018 13:39:39 +0200
Message-Id: <59fd089c075740303d81e4a3475598dfd48e5026.1537961975.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc name is recommended based on devicetree specification.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce23422acf..dacabde6ff7e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -484,7 +484,7 @@
 			interrupts = <0 133 4>;
 		};
 
-		sdhci0: sdhci@ff160000 {
+		sdhci0: mmc@ff160000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
@@ -493,7 +493,7 @@
 			clock-names = "clk_xin", "clk_ahb";
 		};
 
-		sdhci1: sdhci@ff170000 {
+		sdhci1: mmc@ff170000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
 			interrupt-parent = <&gic>;
-- 
1.9.1

