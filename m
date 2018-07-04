Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53BFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E85A2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E85A2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934323AbeGDIrK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:47:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932536AbeGDIrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:47:07 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D2592DC7994A2;
        Wed,  4 Jul 2018 16:46:53 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Wed, 4 Jul 2018
 16:46:51 +0800
Subject: Re: [V9fs-developer] [PATCH] fs: 9p: Adding new return type
 vm_fault_t
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        <akpm@linux-foundation.org>
References: <20180702154928.GA3964@jordon-HP-15-Notebook-PC>
CC:     <lucho@ionkov.net>, <ericvh@gmail.com>,
        <linux-kernel@vger.kernel.org>, <willy@infradead.org>,
        <v9fs-developer@lists.sourceforge.net>, <rminnich@sandia.gov>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B3C8974.6000606@huawei.com>
Date:   Wed, 4 Jul 2018 16:46:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180702154928.GA3964@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

On 2018/7/2 23:49, Souptick Joarder wrote:
> Use new return type vm_fault_t for page_mkwrite
> handler.
> 
> see commit 1c8f422059ae ("mm: change return type to
> vm_fault_t") for reference.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
Acked-by: Jun Piao <piaojun@huawei.com>
> ---
>  fs/9p/vfs_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 03c9e32..5f2e48d 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -533,7 +533,7 @@ int v9fs_file_fsync_dotl(struct file *filp, loff_t start, loff_t end,
>  	return retval;
>  }
> 
> -static int
> +static vm_fault_t
>  v9fs_vm_page_mkwrite(struct vm_fault *vmf)
>  {
>  	struct v9fs_inode *v9inode;
> --
> 1.9.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> V9fs-developer mailing list
> V9fs-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/v9fs-developer
> 
