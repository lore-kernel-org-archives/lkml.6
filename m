Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BB9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B78B23E3C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="QRqBOQY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B78B23E3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeGDOkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:40:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36915 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbeGDOkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:40:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id k81-v6so11138695oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yjz5ybuHpyDOaOQLRbyCjdv0YGvLk7x4x2M4aNkgI1c=;
        b=QRqBOQY3PYGBh2P1EvjcWHkB6XhOZN58XO+s9sUVGtbR5WfhGS4bCK4GZAT3o5iwOh
         u90PZdMdUgEHg7Q5E+enqTHOqzUrQoe4xo6CgjOElwv6FjRTXPmS9EU/nx7KxhHDAy5s
         JqpMj4Yj2PwSathJgqqUMne4A/58SUGWvheXxoA9oiTOrzwn3gnbi54mlI/SVSDyO7h2
         Vh4SWzbS4BIKfgdcPnM1G1kbKj7NkcgddpgvQ4DFvKjXuejI62Csf7mqzlgaKfpCpkWR
         5y9dsVAyItpb8AFHY2fknhBQf39cfRhxuvslqmbz9y+aQNorX0T4uS6QOUwgz4+sh/Jf
         c2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yjz5ybuHpyDOaOQLRbyCjdv0YGvLk7x4x2M4aNkgI1c=;
        b=RXCsxuJyjyan0yCJxZf8GDyF5Q2L8N4dPlLHdhaiqmZ75oswDA8PLWsbn7YsUYgk4D
         1AM/nrk1TBNmSqJtSRggxE2oab95VJydD4UaA3Ry21l5vgT6y535xAD74FVZj7V0PjTJ
         odVPe0GdGwx70C0pKRvUBAqxZMxE69r1Z78zLCXWLugImC1BVRjEC7kljr4nthvGNtNq
         Yn5c9TL7YzUq6JfsbHbpJ2hxdm0X/VHwjozW+CIke4w0eoi7VDu8CnZPMciqoW+Z/V1n
         MS5XNvaMKLFmuvZp/xA2JPj6gmR9pUc3sWRWZZyOseMpH4AgsMC+iZ0WtyxGXivWnZ39
         tqSA==
X-Gm-Message-State: APt69E2+r6H9TqoIK0tXfvwwffqqHuujEXTeCbpFUuYR8AsdGL9TSNnj
        hEyrR2CWl1dwYpqNeRmkqUa+M8Z/fTDqzfq6WZeq+Q==
X-Google-Smtp-Source: AAOMgpcNcpDsvRb6w3dP2RWtCBcXViL/F8ij1MdXzmbvR/NJpAN66cGsOhhnWAyOpNSPy95L/L7Lj+ikkt7T6bmL4H8=
X-Received: by 2002:aca:100f:: with SMTP id 15-v6mr2739935oiq.110.1530715222122;
 Wed, 04 Jul 2018 07:40:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 07:40:21 -0700 (PDT)
In-Reply-To: <20180704064058.1344-1-yehs2007@zoho.com>
References: <20180704064058.1344-1-yehs2007@zoho.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Jul 2018 07:40:21 -0700
Message-ID: <CAPcyv4hJ62nDgEUpOg4ttbZbKUQctGF_adfHOJy0tHBNraeLPQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] nvdimm/pmem: check the validity of the pointer pfn
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jan Kara <jack@suse.com>, NingTing Cheng <chengnt@lenovo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Huaisheng Ye <yehs1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 11:40 PM, Huaisheng Ye <yehs2007@zoho.com> wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> Some functions within fs/dax don't need to get gfn from direct_access.
> Assigning NULL to gfn of dax_direct_access is more intuitive and simple
> than offering a useless local variable.
>
> So direct_access needs to check validity of the pointer pfn For NULL
> assignment.
>
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  drivers/nvdimm/pmem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 9d71492..018f990 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -233,7 +233,8 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>                                         PFN_PHYS(nr_pages))))
>                 return -EIO;
>         *kaddr = pmem->virt_addr + offset;
> -       *pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
> +       if (pfn)
> +               *pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
>
>         /*
>          * If badblocks are present, limit known good range to the

Looks good. You also need to update the unit test infrastructure
version of this operation in:

    tools/testing/nvdimm/pmem-dax.c
