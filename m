Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeEKBvq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 21:51:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35623 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeEKBvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 21:51:45 -0400
X-Google-Smtp-Source: AB8JxZq/6h7c1O3hPIGT++YHO3yn60SQDFH7n0sLzTEVCzEyX+d/rIdCMRMEqyRuIuHsHZvoeyAcHA==
Date: Fri, 11 May 2018 10:51:40 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] printk: Convert pr_fmt from blank define to
 KBUILD_MODNAME
Message-ID: <20180511015140.GB895@jagdpanzerIV>
References: <cover.1525964381.git.joe@perches.com>
 <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb55d864f0bf266e019a74456612db36f8921a9.1525964383.git.joe@perches.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/10/18 08:45), Joe Perches wrote:
> There are more than 1000 uses of #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> Make that the default define so these uses can be removed later via script.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

In general, the idea looks OK to me, so FWIW
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

A quick question:

- Would "can be removed later via script" be so trivial?
  What about these guys?

drivers/of/address.c:#define pr_fmt(fmt)        "OF: " fmt
drivers/of/base.c:#define pr_fmt(fmt)   "OF: " fmt
drivers/of/dynamic.c:#define pr_fmt(fmt)        "OF: " fmt
drivers/of/fdt.c:#define pr_fmt(fmt)    "OF: fdt: " fmt
drivers/of/fdt_address.c:#define pr_fmt(fmt)    "OF: fdt: " fmt
drivers/of/irq.c:#define pr_fmt(fmt)    "OF: " fmt
drivers/of/of_numa.c:#define pr_fmt(fmt) "OF: NUMA: " fmt
drivers/of/of_reserved_mem.c:#define pr_fmt(fmt)        "OF: reserved mem: " fmt
drivers/of/overlay.c:#define pr_fmt(fmt)        "OF: overlay: " fmt
drivers/of/platform.c:#define pr_fmt(fmt)       "OF: " fmt
drivers/of/property.c:#define pr_fmt(fmt)       "OF: " fmt
drivers/of/resolver.c:#define pr_fmt(fmt)       "OF: resolver: " fmt

	-ss
