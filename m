Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60038C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2781B2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788940;
	bh=IDYmgvGFvvbu7Jr5AJIb7Y53/z8k1FD3I/c44so9IZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R3H0CQ9iAI8cIkDciEPMiJDay9Zo/5gnEAVXp47PlTllN1jElCQqwqyNUMEQDS0w5
	 DGRVzxcmtbqZ3g+u4QdxRdrJ4wHRc8w1CZExvwcFdRXAd12Uup8wsWDBll8n6nP4EQ
	 pvNSd9qNiDZqkbAjZ1RMAoJYQeDrVrda13Bpcu2A=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2781B2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbeLNMCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbeLNMCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C322145D;
        Fri, 14 Dec 2018 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788935;
        bh=IDYmgvGFvvbu7Jr5AJIb7Y53/z8k1FD3I/c44so9IZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biPFg4ODsGL42ZpInvi9e+5Qlp2yWXz39FcUoYhMZAXcih7isL7Z6lwJqPaQvzmx8
         eiau9TUZuloKy0WBDwACIX2euQmExRnh9qJKFv3v4uspFGgoEo58IFZ/t3hVcyeiEk
         D1JdTNDRvBsbfuzaIXPe/1f1kcRG2WMZQJm9vTas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/142] ARM: dts: am3517-som: Fix WL127x Wifi interrupt
Date:   Fri, 14 Dec 2018 12:58:35 +0100
Message-Id: <20181214115748.257417688@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 419b194cdedc76d0d3cd5b0900db0fa8177c4a52 ]

At the same time the AM3517 EVM was gaining WiFi support,
separate patches were introduced to move the interrupt
from HIGH to RISING.  Because they overlapped, this was not
done to the AM3517-EVM.  This patch fixes Kernel 4.19+

Fixes: 6bf5e3410f19 ("ARM: dts: am3517-som: Add WL127x Wifi")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am3517-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am3517-som.dtsi b/arch/arm/boot/dts/am3517-som.dtsi
index dae6e458e59f..b1c988eed87c 100644
--- a/arch/arm/boot/dts/am3517-som.dtsi
+++ b/arch/arm/boot/dts/am3517-som.dtsi
@@ -163,7 +163,7 @@
 		compatible = "ti,wl1271";
 		reg = <2>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_LEVEL_HIGH>; /* gpio_170 */
+		interrupts = <10 IRQ_TYPE_EDGE_RISING>; /* gpio_170 */
 		ref-clock-frequency = <26000000>;
 		tcxo-clock-frequency = <26000000>;
 	};
-- 
2.19.1



