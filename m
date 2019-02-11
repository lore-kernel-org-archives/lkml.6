Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F5BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A81E2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C4tTREA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfBKW4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:56:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38478 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfBKW4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:56:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so270031plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HpEhd1hjAxTw2MvV1T4BxjxIfyr9u34ZDCNveDCt9pw=;
        b=C4tTREA7HJPtDyU1uVPrhGE+tenWueSaGN0k0ef/Kh8wHOc+eeRjHW4eNci/W1sNVZ
         nYdNIvPBh0jkuMGegVaVI7ZknSEEmTYjVQ9lkUqwq808jxLyjhyYKUS7PTcL9UCxtB/s
         it+yq0CUlai76H0E960zYXqbQR8MnnrS6MK8skX1EzEWnStU+4GlmKuGyXCUjmhBbpIA
         ESTHk+JdGDgc7/Ph4KMGJJYmCHTvk5TWeSG1yrZVMPtAk3pw1nN/51xgX4GuqGMCDsdQ
         v3NegYxwcxTIMySPBLYjq6QADfr8Cbj0sw8JmSoiCEdCAL1NAbCqVFX55zltezDUhzh9
         STEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HpEhd1hjAxTw2MvV1T4BxjxIfyr9u34ZDCNveDCt9pw=;
        b=qPxhRC1xoiefwSWYGbHdd0Upe3B7OHQsqn7qekjep0u61DDy5ZbTp8Ur70Y+WLoTj5
         6eGRrBKWGtU86+ditAHnUlPcwmzjp+sjF0xtbkMJQYOTJbLDLPmXD2rngnbo3eU80eQL
         CwFLzOw5osYccqXa+STNbX7ugYxgyTsbCN6ArJqEZruJz/Fz1XHxOzm5GPLfHtK8hnfW
         1wxxQDSbvIi4yIq5G+oyPePe5eABJ3etyfogy4r04WS/ZfnezjSnl2mFsHN5a0Lgqehi
         KWfNCTbmY4Zi9N/wpgbI6OxmBp0pS+HN5oeQc4lIyIcSpxgfUAjGB/DbOsuW1i4/VZ0m
         A0kw==
X-Gm-Message-State: AHQUAubJeDhST2G/XAqq+vAXwfMwRoHPB317AU4aXkgPhiD+vvexNCmz
        PmB4G0CZaBkI8tbAzdFXag1+Cg==
X-Google-Smtp-Source: AHgI3IZZHskA3za69Xpd8+FHO3LEV/xrV2vOJSA9kBqr3FxTMFSCZDXTbx2Vmep3HV1eRHv9cAoOVw==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr677704plz.75.1549925781226;
        Mon, 11 Feb 2019 14:56:21 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id e65sm16713492pfc.184.2019.02.11.14.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:56:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtKUu-0003Rw-6N; Mon, 11 Feb 2019 15:56:20 -0700
Date:   Mon, 11 Feb 2019 15:56:20 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     akpm@linux-foundation.org, dave@stgolabs.net, jack@suse.cz,
        cl@linux.com, linux-mm@kvack.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, hao.wu@intel.com,
        atull@kernel.org, mdf@kernel.org, aik@ozlabs.ru
Subject: Re: [PATCH 1/5] vfio/type1: use pinned_vm instead of locked_vm to
 account pinned pages
Message-ID: <20190211225620.GO24692@ziepe.ca>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-2-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211224437.25267-2-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:44:33PM -0500, Daniel Jordan wrote:
> Beginning with bc3e53f682d9 ("mm: distinguish between mlocked and pinned
> pages"), locked and pinned pages are accounted separately.  Type1
> accounts pinned pages to locked_vm; use pinned_vm instead.
> 
> pinned_vm recently became atomic and so no longer relies on mmap_sem
> held as writer: delete.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>  drivers/vfio/vfio_iommu_type1.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 73652e21efec..a56cc341813f 100644
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -257,7 +257,8 @@ static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
>  static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>  {
>  	struct mm_struct *mm;
> -	int ret;
> +	s64 pinned_vm;
> +	int ret = 0;
>  
>  	if (!npage)
>  		return 0;
> @@ -266,24 +267,15 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>  	if (!mm)
>  		return -ESRCH; /* process exited */
>  
> -	ret = down_write_killable(&mm->mmap_sem);
> -	if (!ret) {
> -		if (npage > 0) {
> -			if (!dma->lock_cap) {
> -				unsigned long limit;
> -
> -				limit = task_rlimit(dma->task,
> -						RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	pinned_vm = atomic64_add_return(npage, &mm->pinned_vm);
>  
> -				if (mm->locked_vm + npage > limit)
> -					ret = -ENOMEM;
> -			}
> +	if (npage > 0 && !dma->lock_cap) {
> +		unsigned long limit = task_rlimit(dma->task, RLIMIT_MEMLOCK) >>
> +
> -					PAGE_SHIFT;

I haven't looked at this super closely, but how does this stuff work?

do_mlock doesn't touch pinned_vm, and this doesn't touch locked_vm...

Shouldn't all this be 'if (locked_vm + pinned_vm < RLIMIT_MEMLOCK)' ?

Otherwise MEMLOCK is really doubled..

Jason
