Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeECRIZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:08:25 -0400
Received: from muru.com ([72.249.23.125]:40050 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbeECRIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:08:24 -0400
Date: Thu, 3 May 2018 10:08:20 -0700
From: Tony Lindgren <tony@atomide.com>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: omap1: ams-delta: fix deferred_fiq handler
Message-ID: <20180503170820.GW98604@atomide.com>
References: <20180502183203.16034-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502183203.16034-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180502 11:34]:
> The deferred_fiq handler used to limit hardware operations to IRQ
> unmask only, relying on gpio-omap assigned handler performing the ACKs.
> Since commit 80ac93c27441 ("gpio: omap: Fix lost edge interrupts") this
> is no longer the case as handle_edge_irq() has been replaced with
> handle_simmple_irq() which doesn't touch the hardware.
> 
> Add single ACK operation per each active IRQ pin to the handler. While
> being at it, move unmask operation out of irq_counter loop so it is
> also called only once for each active IRQ pin.

Good to hear the fiq handler is confirmed working, applying
into omap-for-v4.17/fixes thanks.

Tony
