Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeAaSuz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:50:55 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:53051 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeAaSuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:50:54 -0500
Date: Wed, 31 Jan 2018 10:50:51 -0800
From: Darren Hart <dvhart@infradead.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] platform/x86: intel-vbtn: Remove redundant
 inclusions
Message-ID: <20180131185051.GC8676@fury>
References: <20180131175407.18301-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131175407.18301-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 07:54:06PM +0200, Andy Shevchenko wrote:
> Some headers are not needed since the driver can be built as module.
> Remove them.

Removing init because it's included by module.h, and removing acpi_bus.h
because it's included by acpi.h - but not because it can be built as a
module - right?  Just checking, the wording in the commit msg seemed odd
to me.

These removals seem appropriate to me, but so we have it recorded here -
in general, including headers that you explicitly make use of is good
practice, and not depending on others to include them. But in this case,
the implicit includes are reasonable expectations as they are tightly
coupled with the parent include.


Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>


> 
> While here, sort headers alphabetically.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel-vbtn.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> index 101c100a3929..69bc39f8d61d 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -16,15 +16,13 @@
>   *
>   */
>  
> +#include <linux/acpi.h>
> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/input.h>
>  #include <linux/platform_device.h>
> -#include <linux/input/sparse-keymap.h>
> -#include <linux/acpi.h>
>  #include <linux/suspend.h>
> -#include <acpi/acpi_bus.h>
>  
>  /* When NOT in tablet mode, VGBS returns with the flag 0x40 */
>  #define TABLET_MODE_FLAG 0x40
> -- 
> 2.15.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
