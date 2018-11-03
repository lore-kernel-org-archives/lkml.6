Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0F7C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B2B2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B2B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeKCVoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 17:44:06 -0400
Received: from hermes.aosc.io ([199.195.250.187]:58337 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeKCVoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 17:44:06 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id A80552160D1;
        Sat,  3 Nov 2018 12:32:50 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 0/3] Allwinner H6 Ethernet support
Date:   Sat,  3 Nov 2018 20:32:35 +0800
Message-Id: <20181103123238.4665-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces Allwinner H6 Ethernet support with code already
available for A64.

As the EMAC on H6 is similar to A64 ones, support for them are directly
reused, by using fallback compatible strings.

Patches about system controller in v1 is sent by Jernej Skabrec as part
of his H6 display patchset, and already gets applied.

NOTE: This patchset targets the final version of Pine H64, and also
supports the early sample of Pine H64 model B. However, it's not
compatible with the early sample of Pine H64 model A. Please DO NOT test
this patchset on the Pine H64 model A samples.

Icenowy Zheng (3):
  dt-binding: dwmac-sun8i: add H6 compatible string (w/ A64 fallback)
  arm64: allwinner: h6: add EMAC device nodes
  arm64: allwinner: h6: add support for the Ethernet on Pine H64

 .../devicetree/bindings/net/dwmac-sun8i.txt   |  1 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 20 +++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 28 +++++++++++++++++++
 3 files changed, 49 insertions(+)

-- 
2.18.1

