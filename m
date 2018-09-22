Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A99C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590AE208A3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBU5nOuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590AE208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbeIVTd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:33:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45025 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbeIVTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:33:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id d131-v6so9801461qke.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=st8KvSdqa7GD8N6IJLkWN9UnuBkRSqSl2sgziOqhnPI=;
        b=MBU5nOuJq6c8AL2PObv/Bmfx+Tmk89AMslAJyPR38+JEp5FtvMWVFE24HTXQ+vC85R
         moZ7TVLinkepor3yDba+snCPGe7NGQzGxFE1FXi4bILEL3Z3Mkx05aX9PgmIJYN9YW+y
         OwB23x3rMesgwbSskwP9UgfzEI1ojyd4uJnfRgKi1g2C5CBLjq5Uqx3ykG3KBgWyc9BY
         /6kHOMfxTSakiUxieWQpmHz0/4UrvU6ZrurXSgpoIUYo9KmZj1jlLCuXizCjxY6dYzDw
         FN58VF03Rs6T9zGQsS65d2ussy13tJgmz7ptocr1yeWD85dRfv1bV7/D6uPrz4HV6ojO
         h6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=st8KvSdqa7GD8N6IJLkWN9UnuBkRSqSl2sgziOqhnPI=;
        b=NC/5rmhrkS7Cl6tHCkxyHYLo89ubLrZeYUPqUukj6Zxr9YRA4cgpmPGrpPQsQjGS9C
         o7YuDY//iHhuk1SKNdC2Il3Z8w4k7R0kYtHWS7v23LTt2/PWJqi52PJkKY/40HoJlsR1
         2dSOXiEGPkwaPftpcbrSVHS8cUur0GKjNRCVqfLhca9uV4mdzmYL/b7NKtPL5x1hV+hU
         rkTY+sWY5FnUh7l/yIPzlMeaGVNBY6OrQ1UfS/2KjIW5OsP3lJwkku8KTNhSCbMqAWO0
         8pvrpXhFelTGfAejm2Qb7wIFXrvKrYcXgwcolR8/bsrglGqS7OGQBZGcTmOEkHdJvEGS
         ZQzw==
X-Gm-Message-State: ABuFfogITzMxDqv5AgOqK3uYDWaANArxiw2Uqvn/nQpop8VJBZDpXKMu
        2Zc4LZJyhVo0nMsNd0RzBUyY3qB/tC86w6Jt2LM=
X-Google-Smtp-Source: ACcGV61wo+dYWC2+VuabTrkHnDv5CtEgDLgPkAGmuiQLGOHT9mzmeKVckozGFNLevRcqiSfn4m+Yix+OaQaLUDWV9GE=
X-Received: by 2002:ae9:ed4b:: with SMTP id c72-v6mr1330054qkg.54.1537623587339;
 Sat, 22 Sep 2018 06:39:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sat, 22 Sep 2018 06:39:26
 -0700 (PDT)
In-Reply-To: <CAFqt6zYtptZNeXbJwcJemb5O8rKjcB9=FpfiH60wK9v6vd0A2A@mail.gmail.com>
References: <20180920202316.GA6038@jordon-HP-15-Notebook-PC>
 <CANiq72kQA45ekbSruh-zTsc9B-9EOxZna=cOgOcM7--owxrWsA@mail.gmail.com> <CAFqt6zYtptZNeXbJwcJemb5O8rKjcB9=FpfiH60wK9v6vd0A2A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Sep 2018 15:39:26 +0200
Message-ID: <CANiq72=rtoq6269pn0KgznAkoqhF+UmRB2kd9K2vVmFt=SwiZg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay/cfag12864bfb.c: Replace vm_insert_page
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 1:07 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Fri, Sep 21, 2018 at 2:56 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> A link to the discussion/plan would be nice. The commit 1c8f422059ae5
>> ("mm: change return type to vm_fault_t") explains a bit, but has a
>> broken link :( Googling for the stuff returns many of the patches, but
>> not the actual discussion...
>
> This might be helpful.
> https://marc.info/?l=linux-mm&m=152054772413234&w=4

Thank you, although that does not explain why the changes are
happening, only that you are introducing the new API so that you can
start converting users (which is the normal way of doing it, no?).
What I meant is the discussion that led to commit 1c8f422059ae5 itself
(which has a link inside, but is broken).

>> I am out of the loop on these mm changes, so please indulge me, but:
>>
>>   * Why is there no documentation on vmf_insert_page() while
>> vm_insert_page() had it? (specially since it seems you want to remove
>> vm_insert_page()).
>
> The plan is to convert vm_insert_{page,pfn,mixed} to
> vmf_insert_{page,pfn,mixed}. As a good intermediate
> steps inline wrapper vmf_insert_{pfn,page,mixed} are
> introduced. After all the drivers converted, we will convert
> vm_insert_page to vmf_insert_page and remove the inline
> wrapper and update the document at the same time.

Yeah, that is what 1c8f422059ae5 ("mm: change return type to
vm_fault_t") seems to say at the end (thanks for clarifying).

Still, that does not explain why the documentation was not added at
the same time as soon the new API is introduced. I don't see how it
matters that they are wrappers.

Actually, I think the wrappers should have been the final functions
already in memory.c, their declarations in mm.h, etc. That way you
would minimize the code changes later on: you would be only removing
dead code, rather than changing code again. Even if you forward the
calls for the moment, it would have been a much smaller change later
on.

>
>>
>>   * Shouldn't we have a simple remap_page() or remap_kernel_page() to
>> fit this use case and avoid that dance? (another driver in auxdisplay
>> will require the same change, and I guess others in the kernel as
>> well).
>
>
> There are few drivers similar like auxdisplay where straight forward
> conversion from vm_insert_page to vmf_insert_page is not possible.
>
> So I mapped the kernel memory to user vma using remap_pfn_range
> and remove vm_insert_page in this driver.
>
> Other way, is to replace vm_insert_page with vmf_insert_page() and
> then convert VM_FAULT_CODE back to errno. But as part of vm_fault_t
> migration we have already removed/cleanup most the errno to VM_FAULT_CODE
> mapping from drivers. So I prefer not to take this option.
>
> Third, we can introduce a similar API like vm_insert_page say,
> vm_insert_kmem_page() and use it for same scenarios like this.

Yep, I think that is the best, unless there are only a couple of users
and you think nobody should be using it in the future.

Cheers,
Miguel
