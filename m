Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA34C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED05D25622
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED05D25622
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965482AbeGARQw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:16:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031757AbeGAQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:39:34 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 06E31A73;
        Sun,  1 Jul 2018 16:39:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.17 065/220] ARM: dts: socfpga: Fix NAND controller node compatible
Date:   Sun,  1 Jul 2018 18:21:29 +0200
Message-Id: <20180701160911.112628962@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

commit d9a695f3c8098ac9684689774a151cff30d8aa25 upstream.

The compatible string for the Denali NAND controller is incorrect,
fix it by replacing it with one matching the DT bindings and the
driver.

Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marex@denx.de>
Fixes: d837a80d19 ("ARM: dts: socfpga: add nand controller nodes")
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/socfpga.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -748,7 +748,7 @@
 		nand0: nand@ff900000 {
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
-			compatible = "denali,denali-nand-dt";
+			compatible = "altr,socfpga-denali-nand";
 			reg = <0xff900000 0x100000>,
 			      <0xffb80000 0x10000>;
 			reg-names = "nand_data", "denali_reg";


