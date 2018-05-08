Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755380AbeEHOQF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:16:05 -0400
Received: from muru.com ([72.249.23.125]:41008 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbeEHOQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:16:03 -0400
Date: Tue, 8 May 2018 07:16:00 -0700
From: Tony Lindgren <tony@atomide.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        j-keerthy@ti.com
Subject: Re: [PATCH 0/4] ARM: dts: am437x boards: Correct (again) tps65218
 irq type
Message-ID: <20180508141600.GT98604@atomide.com>
References: <20180508132053.5471-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508132053.5471-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [180508 13:22]:
> Hi,
> 
> While based on the datasheet of tps65218 the INT is low active, the GIC_SPI
> does not support anythin but IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING:
> 
> [    2.761814] genirq: Setting trigger mode 8 for irq 102 failed (irq_chip_set_type_parent+0x0/0x30)
> [    2.770913] tps65218 0-0024: Failed to request IRQ 102 for tps65218: -22
> [    2.777854] tps65218: probe of 0-0024 failed with error -22

So does the tps65218 have some register to control the interrupt
direction or is it's datasheet wrong?

BTW, ADC might be a good test case for PMIC interrupt if it has one.

> Use LEVEL_HIGH for the interrupt as it looks to be the correct setting:
> INTn of tps65218 is connected to NMIn of the SoC.
> 
> The offending patches are only in linux-next.

OK

Regards,

Tony
