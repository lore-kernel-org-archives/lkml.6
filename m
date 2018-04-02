Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3370170-1522686078-2-2142922667875257041
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522686077; b=QgUqtqcbKSeFz7qO9sg4dGyV7HUTebqc95O9e2VOT2lgCz6zdV
    0Tt8ULpXERRbmRGPAYngUvqcuPduaXKX8O19XAJvagtNAMcw09pqRvowf68jBlEM
    NQS/Eq3Z1V43Qzw+14pqU/zkQMyAxVH3Rh1zcA75dCmWJsrHEOg7+02v+QKd4qUT
    MaKUrBh51hMBVnYlsKPQCCJ4TeG8h+SXJLbhUSvR+y9KPRj0tIt5BWJfuSXdtT/C
    tLSD6EFzaIpzcWgMLNzrv3fdqCgxOtelHyGUppyZG7yJzwPBimbdwExu6dXJxKjR
    r8MqvoVp4WDzxwI+BfNFYK7myawshWlwR8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522686077; bh=dxPbLOLhsr1NgpONYuWV8seMdH9KslY+6mq62CtBqA
    c=; b=AlY5I3UH8c/AmBITO1i0KWhCdf3P4pngB86MZUEzYG+72+yD9vHeyYKIb9
    hVq08iaTlqmI+B3RHO8pCjuZf5UqGc0Fk4fMQfP2pOnnhAmwF+ptCRO1h9SHV0N/
    kHqDFc2IQhjsIAp2YcWXQ2njOFRwyC+aCA5E9qA5OO2MJy7DpkPjvuTdxAnmP7OB
    EpYItgDyBJViH+atvudTdttksAwEHtoPuEI65ByWngSbU1sD9S2DbHT3X++J9Du8
    0rGPkDtZmX8GhwdEQurXjl+dqiqY5hZ51DNgHXXDFpTw521M7804SWLg0b8WNT54
    No8RBFitOu43x29YJkRHbE1vgCPw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=gbSBhCf8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PvnwZv4b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=gbSBhCf8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PvnwZv4b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKg5HrDgTLJnFnDFOuJ+RE+9GB10TkuLbZzCUAAnVv8X+YJ5KRZU+/DDKJq8K7HrZFOoL159wQ0JPzS+OrmrKFZ8RFGv3uHoWZeADVPwENIPqKtiZ3o1
    UobQsgiAT9kOd5m+mQBqAtKWHi4fKepAS0YlJbeu5rvqHnw57d3RoTQvuxRYxH3SGwoPVKpD9cVoMCBj48MwZBPYQ+7jEpYPlrdd6OOQ6H7idsDyQCvAS/Td
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=uB-mh_tdWKN-RhgGFjEA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeDBQVD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 12:21:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45133 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752880AbeDBQVC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 2 Apr 2018 12:21:02 -0400
X-Google-Smtp-Source: AIpwx4/JaoI9ebKrYaeccO1ATez16aB/rC+wkf8bWp9Xzz9K0EvKhteEkTb1AbttaKbvES6FkNrgFj58LFG7ED+bB/w=
MIME-Version: 1.0
In-Reply-To: <20180330145402.5053-1-mike.kravetz@oracle.com>
References: <20180329041656.19691-1-mike.kravetz@oracle.com> <20180330145402.5053-1-mike.kravetz@oracle.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 2 Apr 2018 18:21:01 +0200
Message-ID: <CADYN=9+FzfFt8kKjw-hnHx7CdPbTsH0OsNs1TAGHa6Hi7ndbZQ@mail.gmail.com>
Subject: Re: [PATCH v2] hugetlbfs: fix bug in pgoff overflow checking
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nic Losby <blurbdust@gmail.com>, Dan Rue <dan.rue@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 30 March 2018 at 16:54, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> This is a fix for a regression in 32 bit kernels caused by an
> invalid check for pgoff overflow in hugetlbfs mmap setup.  The
> check incorrectly specified that the size of a loff_t was the
> same as the size of a long.  The regression prevents mapping
> hugetlbfs files at offsets greater than 4GB on 32 bit kernels.
>
> On 32 bit kernels conversion from a page based unsigned long can
> not overflow a loff_t byte offset.  Therefore, skip this check
> if sizeof(unsigned long) != sizeof(loff_t).
>
> Fixes: 63489f8e8211 ("hugetlbfs: check for pgoff value overflow")
> Cc: <stable@vger.kernel.org>
> Reported-by: Dan Rue <dan.rue@linaro.org>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

> ---
>  fs/hugetlbfs/inode.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index b9a254dcc0e7..d508c7844681 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -138,10 +138,14 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>
>         /*
>          * page based offset in vm_pgoff could be sufficiently large to
> -        * overflow a (l)off_t when converted to byte offset.
> +        * overflow a loff_t when converted to byte offset.  This can
> +        * only happen on architectures where sizeof(loff_t) ==
> +        * sizeof(unsigned long).  So, only check in those instances.
>          */
> -       if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
> -               return -EINVAL;
> +       if (sizeof(unsigned long) == sizeof(loff_t)) {
> +               if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
> +                       return -EINVAL;
> +       }
>
>         /* must be huge page aligned */
>         if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
> --
> 2.13.6
>
