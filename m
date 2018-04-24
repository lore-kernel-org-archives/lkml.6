Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeDXSud (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:50:33 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:51683 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750791AbeDXSuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:50:32 -0400
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Tue, 24 Apr 2018 20:50:30 +0200
X-ME-IP: 81.67.76.113
From: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Mike Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Subject: [PATCH v2 0/2] clk: meson: gxbb: add the video decoder clocks
Date: Tue, 24 Apr 2018 20:48:36 +0200
Message-Id: <20180424184838.3406-1-maxi.jourdan@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the necessary clocks for VDEC_1 and VDEC_HEVC.

On Amlogic SoCs, VDEC1 is responsible for the decoding of:
MPEG 1/2/4, H.263, H.264, MJPEG, VC1, Real Video

VDEC_HEVC is responsible for the decoding of:
HEVC, VP9

Changes since v1:
 - Drop CLK_IGNORE_UNUSED flags
 - Change CLK_SET_RATE_NO_REPARENT to CLK_SET_RATE_PARENT for muxes
 - Add CLK_MUX_ROUND_CLOSEST for muxes

Maxime Jourdan (2):
  clk: meson: gxbb: expose VDEC_1 and VDEC_HEVC clocks
  clk: meson: gxbb: add the video decoder clocks

 drivers/clk/meson/gxbb.c              | 114 ++++++++++++++++++++++++++
 drivers/clk/meson/gxbb.h              |   6 +-
 include/dt-bindings/clock/gxbb-clkc.h |   2 +
 3 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.17.0
