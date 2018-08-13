Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43401C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E894521733
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHk10lO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E894521733
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbeHNARI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:17:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43589 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeHNARI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:17:08 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so7422527plv.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZxzbflCOQY382fh9rSSSZCozTZ/r3oM+f3UblpRfGkI=;
        b=CHk10lO365yB7TV/5/ymoCSbLvd24teU+5g4xxZE7Btgd+U/OvVkpgOjdQGhxZu0hD
         BZcOqwhPQLsfHVZgC7dxZmlS3BeEl6+jcp9uCJ6QLr/9UfKmUNwBsn0Y4FcWNgYgQNXl
         YJEMhMBOlv5N/Isn/DyqD1lsZP6dhzlamabsJ1R3aBaje3hEixx0P4o42S7GBzuu4QtM
         Lx1VyLbN0iv0WZXalmeHeF2DgiQaulYOAL7T7sbUP+PUUQSEEbFg44Y6TjxvlUUMqAqY
         6dtrmIkjYsUplqJUtZpaoXLNZGxIkZ9JctgfJibhLIGPS6Vizazv0Hzp1a9a2G6LXna+
         GFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxzbflCOQY382fh9rSSSZCozTZ/r3oM+f3UblpRfGkI=;
        b=gon9alAZxDuWdc8ePQZcmKzFCBhbyzw8FW0TjkfTBVRet3nYeS8XuNNdq9ER0SeFyE
         nBOYILxePTeHhua1unBousWwMJl/CFp4uHxJ7FzpI8zUBy6MCn6acYvnn22SHvSi8sHq
         A4G1UVBcnR2lqzhMw6GECwYCQTTi+tjEEIyW0YAW3MfwFLpb9npGCW+Z6XlWT5nu9K8v
         5oOhOBJheh50psvuRL5XQabtTRGVFnMlj1pj/Wth6x7968SXiVJEA4HOuVL8jWDYoJwa
         CCVUhts1BPXsovhYqey6iQNOBJo45+co9NZ8Rte90Fq1CsD/J3t1hCkcYTjipWJ5ZtWG
         i/0g==
X-Gm-Message-State: AOUpUlFXiL4Un6LsLhruaZYF3Olu/napi1v6GIzk35FUkbxH5ZnAQe+H
        VbZbOmYimAZSgSUTjr/Xgz2TKT3mK7dnGks+5D+JOA==
X-Google-Smtp-Source: AA+uWPz8JRp4CUzLbGQM++kxBmkGVk2MEI7a3LG8J2sd4GRj7HEfBp/RsW87ccD4TrdS0J1mo7vtq3IBBOUeDr/uEQQ=
X-Received: by 2002:a17:902:6b0b:: with SMTP id o11-v6mr17836259plk.214.1534195987728;
 Mon, 13 Aug 2018 14:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180801210804.175176-1-ndesaulniers@google.com> <CAKwvOd=WZB=x86zqu=vFDoJgpWnfCj0K3qXv14vtysfv3ioi1w@mail.gmail.com>
In-Reply-To: <CAKwvOd=WZB=x86zqu=vFDoJgpWnfCj0K3qXv14vtysfv3ioi1w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Aug 2018 14:32:56 -0700
Message-ID: <CAKwvOd=qGTv1F3CsEeNjuJ93BD9zTnUekUHgvw4Ttpx7us5JdA@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: prefer _THIS_IP_ to current_text_addr
To:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, "Eric W . Biederman" <ebiederm@xmission.com>,
        horms@verge.net.au
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

+ Simon (kexec)

bumping for review.
On Wed, Aug 8, 2018 at 4:06 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> bumping for review
> On Wed, Aug 1, 2018 at 2:08 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > As part of the effort to reduce the code duplication between _THIS_IP_
> > and current_text_addr(), let's consolidate callers of
> > current_text_addr() to use _THIS_IP_.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/x86/include/asm/kexec.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> > index f327236f0fa7..86924d594ecd 100644
> > --- a/arch/x86/include/asm/kexec.h
> > +++ b/arch/x86/include/asm/kexec.h
> > @@ -21,6 +21,7 @@
> >  #ifndef __ASSEMBLY__
> >
> >  #include <linux/string.h>
> > +#include <linux/kernel.h>
> >
> >  #include <asm/page.h>
> >  #include <asm/ptrace.h>
> > @@ -132,7 +133,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
> >                 asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
> >                 asm volatile("pushfq; popq %0" :"=m"(newregs->flags));
> >  #endif
> > -               newregs->ip = (unsigned long)current_text_addr();
> > +               newregs->ip = _THIS_IP_;
> >         }
> >  }
> >
> > --
> > 2.18.0.597.ga71716f1ad-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
