Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46094C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D21257CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D21257CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965921AbeGAR4g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:56:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965704AbeGAQbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:31:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 03B2892B;
        Sun,  1 Jul 2018 16:31:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.14 049/157] ARM: dts: socfpga: Fix NAND controller node compatible for Arria10
Date:   Sun,  1 Jul 2018 18:22:01 +0200
Message-Id: <20180701160855.108683094@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinh Nguyen <dinguyen@kernel.org>

commit 3877ef7a1ccecaae378c497e1dcddbc2dccb664c upstream.

The NAND compatible "denali,denal-nand-dt" property has never been used and
is obsolete. Remove it.

Cc: stable@vger.kernel.org
Fixes: f549af06e9b6("ARM: dts: socfpga: Add NAND device tree for Arria10")
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/socfpga_arria10.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -632,7 +632,7 @@
 		nand: nand@ffb90000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "denali,denali-nand-dt", "altr,socfpga-denali-nand";
+			compatible = "altr,socfpga-denali-nand";
 			reg = <0xffb90000 0x72000>,
 			      <0xffb80000 0x10000>;
 			reg-names = "nand_data", "denali_reg";


