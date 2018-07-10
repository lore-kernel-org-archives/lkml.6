Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235A5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5530208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5530208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389409AbeGJSe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388426AbeGJSe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 998C7D0B;
        Tue, 10 Jul 2018 18:34:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.17 17/56] ARM: dts: omap3: Fix am3517 mdio and emac clock references
Date:   Tue, 10 Jul 2018 20:24:59 +0200
Message-Id: <20180710182504.423718870@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
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

From: Adam Ford <aford173@gmail.com>

commit 0144eb204cdcdf09a76794b4a294291388e739bc upstream.

A previous patch removed OMAP clock aliases that were perceived
to be unnecessary.  Unfortunately, it broke the ethernet on the
am3517-evm.  This patch enables the MDIO clock and EMAC clock.

Fixes: 0ed266d7ae5e ("clk: ti: omap3: cleanup unnecessary clock aliases")
Cc: stable@vger.kernel.org #4.16+

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/am3517.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -39,6 +39,8 @@
 			ti,davinci-ctrl-ram-size = <0x2000>;
 			ti,davinci-rmii-en = /bits/ 8 <1>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
+			clocks = <&emac_ick>;
+			clock-names = "ick";
 		};
 
 		davinci_mdio: ethernet@5c030000 {
@@ -49,6 +51,8 @@
 			bus_freq = <1000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&emac_fck>;
+			clock-names = "fck";
 		};
 
 		uart4: serial@4809e000 {


