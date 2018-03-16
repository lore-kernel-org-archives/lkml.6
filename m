Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeCPW3Q convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 18:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbeCPW3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 18:29:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E3421742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: David Lechner <david@lechnology.com>, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1515112695-3160-1-git-send-email-david@lechnology.com>
Cc: David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        =?utf-8?q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <1515112695-3160-1-git-send-email-david@lechnology.com>
Message-ID: <152123935331.242365.4716792321487612827@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/7] clk: add helper functions for managing clk_onecell_data
Date: Fri, 16 Mar 2018 15:29:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Lechner (2018-01-04 16:38:05)
> I am writing some clock drivers that use struct clk_onecell_data a few
> times, so I decided to write a helper function to allocate the memory
> since it is a two step process and can be tedious. Then I noticed that
> mediatek already had such a helper function, so I have moved that to the
> clk core and made use of it in other drivers where possible.
> 

We're actively trying to discourage driver authors from adding more
clk_onecell_data and pushing them to register clks and providers with
the clk_hw structures. So thanks for doing the consolidation work, but
no thanks. We can wait for the conversion to hw pointers instead.
