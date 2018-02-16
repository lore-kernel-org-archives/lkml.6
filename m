Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932161AbeBPJjT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:39:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:5145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932139AbeBPJjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:39:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="35253992"
Message-ID: <1518773953.22495.366.camel@linux.intel.com>
Subject: Re: [PATCH] sata_dwc_460ex: Delete an error message for a failed
 memory allocation in sata_dwc_port_start()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Fri, 16 Feb 2018 11:39:13 +0200
In-Reply-To: <3ba388af-286a-df63-e78f-c82c1d084439@users.sourceforge.net>
References: <3ba388af-286a-df63-e78f-c82c1d084439@users.sourceforge.net>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-15 at 22:22 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 15 Feb 2018 22:15:25 +0100
> 
> Omit an extra message for a memory allocation failure in this
> function.
> 
> This issue was detected by using the Coccinelle software.

Tejun, it's up to you. In case you are fine with the change,

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/ata/sata_dwc_460ex.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c
> b/drivers/ata/sata_dwc_460ex.c
> index 6af4ec3c88c3..ce3d6674ef80 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -901,7 +901,6 @@ static int sata_dwc_port_start(struct ata_port
> *ap)
>  	/* Allocate Port Struct */
>  	hsdevp = kzalloc(sizeof(*hsdevp), GFP_KERNEL);
>  	if (!hsdevp) {
> -		dev_err(ap->dev, "%s: kmalloc failed for hsdevp\n",
> __func__);
>  		err = -ENOMEM;
>  		goto CLEANUP;
>  	}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
