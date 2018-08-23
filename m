Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D057CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E292098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E292098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeHWL36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:29:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeHWL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:29:57 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14462C18;
        Thu, 23 Aug 2018 08:01:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 012/130] ARM: dts: Cygnus: Fix I2C controller interrupt type
Date:   Thu, 23 Aug 2018 09:52:08 +0200
Message-Id: <20180823074928.155755737@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ray Jui <ray.jui@broadcom.com>

[ Upstream commit 71ca3409703b62b6a092d0d9d13f366c121bc5d3 ]

Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
Cygnus SoC.

Fixes: b51c05a331ff ("ARM: dts: add I2C device nodes for Broadcom Cygnus")
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -128,7 +128,7 @@
 			reg = <0x18008000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
@@ -157,7 +157,7 @@
 			reg = <0x1800b000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};


