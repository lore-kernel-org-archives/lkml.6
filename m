Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC15C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE39E218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901124;
	bh=jWVCY/HkrYkWYM862XmIDbQlPcDCyGvJHHmaNHnfBWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MySdkgwgShEVpfecZzalGf5JrD/Ke9RO4xfo/jV3fJL/1lTzooU13UiiuvyoeZ0dE
	 RWTprD7YIc7s1KkZmDy4vWbE38eTGJVA5u1TZN8duajZFXg+OLkD9U9PdJCZHB9/Zb
	 nb7CB3z1u6DGjCteCQLq4xV6pQmdEF3/Kb525Cps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfBKQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfBKO1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:27:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8825520821;
        Mon, 11 Feb 2019 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895269;
        bh=jWVCY/HkrYkWYM862XmIDbQlPcDCyGvJHHmaNHnfBWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDYq4vW1UQCAaVeGo0cMu4XhNgzpyfYI2dSozZt/GPv+VBM2J+X3f9w5D3XuqnZyQ
         SORHvMZIyjjHe3FLJgUE2L8fFAwTI6hVPi5vvJmLI6sANv7xrmwNTB2cTUe5ufmTXf
         nFyjTc+OUfI9A5WfyPLSsp40budrrT3SsYf2nWtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 109/352] xtensa: xtfpga.dtsi: fix dtc warnings about SPI
Date:   Mon, 11 Feb 2019 15:15:36 +0100
Message-Id: <20190211141852.741774275@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f37598be4e3896359e87c824be57ddddc280cc3f ]

Rename SPI controller node in the XTFPGA DTS to spi@...
This fixes the following build warnings:

arch/xtensa/boot/dts/kc705_nommu.dtb: Warning (spi_bus_bridge):
 /soc/spi-master@0d0a0000: node name for SPI buses should be 'spi'
arch/xtensa/boot/dts/kc705_nommu.dtb: Warning (spi_bus_reg):
 Failed prerequisite 'spi_bus_bridge'
arch/xtensa/boot/dts/lx200mx.dtb: Warning (spi_bus_bridge):
 /soc/spi-master@0d0a0000: node name for SPI buses should be 'spi'
arch/xtensa/boot/dts/lx200mx.dtb: Warning (spi_bus_reg):
 Failed prerequisite 'spi_bus_bridge'
arch/xtensa/boot/dts/kc705.dtb: Warning (spi_bus_bridge):
 /soc/spi-master@0d0a0000: node name for SPI buses should be 'spi'
arch/xtensa/boot/dts/kc705.dtb: Warning (spi_bus_reg):
 Failed prerequisite 'spi_bus_bridge'
arch/xtensa/boot/dts/ml605.dtb: Warning (spi_bus_bridge):
 /soc/spi-master@0d0a0000: node name for SPI buses should be 'spi'
arch/xtensa/boot/dts/ml605.dtb: Warning (spi_bus_reg):
 Failed prerequisite 'spi_bus_bridge'
arch/xtensa/boot/dts/lx60.dtb: Warning (spi_bus_bridge):
 /soc/spi-master@0d0a0000: node name for SPI buses should be 'spi'
arch/xtensa/boot/dts/lx60.dtb: Warning (spi_bus_reg):
 Failed prerequisite 'spi_bus_bridge'

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/boot/dts/xtfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/boot/dts/xtfpga.dtsi b/arch/xtensa/boot/dts/xtfpga.dtsi
index 1090528825ec..e46ae07bab05 100644
--- a/arch/xtensa/boot/dts/xtfpga.dtsi
+++ b/arch/xtensa/boot/dts/xtfpga.dtsi
@@ -103,7 +103,7 @@
 			};
 		};
 
-		spi0: spi-master@0d0a0000 {
+		spi0: spi@0d0a0000 {
 			compatible = "cdns,xtfpga-spi";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.19.1



