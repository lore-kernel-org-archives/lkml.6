Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeBSIUs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 03:20:48 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:56163 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751760AbeBSITC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 03:19:02 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH v3 0/2] arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou
Date: Mon, 19 Feb 2018 09:18:52 +0100
Message-Id: <20180219081855.34400-1-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the audio codec on the Haikou Baseboard when used with a RK3399-Q7.

Changes in v3:
- split i2s0 move from rk3399-puma-haikou.dts to rk3399-puma.dtsi into it's
  own patch
- use dasheѕ in node names
- added missing vin-supply properties to regulators
  had to add an additional regulator to model this correctly
- simple overwrite pins in i2s0_2ch_bus instead of deleting and redefining
  the node

Changes in v2:
- reordered entries as suggested in review
- removed a conflicting i2s definition in rk3399-puma-haikou.dts
  i2s0 was already enabled in rk3399-puma.dtsi as it should be,
  so reuse it and fix the incorrect rockchip,*-channels values
- add a patch to the series that definies a generic i2s0-2ch-bus
- overwrite the generic pin definition of i2s0-2ch-bus with a specific
  one used in the Haikou with RK3399-Q7 setup

Klaus Goger (2):
  arm64: dts: rockchip: move i2s0 node from baseboard to SoM
  arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou

 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 71 +++++++++++++++++++---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 22 +++++++
 2 files changed, 85 insertions(+), 8 deletions(-)

-- 
2.11.0
