Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B743AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D97C20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083926;
	bh=icmn68STVJVWW2Pf6ZOuVkgDB2X4iXfdePmr/Lyoh68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ydGUv1Ml2RJL/AfQxU4ZsZRa889/qIn1WFUjffoBFFrp20ySuWeqRKXVqxwZ8Ow4j
	 YG/vyCmQGOZG+hBpZ7XslqB6B5fZFi0uxGFPXc/RofMhCztNz6mRJvgyLvgqPnRlsO
	 Vl8R7Q4JDy/eoeziOi245hUl2qSW588jfTxdpuC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfBMSv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:51:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405871AbfBMSnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B1D222D6;
        Wed, 13 Feb 2019 18:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083405;
        bh=icmn68STVJVWW2Pf6ZOuVkgDB2X4iXfdePmr/Lyoh68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1/M/mW7Nm6+yakFRAm8h1ewblC4179WHeW0Fw0acfw0fW7FWmFG2JbOpwTUg/jZ1
         FTS/kfk5EXJAr9/zXcZ7ViEAkbMvvpTcCQm0vSALquLQQAYHpo/ooEcO6SPZ4aJ3sg
         INmK4od/uDgmALN2WMNzoBbTecnC8f0ZIALxIa0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 4.19 26/44] ARM: dts: da850: fix interrupt numbers for clocksource
Date:   Wed, 13 Feb 2019 19:38:27 +0100
Message-Id: <20190213183653.973921573@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit e3966a766865da7ced1dece663697861dd5cf103 upstream.

The timer interrupts specified in commit 3652e2741f42 ("ARM: dts:
da850: Add clocks") are wrong but since the current timer code
hard-codes them, the bug was never spotted.

This patch must go into stable since, once we introduce a proper
clocksource driver, devices with buggy device tree will stop booting.

Fixes: 3652e2741f42 ("ARM: dts: da850: Add clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/da850.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -476,7 +476,7 @@
 		clocksource: timer@20000 {
 			compatible = "ti,da830-timer";
 			reg = <0x20000 0x1000>;
-			interrupts = <12>, <13>;
+			interrupts = <21>, <22>;
 			interrupt-names = "tint12", "tint34";
 			clocks = <&pll0_auxclk>;
 		};


