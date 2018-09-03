Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4B1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50AB20652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50AB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeICRzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:55:32 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52323 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeICRzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:55:32 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id F09F05999B;
        Mon,  3 Sep 2018 13:35:15 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] Changes A64 HDMI PHY compatible to R40
Date:   Mon,  3 Sep 2018 21:34:31 +0800
Message-Id: <20180903133434.58188-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is used to be believed that the A64 HDMI PHY has the PLL-VIDEO mux
which is introduced in R40, because A64 has two PLL-VIDEOs. However,
experiments show that the mux is not present in A64, so the compatible
string of dual-PLL-input HDMI PHY clock must be changed to use R40 in
it rather than A64.

This patchset does this change.

Because the compatible string is introduced in 4.19, this patchset
should be applied to 4.19 during RC stage, otherwise this error will
exist forever for DT compatibility.

Icenowy Zheng (3):
  dt-bindings: change the A64 HDMI PHY binding to R40
  drm/sun4i: change A64 HDMI PHY binding to R40
  ARM: sun8i: dts: r40: drop A64 fallback compatible string of HDMI PHY

 .../devicetree/bindings/display/sunxi/sun4i-drm.txt         | 6 +++---
 arch/arm/boot/dts/sun8i-r40.dtsi                            | 3 +--
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c                      | 6 +++---
 3 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.18.0

