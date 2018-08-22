Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5C3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F87920BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odgK+uQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F87920BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeHVV6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:58:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37219 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVV6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:58:08 -0400
Received: by mail-pl0-f66.google.com with SMTP id c6-v6so1230732pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6nRzbI7YxBw0kI+eZ5MPyhsDtdwZjhJiAkVizkZedE=;
        b=odgK+uQXYVMUVDnE5X8nopAtjK6M+fF5/XohRNof2rOffUrh14Xjq9129FJDBGJLd+
         srKCHdR8/qCltzqIK2K57rMOOuLl2a7jTVn6Sn7aLB/Me1jkdA+TWyIwYpdfSxi2M2yB
         RC3wYIbd3S8NLd2CPCr2oiW7kIQmDF5JXKChhNcN1RFTpiqt3CWouUWVCG/rWRW7ixVT
         bKscceGkBSZZbfZP5U1X1RjKikeE3g2jUvzkT4HHggXPbgk6o4+VucqYh0uRNi3t/F2p
         nIg9iWlpDSlEf3rVri0y/7HWttxOjm/MDNqQE4ddfC1ZA2wUlZCQOzXOkVDmoiIJOq7B
         cFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6nRzbI7YxBw0kI+eZ5MPyhsDtdwZjhJiAkVizkZedE=;
        b=kSnenq8CMeW1h+VxqxiLFLXC17UYKpsp6JgSK9nsu/lwBLdnoo9aVBSQ25gQkhK/Sy
         qC0WF76CD8ehjSaMZFe5c3JYaUvO6vy9zu8b3zYnQLB0faj5tbxBDaws+55Ejg2KVZqB
         TXKh0u23aQuEIX16AUJRYEeca1GnXPyFBo1MharurMcmeM8iW14E5HFmR5HrIRglfJL4
         JGvm2b0/JmT1NwlleTT5LzE/kAXopUbfXah4SIshjp3yP/Qa4EAS+KwyRp03opsd8cVR
         LxRXuXCF0dUIexdIu93yJEd9WzsZH69rspZqvTt4x26hdQnfCxrOT3iuGT83fgL/NqgZ
         yp0Q==
X-Gm-Message-State: APzg51AXIWWddGZHJhONLSJYgJoWjmd4rnHZbgN1sbc/r42Zk4deYBds
        9rUpqdS4168qVz5zlUrrAAEvMbG8LWECcGp2ewGPzw==
X-Google-Smtp-Source: ANB0VdZ7iK5HtezcvziTM9u4J2djcvhgymdqoXwPfK4JLMqCrNgyOdCjm65PN4KBWIu2abCjggYnW0stUNXzz2YMoww=
X-Received: by 2002:a17:902:981:: with SMTP id 1-v6mr5512999pln.229.1534962728156;
 Wed, 22 Aug 2018 11:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
 <20180821123832.GA19034@nautica> <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
 <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
 <CAKwvOdkLGhdQxx3oV=R2kv290NOv_w8qQ_yHWCVpvmofp7+ivQ@mail.gmail.com>
 <20180822041646.GA21716@nautica> <78396ba82562326f4b3a395a63e3e8dc38d608b2.camel@perches.com>
 <20180822043230.GA26654@nautica>
In-Reply-To: <20180822043230.GA26654@nautica>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 22 Aug 2018 11:31:56 -0700
Message-ID: <CAKwvOdm+BwvDxAw-A_1v5xO2EjDff1axAttHVz5QnBSxSbKo=g@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
To:     asmadeus@codewreck.org
Cc:     joe@perches.com, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 9:32 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Joe Perches wrote on Tue, Aug 21, 2018:
> > On Wed, 2018-08-22 at 06:16 +0200, Dominique Martinet wrote:
> > > I think that could work, but at the point making a separate
> > > compiler-common.h and not including compiler-gcc.h for clang sounds
> > > better to me... More importantly here, either solution sound complex
> > > enough to require more than a few days and proper testing for all archs
> > > etc when compared to the partial revert we have here.
> >
> > The immediate need for a partial revert seems unnecessary as
> > clang hasn't really worked for a couple releases now.
>
> Sorry for repeating myself, clang is used by bcc for compiling BPF
> programs (e.g. bpf_module_create_c_from_string() or any similar function
> will use the clang libs to compile the bpf program with linux headers),
> and this has always been working because it's not using our makefiles.
>
> This broke today in master and I only joined this thread after looking
> at why the build started failing today and noticing this patch, it
> definitely hasn't been broken for two releases, or I wouldn't be here
> with this timing :)
>
>
> > The separate compiler file changes are much more sensible,
> > even if it takes a few days.
>
> A few days are fine, but I think some form of fix in 4.19-rc1 would be
> good.
>
> I'll stop taking your time now, but I think you are/were underestimating
> how many people use clang with the linux kernel headers indirectly.
> BPF is a well-used tool :)

Hi Dominique,
I'm currently testing a fix in
https://github.com/ClangBuiltLinux/linux/commit/1f89ae7622c26b8131f42f3a362d6ef41b88a595,
can you please share with me your steps to test/verify that the patch
fixes the issue for eBPF?  I'll go talk to a co-worker who know more
about eBPF, but I've not yet done anything with it.

Also, does anyone know who I should talk to about ICC testing?
-- 
Thanks,
~Nick Desaulniers
