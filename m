Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeEEJfE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:35:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57068 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeEEJfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:35:01 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/5] devfreq: rk3399_dmc: improve rk3399_dmc driver and it's documentation
Date: Sat,  5 May 2018 11:34:45 +0200
Message-Id: <20180505093450.17327-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

These patches is an attempt to improve a little bit the rk3399_dmc
driver and it's documentation in order to have all in a better shape for
a future work I am doing. My final intention is add ddrfreq support for
rockchip drm driver, but the patches for this are still
work-in-progress. So let's start with this first patchset that is
basically some fixes/improvements for the rk3399_dmc driver.

The patches apply on top of current 4.17-rc3.

Best regards,
 Enric

Changes in v3:
- [4/6] Move interrupts to be optional instead of remove.

Changes in v2:
- [1/6] Add Acked-by MyungJoo Ham.
- [2/6] Improved commit message.
- [2/6] Rename ddr.h to rk3399-ddr.h because is SoC specific.
- [3/6] Add Reviewed-by Chanwoo Choi
- [4/6] Add Reviewed-by Chanwoo Choi.
- [5/6] Add Acked-by MyungJoo Ham.
- [5/6] Add Reviewed-by Chanwoo Choi.
- [6/6] Removed this patch from this series.

Enric Balletbo i Serra (3):
  dt-bindings: clock: add rk3399 DDR3 standard speed bins.
  devfreq: rk3399_dmc: remove wait for dcf irq event.
  dt-bindings: devfreq: rk3399_dmc: move interrupts to be optional.

Lin Huang (1):
  devfreq: rk3399_dmc: do not print error when get supply and clk defer.

Nick Milner (1):
  dt-bindings: devfreq: rk3399_dmc: improve binding documentation.

 .../bindings/devfreq/rk3399_dmc.txt           | 213 +++++++++---------
 drivers/devfreq/rk3399_dmc.c                  |  59 +----
 include/dt-bindings/clock/rk3399-ddr.h        |  56 +++++
 3 files changed, 172 insertions(+), 156 deletions(-)
 create mode 100644 include/dt-bindings/clock/rk3399-ddr.h

-- 
2.17.0
