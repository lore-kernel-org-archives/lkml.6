Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbeDTJ4N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:56:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38558 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754287AbeDTJ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:56:10 -0400
X-Google-Smtp-Source: AIpwx4++6xrO1lWVJQUZ5YP84BDpH6pnrB5thBiB+pokbfjhbfdaVZSr2jr46erlyH6tTz0k0orFLg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clk: meson: mpll: add round closest support
Date: Fri, 20 Apr 2018 11:56:01 +0200
Message-Id: <20180420095603.29964-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATM, the mpll driver can only round the requested rate down, even if
rounding up would have provided a better approximation of the requested
rate.

This patchset adds a flag to enable rounding to the closest rate possible,
even if it means rounding up.

The flag is then enabled on the axg platform to improve the rates provided
to the audio subsystem.

Jerome Brunet (2):
  clk: meson: mpll: add round closest support
  clk: meson: axg: let mpll clocks round closest

 drivers/clk/meson/axg.c      |  4 ++++
 drivers/clk/meson/clk-mpll.c | 25 ++++++++++++++++++++-----
 drivers/clk/meson/clkc.h     |  3 +++
 3 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.14.3
