Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbeDIN73 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:59:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37681 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeDIN71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:59:27 -0400
X-Google-Smtp-Source: AIpwx4+jszKO24bYpHp6sSpTIJWc/DY4saHMPL4kXBFna132drqxazK9SaLJO5a5FYxgMy1uJaZwqw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 0/2] clk: honor CLK_MUX_ROUND_CLOSEST in mux
Date: Mon,  9 Apr 2018 15:59:19 +0200
Message-Id: <20180409135921.5617-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLK_MUX_ROUND_CLOSEST is part of clk_mux and meson's clk_regmap
documentation, so it should be honored by the determine_rate() callback.

It is note the case ATM. The series fixes this problem.

Jerome Brunet (2):
  clk: honor CLK_MUX_ROUND_CLOSEST in generic clk mux
  clk: meson: honor CLK_MUX_ROUND_CLOSEST in clk_regmap

 drivers/clk/clk-mux.c          | 10 +++++++++-
 drivers/clk/clk.c              |  7 ++++---
 drivers/clk/meson/clk-regmap.c | 11 ++++++++++-
 include/linux/clk-provider.h   |  3 +++
 4 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.14.3
