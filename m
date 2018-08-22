Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E873C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD4C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 23:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TE7zJm6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD4C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeHWDUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 23:20:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36703 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeHWDUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 23:20:47 -0400
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so5660870oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+lcpAwWDtQH6UYK6Nf/zFiC2BHtqP+BXiZmgGiBdd0=;
        b=TE7zJm6Y9OthwdmKPAkzlSryOyrBgnxj5fGco0XmpLclVDK3FO3ZdIMMKdEUsgAEGD
         NChsCWJbwVLsGTTReX80Jbxua/eLS6bacZl32zf7oCfCCWNZK2CAwWS9BPB7RmS3j0s9
         2rQLw70yNSa1GBYgWZ7LH5npRkHUXi3/TdeauxDGjCaJ1csciTialSy37C2mvuPjG3iI
         /Fy5+e150U/8gSGtZtmBWDcSYjQ9duL0Agd4FHAWioFEg1lgix+/nzFUmy1akvmpakK/
         VK1hYcHpG7zXTQPj7VsQqgIyk+ddIFrlQOJl0B3gf7W+sU6k7mvTv1NrlmbbyzYbx/Ql
         a4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+lcpAwWDtQH6UYK6Nf/zFiC2BHtqP+BXiZmgGiBdd0=;
        b=nPn4glawAznJVk7reFBQVzRiYZGYQBL0PFFfG8b3XXTsWTsERvLtZRYINsMsozsHcF
         61c70+WOidI0zAem/uhZQ0YyDMWljO12R4qhoyfkoDqv7N5S0u1iPEwRjTEPAWW4v0vg
         nZ9IrwUK/oZDbMQ8rmGYDq9GPSi2QEBtMjlBzMYgdSplOvql/UbvjMY165jVHJpkBtaP
         3Gx3ZSGm6nhkRFD5ZgFHYqxCF4g61dPkozNKzT62GuriK6QvjvtdSGF7MZuvSnmGAFP5
         Temj9WFOHXmAarCTICCS2E8v9RrWm0QKFwmCi5V6foxFwl+W9G7hK1+nQCaf1+SbWMo9
         tr2A==
X-Gm-Message-State: APzg51C8YYqUxKLkHthFiyRILt0Rho3ARpDQvqouGTrDCad9bdkhGbDB
        OYPB8o4AausRpLRGcc8kZ5tYYUQBDCdgDV0fF/WDWA==
X-Google-Smtp-Source: ANB0VdYVbzjS+gJKn/Z51h0nJgVqwYH9716HBlnUj+ApMg9dY+VAHoBGwycRHYv2Ew44aGKUJwTP4ziN9n5sacT8t9g=
X-Received: by 2002:aca:dc55:: with SMTP id t82-v6mr5516052oig.159.1534982030543;
 Wed, 22 Aug 2018 16:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180807012257.20157-1-jannh@google.com> <C6369CAA-CBB8-420F-97DB-7A242D9650A8@amacapital.net>
In-Reply-To: <C6369CAA-CBB8-420F-97DB-7A242D9650A8@amacapital.net>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 23 Aug 2018 01:53:23 +0200
Message-ID: <CAG48ez0c0L+WyfjDcfx=3wDwOQDOSJM-2JSVUBoWJCaKDVEfbw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86: WARN() when uaccess helpers fault on kernel addresses
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 4:55 AM Andy Lutomirski <luto@amacapital.net> wrote:
> > On Aug 6, 2018, at 6:22 PM, Jann Horn <jannh@google.com> wrote:
> > There have been multiple kernel vulnerabilities that permitted userspace to
> > pass completely unchecked pointers through to userspace accessors:
> >
> > - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
> >  access_ok() checks")
> > - the sg/bsg read/write APIs
> > - the infiniband read/write APIs
> >
> > These don't happen all that often, but when they do happen, it is hard to
> > test for them properly; and it is probably also hard to discover them with
> > fuzzing. Even when an unmapped kernel address is supplied to such buggy
> > code, it just returns -EFAULT instead of doing a proper BUG() or at least
> > WARN().
> >
> > This patch attempts to make such misbehaving code a bit more visible by
> > WARN()ing in the pagefault handler code when a userspace accessor causes
> > #PF on a kernel address and the current context isn't whitelisted.
>
> I like this a lot, and, in fact, I once wrote a patch to do something similar. It was before the fancy extable code, though, so it was a mess.  Here are some thoughts:
>
> - It should be three patches. One patch to add the _UA annotations, one to improve the info passes to the handlers, and one to change behavior.
>
> - You should pass the vector, the error code, and the address to the handler.

I'm polishing the patch a bit, and I've noticed that to plumb the
error code and address through properly, I might need significantly
more code churn because of kprobes - I want to make sure I'm not going
down the completely wrong path here.

I'm extending fixup_exception() to take two extra args "unsigned long
error_code, unsigned long fault_addr". Most callers of
fixup_exception() are fairly straightforward, but
kprobe_fault_handler() has a dozen callchains from different exception
handlers, and most of them are coming via notify_die(). (My RFC patch
cheated by just feeding zeroes into fixup_exception() from
kprobe_fault_handler().) Also, annoyingly, for !CONFIG_KPROBES,
kprobe_fault_handler() is defined in include/linux/kprobes.h with a
single prototype across architectures.

Currently, for example, when do_general_protection() handles a kernel
fault, it first directly calls into fixup_exception(); and then, if
this is happening inside a kprobe, via
notify_die()->atomic_notifier_call_chain()->kprobe_exceptions_notify()->kprobe_fault_handler()->fixup_exception(),
it can end up calling fixup handlers a second time.
I think there's also some inconsistency between #PF and #GP in the
ordering of error handling:

#PF handling:
__do_page_fault
  kprobes_fault
    kprobe_fault_handler
      ->fault_handler    # first: kprobe fault handler
      fixup_exception    # second: kprobe's fixup call
  bad_area_nosemaphore
    __bad_area_nosemaphore
      no_context
        fixup_exception    # third: normal fixup call

#GP handling:
do_general_protection
  fixup_exception    # first: normal fixup call
  notify_die
    atomic_notifier_call_chain
      kprobe_exceptions_notify
        kprobe_fault_handler
          ->fault_handler    # second: kprobe fault handler
          fixup_exception    # third: kprobe's fixup call


Do you think I should actually plumb the error code and fault address
all the way through notify_die() and the kprobe handling fault?
Should I supply some "I don't want to trigger uaccess fault handlers"
flag when coming from the kprobe code?
Should the kprobe code not call into fixup_exception() at all (and if
so, should I change that somehow)?
