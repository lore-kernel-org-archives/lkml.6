Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeCTQ6K convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCTQ6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:58:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0BE21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521168778-27236-14-git-send-email-david@lechnology.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-14-git-send-email-david@lechnology.com>
Message-ID: <152156508760.183971.11983086334390852576@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8 13/42] clk: davinci: Add platform information for TI DM355 PSC
Date: Tue, 20 Mar 2018 09:58:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-03-15 19:52:29)
> +static int dm355_psc_init(struct device *dev, void __iomem *base)
> +{
> +       return davinci_psc_register_clocks(base, dm355_psc_info, 42, base);
> +}
> +

Should be dev for that first argument to davinci_psc_register_clocks()?

I squashed this in:

diff --git a/drivers/clk/davinci/psc-dm355.c b/drivers/clk/davinci/psc-dm355.c
index 249a05330457..6995ecea2677 100644
--- a/drivers/clk/davinci/psc-dm355.c
+++ b/drivers/clk/davinci/psc-dm355.c
@@ -70,7 +70,7 @@ static const struct davinci_lpsc_clk_info dm355_psc_info[] = {
 
 static int dm355_psc_init(struct device *dev, void __iomem *base)
 {
-	return davinci_psc_register_clocks(base, dm355_psc_info, 42, base);
+	return davinci_psc_register_clocks(dev, dm355_psc_info, 42, base);
 }
 
 static struct clk_bulk_data dm355_psc_parent_clks[] = {
