Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDE1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7772084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cbUbkuIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfBUQLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:11:24 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42780 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfBUQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:11:24 -0500
Received: by mail-ua1-f66.google.com with SMTP id d21so9725025uap.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccZQK5lkR0ntVe8r4wno0Ba7GkyoiaG7NSnztmD7HNI=;
        b=cbUbkuIY3IR9D+xAAD7lr4gBDCZv3CzNmA7AFdOWzgm6e8opYVtS1n3pa3tA5cFbD8
         mUvB+dl0TWE+j7g97KrA+EEATSxLrm7k6sGdrq7DsLDP7wK0veKNaIw6Y3/0yDFDrfng
         0LjFc2Q+IoVOt/m9T1vtEtXZdsLI27qP0z72I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccZQK5lkR0ntVe8r4wno0Ba7GkyoiaG7NSnztmD7HNI=;
        b=sZcw5JjsiCeiXpt8RBW6DJfcFyWaU1o0iwdlSfaA8gCC+26goWEPBoGTuG9JfFDm25
         F1JLQQZ4JBtjV4YDPs7jbo2w4QfSKipHQh7ZdSVsEaJ+37SX9+aCTa9/d29y/UM9HwKW
         kNismKes/ZIUb0abFhiZOkGyf9Sa2GooipKF/6RMAye7i6WgDUWQjtKOtVGopWkio2/y
         JqWSNJLxqQnsqA5rUOasOyMvtvRtQEkOmunm8/tza4MuNIYVXhtRmYUvknZBtmGZqSxa
         za9GsWav/vspGbJZ3sf72ZFGSCa/q0Jl0AwPGQFxiWCeXDsZMTY5ZwmfolACAtCZZL42
         9v/A==
X-Gm-Message-State: AHQUAua4o1SefsAq261PFo+2ITPPPHVClnoqfli7d7VF7o0yrQZ4/+Eb
        6SrhD2QTWW7E0/1caQm38Wv16I30xgs=
X-Google-Smtp-Source: AHgI3IZScrr6oNUOCFDjFeN59g1dORV9ck5SsJNMwDRFtaC2n6iTHjYTz2yXfeaZM5GFNc8CFhLzKw==
X-Received: by 2002:ab0:2bc9:: with SMTP id s9mr20286219uar.91.1550765481843;
        Thu, 21 Feb 2019 08:11:21 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id t133sm20471118vsc.8.2019.02.21.08.11.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 08:11:21 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id z11so9724177uaa.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:11:20 -0800 (PST)
X-Received: by 2002:a05:6102:d2:: with SMTP id u18mr13546244vsp.172.1550765480348;
 Thu, 21 Feb 2019 08:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20190220180934.GA46255@beast> <20190220184859.GA6429@openwall.com>
 <CAGXu5jLB=so4r169pq1KF3Kyfh2Kw_t6ZXGavpzVO2sg3=D1tw@mail.gmail.com> <20190221130645.GA8281@openwall.com>
In-Reply-To: <20190221130645.GA8281@openwall.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Feb 2019 08:11:08 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ46whob0-DE1_dydRtoNAN0Lw7EUsnNvNyQzwt_g9iEg@mail.gmail.com>
Message-ID: <CAGXu5jJ46whob0-DE1_dydRtoNAN0Lw7EUsnNvNyQzwt_g9iEg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/asm: Pin sensitive CR4 bits
To:     Solar Designer <solar@openwall.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 5:06 AM Solar Designer <solar@openwall.com> wrote:
>
> On Wed, Feb 20, 2019 at 01:20:58PM -0800, Kees Cook wrote:
> > On Wed, Feb 20, 2019 at 10:49 AM Solar Designer <solar@openwall.com> wrote:
> > >
> > > On Wed, Feb 20, 2019 at 10:09:34AM -0800, Kees Cook wrote:
> > > > +     if (WARN_ONCE((val & cr4_pin) != cr4_pin, "cr4 bypass attempt?!\n"))
> > > > +             goto again;
> > >
> > > I think "goto again" is too mild a response given that it occurs after a
> > > successful write of a non-pinned value to CR4.  I think it'd allow some
> > > exploits to eventually win the race: make their desired use of whatever
> > > functionality SMEP, etc. would have prevented - which may be just a few
> > > instructions they need to run - before the CR4 value is reverted after
> > > "goto again".  I think it's one of those cases where a kernel panic
> > > would be more appropriate.
> >
> > It will not land upstream with a BUG() or panic(). Linus has
> > explicitly stated that none of this work can do that until it has
> > "baked" in the kernel for a couple years.
>
> OK.
>
> > In his defense, anyone sufficiently paranoid can already raise the
> > priority of a WARN() into a panic via sysctl kernel.panic_on_warn (and
> > kernel.panic_on_oops).
>
> I think there are too many uses of WARN() for anyone sane to enable
> that in production, whereas it'd have made sense to enable it for the
> few security-related uses.

Yeah, that's been my thinking too. I've been thinking about this for a
while trying to decide if we need something between WARN and BUG, but
I can't make up my mind. ;)

> > > Also, WARN_ONCE possibly introduces a delay sufficient to realistically
> > > win this race on the first try.  If we choose to warn, we should do it
> > > after having reverted the CR4 value, not before.
> >
> > Isn't cr4 CPU-local though?
>
> Good point.  I don't know.  If CR4 is per hardware thread, then the race
> would require an interrupt and would be much harder to win.
>
> > Couldn't we turn off interrupts to stop the race?
>
> This won't help.  An attack would skip the code that disables interrupts
> and land right on the MOV instruction.

Oh duh, yeah. ;)

I think v2 is good enough given the constraints we've got.

Thanks for looking at it!

-- 
Kees Cook
