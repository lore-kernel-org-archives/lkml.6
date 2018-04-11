Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeDKJrT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:47:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:34379 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751898AbeDKJrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:47:17 -0400
Date: Wed, 11 Apr 2018 11:47:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2 7/9] lib/vsprintf: Replace space with '_' before crng
 is ready
Message-ID: <20180411094712.3wrptzcupkkdd6ym@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
 <20180216210711.79901-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216210711.79901-7-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-02-16 23:07:09, Andy Shevchenko wrote:
> From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> 
> Before crng is ready, output of "%p" composes of "(ptrval)" and
> left padding spaces for alignment as no random address can be
> generated. This seems a little strange when default string width
> is larger than strlen("(ptrval)").
> 
> For example, when irq domain names are built with "%p", the nodes
> under /sys/kernel/debug/irq/domains like this on AArch64 system,
> 
> [root@y irq]# ls domains/
> default                   irqchip@        (ptrval)-2
> irqchip@        (ptrval)-4  \_SB_.TCS0.QIC1  \_SB_.TCS0.QIC3
> irqchip@        (ptrval)  irqchip@        (ptrval)-3
> \_SB_.TCS0.QIC0             \_SB_.TCS0.QIC2
> 
> The name "irqchip@        (ptrval)-2" is not so readable in console
> output.
> 
> This patch replaces space with readable "_" when output needs padding.
> Following is the output after applying the patch,
> 
> [root@y domains]# ls
> default                   irqchip@(____ptrval____)-2
> irqchip@(____ptrval____)-4  \_SB_.TCS0.QIC1  \_SB_.TCS0.QIC3
> irqchip@(____ptrval____)  irqchip@(____ptrval____)-3  \_SB_.TCS0.QIC0
> \_SB_.TCS0.QIC2
> 
> There is same problem in some subsystem's dmesg output. Moreover,
> someone may call "%p" in a similar case. In addition, the timing of
> crng initialization done may vary on different system. So, the change
> is made in vsprintf.c.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have pushed it into printk.git, branch for-4.18-vsprintf-cleanup.

Best Regards,
Petr
