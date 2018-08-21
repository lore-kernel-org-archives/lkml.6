Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF5BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92E9208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvdurBXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92E9208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeHUTrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 15:47:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39747 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeHUTrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 15:47:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so8742200pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ouEEFtL34t4lmoUV4w9FNto9ZND3NS+XFxkeGKaWn8=;
        b=kvdurBXhM8n4C/qkyfA+L26OwpcbFGKjutCUXRK0/Rw7scLymyn2pop2IoQvKCECl3
         osWwZQld8FoYtMl8Je6kUGLq65mPAfRxHzxFSr/SxCM2CsKqOYwylWqKu0tXWf7tw8No
         1DeowwODccI4+fn2RR6CkNN//ZEugSIFflEWOyvUfIdN8MBZNGX0f8UW+BhGs6NxE0MF
         WLX89KccmhwkuIcs8H6+kKUAliI4SzUEOav43vztJDm2TyTgQRO5kcbTSwCU9YaVpF+y
         bwdXbO4z5Cy4FIaqBI9zVXwZeoIJSIVmXXvhVJiq8y/+n7nyaetxCq1cQ8WH0QZdan0e
         H/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ouEEFtL34t4lmoUV4w9FNto9ZND3NS+XFxkeGKaWn8=;
        b=mqI3wg604aucM2jpB4XcBqvPEu6pcqfbkntwW1evKaXFgC25Knm7b2GjYJC4/OXWFP
         B/0lOHRVj7t/SzcZnx2hykaO1yS8W/IM/ltweXtDmVkC3AUtS2xbicCT7qyhqy4PBVBA
         IP2psvP6TNm98jeV5X6AhPmAYubLSzRjS+sconXKOx0W+2mmLtZDIEgWDyQ6MY5L774N
         G+06xfXJqsXFE4mdC+PSMvP9LJyxznA7/LWe7V4cn711KC91tSAqwi600Yuq1X9S7zUl
         kdonNgzLPmneDgagaIbK/9vCz9DWaW/8rCXKOUtDJJ9BLB+CXaJO4hY00Jn+HyNq3a75
         tpoA==
X-Gm-Message-State: AOUpUlH0ueGRJNJZYvp3wE1QY6hNIsDZ80XSfhQy9w/1IYFmZICIun9v
        8MCxWThqQoNTx2MEC0BPkpAn4AJOJOi4EhCHGevf4A==
X-Google-Smtp-Source: AA+uWPzXoz/dTyVwk2HT3ahhWfFNxT/HqiWg8/ygMfbNYzyfca60b5xD2Nyxph2k8BqhseH70/pUtchDJ1LYoZfSwxU=
X-Received: by 2002:a63:c24c:: with SMTP id l12-v6mr20663500pgg.255.1534868796039;
 Tue, 21 Aug 2018 09:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180801210804.175176-1-ndesaulniers@google.com>
 <CAKwvOd=WZB=x86zqu=vFDoJgpWnfCj0K3qXv14vtysfv3ioi1w@mail.gmail.com>
 <CAKwvOd=qGTv1F3CsEeNjuJ93BD9zTnUekUHgvw4Ttpx7us5JdA@mail.gmail.com>
 <CAKwvOd=U0aMsUmBytK7vq=ORj+Npw7FqZ50EMEJPnmTG15N7dg@mail.gmail.com>
 <CA+55aFxHtbq=X9Jaes1qwVAhu5mx0eTahUjd7ijxgW44JjFaYQ@mail.gmail.com> <87bm9v28rh.fsf@xmission.com>
In-Reply-To: <87bm9v28rh.fsf@xmission.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Aug 2018 09:26:24 -0700
Message-ID: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
Subject: Re: [PATCH] x86/kexec: prefer _THIS_IP_ to current_text_addr
To:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, Simon Horman <horms@verge.net.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>, x86@kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 5:40 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Mon, Aug 20, 2018 at 10:58 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> >>
> >> + akpm, Linus
> >>
> >> Bumping for review.
> >
> > Ugh. I am not personally a huge fan of this endless "fix up one at a time".
> >
> > Just do a patch that removes current_text_addr() entirely and be done
> > with it, if that's what we want the end result to be.
> >
> > Don't bother with these small "let's remove the remaining ones one by
> > one". Just get it over and done with.

Linus,
No problem. Will send a V2 that rips off the band-aid.

I explained my thoughts on the process more in
https://lkml.org/lkml/2018/8/1/1689, which akpm agreed with.  I was
hoping that I wouldn't have to bother you with a tree-wide change, but
if code review takes 3 weeks...

Also, I was hoping to save the small but many clean ups as starter
patches for some newbies that we're asking me how to get started
contributing to the kernel, but I can find other good first bugs for
them.

>
> One is generic code the other is assembly but the both appear to do the
> same thing without unexpected complexity.
>
> That said the patch earlier in this thread has clearly never been
> compiled as it is using THIS_IP instead of _THIS_IP_ and there is not
> a define of THIS_IP in the kernel.

Eric,
Please triple check your email client or whatever you're using to
download patches, as I suspect one of them may be stripping
leading+trailing underscores.  That would be quite problematic for
code review or applying patch files.  I've seen some text renderers
treat the underscores as markdown and italicize the contained word.
https://lkml.org/lkml/2018/8/1/1608 shows the underscores.

-- 
Thanks,
~Nick Desaulniers
