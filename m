Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BEBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0932173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f48qVFS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0932173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeHTVPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:15:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36393 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTVPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:15:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so7154475pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yAsGAHQkZfKFXMLPod80NA7dSbz6WpMWOaLo2QhCS2c=;
        b=f48qVFS+KEfRbmYkwqmbJeiuChpid7hVepBx+BBHOZ+QUvHMVAorGjqJnq/BA7jV1z
         N9iiJObXuTgbw2iBe9J16fvZKzlILGsIKelsVx9A406lfpvA2FReAZTP0H0Anfmyq+Aw
         IptfpHUFDcWvBCEBoF/kMPhaQNHqqXakqSYK0g085cdrVW5d5wzgnq/EeFFzyNRwaLcW
         Ve50WXYz8im+Ie+bpOSoBseif9w5ko6SoiiuHQjn8LvgWTN0uW/MsPEOt/WqcQ2E5Jk7
         sR3B6n6xTJFm0jrh+MRhdQTJ9fC2bGyrSLdNf17TH4awiYSM0+4nWWFLCCWbh3jXjGhl
         in5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAsGAHQkZfKFXMLPod80NA7dSbz6WpMWOaLo2QhCS2c=;
        b=A2n20hdbCrXux89p3N/iR7Z53uPeFxkmyssk3KNyllI06/yr+BcjZr88UfV1AOepxA
         rsFBQkP0Sttmr6xRKnmkg8ORkbEpoe+CkwIC+2QZ441a3S3hHYRn7c9Xms/iEoE4ctN7
         PViJTtezEVCTbHsN9b4U/BJ28YLAD9dxlFMLCLbXzGVqkXEHmzBrjD7Wuuh+RUlA9inb
         xMcQzCDOW3VTK5m7hsy2vN+0uJah99KQVcZVq/Xs1ypNliiGuakynv6MTMsjf9ReDUje
         HbDbqLeyMlKol3xGoJ9YL75k7MxyYHweup07kItuhFX0nmt/hrvlp08CmhSle+91qK0e
         D9zw==
X-Gm-Message-State: AOUpUlHt8A9yLKuDs5bDKnlGnsFTF7Aa+TnQz8A9CFlf1b1MgptibiHO
        MUnKWwNMpcZdW95nUKkv86l8fe1UIrNB4tHfIFyTbw==
X-Google-Smtp-Source: AA+uWPyT/y/DpbmrXFOnCbgBYq4cof1nRphslyG949GJl7uyXsMvSXlYEbWiCsU3f+QID6atgnQX0OZULYSCNhj8/Xc=
X-Received: by 2002:a63:28c1:: with SMTP id o184-v6mr43328415pgo.225.1534787932243;
 Mon, 20 Aug 2018 10:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180801210804.175176-1-ndesaulniers@google.com>
 <CAKwvOd=WZB=x86zqu=vFDoJgpWnfCj0K3qXv14vtysfv3ioi1w@mail.gmail.com> <CAKwvOd=qGTv1F3CsEeNjuJ93BD9zTnUekUHgvw4Ttpx7us5JdA@mail.gmail.com>
In-Reply-To: <CAKwvOd=qGTv1F3CsEeNjuJ93BD9zTnUekUHgvw4Ttpx7us5JdA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 20 Aug 2018 10:58:41 -0700
Message-ID: <CAKwvOd=U0aMsUmBytK7vq=ORj+Npw7FqZ50EMEJPnmTG15N7dg@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: prefer _THIS_IP_ to current_text_addr
To:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, "Eric W . Biederman" <ebiederm@xmission.com>,
        Simon Horman <horms@verge.net.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, x86@kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ akpm, Linus

Bumping for review.

On Mon, Aug 13, 2018 at 2:32 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Simon (kexec)
>
> bumping for review.
> On Wed, Aug 8, 2018 at 4:06 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > bumping for review
> > On Wed, Aug 1, 2018 at 2:08 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > As part of the effort to reduce the code duplication between _THIS_IP_
> > > and current_text_addr(), let's consolidate callers of
> > > current_text_addr() to use _THIS_IP_.
> > >
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  arch/x86/include/asm/kexec.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> > > index f327236f0fa7..86924d594ecd 100644
> > > --- a/arch/x86/include/asm/kexec.h
> > > +++ b/arch/x86/include/asm/kexec.h
> > > @@ -21,6 +21,7 @@
> > >  #ifndef __ASSEMBLY__
> > >
> > >  #include <linux/string.h>
> > > +#include <linux/kernel.h>
> > >
> > >  #include <asm/page.h>
> > >  #include <asm/ptrace.h>
> > > @@ -132,7 +133,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
> > >                 asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
> > >                 asm volatile("pushfq; popq %0" :"=m"(newregs->flags));
> > >  #endif
> > > -               newregs->ip = (unsigned long)current_text_addr();
> > > +               newregs->ip = _THIS_IP_;
> > >         }
> > >  }
> > >
> > > --
> > > 2.18.0.597.ga71716f1ad-goog
> > >

-- 
Thanks,
~Nick Desaulniers
