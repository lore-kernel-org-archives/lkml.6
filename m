Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeCLKWu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:22:50 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43172 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeCLKWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:22:47 -0400
X-Google-Smtp-Source: AG47ELtOoNchSplMQZiSKam45XL8jXsL4szuIei5T7f5QHmeiKYLnmDyvgeSFBa9WuNfiUS65KECPw==
Subject: Re: [PATCH 00/11] clk: meson: second round of updates
To: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180219112146.21746-1-jbrunet@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <670fffce-220b-b65e-d855-80603f1972b5@baylibre.com>
Date: Mon, 12 Mar 2018 11:22:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219112146.21746-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2018 12:21, Jerome Brunet wrote:
> This changeset applies on top of the previous updates series
> available here [0].
> 
> Most of the changes proposed here are related to the plls of meson
> SoCs. Details can be found in each patches but, in nutshell, there
> is :
> * a bit of clean-up,
> * improved pll capabilities using the frac parameter,
> * several clocks added to model the tree more accurately.
> 
> Beware: patch #10 depends on this core clock framework fix: [1]
> As explained in the description on the patch, if the gates are
> added w/o this fix, the system will crash when
> clk_disable_unused() is called.
> 
> [0]: https://lkml.kernel.org/r/20180212145846.19380-1-jbrunet@baylibre.com
> [1]: https://lkml.kernel.org/r/20180214134340.17242-5-jbrunet@baylibre.com
> 
> Jerome Brunet (11):
>   clk: meson: add fractional part of meson8b fixed_pll
>   clk: meson: poke pll CNTL last
>   clk: meson: remove special gp0 lock loop
>   clk: meson: improve pll driver results with frac
>   clk: meson: add gp0 frac parameter for axg and gxl
>   clk: meson: add ROUND_CLOSEST to the pll driver
>   clk: meson: axg: add hifi clock bindings
>   clk: meson: axg: add hifi pll clock
>   clk: meson: add mpll pre-divider
>   clk: meson: add fdiv clock gates
>   clk: meson: clean-up clk81 clocks
> 
>  drivers/clk/meson/axg.c              | 184 +++++++++++++++++++++++++++++++----
>  drivers/clk/meson/axg.h              |   8 +-
>  drivers/clk/meson/clk-pll.c          | 154 ++++++++++++++++++-----------
>  drivers/clk/meson/clkc.h             |  15 +--
>  drivers/clk/meson/gxbb.c             | 141 +++++++++++++++++++++++----
>  drivers/clk/meson/gxbb.h             |  10 +-
>  drivers/clk/meson/meson8b.c          | 128 ++++++++++++++++++++----
>  drivers/clk/meson/meson8b.h          |   8 +-
>  include/dt-bindings/clock/axg-clkc.h |   1 +
>  9 files changed, 521 insertions(+), 128 deletions(-)
> 

Tested on Odroid-C2 & LibreTech-CC,

Applied to meson's next/drivers tree.

Neil
