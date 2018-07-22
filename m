Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D51ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDF720858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDF720858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeGVGgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 02:36:14 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44771 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbeGVGgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 02:36:14 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 6E1669F530;
        Sun, 22 Jul 2018 05:40:39 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/5] Allwinner H6 Ethernet support
Date:   Sun, 22 Jul 2018 13:39:50 +0800
Message-Id: <20180722053955.25266-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces Allwinner H6 Ethernet support with code already
available for A64.

As the system controller and EMAC on H6 are all similar to A64 ones,
support for them are directly reused, by using fallback compatible
strings.

Icenowy Zheng (5):
  dt-binding: dwmac-sun8i: add H6 compatible string (w/ A64 fallback)
  dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C
  arm64: allwinner: h6: add system controller device tree node
  arm64: allwinner: h6: add EMAC device nodes
  arm64: allwinner: h6: add support for the Ethernet on Pine H64

 .../devicetree/bindings/net/dwmac-sun8i.txt   |  1 +
 .../devicetree/bindings/sram/sunxi-sram.txt   |  4 ++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 29 ++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 53 +++++++++++++++++++
 4 files changed, 87 insertions(+)

-- 
2.18.0

