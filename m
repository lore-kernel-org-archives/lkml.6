Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeE3UJ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:09:56 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36406 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbeE3UJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:09:55 -0400
X-Google-Smtp-Source: ADUXVKIzjUQj40EzGrs60wCphKJLh+7EEZMt9XfVTtAdF03hnTmyiIj7BH4SUjj0zhrsi1R2PoHV4Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: David Lechner <david@lechnology.com>, Stephen Boyd <sboyd@kernel.org>
From: Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20180525181150.17873-1-david@lechnology.com>
Cc: David Lechner <david@lechnology.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
References: <20180525181150.17873-1-david@lechnology.com>
Message-ID: <20180530200947.982.19495@harbor.lan>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/9] clk: davinci: outstanding fixes
Date: Wed, 30 May 2018 13:09:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4UKA1gW013938

Hi David,

Quoting David Lechner (2018-05-25 11:11:41)
> This is a resend of all of the outstanding DaVinci clock patches plus one new
> patch. All of the patches (except the new one) have been reviewed and tested
> by someone other than me.
> 
> The new patch ("clk: davinci: Fix link errors when not all SoCs are enabled")
> should be fairly trivial.
> 
> I am resending them all in one series to hopefully make it easier to get them
> picked up by having them in the correct order to avoid merge conflicts. This
> series is based on the clk/clk-davinci-psc-da830 branch.

I picked them all and pushed to clk/clk-davinci based on -rc1. There are
some comments on the individual patches, all of which are of the "please
revisit this and fix it up later" variety.

Going forward I'm happy for you and/or Sekhar to send clk PRs to Stephen
and myself. The same rules apply for PRs: all patches need to be posted
to the list the old fashioned way for review. But PRs make our lives a
bit easier, especially when dealing with chip variants from the same SoC
family like we have with davinci.

Best regards,
Mike

> 
> David Lechner (7):
>   clk: davinci: pll-dm355: drop pll2_sysclk2
>   clk: davinci: pll-dm355: fix SYSCLKn parent names
>   clk: davinci: psc-dm355: fix ASP0/1 clkdev lookups
>   clk: davinci: pll: allow dev == NULL
>   clk: davinci: da850-pll: change PLL0 to CLK_OF_DECLARE
>   clk: davinci: psc: allow for dev == NULL
>   clk: davinci: Fix link errors when not all SoCs are enabled
> 
> Sekhar Nori (2):
>   clk: davinci: pll-dm646x: keep PLL2 SYSCLK1 always enabled
>   clk: davinci: psc-dm365: fix few clocks
> 
>  drivers/clk/davinci/pll-da830.c  |   5 +-
>  drivers/clk/davinci/pll-da850.c  |  37 ++--
>  drivers/clk/davinci/pll-dm355.c  |  22 ++-
>  drivers/clk/davinci/pll-dm365.c  |   9 +-
>  drivers/clk/davinci/pll-dm644x.c |   9 +-
>  drivers/clk/davinci/pll-dm646x.c |  11 +-
>  drivers/clk/davinci/pll.c        | 299 +++++++++++++++++++++----------
>  drivers/clk/davinci/pll.h        |  41 +++--
>  drivers/clk/davinci/psc-dm355.c  |   7 +-
>  drivers/clk/davinci/psc-dm365.c  |  22 ++-
>  drivers/clk/davinci/psc-dm644x.c |   3 +-
>  drivers/clk/davinci/psc-dm646x.c |   3 +-
>  drivers/clk/davinci/psc.c        |  72 ++++++--
>  drivers/clk/davinci/psc.h        |  12 ++
>  include/linux/clk/davinci.h      |  40 +++++
>  15 files changed, 418 insertions(+), 174 deletions(-)
>  create mode 100644 include/linux/clk/davinci.h
> 
> -- 
> 2.17.0
> 
