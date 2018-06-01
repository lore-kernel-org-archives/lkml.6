Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeFAPml (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:42:41 -0400
Received: from 8bytes.org ([81.169.241.247]:56860 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeFAPmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:42:40 -0400
Date: Fri, 1 Jun 2018 17:42:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yizhuo Zhai <yzhai003@ucr.edu>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>
Subject: Re: [patch] drivers/iommu/amd_iommu.c: argument page_size could be
 uninitialized
Message-ID: <20180601154238.GA16285@8bytes.org>
References: <CABvMjLQL4QXiX+8h3qTSUjD3bD4MU5oAp=PijHh94xnZgVWM7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABvMjLQL4QXiX+8h3qTSUjD3bD4MU5oAp=PijHh94xnZgVWM7A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yizhuo Zhai,

your mail is a mime/multipart email with a html version. Please send a
plain text email with the patch in it. You can use git-send-email for
that. This patch doesn't apply through my git workflow.

Also, please change the subject to:

	
	[PATCH] iommu/amd: Argument page_size could be uninitialized

This matches upstream conventions for iommu patches. So make these
changes and re-post this patch after the next merge-window.

On Thu, May 31, 2018 at 11:20:28AM -0700, Yizhuo Zhai wrote:
> Argument "page_size" passing to function "fetch_pte" could be uninitialized if
> the function returns NULL. The caller "iommu_unmap_page" checks the return
> value but the page_size is used outside the if block.
> 
> Signed-off-by: yzhai003@ucr.edu <yzhai003@ucr.edu>
> ---
>  drivers/iommu/amd_iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 774e057..3a23e97 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1397,6 +1397,7 @@ static u64 *fetch_pte(struct protection_domain *domain,
>  {
>   int level;
>   u64 *pte;
> + *page_size = 0;

Please put a newline between variable definitions and code.


Thanks,

	Joerg
