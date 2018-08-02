Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC100C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD422151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBtfAMby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD422151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbeHBVE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:04:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41261 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeHBVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:04:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so3167700wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JIPtmhgglsF+MzK+Y1Sy9nxL1qQY8Frwl5nOkaV1+cQ=;
        b=hBtfAMbyZ30z8skC8WtDOyVO6C5bF4fWSpzp28ruYACre6EF2ORqtGC5ROrdmM2ccg
         xKSoeyWAD/E+rUhVi/E0l57xzM9BZ/i4SwYa6Qdbd6ockBQEi63ydc4izNCLJtXWrQn+
         FI+dOLk9BJU7baDN1Jb7VnAPCTq2t/Zcb0qxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JIPtmhgglsF+MzK+Y1Sy9nxL1qQY8Frwl5nOkaV1+cQ=;
        b=pH9xPsgKawoxwrzrIDKk1AfdqwcCIFi75X2vU1s81TSHXatDtwDUxk9LBRtWMOakAe
         sdWKgrRBvnDGQpt5XEwLGSsaYhBcmg1MoMm9tEyf5gWFy2LKLrpN34WvnpkasQ20iKbD
         Dxy5rYIDQbUhzEOcAz156keghhBHKkWYte7HNBCRdZDwHz+92m4KosM0t/pVckDkG3t8
         BOV8H/G8E4CJUjZkMh3PRfeVLy3Pm4RsrJWB+qu+VrITzNCKFWmrMkHsMccP47N1+hUf
         Xi6qriGbfxr+703InLNRx3HY2PgQwwslEMtd/qWZj0SM57GFHM6eA00PekZ3YHAYb47T
         Ol5A==
X-Gm-Message-State: AOUpUlGltzJsDcDpx7ycYlrWKMzvDEfC665ltWsHgexXk8MH+h9iI3IZ
        EJeA67k32cvjX+TDFQAI4iGtxqUwKl0Qnihizvo3Gg==
X-Google-Smtp-Source: AAOMgpcDZaoPH9ZAeyubxc5h7xGucuq9W2emEO1iipofRjM3MLdqV0Rui6S01aik+X6laGXN3wSvhef2Vo7eLS+9Avg=
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr530542wra.90.1533237146645;
 Thu, 02 Aug 2018 12:12:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 12:12:24 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.11.1808011424540.1087@eggly.anvils>
References: <alpine.LSU.2.11.1807301410470.4805@eggly.anvils>
 <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils> <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com>
 <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
 <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1> <20180731174349.GA12944@agluck-desk>
 <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com>
 <alpine.LSU.2.11.1808011042090.14313@eggly.anvils> <20180801205848.6mgcfux4b63svj3n@kshutemo-mobl1>
 <alpine.LSU.2.11.1808011424540.1087@eggly.anvils>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 2 Aug 2018 12:12:24 -0700
Message-ID: <CALAqxLWWUHhuTPa7VpAdvScRHnHT=0UcKyDuJgn=BVCaOd1Beg@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     Hugh Dickins <hughd@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 2:55 PM, Hugh Dickins <hughd@google.com> wrote:
> On Wed, 1 Aug 2018, Kirill A. Shutemov wrote:
>> On Wed, Aug 01, 2018 at 11:31:52AM -0700, Hugh Dickins wrote:
>> > On Wed, 1 Aug 2018, Linus Torvalds wrote:
>> > >
>> > > Anyway, the upshot of all this is that I think I know what the ia64
>> > > problem was, and John sent the patch for the ashmem case, and I'm
>> > > going to hold off reverting that vma_is_anonymous() false-positives
>> > > commit after all.
>> >
>> > I'd better send deletion of zap_pmd_range()'s VM_BUG_ON_VMA(): below
>> > (but I've no proprietorial interest, if you prefer to do your own).
>>
>> Agreed.
>>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
> Thanks.
>
>>
>> > John's patch is good, and originally I thought it was safe from that
>> > VM_BUG_ON_VMA(), because the /dev/ashmem fd exposed to the user is
>> > disconnected from the vm_file in the vma, and madvise(,,MADV_REMOVE)
>> > insists on VM_SHARED. But afterwards read John's earlier mail,
>> > drawing attention to the vfs_fallocate() in there: I may be wrong,
>> > and I don't know if Android has THP in the config anyway, but it looks
>> > to me like an unmap_mapping_range() from ashmem's vfs_fallocate()
>> > could hit precisely the VM_BUG_ON_VMA(), once it's vma_is_anonymous().
>> >
>> > (I'm not familiar with ashmem, and I certainly don't understand the
>> > role of MAP_PRIVATE ashmem mappings - hole-punch's zap_pte_range()
>> > should end up leaving any anon pages in place; but the presence of
>> > the BUG is requiring us all to understand too much too quickly.)
>>
>> Hugh, do you see any reason why ashmem shouldn't have vm_ops ==
>> shmem_vm_ops?
>
> I cannot immediately think of an absolute reason why not, but I'm
> not giving it much thought; and that might turn it into a stranger
> beast than it already is.
>
>>
>> I don't understand ashmem, but I feel uncomfortable that we have this
>> sneaky way to create an anonymous VMA. It feels wrong to me.
>
> I agree it's odd, but in this respect it's no odder than /dev/zero:
> that has exactly the same pattern of shmem_zero_setup() for VM_SHARED,
> else vma_set_anonymous(): which made me comfortable with John's patch,
> restoring the way it worked before.
>
> Admittedly, the subsequent vfs_fallocate() might generate surprises;
> and the business of doing a shmem_file_setup() first, and then undoing
> it with a shmem_zero_setup(), looks weird - from John's old XXX comment,

Yes, it is weird. :)

> I think it was a quick hack to piece together some functionality they
> needed in a hurry, which never got revisited (they wanted a name for
> the area? maybe memfd would be good for that now).

So my XXX comment is to do with a change I made to ashmem in order for
it to go into staging, compared with the original Android
implementation. They still carry the patch to undo it here:
https://android.googlesource.com/kernel/common.git/+/ebfc8d6476a66dc91a1b30cbfc18e67d4401af09%5E%21/

But it has more to do w/ in the shared mapping case, providing a
cleaner way of setting the vma->vm_ops = &shmem_vm_ops without having
to use shmem_zero_setup(), and doesn't change the behavior in the
private mapping case.

This discussion has spurred Joel and I to chat a bit about reviving
the effort to "properly" upstream ashmem. We're still in discussion
but I'm thinking we might just try to add the pin/unpin functionality
to memfd. We'll see how the discussion evolves.

thanks
-john
