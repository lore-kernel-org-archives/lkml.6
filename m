Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeCOLzw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:55:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39349 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeCOLzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:55:50 -0400
X-Google-Smtp-Source: AG47ELv3vh9WFh0t0YGNx0CRcPslRqsOIQNwx0CSkbMdtKRis2k67q+Qi1kh3M7uBHv8tqOL0Bnvgw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] ARM64: dts: meson: hhi syscon and clock controllers
Date: Thu, 15 Mar 2018 12:55:41 +0100
Message-Id: <20180315115545.1884-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HHI register region provides more than just clocks. Several drivers may
need to access this region, such as the clock controllers and the display
driver.

Meson-gx clock controllers has been developed and merged before we knew the
hhi could be needed elsewhere, which is why it requests the region directly.
Meson-axg was built following the model of meson-gx.

To fix this situation, the clock controller should be a child of the hhi
system controllers. The hhi system controller node already exists on meson-gx.
It needs to be added on the axg.

This changeset depends on [0]. This dependency has been merged in
clk-next. A topic branch is available here [1]

[0]: https://lkml.kernel.org/r/20180212145846.19380-1-jbrunet@baylibre.com
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-amlogic

Jerome Brunet (4):
  dt-bindings: clock: meson: update documentation with hhi syscon
  ARM64: dts: meson-gx: sysctrl is the parent of the clock controller
  ARM64: dts: meson-axg: use hhi syscon for the clock controller
  ARM64: dts: meson-gx: fix gxl clock controller compatible

 .../devicetree/bindings/clock/amlogic,gxbb-clkc.txt      | 16 +++++++++++-----
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi               | 12 ++++++++----
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi              |  5 ++---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi               |  7 +++----
 4 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.14.3
