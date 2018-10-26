Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E479EECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EE020856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4J1+2j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EE020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeJ0EoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:44:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44375 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJ0EoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:44:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2-v6so1042205pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rQYg0Ei3Z+g2eWBiookOM+RCW1fS/B3c+BTE3JJ7Wo=;
        b=P4J1+2j8vWYJ2pcCXUq8rZQczZi9bYSHVgBnUwlkVjhzqEAfOaHJCj2K31MAcCKGpA
         Yb9EInL99zjaKKwASHjGIUc1AnMQXOoVwk0KEmZzp0HJ7JxJG1Wz1Gv8K48H2qjDN5Oq
         gREE8bs7iqQrlR3g1uOxhkaW3jFpU3X28P129ZnCiRaI19ohYg+h3FqOWMWFsDV7jWRa
         G+3aTww+IVQLwY8d71JC7rk0VHS5NJcrJxHh1268Tt0lK/Y+JeBhL0fv9FJqA0XaeDxF
         kUmpb0MbS4EInHAlNLmlkOYcaFyylqzhOClXQ48jBHyBAXNXT/wdEBrZ/AiOMK6ksuN8
         klxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rQYg0Ei3Z+g2eWBiookOM+RCW1fS/B3c+BTE3JJ7Wo=;
        b=rg1D2G4KcUHztQR6uPLaOTpeVLI7OuowxXxxZsuTY7JUxQgVuq2UW9jSfFfg3fxQtp
         TN06cpWR3ZvU0OK7Z9nVd+PsAtNAS6Z172llnoQt2bTTFGjsdcnxtrh3iDuB6+GxMuoq
         ZEdgyZQ6Tzc7qHKupp9Al9Oa/4QbyedWLb4u64v69dMOvtgxHkWmCf44nW4YusOqCEeQ
         f1Q2PLWFp4nNZ5qMxYBFhSYO1SPPWkzfs84IyWPYVaFmtsYgZSUgGm2/ooaroFo2UpVw
         PoM40Oznw3qMSs2efwEbY4ytqOmHnFPlnzNrpiJtIOMsTsihtcRciiU73hFtj5INM9zB
         jZGQ==
X-Gm-Message-State: AGRZ1gKgj2uP+i2XDNNmrXrbHSILMOImJjoojYEB0NSAL/g9Gg1lFsLY
        B0AV0GAn+6fSkkdO1Nw9/Zy7l9NdAMk7pfhOy4/PbA==
X-Google-Smtp-Source: AJdET5dROaeU7uPALW5e8xQ4a3b7DNoxVuG9SULxa4l5+R7AZSWMUSHmipROOh8LYM+6AIu9V25ZugmMfi/ExdgCOkM=
X-Received: by 2002:a63:9e02:: with SMTP id s2-v6mr4907320pgd.302.1540584362686;
 Fri, 26 Oct 2018 13:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <10b12992-3570-4646-374b-82cbd7276839@acm.org> <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org> <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox> <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org> <20181026180515.GA12129@flashbox>
 <CAKwvOdnEHCmNjm-P068KQrbU0K+Dzyw_+_j7XLKJET0LWSz86A@mail.gmail.com> <CAHk-=wh0LsuM+kAZGbDaogDdSbdCk3GvXmjYVAMkpmLj2=VF=g@mail.gmail.com>
In-Reply-To: <CAHk-=wh0LsuM+kAZGbDaogDdSbdCk3GvXmjYVAMkpmLj2=VF=g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 26 Oct 2018 13:05:51 -0700
Message-ID: <CAKwvOd=c9RG2s3f-PgM1T84sHc5N9zcjrVpG5is+mGbTOxvtrQ@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bvanassche@acm.org, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        hch@infradead.org, Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 12:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Oct 26, 2018 at 11:32 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > + Linus
> > I'm not about the process of removing code from the kernel.  Doesn't
> > that violate the "thou shalt not break userspace" rule?
>
> The only thing that breaks the "thou shalt not break userspace" rule
> is fairly simple: things that break user space.

Is removing a filesystem considered a userspace breakage?  If you have
an exofs mount, and you upgrade to a kernel with the RFC patch, you
will no longer be able to mount that type of FS.  Userspace code that
expects to mount an exofs FS would now always fail.  Maybe this is
equivalent to removing a previously supported mount option.
/proc/filesystems might have one less option.

So I guess this is different than dropping support for an architecture
since you cannot produce an updated kernel image, as opposed to this
RFC which would make existing drives fail to mount?

>
> Does removing the code break for somebody? If so we don't do it. But
> if nobody notices because nobody uses, it's fine.

Right, but it seems like a catch 22; it's not possible to prove that
nobody will notice because they are not using it.

Like the expression:
If a tree falls in a forest and no one is around to hear it, does it
make a sound?

If no one is using a kernel feature and its removed, will anyone notice?

If the maintainer would like to remove support for their subsystem,
should it continue to remain in the tree?  Code is never truly
deleted, and is relatively painless to resurrect with git.

Solutions that come to mind immediately:
* Just land the small fix discussed earlier in the thread. These
subsystems continue to exist.  Maybe this question comes up again for
this subsystem in a few years.  Christoph alludes to my question not
being the first time this was asked of this subsystem.
* Put out some kind of intent to deprecate, hoping to get feedback on
possible users that would be affected. Land the deletion patches in
-next.  This approach always runs the risk of not posting in the right
venue; and users can't be bothered to check for intent to deprecate
notices.
* Just delete it. Resurrect if users report use of this FS.

What are your thoughts?

>
> Basically, there is no "theoretical" rule about what breaks user space
> or not. In particular, the rule is *not* that you can't change ABI.
> You can do any change you want that changes a kernel exported ABI,
> just as long as nobody actually notices the change.
>
> But in practice, it's often _much_ more work to try to figure out
> whether something breaks somebody than it is to just say "don't change
> behavior", so 99% of the time, the rule ends up being just "try to
> avoid intentionally changing behavior, because you'll likely get it
> wrong".

I agree semantic changes to an existing API are problematic (not just
within the kernel), but do you consider deletion or removal of
parameters in the same category?

Thank you for your insight on this.
-- 
Thanks,
~Nick Desaulniers
