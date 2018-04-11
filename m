Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeDKDqw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 23:46:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35736 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDKDqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 23:46:51 -0400
X-Google-Smtp-Source: AIpwx4+Sobx7gd7ggAy3bXLfMAbnh5M7Jr4szdB5dNP3y6zOAZhqQmEmBoktxy0pCnEa19rvDLT1lw==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: Regression caused by commit bc976233a872, ethernet r8169 stops
 working after system S3
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <alpine.DEB.2.21.1804031050020.2511@nanos.tec.linutronix.de>
Date: Wed, 11 Apr 2018 11:46:44 +0800
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E5521441-BE1E-4A43-AB5C-0E91165E0AEC@canonical.com>
References: <E3F55561-8733-4056-ABEC-5AF87AC288CB@canonical.com>
 <alpine.DEB.2.21.1803302137510.1479@nanos.tec.linutronix.de>
 <4ABF72ED-A0C3-405D-8F02-785ED111F9FB@canonical.com>
 <alpine.DEB.2.21.1804031050020.2511@nanos.tec.linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Apr 3, 2018, at 4:51 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Bah. The patch is broken. New version written with brain awake below.

Actually I can't reproduce this issue anymore on latest Linus' tree.

I'll do a bisect and ask linux-stable maintainer to include the commit.

Thanks for your help!

Kai-Heng

>
> Thanks,
>
> 	tglx
>
> 8<---------------------
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -134,6 +134,10 @@ static bool migrate_one_irq(struct irq_d
>  		brokeaff = false;
>  	}
>
> +	pr_info("IRQ%u: New affinity: %*pbl effective: %*pbl\n",
> +		d->irq, cpumask_pr_args(affinity),
> +		cpumask_pr_args(irq_data_get_effective_affinity_mask(d)));
> +
>  	if (maskchip && chip->irq_unmask)
>  		chip->irq_unmask(d);
