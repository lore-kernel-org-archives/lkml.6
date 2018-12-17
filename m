Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86664C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543DA20672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbeLQMhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:37:34 -0500
Received: from gloria.sntech.de ([185.11.138.130]:57722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732852AbeLQMhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:37:21 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gYs8q-0003o4-Sv; Mon, 17 Dec 2018 13:37:00 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, mark.rutland@arm.com, architt@codeaurora.org,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 00/15] drm/rockchip: add display support for rk3368
Date:   Mon, 17 Dec 2018 13:36:35 +0100
Message-Id: <20181217123650.6773-1-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ties together the last lose ends to make display support
work on rk3368 and includes some missing clock exports,
compatible values+settings for the specific encoder drivers
and quite a number of dt-changes enabling power-domains first
and then adding the display stuff.

The core rk3368 support for powerdomains and the vop is in the
kernel for quite a while already but hasn't been used so far.


Heiko Stuebner (15):
  clk: rockchip: add clock ids for dphy rx and tx channels on rk3368
  clk: rockchip: add clock id 24m dsi clock on rk3368
  clk: rockchip: use clock ids for dphy rx and tx on rk3368
  clk: rockchip: use clock id for 24m dsi on rk3368
  drm/rockchip: dw_hdmi: add support for rk3368
  drm/rockchip: analogix_dp: add support for the rk3368 variant
  drm/rockchip: dw-mipi-dsi: add support for rk3368-variant
  arm64: dts: rockchip: default values for core clocks on rk3368
  arm64: dts: rockchip: add power-domain nodes on rk3368
  arm64: dts: rockchip: add dw-hdmi controller on rk3368
  arm64: dts: rockchip: add analogix-dp controller on rk3368
  arm64: dts: rockchip: add dw-mipi-dsi controller on rk3368
  arm64: dts: rockchip: add core display support for rk3368
  arm64: dts: rockchip: enable display on rk3368-r88
  arm64: defconfig: enable hym8563 rtc driver

 .../display/rockchip/analogix_dp-rockchip.txt |   1 +
 .../display/rockchip/dw_hdmi-rockchip.txt     |   1 +
 .../display/rockchip/dw_mipi_dsi_rockchip.txt |   1 +
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts   |  17 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      | 309 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/rockchip/clk-rk3368.c             |   6 +-
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  17 +-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |  25 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  15 +
 include/dt-bindings/clock/rk3368-cru.h        |   3 +
 11 files changed, 387 insertions(+), 9 deletions(-)

-- 
2.19.2

