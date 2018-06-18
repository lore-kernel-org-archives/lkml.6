Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100EEC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4F82075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Qj9fIc5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4F82075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936229AbeFRTVv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:21:51 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38934 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935544AbeFRTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:21:47 -0400
Received: by mail-oi0-f65.google.com with SMTP id t22-v6so15903383oih.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P72y9HBsxOeK3n6ypmZhKrph6Tes9m4oigwwoetoE+I=;
        b=Qj9fIc5ZSkn0rr31HLRt94YI5zW2DRNeCugU+vaUfLxCPjyvo8zMmRB3nKrqFegp4/
         ynfzBc4OPiBZPC76rxAxn35kkIcixBW4zzBz6cS6M7BaJt2KYQtq2neLFm01R2Il+J5z
         V+SM4ofdoPhTtpTajhKXpMcXKch7xgO/IDeFh70GXLKTeZW+h44CmjBUyafdMO6Hw1oa
         36OVzsnnPdRGh34UD8Udyja8SDLitZ6ofvC1Ei/zs4o1pxmEhv1lDHQkzBA1cQoggFrR
         CNL2Hs9yEFaybQmVHfLCH7EBhp02LzFgd6kszvG/7NXid4XFtO+lLejp03On+nvWSvkN
         S2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P72y9HBsxOeK3n6ypmZhKrph6Tes9m4oigwwoetoE+I=;
        b=NliEaQ4fRHiKuOKcqakW/5uFlsimSztlZpQlF41iS7jPcMRsRD7WlVrUcZ5Ak/V3Lb
         IKJ6jlOzuqNnG4r5T01qRV4ce/iiqgJKBUQKdCajD7fYB5i1UflnEueFvR/rO73SLZPk
         s8z+s7PXkAzjNeE2V7kVyVF5rLasAK6YzWyDTQzKRmULJuCwiit19y/K9ZIbMHC0/Abv
         ICgSf7LrarE5RWrxuVepXtTe0PoOGEUiL60SSEsD0GZseaLd3JctQLC+SW8IHhm/x5Ow
         wuB+TSvxMOU0Shz9WMAj1iKcdgTQzao/87lnyCBjn0jpL2P7kSTbS9FIRLVnHthC4qdn
         nREQ==
X-Gm-Message-State: APt69E3XQ6tzXNPDQ2zlqUIdb2pY3ifqH2JEw6vGK0JB7vlXd0CrekYE
        7mC0t9r1oQ76xJItdJBlWJFqNxi2bl/O+QgvDZeOjg==
X-Google-Smtp-Source: ADUXVKJyRnhtPYcm4Sf1p3X/gutkAr6BZae8kdc1MM36ng3+1MAwEW0u2cqqUdPd7V3qRRq9NB5twttUKS5VIGpnUEg=
X-Received: by 2002:aca:3954:: with SMTP id g81-v6mr8270687oia.215.1529349707282;
 Mon, 18 Jun 2018 12:21:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 12:21:46
 -0700 (PDT)
In-Reply-To: <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
References: <20180617012510.20139-1-jhubbard@nvidia.com> <20180617012510.20139-3-jhubbard@nvidia.com>
 <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
 <20180617200432.krw36wrcwidb25cj@ziepe.ca> <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com> <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com> <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Jun 2018 12:21:46 -0700
Message-ID: <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:14 AM, John Hubbard <jhubbard@nvidia.com> wrote:
> On 06/18/2018 10:56 AM, Dan Williams wrote:
>> On Mon, Jun 18, 2018 at 10:50 AM, John Hubbard <jhubbard@nvidia.com> wrote:
>>> On 06/18/2018 01:12 AM, Christoph Hellwig wrote:
>>>> On Sun, Jun 17, 2018 at 01:28:18PM -0700, John Hubbard wrote:
>>>>> Yes. However, my thinking was: get_user_pages() can become a way to indicate that
>>>>> these pages are going to be treated specially. In particular, the caller
>>>>> does not really want or need to support certain file operations, while the
>>>>> page is flagged this way.
>>>>>
>>>>> If necessary, we could add a new API call.
>>>>
>>>> That API call is called get_user_pages_longterm.
>>>
>>> OK...I had the impression that this was just semi-temporary API for dax, but
>>> given that it's an exported symbol, I guess it really is here to stay.
>>
>> The plan is to go back and provide api changes that bypass
>> get_user_page_longterm() for RDMA. However, for VFIO and others, it's
>> not clear what we could do. In the VFIO case the guest would need to
>> be prepared handle the revocation.
>
> OK, let's see if I understand that plan correctly:
>
> 1. Change RDMA users (this could be done entirely in the various device drivers'
> code, unless I'm overlooking something) to use mmu notifiers, and to do their
> DMA to/from non-pinned pages.

The problem with this approach is surprising the RDMA drivers with
notifications of teardowns. It's the RDMA userspace applications that
need the notification, and it likely needs to be explicit opt-in, at
least for the non-ODP drivers.

> 2. Return early from get_user_pages_longterm, if the memory is...marked for
> RDMA? (How? Same sort of page flag that I'm floating here, or something else?)
> That would avoid the problem with pinned pages getting their buffer heads
> removed--by disallowing the pinning. Makes sense.

Well, right now the RDMA workaround is DAX specific and it seems we
need to generalize it for the page-cache case. One thought is to have
try_to_unmap() take it's own reference and wait for the page reference
count to drop to one so that the truncate path knows the page is
dma-idle and disconnected from the page cache, but I have not looked
at the details.

> Also, is there anything I can help with here, so that things can happen sooner?

I do think we should explore a page flag for pages that are "long
term" pinned. Michal asked for something along these lines at LSF / MM
so that the core-mm can give up on pages that the kernel has lost
lifetime control. Michal, did I capture your ask correctly?
