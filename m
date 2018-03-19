Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971656AbeCSUxj convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971632AbeCSUxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:53:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE5A204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1520931243-29091-1-git-send-email-mike.looijmans@topic.nl>
Cc: linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Mike Looijmans <mike.looijmans@topic.nl>
References: <1520931243-29091-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <152149281366.242365.13850922141460907992@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: clk-gpio: Allow GPIO to sleep in set/get_parent
Date: Mon, 19 Mar 2018 13:53:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2018-03-13 01:54:03)
> When changing or retrieving clock parents, the caller is in a sleepable
> state (like prepare) so the GPIO operation need not be atomic. Replace
> gpiod_{g|s}et_value with gpiod_{g|s}et_value_cansleep in the {g|s}et_parent
> calls for the GPIO based clock mux.
> 
> This fixes a "slowpath" warning when the GPIO controller is an I2C expander
> or something similar.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Applied to clk-next
