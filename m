Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935677AbeE2Plk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:41:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43240 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935243AbeE2Pli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:41:38 -0400
Date: Tue, 29 May 2018 16:42:08 +0100
From: Will Deacon <will.deacon@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Punit Agrawal <punit.agrawal@arm.com>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/bus: arm-cci: fix build warnings
Message-ID: <20180529154207.GJ17159@arm.com>
References: <20180528154228.2403116-1-arnd@arndb.de>
 <0db1b8cd-b695-6cbf-9b27-f632b76bad11@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db1b8cd-b695-6cbf-9b27-f632b76bad11@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:34:01PM +0100, Robin Murphy wrote:
> On 28/05/18 16:41, Arnd Bergmann wrote:
> >When the arm-cci driver is enabled, but both CONFIG_ARM_CCI5xx_PMU and
> >CONFIG_ARM_CCI400_PMU are not, we get a warning about how parts of
> >the driver are never used:
> >
> >drivers/perf/arm-cci.c:1454:29: error: 'cci_pmu_models' defined but not used [-Werror=unused-variable]
> >drivers/perf/arm-cci.c:693:16: error: 'cci_pmu_event_show' defined but not used [-Werror=unused-function]
> >drivers/perf/arm-cci.c:685:16: error: 'cci_pmu_format_show' defined but not used [-Werror=unused-function]
> >
> >Marking all three functions as __maybe_unused avoids the warnings in
> >randconfig builds. I'm doing this lacking any ideas for a better fix.
> 
> Yeah, it's a bit of a silly configuration to allow building a driver
> supporting no PMU types, but I couldn't find a way to enforce "at least one
> sub-option enabled" logic without introducing mutually-exclusive
> dependencies which kbuild thinks are recursive.
> 
> An alternative would be to remove the CCI400/CCI5x0 configurability
> altogether - I've not not looked in detail at how much difference that
> actually makes.
> 
> Otherwise, as an immediate quick-fix:
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I'll pick this one up into the arm perf tree.

Will
