Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C2BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B92208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nE9Aynkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B92208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbeHAXnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:43:23 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33462 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHAXnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:43:23 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so60400plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BrGcMCfuqBW04cMtUwDRaVcFdQjQwHiU8Batmrc0uRw=;
        b=nE9AynkgkzqshTFm78K9kSJLk2NQlYHIFdzY0RL742gACnvY8DsKksuVxkUuYhDz5U
         rmfK8rqC+QJqVb/jWgCBoS156Dr7jEf8gincVsvkuewjj/A7UV0iIccN6qtVrIvefl9l
         pYh3GP57ANLs+eH9MqWRPEhJtOr+LwnV66EsGmLSafWLsNCkrdSiQ8LrJqoy02OhKsdl
         a285woXd9Ylz+cg+fXIMhHShQLHLED7hMypIicVagDgTydbAq3osNYbNjw+gceENIk25
         CCtY5Ee9o4gih96c4r4ioqTDmw605SfPHxFLc9jBRE8sgGbRCxt2LDsNcguy2D4ZIX9y
         F0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BrGcMCfuqBW04cMtUwDRaVcFdQjQwHiU8Batmrc0uRw=;
        b=VkyTKP506PMQy6uP53vh80IzDHD5CVGXSl2cK1rx1gf7B+z9oL2iI7kTV/sadvC2Kb
         gpRgWv011Q0c7VQgMadtHzPP7wMPFf2JUsOJMXiI7IdVVFCNWw9FTawLPpu8w2kVAlz1
         fstT33KqFrzhU0pwTP0om/8mkUQDc9X3mA3T38Q+bUT/a5zaRUxLvp3kEYYa+4sv6guz
         EGCh57gbLlQAtqUOt6eQsxXgW7GlWLPS7a1wYu5QwQHAWc4o+mDPrNfXuYRyA+c/0zSA
         MAd/GhA9JSshxZcKNCAmYHlp9hQWCRSue2md0WfB2Wz4TnnvDyoDSY334ekB0AyU5lx4
         dBbQ==
X-Gm-Message-State: AOUpUlGcnZZW3joecPUxy+yOe9x5PRIsUwYpVoA03vAJNtoM3hfA+TiR
        rwQFJeFQJSlIn58q63ZRVz8ESA==
X-Google-Smtp-Source: AAOMgpdAD7etdgiwo0AtPTFPg9v6YxLmech9++NFsHkHjdyzllJJCU0kLysrs4oDpfs4GnwHEfwyqg==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7-v6mr107545plt.128.1533160530257;
        Wed, 01 Aug 2018 14:55:30 -0700 (PDT)
Received: from [100.112.75.99] ([104.133.8.99])
        by smtp.gmail.com with ESMTPSA id j5-v6sm60623pff.139.2018.08.01.14.55.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 14:55:28 -0700 (PDT)
Date:   Wed, 1 Aug 2018 14:55:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
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
Subject: Re: Linux 4.18-rc7
In-Reply-To: <20180801205848.6mgcfux4b63svj3n@kshutemo-mobl1>
Message-ID: <alpine.LSU.2.11.1808011424540.1087@eggly.anvils>
References: <alpine.LSU.2.11.1807301410470.4805@eggly.anvils> <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com> <alpine.LSU.2.11.1807301940460.5904@eggly.anvils> <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com> <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com> <20180731170328.ocb5oikwhwtkyzrj@kshutemo-mobl1> <20180731174349.GA12944@agluck-desk>
 <CA+55aFxJpJvcYKos-sVTsn9q4wK0-m4up1SXrcqfbXHKxaKxjg@mail.gmail.com> <alpine.LSU.2.11.1808011042090.14313@eggly.anvils> <20180801205848.6mgcfux4b63svj3n@kshutemo-mobl1>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Kirill A. Shutemov wrote:
> On Wed, Aug 01, 2018 at 11:31:52AM -0700, Hugh Dickins wrote:
> > On Wed, 1 Aug 2018, Linus Torvalds wrote:
> > > 
> > > Anyway, the upshot of all this is that I think I know what the ia64
> > > problem was, and John sent the patch for the ashmem case, and I'm
> > > going to hold off reverting that vma_is_anonymous() false-positives
> > > commit after all.
> > 
> > I'd better send deletion of zap_pmd_range()'s VM_BUG_ON_VMA(): below
> > (but I've no proprietorial interest, if you prefer to do your own).
> 
> Agreed.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Thanks.

> 
> > John's patch is good, and originally I thought it was safe from that
> > VM_BUG_ON_VMA(), because the /dev/ashmem fd exposed to the user is
> > disconnected from the vm_file in the vma, and madvise(,,MADV_REMOVE)
> > insists on VM_SHARED. But afterwards read John's earlier mail,
> > drawing attention to the vfs_fallocate() in there: I may be wrong,
> > and I don't know if Android has THP in the config anyway, but it looks
> > to me like an unmap_mapping_range() from ashmem's vfs_fallocate()
> > could hit precisely the VM_BUG_ON_VMA(), once it's vma_is_anonymous().
> > 
> > (I'm not familiar with ashmem, and I certainly don't understand the
> > role of MAP_PRIVATE ashmem mappings - hole-punch's zap_pte_range()
> > should end up leaving any anon pages in place; but the presence of
> > the BUG is requiring us all to understand too much too quickly.)
> 
> Hugh, do you see any reason why ashmem shouldn't have vm_ops ==
> shmem_vm_ops?

I cannot immediately think of an absolute reason why not, but I'm
not giving it much thought; and that might turn it into a stranger
beast than it already is.

> 
> I don't understand ashmem, but I feel uncomfortable that we have this
> sneaky way to create an anonymous VMA. It feels wrong to me.

I agree it's odd, but in this respect it's no odder than /dev/zero:
that has exactly the same pattern of shmem_zero_setup() for VM_SHARED,
else vma_set_anonymous(): which made me comfortable with John's patch,
restoring the way it worked before.

Admittedly, the subsequent vfs_fallocate() might generate surprises;
and the business of doing a shmem_file_setup() first, and then undoing
it with a shmem_zero_setup(), looks weird - from John's old XXX comment,
I think it was a quick hack to piece together some functionality they
needed in a hurry, which never got revisited (they wanted a name for
the area? maybe memfd would be good for that now).

But if what's in there is working now, I do not want to mess with it:
I'd be adding bugs faster than removing them.

Hugh
