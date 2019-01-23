Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B523C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BE021872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfAWUFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:05:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfAWUFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:05:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 528B719D055;
        Wed, 23 Jan 2019 20:05:11 +0000 (UTC)
Received: from w520.home (ovpn-116-182.phx2.redhat.com [10.3.116.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7127DBA9B;
        Wed, 23 Jan 2019 20:05:10 +0000 (UTC)
Date:   Wed, 23 Jan 2019 13:05:10 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org
Subject: Re: [patch 9/9] vfio/pci: Cleanup license mess
Message-ID: <20190123130510.0b64bd64@w520.home>
In-Reply-To: <20190117231501.654003681@linutronix.de>
References: <20190117231416.111952141@linutronix.de>
        <20190117231501.654003681@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 23 Jan 2019 20:05:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 00:14:25 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> The recently added nvlink2 VFIO driver introduced a license conflict in two
> files. In both cases the SPDX license identifier is:
> 
>   SPDX-License-Identifier: GPL-2.0+
> 
> but the files contain also the following license boiler plate text:
> 
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation
> 
> The latter is GPL-2.9-only and not GPL-2.0=.
> 
> Looking deeper. The nvlink source file is derived from vfio_pci_igd.c which
> is also licensed under GPL-2.0-only and it can be assumed that the file was
> copied and modified. As the original file is licensed GPL-2.0-only it's not
> possible to relicense derivative work to GPL-2.0-or-later.
> 
> Fix the SPDX identifier and remove the boiler plate as it is redundant.
> 
> Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kvm@vger.kernel.org
> ---
> 
> P.S.: This patch is part of a larger cleanup, but independent of other
>       patches and is intended to be picked up by the maintainer directly.

Applied to vfio for-linus branch for v5.0.  Thanks,

Alex


> ---
>  drivers/vfio/pci/trace.h            |    6 +-----
>  drivers/vfio/pci/vfio_pci_nvlink2.c |    6 +-----
>  2 files changed, 2 insertions(+), 10 deletions(-)
> 
> --- a/drivers/vfio/pci/trace.h
> +++ b/drivers/vfio/pci/trace.h
> @@ -1,13 +1,9 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * VFIO PCI mmap/mmap_fault tracepoints
>   *
>   * Copyright (C) 2018 IBM Corp.  All rights reserved.
>   *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #undef TRACE_SYSTEM
> --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> @@ -1,14 +1,10 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * VFIO PCI NVIDIA Whitherspoon GPU support a.k.a. NVLink2.
>   *
>   * Copyright (C) 2018 IBM Corp.  All rights reserved.
>   *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   * Register an on-GPU RAM region for cacheable access.
>   *
>   * Derived from original vfio_pci_igd.c:
> 
> 

