Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030454AbeBNNoY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:44:24 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44880 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030395AbeBNNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:43:53 -0500
X-Google-Smtp-Source: AH8x226DvhTfXWZlCRUkt5PnQlYFOLq5gGaRx5+Z9lEax7dNMU6LuWnC/JEYivJkarZszb6zt8i45Q==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] clk: fix mux clock documentation
Date: Wed, 14 Feb 2018 14:43:38 +0100
Message-Id: <20180214134340.17242-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214134340.17242-1-jbrunet@baylibre.com>
References: <20180214134340.17242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mux documentation mentions the non-existing parameter width instead
of mask, so just sed this.

The table field is missing in the documentation of clk_mux.
Add a small blurb explaining what it is

Fixes: 9d9f78ed9af0 ("clk: basic clock hardware types")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/linux/clk-provider.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index fe720d679c31..cb18526d69cb 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -450,8 +450,9 @@ void clk_hw_unregister_divider(struct clk_hw *hw);
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register controlling multiplexer
+ * @table:	array of register values corresponding to the parent index
  * @shift:	shift to multiplexer bit field
- * @width:	width of mutliplexer bit field
+ * @mask:	mask of mutliplexer bit field
  * @flags:	hardware-specific flags
  * @lock:	register lock
  *
-- 
2.14.3
