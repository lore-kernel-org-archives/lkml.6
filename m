Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FB5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319FA2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="UXgccndh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319FA2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeGMRm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:42:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40011 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeGMRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:42:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so10106119wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cF9exWOBSiSYKDSlAAL3RrSktGF792+4hkmWV8Z7a7g=;
        b=UXgccndhMJFiwLp3AGbabwjGyQPo1aaDO+ACOLm1xFBYczxp+qGgD5dXpqo2Tg0HXy
         8Ofhxe2Wi8Cifedf3s86YYnV9RCmKt5xc+/gOiG88fFX3QtTsrU80T558yzXd51JUl/R
         baXOXNsilwm0jGvtn4IqddyYOTOJzUhpycYDzCkY73oNyGYWLYf+QlXw1sCcbefqOopX
         WammAe50nhHqOXfKqrnqg52ki7vOQ7QCij6OX2l/SfAHKyHbrt8+Aiw9xJC3aIYKMiL1
         nGH4SHdRsNtlhN0nyWEHspoiJig+M3JYrTCKd4+GwujO25VpXTjP+MgAqDs12ZqTSqG6
         mvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cF9exWOBSiSYKDSlAAL3RrSktGF792+4hkmWV8Z7a7g=;
        b=GsWilr5tbYT3lUR8Oy0Yn0AaNYUVO16qAp5kdQKYt/AwDosmMWPQPKQqe/VbTEiDzi
         H25mncsAc4PJ559bFxUR3KhyEMCQPL3sqg2AD6mPluVcdeV3ziS808UqdFJhy1GBcVCK
         SC4Cb639Z9VtIoqlHXfiE9unu2QNiE9ByCcFwcOlF8QBSSMe8oT6yLA+TdXPwB3z1kvF
         Jrjf42WzCNLPBOrv3YoGWpqcbMRgKnz3u68YzaginRPq2pOXCPWGraOcDkm0+EOknuTx
         tdDy5BLvhtkYFg4rz7m928qzwyJrXW98vJUoVBjRhhliMmizEOSl5fpoKrhu59pbnakR
         5EEg==
X-Gm-Message-State: AOUpUlEOtGLslvIBYweysyEcaO2GmQHVOxo0T9R0C5OGUvZiFH1QOqdf
        m2LMHdc1xcBbbJNZ3PNTFoXWeu6THwtwlxpPj5/OLA==
X-Google-Smtp-Source: AAOMgpd9/PTY0kNm91ly28NhmjVWgg6danbo7h0uaASx3MUPWQWYWvXcEL7r0F5aG8eI3Dli3atjTY70c06Z/iOhSDg=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr4225801wmh.116.1531502811434;
 Fri, 13 Jul 2018 10:26:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:26:30
 -0700 (PDT)
In-Reply-To: <20180713100519.pn7ium7a4ga24dys@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-6-git-send-email-joro@8bytes.org> <BEEA447A-26A1-49C9-925A-63F96E9115B0@amacapital.net>
 <20180713100519.pn7ium7a4ga24dys@8bytes.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 13 Jul 2018 10:26:30 -0700
Message-ID: <CALCETrWD7jhBarEr7r0iCN_Z8A2GvsE7VUi_4OVkQWwg8U516w@mail.gmail.com>
Subject: Re: [PATCH 05/39] x86/entry/32: Unshare NMI return path
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 3:05 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Thu, Jul 12, 2018 at 01:53:19PM -0700, Andy Lutomirski wrote:
>> > On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
>> > NMI will no longer use most of the shared return path,
>> > because NMI needs special handling when the CR3 switches for
>> > PTI are added.
>>
>> Why?  What would go wrong?
>>
>> How many return-to-usermode paths will we have?  64-bit has only one.
>
> In the non-NMI return path we make a decission on whether we return to
> user-space or kernel-space and do different things based on that. For
> example, when returning to user-space we call
> prepare_exit_to_usermode(). With the CR3 switches added later we also
> unconditionally switch to user-cr3 when we are in the return-to-user
> path.
>
> The NMI return path does not need any of that, as it doesn't call
> prepare_exit_to_usermode() even when it returns to user-space. It
> doesn't even care where it returns to. It just remembers stack and cr3
> on entry in callee-safed registers and restores that on exit. This works
> in the NMI path because it is pretty simple and doesn't do any fancy
> work on exit.
>
> While working on a previous version I also tried to store stack and cr3
> in a callee-safed register and restore that on exit again, but it didn't
> work, most likley because something in-between overwrote one of the
> registers. I also found it a bit fragile to make make two registers
> untouchable in the whole entry-code. It doesn't make future changes
> simpler or more robust.
>
> So long story short, the NMI path can be simpler wrt. stack and cr3
> handling as the other entry/exit points, and therefore it is handled
> differently.
>
>

We used to do it this way on 64-bit, but I had to change it because of
a nasty case where we *fail* the return to user mode when we're
returning from an NMI.  In theory this can't happen any more due to a
bunch of tightening up of the way we handle segmentation, but it's
still quite nasty.  The whole situation on 32-bit isn't quite as
fragile because espfix32 is much more robust than espfix64.

So I suppose this is okay, but I wouldn't be totally shocked if we
need to redo it down the road.
