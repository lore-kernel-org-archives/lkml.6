Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F92C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD4F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5usVaxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD4F2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbeJQBQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:15:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6529E20658;
        Tue, 16 Oct 2018 17:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710672;
        bh=VTKhjclrfj1l0kgZ4XWtXihNfBKCdx+JmfcKU2mQA4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5usVaxBb6kwe9SnG/a9LFvAp1bfcFx0a/ynbX4gS9Tk6SO6tytkW57/ENS3Prb7k
         nJIiMrejkwdq9DRMpA1sCGo0Aaerym5bOQE4FNnNMPaUKLb5TQagkS/H0rgjP1gicC
         2yJM/5igLPydu4CV7pqnNunbIIp6ufP8TD38z1+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 11/71] ARM: dts: at91: add new compatibility string for macb on sama5d3
Date:   Tue, 16 Oct 2018 19:09:08 +0200
Message-Id: <20181016170539.973879426@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Ferre <nicolas.ferre@microchip.com>

[ Upstream commit 321cc359d899a8e988f3725d87c18a628e1cc624 ]

We need this new compatibility string as we experienced different behavior
for this 10/100Mbits/s macb interface on this particular SoC.
Backward compatibility is preserved as we keep the alternative strings.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/net/macb.txt |    1 +
 arch/arm/boot/dts/sama5d3_emac.dtsi            |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -10,6 +10,7 @@ Required properties:
   Use "cdns,pc302-gem" for Picochip picoXcell pc302 and later devices based on
   the Cadence GEM, or the generic form: "cdns,gem".
   Use "atmel,sama5d2-gem" for the GEM IP (10/100) available on Atmel sama5d2 SoCs.
+  Use "atmel,sama5d3-macb" for the 10/100Mbit IP available on Atmel sama5d3 SoCs.
   Use "atmel,sama5d3-gem" for the Gigabit IP available on Atmel sama5d3 SoCs.
   Use "atmel,sama5d4-gem" for the GEM IP (10/100) available on Atmel sama5d4 SoCs.
   Use "cdns,zynq-gem" Xilinx Zynq-7xxx SoC.
--- a/arch/arm/boot/dts/sama5d3_emac.dtsi
+++ b/arch/arm/boot/dts/sama5d3_emac.dtsi
@@ -41,7 +41,7 @@
 			};
 
 			macb1: ethernet@f802c000 {
-				compatible = "cdns,at91sam9260-macb", "cdns,macb";
+				compatible = "atmel,sama5d3-macb", "cdns,at91sam9260-macb", "cdns,macb";
 				reg = <0xf802c000 0x100>;
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";


