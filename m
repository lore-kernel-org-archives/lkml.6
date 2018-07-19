Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6838CECDFBD
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7F420673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7F420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeGSFKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:10:06 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40555 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeGSFKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:10:05 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 41E199ED91;
        Thu, 19 Jul 2018 04:28:36 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 0/3] Allwinner H6 MMC support
Date:   Thu, 19 Jul 2018 12:28:07 +0800
Message-Id: <20180719042810.6546-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for MMC controller in the Allwinner H6 SoC.

Its function is a superset of the A64 MMC controller's, so it currently
use A64 compatible as a fallback.

Icenowy Zheng (3):
  dt-binding: mmc: sunxi: add H6 compatible (with A64 fallback)
  arm64: allwinner: h6: add device tree nodes for MMC controllers
  arm64: allwinner: h6: enable MMC0/2 on Pine H64

 .../devicetree/bindings/mmc/sunxi-mmc.txt     |  2 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 18 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 59 +++++++++++++++++++
 3 files changed, 79 insertions(+)

-- 
2.17.1

