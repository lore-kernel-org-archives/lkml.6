Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeDMVQt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:16:49 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45927 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeDMVQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:16:46 -0400
X-Google-Smtp-Source: AIpwx499zOuzWXrFErtTAYgDlJA6OmHY0hPSbmbgMtzBQmk53oHH8mlM2mo3CHP6mR7duJlztXVwkQ==
Date: Fri, 13 Apr 2018 16:16:44 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] clk: Extract OF clock helpers in <linux/of_clk.h>
Message-ID: <20180413211644.wd7lrl4phqtshpzp@rob-hp-laptop>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523364701-15383-2-git-send-email-geert+renesas@glider.be>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 02:51:37PM +0200, Geert Uytterhoeven wrote:
> The use of of_clk_get_parent_{count,name}() and of_clk_init() is not
> limited to clock providers.
> 
> Hence move these helpers into their own header file, so callers that are
> not clock providers no longer have to include <linux/clk-provider.h>.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New.
> 
> I have't added an SPDX-License-Identifier line, as
> <linux/clk-provider.h> also doesn't have one yet.

Should that matter?

> 
> Other candidates to be moved here later?
>   - of_clk_get(),
>   - of_clk_get_by_name(),
>   - of_clk_get_from_provider().
> ---
>  include/linux/clk-provider.h | 14 +-------------
>  include/linux/of_clk.h       | 29 +++++++++++++++++++++++++++++

Please update MAINTAINERS so I am not the maintainer. :)

>  2 files changed, 30 insertions(+), 13 deletions(-)
>  create mode 100644 include/linux/of_clk.h
