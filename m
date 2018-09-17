Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E42ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBED2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBED2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbeIREok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:44:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbeIREoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:44:39 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F06CFC9D;
        Mon, 17 Sep 2018 23:15:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Burton <paul.burton@mips.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, jhogan@kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 154/158] MIPS: mscc: ocelot: fix length of memory address space for MIIM
Date:   Tue, 18 Sep 2018 00:43:04 +0200
Message-Id: <20180917211718.210530654@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quentin Schulz <quentin.schulz@bootlin.com>

[ Upstream commit 49e5bb13adc11fe6e2e40f65c04f3a461aea1fec ]

The length of memory address space for MIIM0 is from 0x7107009c to
0x710700bf included which is 36 bytes long in decimal, or 0x24 bytes in
hexadecimal and not 0x36.

Fixes: 49b031690abe ("MIPS: mscc: Add switch to ocelot")

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/20013/
Cc: robh+dt@kernel.org
Cc: mark.rutland@arm.com
Cc: ralf@linux-mips.org
Cc: jhogan@kernel.org
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -184,7 +184,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "mscc,ocelot-miim";
-			reg = <0x107009c 0x36>, <0x10700f0 0x8>;
+			reg = <0x107009c 0x24>, <0x10700f0 0x8>;
 			interrupts = <14>;
 			status = "disabled";
 


