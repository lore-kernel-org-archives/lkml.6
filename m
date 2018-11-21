Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B72C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49D1214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49D1214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbeKVD7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:59:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34055 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbeKVD7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:59:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id a132so5367655qkg.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaCVNqyJbaP9O+t90Hd4/wjgzX3V51X1m72Wc6ZVnA0=;
        b=O3eLW3c61veM4Oc5/9KR+SHW4UiEieYF0IIn+J0JBg/U+Rkbitia4dC5TqAYrUDluW
         mf1vgU9FJaBgRKdGvV8+MkBefx14ZnsvLBl12m2m4PzNVEpqi/xQjDE+XnplBX9qn3ib
         syoXMrpBsXDKfV0TyHGdgBYOjpXhVs13bel/gvFxKillF/78RCGDr51q+ATtTji8wXfd
         wggYLpo7JPqnreu7ugjfxa04F+bwzCSQ8VWmM1SI1xRzHQNwOLplfXY0I7/nbjw1Mnjr
         ny7/8thPB6I9tVpt0qqa3IfeXYPOI181jRYRsPZ0DaN/+OBlSnsYS8XycnNAI7NiR6Fo
         7qOQ==
X-Gm-Message-State: AA+aEWa7E6UUNnBnkjeOGJGwggcAJCSCL4AK6xg0O87LM+UhYY/LNLSH
        HWzWJC5ybD4ESztJYiotcDt7mpX1LX6S/PEVEwk=
X-Google-Smtp-Source: AFSGD/VICNAJxO5C1sZr7RMIspZpzPAIWVu4oDkoKXYU7ct3BKfzNaDlcPK6nnnVeFao8QGr0jrN9sWloMV7dZFMf/k=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr6056730qkm.343.1542821057253;
 Wed, 21 Nov 2018 09:24:17 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrVPcgKarpTOsdTfODkNA76W04WvW+tNWoOx6+Em0KS04A@mail.gmail.com>
 <87efbggly5.fsf@oldenburg.str.redhat.com> <CALCETrVJO-GSbQCGNJS_F1ZswG15aWOdX7onWFYgTVhh97WbWg@mail.gmail.com>
In-Reply-To: <CALCETrVJO-GSbQCGNJS_F1ZswG15aWOdX7onWFYgTVhh97WbWg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 21 Nov 2018 18:23:50 +0100
Message-ID: <CAK8P3a0y=nUg=SqdVLrPobV0GQp3YukSWWr0GSpXEq4KBQ8=ug@mail.gmail.com>
Subject: Re: Cleaning up numbering for new x86 syscalls?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Daniel Colascione <dancol@google.com>, carlos@redhat.com,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 4:35 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Tue, Nov 20, 2018 at 1:03 AM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * Andy Lutomirski:
> >
> > > 5. Adjust the scripts so that we only have to wire up new syscalls
> > > once.  They'll have a nr above 1024, and they'll have the same nr on
> > > all x86 variants.
> >
> > Is there a sufficiently sized gap on all other architectures as well?
> > The restriction to the x86 variants seems arbitrary to me.
> >
>
> Fair point.  We have this shiny "generic" syscall list.  Maybe we can
> get x86 synced up with it for new syscalls.

The generic table is already a subset of the x86 tables, so there
should be no need to sync up the contents.

It's more critical on other architectures that currently lack a number
of the syscalls that got added in asm-generic and x86 recently,
so I'd like to synchronize these all and add the missing calls
to ensure that each architecture has at least all the calls from
asm-generic table.

After that,  I would hope to come up with a way to add future numbers
to all tables together, either using the same numbers everywhere (plus
an offset where necessary, e.g. mips), or even have an include file
logic so we only need a single file for future additions.

Note: for y2038, we will have to add around 20 to 25 syscalls to each
32-bit architecture, plus another 10 for those that lack the separate
sys_ipc calls.


      Arnd
