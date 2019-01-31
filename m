Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FBFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36189218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548935989;
	bh=DBjr32p49xidJv+eiATWdivDSxt7NQWqpqU8mYWRFWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NadFmMcS7aM/y3/UXoRIHxs/B8uyH31y0rHa/vggP04vSvxZmEePXOQrX5EKa0Ygs
	 25KEm2XtLCVjdExSjAXE+xl2Aenqx2jkS5xs4plYnBOdqOKvKxjLu3riedSkXpJ467
	 kXYKZ+2Qi+idSqFllDO2Fz/zeZskumnzGJ6Bgbik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbfAaL7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbfAaL7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:59:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B117218D3;
        Thu, 31 Jan 2019 11:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548935986;
        bh=DBjr32p49xidJv+eiATWdivDSxt7NQWqpqU8mYWRFWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8QmYjDW0MBYd9yBlzfTXEQf15LmP6bKLBN8tVCFxRdtzv+JZkrrxlHDoCTqmZYB9
         V3BMTYlOV03lmw1zsJMW+hfhXDdGlQNBwviAnS/+2/4Pje19Qw3JZx8cAqCrD6Umay
         bzThrSCrTnqNkyh+qM8sQy0Au4+aD7WN6PpVOPRg=
Date:   Thu, 31 Jan 2019 12:59:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lantianyu1986@gmail.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, joro@8bytes.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Message-ID: <20190131115944.GB19969@kroah.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 06:17:32PM +0800, lantianyu1986@gmail.com wrote:
> --- /dev/null
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt)     "HYPERV-IR: " fmt

Minor nit, you never do any pr_*() calls, so this isn't needed, right?

> +static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
> +struct irq_domain *ioapic_ir_domain;

Global?  Why?

thanks,

greg k-h
