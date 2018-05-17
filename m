Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeEQVOF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:14:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35502 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbeEQVOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:14:03 -0400
Date: Thu, 17 May 2018 17:14:01 -0400 (EDT)
Message-Id: <20180517.171401.1767056771128015395.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, fugang.duan@nxp.com, andrew@lunn.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] net: Allow more drivers with
 COMPILE_TEST
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180517200745.19142-1-f.fainelli@gmail.com>
References: <20180517200745.19142-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HLEB6B011052

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 17 May 2018 13:07:42 -0700

> Hi David,
> 
> This patch series includes more drivers to be build tested with COMPILE_TEST
> enabled. This helps cover some of the issues I just ran into with missing
> a driver *sigh*.
> 
> Chanves in v3:
> 
> - drop the TI Keystone NETCP driver from the COMPILE_TEST additions
> 
> Changes in v2:
> 
> - allow FEC to build outside of CONFIG_ARM/ARM64 by defining a layout of
>   registers, this is not meant to run, so this is not a real issue if we
>   are not matching the correct register layout

Ok, series applied.

Just some printf format string warnings to clear up on 64-bit in TI
driver files davinci_cpdma.c, cpsw.c, and cpts.c.

In file included from ./arch/x86/include/asm/bug.h:83:0,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:12,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:81,
                 from ./include/linux/spinlock.h:51,
                 from drivers/net/ethernet/ti/davinci_cpdma.c:16:
drivers/net/ethernet/ti/davinci_cpdma.c: In function ¡cpdma_desc_pool_destroy¢:
drivers/net/ethernet/ti/davinci_cpdma.c:194:7: warning: format ¡%d¢ expects argument of type ¡int¢, but argument 2 has type ¡size_t {aka long unsigned int}¢ [-Wformat=]
       "cpdma_desc_pool size %d != avail %d",
       ^
       gen_pool_size(pool->gen_pool),
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:98:50: note: in definition of macro ¡__WARN_printf¢
 #define __WARN_printf(arg...) do { __warn_printk(arg); __WARN(); } while (0)
                                                  ^~~
drivers/net/ethernet/ti/davinci_cpdma.c:193:2: note: in expansion of macro ¡WARN¢
  WARN(gen_pool_size(pool->gen_pool) != gen_pool_avail(pool->gen_pool),
  ^~~~
drivers/net/ethernet/ti/davinci_cpdma.c:194:7: warning: format ¡%d¢ expects argument of type ¡int¢, but argument 3 has type ¡size_t {aka long unsigned int}¢ [-Wformat=]
       "cpdma_desc_pool size %d != avail %d",
       ^
drivers/net/ethernet/ti/davinci_cpdma.c:196:7:
       gen_pool_avail(pool->gen_pool));
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:98:50: note: in definition of macro ¡__WARN_printf¢
 #define __WARN_printf(arg...) do { __warn_printk(arg); __WARN(); } while (0)
                                                  ^~~
drivers/net/ethernet/ti/davinci_cpdma.c:193:2: note: in expansion of macro ¡WARN¢
  WARN(gen_pool_size(pool->gen_pool) != gen_pool_avail(pool->gen_pool),
  ^~~~
In file included from ./arch/x86/include/asm/realmode.h:15:0,
                 from ./arch/x86/include/asm/acpi.h:33,
                 from ./arch/x86/include/asm/fixmap.h:19,
                 from ./arch/x86/include/asm/apic.h:10,
                 from ./arch/x86/include/asm/smp.h:13,
                 from ./arch/x86/include/asm/mmzone_64.h:11,
                 from ./arch/x86/include/asm/mmzone.h:5,
                 from ./include/linux/mmzone.h:911,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/idr.h:16,
                 from ./include/linux/kernfs.h:14,
                 from ./include/linux/sysfs.h:16,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/device.h:16,
                 from drivers/net/ethernet/ti/davinci_cpdma.c:17:
drivers/net/ethernet/ti/davinci_cpdma.c: In function ¡cpdma_chan_submit¢:
drivers/net/ethernet/ti/davinci_cpdma.c:1083:17: warning: passing argument 1 of ¡__writel¢ makes integer from pointer without a cast [-Wint-conversion]
  writel_relaxed(token, &desc->sw_token);
                 ^
./arch/x86/include/asm/io.h:88:39: note: in definition of macro ¡writel_relaxed¢
 #define writel_relaxed(v, a) __writel(v, a)
                                       ^
./arch/x86/include/asm/io.h:71:18: note: expected ¡unsigned int¢ but argument is of type ¡void *¢
 build_mmio_write(__writel, "l", unsigned int, "r", )
                  ^
./arch/x86/include/asm/io.h:53:20: note: in definition of macro ¡build_mmio_write¢
 static inline void name(type val, volatile void __iomem *addr) \
                    ^~~~
drivers/net/ethernet/ti/davinci_cpdma.c: In function ¡__cpdma_chan_free¢:
drivers/net/ethernet/ti/davinci_cpdma.c:1126:15: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  token      = (void *)desc_read(desc, sw_token);
               ^
In file included from ./include/linux/kernel.h:14:0,
                 from ./include/linux/uio.h:12,
                 from ./include/linux/socket.h:8,
                 from ./include/uapi/linux/if.h:25,
                 from drivers/net/ethernet/ti/cpts.c:21:
drivers/net/ethernet/ti/cpts.c: In function ¡cpts_overflow_check¢:
drivers/net/ethernet/ti/cpts.c:297:11: warning: format ¡%lld¢ expects argument of type ¡long long int¢, but argument 3 has type ¡__kernel_time_t {aka long int}¢ [-Wformat=]
  pr_debug("cpts overflow check at %lld.%09lu\n", ts.tv_sec, ts.tv_nsec);
           ^
./include/linux/printk.h:288:21: note: in definition of macro ¡pr_fmt¢
 #define pr_fmt(fmt) fmt
                     ^~~
./include/linux/printk.h:336:2: note: in expansion of macro ¡dynamic_pr_debug¢
  dynamic_pr_debug(fmt, ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~
drivers/net/ethernet/ti/cpts.c:297:2: note: in expansion of macro ¡pr_debug¢
  pr_debug("cpts overflow check at %lld.%09lu\n", ts.tv_sec, ts.tv_nsec);
  ^~~~~~~~
drivers/net/ethernet/ti/davinci_emac.c: In function ¡davinci_emac_probe¢:
drivers/net/ethernet/ti/davinci_emac.c:1934:7: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
       (void *)priv->emac_base_phys, ndev->irq);
       ^
drivers/net/ethernet/ti/cpsw.c: In function ¡cpsw_add_ch_strings¢:
drivers/net/ethernet/ti/cpsw.c:1284:19: warning: format ¡%d¢ expects argument of type ¡int¢, but argument 5 has type ¡long unsigned int¢ [-Wformat=]
     "%s DMA chan %d: %s", rx_dir ? "Rx" : "Tx",
                  ~^
                  %ld
