Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A7CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9DA2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1QlTh4P+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9DA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeKOI1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbeKOI1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:19 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8715B22520;
        Wed, 14 Nov 2018 22:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234136;
        bh=AfjghSSMA75Q19s/l11mAa4LfU9jCjxHFqFWEfvlSZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1QlTh4P+EzU+dcvXg2bT/Dh6pE35iK2hv20aAShu4bqIE3hSDXpxTj8mcGZ901agw
         rQP7oVvbI7Y8rYTyDlkIoQAxMbStDGOfUyx4V85SDiRVbK+Jqvcw89FSpOZ2RBKuPx
         bcQXvAyzRNfr5hU3MTDsTRq+JstNxkkpcizYWNjQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 34/73] arm64: dts: renesas: r8a7795: add missing dma-names on hscif2
Date:   Wed, 14 Nov 2018 17:21:28 -0500
Message-Id: <20181114222207.98701-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit aab7a2414ba0d5c3d0571a90031b535adba7146a ]

hscif2 has 4 dmas, but has only 2 dma-names.
This patch add missing dma-names.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: e0f0bda79337701a ("arm64: dts: renesas: r8a7795: sort subnodes
of the soc node")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index fb9d08ad7659..c87eed77de2c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -662,7 +662,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>,
 			       <&dmac2 0x35>, <&dmac2 0x34>;
-			dma-names = "tx", "rx";
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 518>;
 			status = "disabled";
-- 
2.17.1

