Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeCKWcJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:32:09 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37266 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932363AbeCKWcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:32:07 -0400
X-Google-Smtp-Source: AG47ELuLSPWuJu0JY24ZminbIToYTs0yYN/X6/Ji5WBoNK6QlA+6+CDLX4dXpg2hTtKBc+G0bNriPw==
Date: Sun, 11 Mar 2018 15:31:58 -0700
From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 0/8] clk: helpers and fixes
To: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180214134340.17242-1-jbrunet@baylibre.com>
In-Reply-To: <20180214134340.17242-1-jbrunet@baylibre.com>
MIME-Version: 1.0
User-Agent: astroid/8ea8c2a3 (https://github.com/astroidmail/astroid)
Message-Id: <1520807121.n44nt5z8tk.astroid@resonance.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2BMWFnY015595

Excerpts from Jerome Brunet's message of February 14, 2018 5:43 am:
> This changset is consist of various patches I have recently sent
> for the clock framework. They are gathered here for your convinience.
> 
> The first two changes exports helpers of the generic clocks (divider and
> mux). The goal is to avoid code duplication when writing clock driver
> derived from these generic clock drivers.
> 
> The rest fixes various issues found in the clock framework while working on
> a rework of meson's clock controllers [0]

Applied to clk-helpers towards v4.17.

Regards,
Mike

> 
> Changes since the v1s:
>  * dropped lpc32xx divider read-only patches as requested by
>    Vladimir Zapolskiy [2]
>  * Squashed generic divider read-only patches
>  * Squashed mux documentations patches
> 
> [0]: https://lkml.kernel.org/r/20180212145846.19380-1-jbrunet@baylibre.com
> [2]: https://lkml.kernel.org/r/54782a8f-9735-a574-d8e1-7ff3e9173229@mleia.com
> 
> Jerome Brunet (8):
>   clk: divider: export clk_div_mask() helper
>   clk: mux: add helper function for index/value translation
>   clk: fix determine rate error with pass-through clock
>   clk: migrate the count of orphaned clocks at init
>   clk: call the clock init() callback before any other ops callback
>   clk: fix mux clock documentation
>   clk: divider: read-only divider can propagate rate change
>   clk: qcom: use divider_ro_round_rate helper
> 
>  drivers/clk/clk-divider.c             | 58 ++++++++++++++++++---------
>  drivers/clk/clk-mux.c                 | 75 ++++++++++++++++++++---------------
>  drivers/clk/clk.c                     | 63 ++++++++++++++++-------------
>  drivers/clk/qcom/clk-regmap-divider.c | 20 +++-------
>  include/linux/clk-provider.h          | 23 ++++++++++-
>  5 files changed, 146 insertions(+), 93 deletions(-)
> 
> -- 
> 2.14.3
> 
> 
