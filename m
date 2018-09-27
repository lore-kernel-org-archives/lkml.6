Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1152156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocLkwFa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1152156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeI0Hfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:35:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39241 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeI0Hfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:35:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id c12-v6so929930otl.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 18:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYF1LptfL23EOpPF8bJxdp8WTTQI9jwOuJ4W1GvyqxQ=;
        b=ocLkwFa4ZXka/lUgDgTFe5X9Ea85mgMCLsHexjxld1ZfgvqB910jjJKzrqdgfYDIZc
         mEp8AyxPnbYskBdhz3KCnaUet8Eb2pzOGA+RvSduZkiJ2B4op1ePER2MtfYulH7xogJB
         n0ZGxWZd3wMPcfMDzPF9dgeBNU0y+/tgTzIU6xCb8HO67tpui89KBXogD2L06YEdZAP7
         pc+4Sy4tMaakZB9EnP65Z3728KJLaoUQB2p2Uq28GeXhb0qF6j46HLAvqDePBiMOhN6Q
         7tWTy8VWtOZc6QVraGSluBxQs6n0lpDDxDT2UJIU/LYaOQsboqEhzb6Qi7C5z/5dTkb6
         Ffzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYF1LptfL23EOpPF8bJxdp8WTTQI9jwOuJ4W1GvyqxQ=;
        b=c8LRd9PcPR3ZWqKEN1V2ZgvGe1qcsKJzohvjX23m6DEfahnEgXIxjyQertL/vUoKlA
         /I88iS1yTMuUtlFGV1bjE4TETZ+fA1ovHoGmICzFZ3rLIUht/BEr/PIzAT+yQvoKE5U8
         lU1in0W+1ayiqmuX7c/PN7A+rIzgxjJTadZ9GEHGsXc7C3wlBtI7iNOru1wuoVN3upsD
         RLhq380QqoNQ1Ptzi2Ih7sLFjygyMicEi2Mi2i+ZFKhf2X6mN64qFwj1pIiZOIGr2VHa
         9WwFICXwQiA+KZB/3yOXDJg3THwea29M1Oz1bZG8/PX707WPDFLTdYhWM+z0Q5Kg19Si
         JZsA==
X-Gm-Message-State: ABuFfogCbCZAxltEYc5ZZ/fjPqsFJOb3OE3T/6baerKMx/OJIiuB977T
        TBZZ5Ydfo+iYBA5zcjOa3n4J4XW+qoA+EA8BXshZqw==
X-Google-Smtp-Source: ACcGV63aa6YzoUXM02rQjQbOtNwpOXyK6aBPVMxlYIZy1v3JQbGx57ATFgdF8bthfkvExva3mrr46B3iGQh1743Vp0o=
X-Received: by 2002:a9d:844:: with SMTP id 62-v6mr5444008oty.159.1538011202478;
 Wed, 26 Sep 2018 18:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180911183909.233413-1-jannh@google.com> <CAG48ez03ivLr6w+V911V7pqb1o=kcJw4CLEktcSVVE+=hXXP=w@mail.gmail.com>
 <CAGXu5jKBPh+TSCuaitpPdk89hW=ch+QeRsUfE68pLpzLS=z4Jg@mail.gmail.com>
 <CAG48ez22djpKdtYDTMn0MS=2m_QAq983O0-oXyVGiu3ju2HwXg@mail.gmail.com> <CAGXu5jLLC6dp7T5AmKur0dioc767vvJFms8wj9syLBvQzcYQpg@mail.gmail.com>
In-Reply-To: <CAGXu5jLLC6dp7T5AmKur0dioc767vvJFms8wj9syLBvQzcYQpg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 27 Sep 2018 03:19:35 +0200
Message-ID: <CAG48ez0M90ajea8Cee32VjRV4A5CjM8FA1kpdmL6yThBrGf9Lg@mail.gmail.com>
Subject: Re: [PATCH] proc: restrict kernel stack dumps to root
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ken Chen <kenchen@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>, security@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 4:39 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 13, 2018 at 4:55 AM, Jann Horn <jannh@google.com> wrote:
> > On Thu, Sep 13, 2018 at 12:28 AM Kees Cook <keescook@chromium.org> wrote:
> >>
> >> On Wed, Sep 12, 2018 at 8:29 AM, Jann Horn <jannh@google.com> wrote:
> >> > +linux-api, I guess
> >> >
> >> > On Tue, Sep 11, 2018 at 8:39 PM Jann Horn <jannh@google.com> wrote:
> >> >>
> >> >> Restrict the ability to inspect kernel stacks of arbitrary tasks to root
> >> >> in order to prevent a local attacker from exploiting racy stack unwinding
> >> >> to leak kernel task stack contents.
> >> >> See the added comment for a longer rationale.
> >> >>
> >> >> There don't seem to be any users of this userspace API that can't
> >> >> gracefully bail out if reading from the file fails. Therefore, I believe
> >> >> that this change is unlikely to break things.
> >> >> In the case that this patch does end up needing a revert, the next-best
> >> >> solution might be to fake a single-entry stack based on wchan.
> >> >>
> >> >> Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
> >> >> Cc: stable@vger.kernel.org
> >> >> Signed-off-by: Jann Horn <jannh@google.com>
> >> >> ---
> >> >>  fs/proc/base.c | 14 ++++++++++++++
> >> >>  1 file changed, 14 insertions(+)
> >> >>
> >> >> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >> >> index ccf86f16d9f0..7e9f07bf260d 100644
> >> >> --- a/fs/proc/base.c
> >> >> +++ b/fs/proc/base.c
> >> >> @@ -407,6 +407,20 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
> >> >>         unsigned long *entries;
> >> >>         int err;
> >> >>
> >> >> +       /*
> >> >> +        * The ability to racily run the kernel stack unwinder on a running task
> >> >> +        * and then observe the unwinder output is scary; while it is useful for
> >> >> +        * debugging kernel issues, it can also allow an attacker to leak kernel
> >> >> +        * stack contents.
> >> >> +        * Doing this in a manner that is at least safe from races would require
> >> >> +        * some work to ensure that the remote task can not be scheduled; and
> >> >> +        * even then, this would still expose the unwinder as local attack
> >> >> +        * surface.
> >> >> +        * Therefore, this interface is restricted to root.
> >> >> +        */
> >> >> +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
> >> >> +               return -EACCES;
> >>
> >> In the past, we've avoided hard errors like this in favor of just
> >> censoring the output. Do we want to be more cautious here? (i.e.
> >> return 0 or a fuller seq_printf(m, "[<0>] privileged\n"); return 0;)
> >
> > In my mind, this is different because it's a place where we don't have
> > to selectively censor output while preserving parts of it, and it's a
> > place where, as Laura said, it's useful to make lack of privileges
> > clearly visible because that informs users that they may have to retry
> > with more privileges.
> >
> > Of course, if you have an example of software that actually breaks due
> > to this, I'll change it. But I looked at the three things in Debian
> > codesearch that seem to use it, and from what I can tell, they all
> > bail out cleanly when the read fails.
>
> I prefer -EACCESS too, but I thought I'd mention the alternative. So, I guess:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

What do I need to do to get this merged? Oh, I think I misread
MAINTAINERS - Alexey Dobriyan is not a maintainer, just a reviewer. So
I guess this has to go via Andrew Morton? Should I resend the patch
with Andrew in the recipient list?
