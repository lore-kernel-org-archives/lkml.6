Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756053AbeEAPdz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:33:55 -0400
Received: from muru.com ([72.249.23.125]:39512 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755942AbeEAPdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:33:53 -0400
Date: Tue, 1 May 2018 08:33:50 -0700
From: Tony Lindgren <tony@atomide.com>
To: Keerthy <j-keerthy@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, bcousson@baylibre.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] ARM: dts: am437x boards: Correct tps65218 irq type
Message-ID: <20180501153350.GE98604@atomide.com>
References: <20180420113822.17577-1-peter.ujfalusi@ti.com>
 <5423d98d-6c32-56f4-d228-bd1d33d9dff1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5423d98d-6c32-56f4-d228-bd1d33d9dff1@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180423 10:32]:
> 
> 
> On Friday 20 April 2018 05:08 PM, Peter Ujfalusi wrote:
> > Hi,
> > 
> > In linux-next I started to see: https://pastebin.com/wrDdptzh
> > [    2.813985] ------------[ cut here ]------------
> > [    2.818746] WARNING: CPU: 0 PID: 19 at /home/ujfalusi/work/kernel/github.omap-audio.linux-audio/drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0xd4/0xec
> > [    2.833311] Modules linked in:
> > [    2.836417] CPU: 0 PID: 19 Comm: kworker/0:2 Not tainted 4.17.0-rc1-next-20180420-00057-gffd03ee19b9b #182
> > [    2.846113] Hardware name: Generic AM43 (Flattened Device Tree)
> > [    2.852073] Workqueue: events deferred_probe_work_func
> > ...
> > 
> > Becasue most of the am437x boards had IRQ_TYPE_NONE for tps65218.
> > 
> > According to the datasheet [1] the interrult line is low active, so fix up the board
> > DTS files.
> > 
> > Interestingly the am437x-sk-evm had IRQ_TYPE_LEVEL_HIGH, which is not matching
> > with the datasheet.
> > 
> > [1] http://www.ti.com/lit/ds/symlink/tps65218.pdf, page 8.
> 
> For the series:
> 
> Reviewed-by: Keerthy <j-keerthy@ti.com>
> 
> Also Boot tested on AM437X-GP-EVM with the patch 1 of the series and i
> do not see the error above.

Thanks applying all into omap-for-v4.18/dt.

Tony
