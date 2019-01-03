Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FACC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6F1217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGajQCg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfACWTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:19:10 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:43364 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbfACWTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:19:10 -0500
Received: by mail-yb1-f170.google.com with SMTP id t16so12358147ybk.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 14:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmllRMdyJnbmtqXjx8n3a2o3oNHbW/WUJayH7xChrWo=;
        b=uGajQCg+aFzz+jSS/1j66aNVb1Uhr9Y9FqzhjpEv6zwqkzNUsSEz0MXXDJzlolZpL5
         yOpqMAz/qYTeYQGLKg9Rs+lPNzs18AM80Hpw4VF/KDDBVGXsRDIu7PukKycJZ0tY75Pj
         QsxR1y0SWjJHeJjohlfaYdddn3PtyHlaU3Al1s8p+amXSQlJBTGQLFawdrWlYChMdOHS
         45BwDzzFPv5uz+GDu2wwJnJdtyFB7NA/hLMtZVDhH7jH17H/wcpj4+8HqFVZpCYowCKO
         HeowZqtxuRFIwLHojY0kRxEob3jVpLHVFuFOX2LFDc9ySb98+D6eTjlxmeQ9cnVQ4fIf
         EfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmllRMdyJnbmtqXjx8n3a2o3oNHbW/WUJayH7xChrWo=;
        b=bvK/LctluEOMF5Vtv5UldcPBwT1v+ObPtefxURs9eBZaLe4qbFzD3jKvjX+d3+kQfp
         wepjNNzB4w8GNa/8F7OgpfUfns907QlDrBCK5wvl+hT+PfxWDuev5DwzUiAE2SxKx/N7
         LMuAX7Kj5HulFFQikH33cglgOyVIBVrra1HanRIWvSTJFdHJhAU1n9At3BXkJjp+QJnL
         hDmZzwHp7YcnT+z1rwChIrefWEryn6Dsc8PBhmICjaShfnlwRd+3r8w+EpinL93cdD7J
         1Ro8DN1qVjxZ9JLzh2/DVaLUn5wpSyBbEr0SIVJiyPlEJXMdS6LPpUhfwg9sFMxwlWyQ
         orbA==
X-Gm-Message-State: AJcUukd1gwnTvyRRcD/qtuv+D8l3XaNpAmc0vMGWTNfBU3EmWKjvbvca
        z5abmuLbdYbRPxB84kA5em3qytrMkWPu7LInBIhjpZAhDHJrqA==
X-Google-Smtp-Source: ALg8bN49kmejTKC2xau8DNean0DbiGUWvqJnsutSphg/oS7XKSd3shrabTDFFnkKN2La83DRP+aZFBVQvltpsudZmWQ=
X-Received: by 2002:a25:a269:: with SMTP id b96mr20156330ybi.148.1546553948330;
 Thu, 03 Jan 2019 14:19:08 -0800 (PST)
MIME-Version: 1.0
References: <00000000000051ee78057cc4d98f@google.com> <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
 <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com> <CACT4Y+Y-c7FgSTKyHqpRZu3eKLo5QfXy10axTSwWkU4MUgjFgw@mail.gmail.com>
 <87614226-e895-c3a3-3626-b0fbe7e191be@colorfullife.com> <CACT4Y+bU4mLF1tEhw6mKf1m1W63OGvaFhAsTrpTW0M5MFXekRQ@mail.gmail.com>
 <CACT4Y+Zynq-URqgJNyCZyTPM80GU8DndtKv=BFDU9_U=f0KceA@mail.gmail.com> <cc088b05-7bc9-778e-30b9-4b8720314001@colorfullife.com>
In-Reply-To: <cc088b05-7bc9-778e-30b9-4b8720314001@colorfullife.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 3 Jan 2019 14:18:57 -0800
Message-ID: <CALvZod7RtD7zcN48S+duFtjLUsSJrmXUqQawh6=ziw62gvOQjg@mail.gmail.com>
Subject: Re: general protection fault in put_pid
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred,

On Sun, Dec 23, 2018 at 4:26 AM Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Hello Dmitry,
>
> On 12/23/18 10:57 AM, Dmitry Vyukov wrote:
> >
> > I can reproduce this infinite memory consumption with the C program:
> > https://gist.githubusercontent.com/dvyukov/03ec54b3429ade16fa07bf8b2379aff3/raw/ae4f654e279810de2505e8fa41b73dc1d77778e6/gistfile1.txt
> >
> > But this is working as intended, right? It just creates infinite
> > number of large semaphore sets, which reasonably consumes infinite
> > amount of memory.
> > Except that it also violates the memcg bound and a process can have
> > effectively unlimited amount of such "drum memory" in semaphores.
>
> Yes, this is as intended:
>
> If you call semget(), then you can use memory, up to the limits in
> /proc/sys/kernel/sem.
>
> Memcg is not taken into account, an admin must set /proc/sys/kernel/sem.
>
> The default are "infinite amount of memory allowed", as this is the most
> sane default: We had a logic that tried to autotune (i.e.: a new
> namespace "inherits" a fraction of the parent namespaces memory limits),
> but this we more or less always wrong.
>
>

What's the disadvantage of setting the limits in /proc/sys/kernel/sem
high and let the task's memcg limits the number of semaphore a process
can create? Please note that the memory underlying shmget and msgget
is already accounted to memcg.

thanks,
Shakeel
