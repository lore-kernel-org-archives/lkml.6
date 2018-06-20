Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F33AC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191982083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dYeowoDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191982083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeFTB5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:57:45 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36247 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753619AbeFTB5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:57:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id 14-v6so1609177oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x1cDTKwy+A0g7klqr4/9PADmywcPYq6UGwzf/26w3Fc=;
        b=dYeowoDrdhsa/IKDB+Ai0hYgs7PYNvN5oYRKUTBu/ilzsR/K1MZjGzSRBV0T9KLukq
         etalU8pGG0vQmJpbBLkbDEz2iypN1G4OfD3OtZqvFghees4u0u2AaX6OCFxYya/eii/q
         SEcUEjcg1w4cnwqucam7m+JNhWWY7myBH+qDpVQ2SvFeht1xpjK1aCfMs6Su0CNg7QSZ
         8lsBiZC18gmmXgiyTycDZMGNBZ7qDHt2L+WkCzt6M7dEEdOXIOWyEtS4cWvLmNZ1RNSB
         CFyOLs0ImKJuI7MYtQH/ofQnG+doIlECn+e3GTijjZpU8DTrQ+nmGW+3tQ7dWnFIya7W
         URjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x1cDTKwy+A0g7klqr4/9PADmywcPYq6UGwzf/26w3Fc=;
        b=kBvLWu9tH2rPl0SVtvejmmXyy8JOwszi6rOUCs+1i9k5Au0BVpNeuki3aYO+eUlydg
         GfPMyISe+jsUyP0Od02tIdVntYoNlOUTYnq2pj3sECyYYq1L7X37Ap86Bq/ELSFimqRH
         ltX2Lbw6JUgWHEhueGdp9vJ3YUCdkvzKGA8ddXPdUTqhky+UYUwmMgkrGaI4rGHFiRDQ
         CUe47g3ZOANfPjM6PXjU8QLpHDUzr2pXDfOv3VdLTvfU5l7gL8aXRlKeRtMB6LDHoSa/
         L8M1AIhyZ3ycdNlt0ubOLc61WEHXZoE2kZiA6e6KfhRJZ5GOddrIJCkc/1Zhcze8TIcK
         i4Ig==
X-Gm-Message-State: APt69E3iBUdginb8h4BKZirfCGIiYTmCrYXoP/IF+rTM2OfSh/GK6zsK
        fBO9y5cOoQMgWhGYHROAatMR+Zu4NlyZUWPnCAiFQA==
X-Google-Smtp-Source: ADUXVKK76dzp6ruYVeqzJJiL8bLenIdyFBK8QPfB7WTypLeM9FC/27uk3i7Do3oxsHiLM0FIejsxs11XFzwPrFBVKgk=
X-Received: by 2002:aca:745:: with SMTP id 66-v6mr10015355oih.295.1529459861835;
 Tue, 19 Jun 2018 18:57:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 18:57:41
 -0700 (PDT)
In-Reply-To: <ecb54f89-52dc-a37a-5592-d2c40f216047@nvidia.com>
References: <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com> <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com> <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com> <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <0e6053b3-b78c-c8be-4fab-e8555810c732@nvidia.com> <20180619082949.wzoe42wpxsahuitu@quack2.suse.cz>
 <20180619090255.GA25522@bombadil.infradead.org> <20180619104142.lpilc6esz7w3a54i@quack2.suse.cz>
 <70001987-3938-d33e-11e0-de5b19ca3bdf@nvidia.com> <CAPcyv4iGKYRpbv-KK3KUrm8Ab485DwX05y4uGH2ZZ8GNYh8Q_g@mail.gmail.com>
 <ecb54f89-52dc-a37a-5592-d2c40f216047@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Jun 2018 18:57:41 -0700
Message-ID: <CAPcyv4iZU3Cin589Tg2g=NN5XoTosbsosf27frxBCWznB+X8ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <john.hubbard@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 6:34 PM, John Hubbard <jhubbard@nvidia.com> wrote:
> On 06/19/2018 06:24 PM, Dan Williams wrote:
>> On Tue, Jun 19, 2018 at 11:11 AM, John Hubbard <jhubbard@nvidia.com> wrote:
>>> On 06/19/2018 03:41 AM, Jan Kara wrote:
>>>> On Tue 19-06-18 02:02:55, Matthew Wilcox wrote:
>>>>> On Tue, Jun 19, 2018 at 10:29:49AM +0200, Jan Kara wrote:
>> [..]
>>>> And then there's the aspect that both these approaches are a bit too
>>>> heavyweight for some get_user_pages_fast() users (e.g. direct IO) - Al Viro
>>>> had an idea to use page lock for that path but e.g. fs/direct-io.c would have
>>>> problems due to lock ordering constraints (filesystem ->get_block would
>>>> suddently get called with the page lock held). But we can probably leave
>>>> performance optimizations for phase two.
>>>
>>>
>>> So I assume that phase one would be to apply this approach only to
>>> get_user_pages_longterm. (Please let me know if that's wrong.)
>>
>> I think that's wrong, because get_user_pages_longterm() is only a
>> filesystem-dax avoidance mechanism, it's not trying to address all the
>> problems that Jan is talking about. I don't see any viable half-step
>> solutions.
>>
>
> OK, but in that case, I'm slightly confused by Jan's comment above, about leaving
> performance optimizations until phase two. Because that *is* a half-step approach:
> phase one, phase two.

No, sorry, I might be confusing things. The half step is leaving
truncate broken, or my strawman that only addressed unmap.

> Are you disagreeing with Jan, or are you suggesting "fix get_user_pages first, and
> leave get_user_pages_fast alone for now?"

I'm agreeing with Jan, we need to fix page_mkclean() and
try_to_unmap() without regressing truncate behavior.
