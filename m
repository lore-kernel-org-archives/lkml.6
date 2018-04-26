Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbeDZDpc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 23:45:32 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:46119 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbeDZDpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 23:45:30 -0400
X-Google-Smtp-Source: AIpwx48PVUqLbaysNjNYNSUILyDFUgf/ccnhKprKsEuZ2QdeFiHxINkJJtLykNwJFgv/p6p8dCixxQ==
Date: Wed, 25 Apr 2018 20:46:39 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: linux-next: build failure after merge of the rpmsg tree
Message-ID: <20180426034639.GA11526@tuxbook-pro>
References: <20180426133310.0ec74122@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426133310.0ec74122@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Apr 20:33 PDT 2018, Stephen Rothwell wrote:

> Hi Bjorn,
> 
> After merging the rpmsg tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/remoteproc/remoteproc_core.c: In function 'rproc_handle_devmem':
> drivers/remoteproc/remoteproc_core.c:557:8: error: implicit declaration of function 'iommu_map_sync'; did you mean 'iommu_map_sg'? [-Werror=implicit-function-declaration]
>   ret = iommu_map_sync(rproc->domain, rsc->da,
>         ^~~~~~~~~~~~~~
>         iommu_map_sg
> drivers/remoteproc/remoteproc_core.c: In function 'rproc_resource_cleanup':
> drivers/remoteproc/remoteproc_core.c:845:14: error: implicit declaration of function 'iommu_unmap_sync'; did you mean 'iommu_unmap_fast'? [-Werror=implicit-function-declaration]
>    unmapped = iommu_unmap_sync(rproc->domain, entry->da,
>               ^~~~~~~~~~~~~~~~
>               iommu_unmap_fast
> 
> Caused by commit
> 
>   aace25b18cbd ("remoteproc: Use sychronized interface of the IOMMU-API")
> 
> I suspect that part of the commit is missing ...
> 

Sorry about that, now I've actually pushed the branch with this commit
removed again.

> I have use the rpmsg tree from next-20180424 for today.
> 

Thanks, should be good tomorrow again!

Regards,
Bjorn
