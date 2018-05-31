Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755499AbeEaPeg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755369AbeEaPec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:34:32 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527775435-5017-1-git-send-email-mike.looijmans@topic.nl>
Cc: linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Mike Looijmans <mike.looijmans@topic.nl>
References: <1527775435-5017-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <152778087117.144038.3582001993053198941@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk-si544: Properly round requested frequency to nearest match
Date: Thu, 31 May 2018 08:34:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VFYc9m020093

Quoting Mike Looijmans (2018-05-31 07:03:55)
> The si544 driver had a rounding problem that using the result of clk_round_rate
> may set the clock to yet another rate, for example:
> clk_round_rate(195000000) = 194999999
> clk_round_rate(194999999) = 194999998
> 
> Clients would expect that after clk_set_rate(clk, freq2=clk_round_rate(clk, freq)) the
> chip will be running at exactly freq2.
> 
> The problem was in the calculation of the feedback divider, it was always rounded
> down instead of to the nearest possible VCO value.
> 
> After this change, the following holds true for any supported frequency:
> actual_freq = clk_round_rate(clk, freq);
> clk_set_rate(clk, actual_freq);
> clk_round_rate(clk, actual_freq) == actual_freq && clk_get_rate(clk) == actual_freq
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Any fixes tag? I can slap 

Fixes: 953cc3e81170 ("clk: Add driver for the si544 clock generator chip")

on to the patch here.
