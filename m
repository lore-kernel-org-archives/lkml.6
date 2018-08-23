Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32536C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5962083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5962083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbeHWMLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:11:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50062 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbeHWMLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:11:12 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C17957F6;
        Thu, 23 Aug 2018 08:42:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 042/324] arm64: dts: ns2: Fix PCIe controller interrupt type
Date:   Thu, 23 Aug 2018 09:51:48 +0200
Message-Id: <20180823074957.916172985@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ray Jui <ray.jui@broadcom.com>

[ Upstream commit d0b8aed9e80ab526dbb04020bfc94ecea7bddb44 ]

Fix PCIe controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
NS2 SoC.

Fixes: fd5e5dd56a2f ("arm64: dts: Add PCIe0 and PCIe4 DT nodes for NS2")
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -118,7 +118,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <0>;
 
@@ -149,7 +149,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <4>;
 


