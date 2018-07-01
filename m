Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D5CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACE2257D7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACE2257D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965935AbeGAR5F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:57:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34928 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030465AbeGAQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:31:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2DF2FAD8;
        Sun,  1 Jul 2018 16:31:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.14 046/157] ARM: dts: Fix SPI node for Arria10
Date:   Sun,  1 Jul 2018 18:21:58 +0200
Message-Id: <20180701160854.978753472@linuxfoundation.org>
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

From: Thor Thayer <thor.thayer@linux.intel.com>

commit 975ba94c2c3aca4d9f1ae26f3916d7787495ce86 upstream.

Remove the unused bus-num node and change num-chipselect
to num-cs to match SPI bindings.

Cc: stable@vger.kernel.org
Fixes: f2d6f8f817814 ("ARM: dts: socfpga: Add SPI Master1 for Arria10 SR chip")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/socfpga_arria10.dtsi |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -593,8 +593,7 @@
 			#size-cells = <0>;
 			reg = <0xffda5000 0x100>;
 			interrupts = <0 102 4>;
-			num-chipselect = <4>;
-			bus-num = <0>;
+			num-cs = <4>;
 			/*32bit_access;*/
 			tx-dma-channel = <&pdma 16>;
 			rx-dma-channel = <&pdma 17>;


