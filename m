Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59559C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFA02085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="l6kTCtOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFA02085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbeKGExj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:53:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36593 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbeKGExj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:53:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so13356623wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 11:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ff/unWpMYqcJyC/XCKzSyImdSvdxesphNOgvcWfV+bk=;
        b=l6kTCtOPNRfKeJ7KL2f13bJCfI1UYCOAf5I1KstoDRVJ1mL+sIEZLE/B57oYb9iB/J
         4fOLTRTsUpwioiO7XV72khVAZPAUHhAot+2kTyUpyrWKqRqz9ZjlSGITsAU+kl9I33zS
         Hymr2VpU39WWCBVWN5oiMR0uKqlwSUJGZ1Oy9U1XWsDVrF5UMGdYMbYb0TcV6AYxXsIS
         Hr5khBayLxxF7IIISHRg2/GDfek46yE+BZoI8yk5seVkrUFRSYQiVkRVcGOCXz3TFbU/
         Wu8H4yGxvlggD4dK7byoQ4GSztdIUsdCloMCIus7wjP/ThMnVzci3sx6auy1YLnNlqLh
         QGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ff/unWpMYqcJyC/XCKzSyImdSvdxesphNOgvcWfV+bk=;
        b=lqnI1q0AMm9EVZuSLe3HCQhz64rm0ryPD8iXor60UfK7gIYa8hPpkles3+p0JbWTDP
         RTOXwmL1bTP3KEvOh5Z0lJFv/35HgcGKBbkAMNTZFVUwREEvCzcmYGhOe/n4IaQMRzG6
         ObcImPHJ5Y1h+vd6FvZhAsP6BjVQSRdg3rr3JRl69Q60v1fFG1FcYJC/LA3gO+6qud7F
         TcooO6kqmT9cam4kOpd3dSPjPprh2mrCoAPdvCLFdUrmks1ylKYCGUQ2h8ECPlQe6IMH
         ObFltL4zzRT5sUOQYx7anHbwFLnYTdEtiDE5XQzcWzl75dD0H29r2nDNs3ZfUaE34lHm
         S5Cg==
X-Gm-Message-State: AGRZ1gICnadv8E17Qbbuh6allBcFmyOz8esX7sSdtRSt8WzcM8KJlIAF
        AXzWvDd4QX2/MMQJH1vqbmnaBEYRIU/myrLPBgFQoA==
X-Google-Smtp-Source: AJdET5eH1LOXpnXBAwkcnppgBnvZNtenDWR31FfuLNSHVj3Lls82Pgo8tZPo7vX3RDUFbnA6z2SLAcSm8NqqBDs7r3o=
X-Received: by 2002:a1c:2b45:: with SMTP id r66-v6mr2951052wmr.128.1541530547984;
 Tue, 06 Nov 2018 10:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20181011151523.27101-1-yu-cheng.yu@intel.com> <20181011151523.27101-22-yu-cheng.yu@intel.com>
 <ee5a93f7-ed42-dcc5-0e55-e73ac2637e84@intel.com>
In-Reply-To: <ee5a93f7-ed42-dcc5-0e55-e73ac2637e84@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 6 Nov 2018 10:55:36 -0800
Message-ID: <CALCETrVfQ8oumNUx6jCFDm0JOD+7qPjaeYvC6pGyodMBcf0VRw@mail.gmail.com>
Subject: Re: [PATCH v5 21/27] x86/cet/shstk: Introduce WRUSS instruction
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:43 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/11/18 8:15 AM, Yu-cheng Yu wrote:
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1305,6 +1305,15 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
> >               error_code |= X86_PF_USER;
> >               flags |= FAULT_FLAG_USER;
> >       } else {
> > +             /*
> > +              * WRUSS is a kernel instruction and but writes
> > +              * to user shadow stack.  When a fault occurs,
> > +              * both X86_PF_USER and X86_PF_SHSTK are set.
> > +              * Clear X86_PF_USER here.
> > +              */
> > +             if ((error_code & (X86_PF_USER | X86_PF_SHSTK)) ==
> > +                 (X86_PF_USER | X86_PF_SHSTK))
> > +                     error_code &= ~X86_PF_USER;
> This hunk of code basically points out that the architecture of WRUSS is
> broken for Linux.  The setting of X86_PF_USER for a ring-0 instruction
> really is a mis-feature of the architecture for us and we *undo* it in
> software which is unfortunate.  Wish I would have caught this earlier.
>
> Andy, note that this is another case where hw_error_code and
> sw_error_code will diverge, unfortunately.
>
> Anyway, this is going to necessitate some comment updates in the page
> fault code.  Yu-cheng, you are going to collide with some recent changes
> I made to the page fault code.  Please be careful with the context when
> you do the merge and make sure that all the new comments stay correct.

I'm going to send a patch set in the next day or two that cleans it up
further and is probably good preparation for WRUSS.
