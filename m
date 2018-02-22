Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932105AbeBVMND (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:13:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40020 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753570AbeBVMNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:13:02 -0500
Date: Thu, 22 Feb 2018 12:13:01 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: include linux/vmalloc.h for vmap()
Message-ID: <20180222121301.GA1591@arm.com>
References: <20180222114716.1356279-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222114716.1356279-1-arnd@arndb.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:47:05PM +0100, Arnd Bergmann wrote:
> On linux-next, I get a build failure in some configurations:
> 
> drivers/perf/arm_spe_pmu.c: In function 'arm_spe_pmu_setup_aux':
> drivers/perf/arm_spe_pmu.c:857:14: error: implicit declaration of function 'vmap'; did you mean 'swap'? [-Werror=implicit-function-declaration]
>   buf->base = vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
>               ^~~~
>               swap
> drivers/perf/arm_spe_pmu.c:857:37: error: 'VM_MAP' undeclared (first use in this function); did you mean 'VM_MPX'?
>   buf->base = vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
>                                      ^~~~~~
>                                      VM_MPX
> drivers/perf/arm_spe_pmu.c:857:37: note: each undeclared identifier is reported only once for each function it appears in
> drivers/perf/arm_spe_pmu.c: In function 'arm_spe_pmu_free_aux':
> drivers/perf/arm_spe_pmu.c:878:2: error: implicit declaration of function 'vunmap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]
> 
> vmap() is declared in linux/vmalloc.h, so we should include that header file.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, Arnd. I'll pick this up for 4.17.

Will
