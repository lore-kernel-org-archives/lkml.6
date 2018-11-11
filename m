Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 02:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3793E208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 02:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJvKvf9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3793E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeKKMml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 07:42:41 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52021 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeKKMml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 07:42:41 -0500
Received: by mail-it1-f193.google.com with SMTP id m34-v6so8245235iti.1;
        Sat, 10 Nov 2018 18:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTyNuN8MZTipfWOODnXrtnM9yGVyfkbbBg+9y3SBRhk=;
        b=vJvKvf9C34/AGLDFmS8StW3/hVqXuDNtCQnoS0PujSBNG76D7/BYOmbLUR+oHhPja1
         84jSKxFHkJ+k1WHJMuJ3Q8TKaq15sQJtBheSd91mtuLvhJL7WC9yM6KUghbeGSr0Bdny
         OZARs47zAOGs00ObFfk7HlHntW6KYpJcIOmh4zNIAEtaHSP0wZ9yiBNYpmRtBXKcoOGM
         jAPzHoN3GTfMY1AHyKM+aFw1cAqvwrwMQoMhkSe1VEdCMUchRmA1tZ5N0ID1sZ3OhN9+
         12VsZYWZlZ2wIwe+yay4zFzPz6kUX+6d6gM8BmoinKX7EDlZp0vxFV7cHRe2avkxy9D1
         ZdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTyNuN8MZTipfWOODnXrtnM9yGVyfkbbBg+9y3SBRhk=;
        b=WtyaDzpHvKkpIJhz1hvAh9E/Y3gHMdc04M/kP3aJnOJmjoVgoTcLzyKBfvGolgjkpf
         GAKWflZmaibuECyuqEn18qzQyq+rCQ6OntvDvtgLBBz3vxxzDVE+U9dheplny8X+aYoR
         3/nQIKFGZFFgOvHBVFLmgHQuhgyR0USy8TftffMSSXWhkJqQ501UDnQ1NZ9hcFp3z+uA
         zZlpqmAno2IGDdn1SSeMO8QIkXuQfiXSk/9AE99B/iOnyvFmClEIlLh4xTIrYwZG8yFU
         MliSDmZ03+CD/8OjsveEKuyc+aZRZOmzafc5y7SPUBWR4SIHjqA7dJPhHAOlbhmvUx/A
         DAPw==
X-Gm-Message-State: AGRZ1gIT+4kjl6y6ONBK2JeeWDkrDdEQSWcxYEkweTBUTHxbnfmCx7kP
        y+HWFdFMAYdr5RS6iA9zfHUgk25nBOqHDTofiwo=
X-Google-Smtp-Source: AJdET5cTYTfi1b8ROMhdpcj53B9rO33++82YX4ucsheXdm+UgsGNdFYR7NXzNmIzsdebsH2HKt84j7zTAu30LhDRAh8=
X-Received: by 2002:a02:5543:: with SMTP id e64-v6mr8105399jab.113.1541904930803;
 Sat, 10 Nov 2018 18:55:30 -0800 (PST)
MIME-Version: 1.0
References: <2335309.gnWok9HYb4@agathebauer> <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava> <3799078.YBnU1OB0PF@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com> <CAOBGo4za8hnGt1NUWy1Y1V12WycbxbYP0G0Sm=UT7T9dQ88vDg@mail.gmail.com>
 <20181111010702.GC6218@tassilo.jf.intel.com> <CAOBGo4zirLiKX8VcROAE=kAD0+qkF0E-cBv9DtBiQr=_obDv5w@mail.gmail.com>
In-Reply-To: <CAOBGo4zirLiKX8VcROAE=kAD0+qkF0E-cBv9DtBiQr=_obDv5w@mail.gmail.com>
From:   Travis Downs <travis.downs@gmail.com>
Date:   Sat, 10 Nov 2018 21:54:54 -0500
Message-ID: <CAOBGo4wmMEP_uy8dHh3UvXShHDPBuac=EwJ+HqJfpuzzQRoL=g@mail.gmail.com>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
To:     ak@linux.intel.com
Cc:     Milian Wolff <milian.wolff@kdab.com>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 8:07 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Sat, Nov 10, 2018 at 04:42:48PM -0500, Travis Downs wrote:
> > I guess this problem doesn't occur for LBR unwinding since the LBR
> > records are captured at the same
> > moment in time as the PEBS record, so reflect the correct branch
> > sequence.
>
> Actually it happens with LBRs too, but it always gives the backtrace
> consistently at the PMI trigger point.


That's weird - so the LBR records are from the PMI point, but the rest
of the PEBS record comes from the PEBS trigger point? Or the LBR isn't
part of PEBS at all?

>
> > What would this fix mean for perf report when you use cycles:pp and
> > cycles:ppp (or any PEBS based events)? The unwinding should generally
> > work, but the IP at the top of that stack (from the PMI) will
> > generally be different than that recorded by PEBS. The tree view and
> > overhead calculations will be based on the captured stacks, I guess -
> > but when I annotate, will the values I see correspond to the PEBS IPs
> > or the PMI IPs?
>
> Based on PEBS IPs.
>
> It would be a good idea to add a check to perf report
> that the two IPs are different, and if they differ
> add some indicator to the sample. This could be a new sort key,
> although that would waste some space on the screen, or something
> else.


In the case that PEBS events are used, the IP will differ essentially
100% of the time, right? That is, there will always be *some* skid.

>
>
> It wouldn't be cover all cases, for example if you have recursion
> on the same function it might report the same IP even though
> it's a different instance, but I presume that should be rare
> enough to not be a problem.
>

Well the main problem I see is that "IP inconsistency" will be the
usual case, and it will be hard to resent in a reasonable way in the
report. For example, the backtrace-based displays/reports may indicate
that 80% of your samples are in function X, but based on the PEBS IP
records, only 50% may fall in that function, so you'll always have a
weird thing where when you are investigating within the stack-display
you might see 1234 samples in a function, but when you annotate only
789 samples are accounted for, or whatever.

I don't think this is 100% solvable, it's mostly an issue of
displaying it reasonably and managing expectations.

If the LBR record came from PEBS (as I had thought, but perhaps you
are indicating otherwise above), I could imagine a hybrid mode where
LBR is used to go back some number of calls and then dwarf or FP or
whatever unwinding takes over, because the further down the stack you
do the more likely the PEBS trigger point and PMI point are likely to
have a consistent stack.
