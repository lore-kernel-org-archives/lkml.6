Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeENINA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:13:00 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33545 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeENIMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:12:52 -0400
X-Google-Smtp-Source: AB8JxZrdn8iJykDFAdUM3MyaiaWlwW/aHbtHC3F0by6RiWB2K33TBrTr3M8scqNGMBMJlik0wG6eeA==
Date: Mon, 14 May 2018 01:01:51 -0700
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH fixes-for-current] arm64: dts: exynos: Fix interrupt type
 for I2S1 device on Exynos5433
Message-ID: <20180514080151.hykqjt5232nsb5ti@localhost>
References: <20180506145524.14570-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506145524.14570-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 04:55:24PM +0200, Krzysztof Kozlowski wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> All interrupts from SoC internal modules are level triggered, so fix
> incorrect trigger type for I2S1 device on Exynos5433 SoCs.
> 
> This fixes following kernel warning:
> 
> WARNING: CPU: 2 PID: 1 at drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0xb0/0xb8
> Modules linked in:
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc7-next-20180329 #646
> Hardware name: Samsung TM2 board (DT)
> pstate: 20000005 (nzCv daif -PAN -UAO)
> pc : gic_irq_domain_translate+0xb0/0xb8
> lr : irq_create_fwspec_mapping+0x64/0x328
> sp : ffff0000098b38d0
> ...
> Call trace:
>  gic_irq_domain_translate+0xb0/0xb8
>  irq_create_of_mapping+0x78/0xa0
>  of_irq_get+0x6c/0xa0
>  of_irq_to_resource+0x38/0x108
>  of_irq_to_resource_table+0x50/0x78
>  of_device_alloc+0x118/0x1b8
>  of_platform_device_create_pdata+0x54/0xe0
>  of_platform_bus_create+0x118/0x340
>  of_platform_bus_create+0x17c/0x340
>  of_platform_populate+0x74/0xd8
>  of_platform_default_populate_init+0xb0/0xcc
>  do_one_initcall+0x50/0x158
>  kernel_init_freeable+0x184/0x22c
>  kernel_init+0x10/0x108
>  ret_from_fork+0x10/0x18
> ---[ end trace 6decb2b3078d73f0 ]---
> 
> Fixes: d8d579c316e8 ("ARM: dts: exynos: Add I2S1 device node to exynos5433")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> 
> Hi Arnd and Olof,
> 
> That's one fix for current release cycle (issue introduced in merge window).

Applied to fixes. Thanks!


-Olof
