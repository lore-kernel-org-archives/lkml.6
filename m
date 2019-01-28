Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BFA20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690550;
	bh=pjiibTFqhLXgxsLFm+PrkHb6RyAomAh2N+Zs6PtmI34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z0yUWoA8JiZhBRL7hHMQ4aabQGLj/+kpCUGBdIb0qdwIO3a9ZzbAtq3i2syvNPYuV
	 H3u2mGX+CK87s26GpkRwKtQQeTOFFi5RpVATvfgYrrSVdhapaJ6brZlMwQO1PFbfpF
	 7rExPxtj4/6wDeNxi7P7MiFWZFywC3CkbEb+/luE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfA1PtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbfA1PtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 565DA2147A;
        Mon, 28 Jan 2019 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690543;
        bh=pjiibTFqhLXgxsLFm+PrkHb6RyAomAh2N+Zs6PtmI34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9Q7by86GJrx4Zkkl+I/AvFcgA9yA6DZnDijaBcnVdusqQwhueSNAoyJnbIY5D4wF
         behdD8DZmq8nAvq00cxBqCRyC89Vh7F41a+utvetB35TiT2jFjG2Uz71oDFgFF4OcU
         A2Hj1qHHOvOJgJJlBI15E53T4Mo/7un3B5D0FnTo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.20 118/304] xtensa: xtfpga.dtsi: fix dtc warnings about SPI
Date:   Mon, 28 Jan 2019 10:40:35 -0500
Message-Id: <20190128154341.47195-118-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

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

