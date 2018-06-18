Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6DFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EC820836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGzJCx4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EC820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936974AbeFRVot (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936504AbeFRVor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:44:47 -0400
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6FB20874
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 21:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529358286;
        bh=gDw8i04v+PnkkUDymHS9ykQ+jmxZYRMZE4jHMJO8o/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SGzJCx4MrpeTQuPJDZg1dnUpY6AmYGqyE8U09bxIvEIQbyGhv9effZP8FjAsE2P87
         mkzltxoWYRPrOMe5Qmh2tp0ju5p9Z2yHyYz9LBWcORnIBhAu4vC6Vy2PfNGMJHDvoE
         cMCMky/tdi/OkYNhPbSK9+IEL1BTpMboqG/OstcY=
Received: by mail-wm0-f44.google.com with SMTP id r15-v6so16483363wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 14:44:46 -0700 (PDT)
X-Gm-Message-State: APt69E25ScFRCeSeNGjpx/qOI7S5BDbKD5XXiuUVnZjR9vH/g+6Si0cY
        MjsT8lgd0/S6Pa8KB+vTh4lTgpBAtl5LFH5L1AvDIA==
X-Google-Smtp-Source: ADUXVKIb8qUh7XC+sL9MOcnqlLKDxU4C6RRWGSqu7pZ/LNB0urpcMNsHJR2ldbkC/H8WuhAjX3zKMHzLUuLV6tgXErc=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr9232918wmh.116.1529358285009;
 Mon, 18 Jun 2018 14:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
 <1528815820.8271.16.camel@2b52.sc.intel.com> <814fc15e80908d8630ff665be690ccbe6e69be88.camel@gmail.com>
 <1528988176.13101.15.camel@2b52.sc.intel.com> <2b77abb17dfaf58b7c23fac9d8603482e1887337.camel@gmail.com>
In-Reply-To: <2b77abb17dfaf58b7c23fac9d8603482e1887337.camel@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Jun 2018 14:44:33 -0700
X-Gmail-Original-Message-ID: <CALCETrWCEjuM56J8dqXPR==MevJTYKan5dnAMFJaXzFMYr8Q_A@mail.gmail.com>
Message-ID: <CALCETrWCEjuM56J8dqXPR==MevJTYKan5dnAMFJaXzFMYr8Q_A@mail.gmail.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 8:16 PM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Thu, 2018-06-14 at 07:56 -0700, Yu-cheng Yu wrote:
> > On Thu, 2018-06-14 at 11:07 +1000, Balbir Singh wrote:
> > > On Tue, 2018-06-12 at 08:03 -0700, Yu-cheng Yu wrote:
> > > > On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> > > > >
> > > > > On 08/06/18 00:37, Yu-cheng Yu wrote:
> > > > > > This series introduces CET - Shadow stack
> > > > > >
> > > > > > At the high level, shadow stack is:
> > > > > >
> > > > > >       Allocated from a task's address space with vm_flags VM_SHSTK;
> > > > > >       Its PTEs must be read-only and dirty;
> > > > > >       Fixed sized, but the default size can be changed by sys admin.
> > > > > >
> > > > > > For a forked child, the shadow stack is duplicated when the next
> > > > > > shadow stack access takes place.
> > > > > >
> > > > > > For a pthread child, a new shadow stack is allocated.
> > > > > >
> > > > > > The signal handler uses the same shadow stack as the main program.
> > > > > >
> > > > >
> > > > > Even with sigaltstack()?
> > > > >
> > > >
> > > > Yes.
> > >
> > > I am not convinced that it would work, as we switch stacks, oveflow might
> > > be an issue. I also forgot to bring up setcontext(2), I presume those
> > > will get new shadow stacks
> >
> > Do you mean signal stack/sigaltstack overflow or swapcontext in a signal
> > handler?
> >
>
> I meant any combination of that. If there is a user space threads implementation that uses sigaltstack for switching threads
>

Anyone who does that is nuts.  The whole point of user space threads
is speed, and signals are very slow.  For userspace threads to work,
we need an API to allocate new shadow stacks, and we need to use the
extremely awkwardly defined RSTORSSP stuff to switch.  (I assume this
is possible on an ISA level.  The docs are bad, and the mnemonics for
the relevant instructions are nonsensical.)
