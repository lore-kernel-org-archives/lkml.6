Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A9C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0550218FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dLIW1BkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfADUyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:54:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35768 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfADUyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:54:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so32899010edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgLnauOZkXoPtHurEq0Oj675WU+WR7c8BuPRsux1g84=;
        b=dLIW1BkFDXIrQxkNITRdb9L5EiSTpqzGsbIs32IbyQ3pZwjHb5l+Oqn3OwQy06lLTg
         FGqkc1s0gOCwtbBh48HEMNFjQXC7ykcc6oMr2FFIDf8x5jriybPLmS2cPQQW1GCy/EUx
         ahlfpPHwxJubS5g1bDHElcQFUQ3vylfEGZC+4F27DiutpPaxOzwZ/VXDf5v1EOU3w8xs
         SJ/DaxCmPd+3FSht8FS9Mny3qNWrXBuuI+y1AWL1nNJQoO2oY/59IggtqbS8AEoWmLsJ
         q0RcEiVnSwDbA0QUYk6gP4zJxlMO4vEnr7bWDnBBjVkZbSwWzvvs4QAVLdZ8fgWureJv
         XtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgLnauOZkXoPtHurEq0Oj675WU+WR7c8BuPRsux1g84=;
        b=mUpvoEpZHpa9+LUPNiUrdByR5HlKZV7mq/KB2Akh2BJL2coIOowexBWGq+EnYs3fSr
         Utl2t1rnuiEydJhrTWv8W+S7DilNFakKEJ/CZjZJCFzelbQ56yfAik+uCsbKaMRH8rxS
         5ON1OxqsnyRtM5eFZPPiiUWe+VFpq0KM6AwYlAJXYsZuDfQlqp0hBYT6q6zynlIC9vCY
         pxNAQ1uCg6z9nO99DB0qdYWqsVnwvRhDDPQbyvESoM1MQxK4xASpXUHgGq/+7VDIfNzL
         gjG/u+/lWV6nWXvuFy8j9cHei422U0sGiQKBK34qiBzfqOmyPqLiFkxm4AB0N/+UqQIQ
         20qQ==
X-Gm-Message-State: AA+aEWb8LCgrNKVu/qyr+6InyredN0YlKuZG4SNpOIpNB4ZFLk75RsXi
        MgkH+vjUP3YzAM6NSDUuJiCCb3F2ZOmLNleBTUkZv51HQI3PbA==
X-Google-Smtp-Source: AFSGD/WV2GWDyRSY5Vx6ILFoLgSS25PVv9o1SpyFwb649Vf3CGlvHX/6T2KnPylQxURgKy+W/spO2cCQ8lepipoebNs=
X-Received: by 2002:a17:906:1c5b:: with SMTP id l27-v6mr40169644ejg.118.1546635271379;
 Fri, 04 Jan 2019 12:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
 <20181226164509.22916-4-pasha.tatashin@soleen.com> <9fe670d4-d799-c05f-297e-437eda1d2072@arm.com>
 <CA+CK2bA_006YGu3dtJM24pN1ZGgcJZnF2oEeWKkq3QBrcCbB6Q@mail.gmail.com>
 <86bm4wbff9.wl-marc.zyngier@arm.com> <CA+CK2bCZHCp7d3SyiE2UpZr=K-NMPcGPVS0d-iU_7_tfcVmaGw@mail.gmail.com>
 <54caed52-2859-df94-1e3b-223397d42602@arm.com>
In-Reply-To: <54caed52-2859-df94-1e3b-223397d42602@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 4 Jan 2019 15:54:20 -0500
Message-ID: <CA+CK2bAMSspkLmvypqEgO-4mzNvE7JzjkkTWv7Pq-+DanZR+xw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: Early boot time stamps
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        rppt@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        andrew.murray@arm.com, james.morse@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > sched_clock() will still be strictly monotonic. During switch over we
> > will guarantee to continue from where the early clock left.
>
> Not quite. There is at least one broken integration that results in
> large, spurious jumps ahead. If one of these jumps happens during the
> "unstable" phase, we'll only return old_clock. At some point, we switch
> early_unstable_clock to be false, as we've now properly initialized the
> timer and found the appropriate workaround. We'll now return a much
> smaller value. sched_clock continuity doesn't seem to apply here, as
> you're not registering a new sched_clock (or at least that's not how I
> understand your code above).
>
> >> What I'm proposing is that we allow architectures to override the hard
> >> tie between local_clock/sched_clock and kernel log time stamping, with
> >> the default being of course what we have today. This gives a clean
> >> separation between the two when the architecture needs to delay the
> >> availability of sched_clock until implementation requirements are
> >> discovered. It also keep sched_clock simple and efficient.
> >>
> >> To illustrate what I'm trying to argue for, I've pushed out a couple
> >> of proof of concept patches here[1]. I've briefly tested them in a
> >> guest, and things seem to work OK.
> >
> > What I am worried is that decoupling time stamps from the
> > sched_clock() will cause uptime and other commands that show boot time
> > not to correlate with timestamps in dmesg with these changes. For them
> > to correlate we would still have to have a switch back to
> > local_clock() in timestamp_clock() after we are done with early boot,
> > which brings us back to using a temporarily unstable clock that I
> > proposed above but without adding an architectural hook for it. Again,
> > we would need to solve the problem of time continuity during switch
> > over, which is not a hard problem to solve, as we do it already in
> > sched_clock.c, and everytime clocksource changes.
> >
> > During early boot time stamps project for x86 we were extra careful to
> > make sure that they stay the same.
>
> I can see two ways to achieve this requirement:
>
> - we allow timestamp_clock to fall-back to sched_clock once it becomes
> non-zero. It has the drawback of resetting the time stamping in the
> middle of the boot, which isn't great.

Right, I'd like those timestamps to be continuous.

>
> - we allow sched_clock to inherit the timestamp_clock value instead of
> starting at zero like it does now. Not sure if that breaks anything, but
> that's worth trying (it should be a matter of setting new_epoch to zero
> in sched_clock_register).

This is what I am proposing above with my approach. Inherit the last
value of unstable sched_clock before switching to permanent. Please
see [1] how I implemented it, and we can discuss what is better
whether to use timestamp hook in printk or what I am suggestion.

[1] https://github.com/soleen/time_arm64/commits/time
sched_clock: generic unstable clock is a new patch, the other patches
are the ones sent out in this series. Because we use sched_clock() as
the last value calculating epoch in sched_clock_register() we
guarantee monotonicity during clock change.

Thank you,
Pasha
