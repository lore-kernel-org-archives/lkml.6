Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935567AbeBLNhT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:37:19 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43914 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935552AbeBLNhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:37:16 -0500
X-Google-Smtp-Source: AH8x225P/kGjtJf8vC9YLEBOXtngL/ujXdI9AeZpRx1s04tomwb64bJ1N42vpTsXrlOM0UaV8Vh2Lg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] clk: fix mux clock documentation
Date: Mon, 12 Feb 2018 14:37:12 +0100
Message-Id: <20180212133712.15132-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mux documentation mentions the non-existing parameter width instead
of mask. Just sed this.

Fixes: 9d9f78ed9af0 ("clk: basic clock hardware types")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/linux/clk-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b3210c431e33..210a890008f9 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -456,7 +456,7 @@ void clk_hw_unregister_divider(struct clk_hw *hw);
  * @reg:	register controlling multiplexer
  * @table:	array of register values corresponding to the parent index
  * @shift:	shift to multiplexer bit field
- * @width:	width of mutliplexer bit field
+ * @mask:	mask of mutliplexer bit field
  * @flags:	hardware-specific flags
  * @lock:	register lock
  *
-- 
2.14.3
