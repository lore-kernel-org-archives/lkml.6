Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeCTQ5A convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeCTQ4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:56:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C9921770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521168778-27236-3-git-send-email-david@lechnology.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-3-git-send-email-david@lechnology.com>
Message-ID: <152156501473.183971.10164660837276962553@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8 02/42] clk: davinci: New driver for davinci PLL clocks
Date: Tue, 20 Mar 2018 09:56:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-03-15 19:52:18)
> +
> +static int davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
> +{
> +       struct davinci_pll_clk *pll = to_davinci_pll_clk(hw);
> +       struct debugfs_regset32 *regset;
> +       struct dentry *d;
> +
> +       regset = kzalloc(sizeof(regset), GFP_KERNEL);

Should be sizeof(*regset)?

I squashed this in:

diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 588a48927436..89d30bf95102 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -882,7 +882,7 @@ static int davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
 	struct debugfs_regset32 *regset;
 	struct dentry *d;
 
-	regset = kzalloc(sizeof(regset), GFP_KERNEL);
+	regset = kzalloc(sizeof(*regset), GFP_KERNEL);
 	if (!regset)
 		return -ENOMEM;
 
