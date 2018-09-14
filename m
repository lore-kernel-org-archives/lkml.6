Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B751C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD5820853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iTfu1seN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD5820853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeINIV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:21:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43621 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeINIV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:21:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so6571417lfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 20:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zV0E11/9LhPWNRkhTaAWrfVN37Gj+T7MZnhY2lzUbYQ=;
        b=iTfu1seNzE0ZdQvosj5RjqBjzAGq3yFPWMLA6V8/TJMbd4puj+lqhAqOYDxOjy4soY
         AcslJzJEySX/byw7pIOWR3tMV5OzPDuqH2aKhIfjxSHJyCOcmAih4L99zmQ7gPTOYew3
         of1+VCv2UrZPyA4KbOnZv7+hU+ko3wbG5qh7vzAZVM46xgrZuzCmvV2LuoNYQ+7P+ppn
         v08GITwxqx78yrUcKEy9gqPHQW8Hj12pC+ToMVvqdsXbfPPIR5jG5b8JZuHfobpVMbJg
         hprXy2SRKB8ktaSSrlQC6rCw0+aeosHwEJ6YU8TvZ0MaeBx2LnNc3LctwNPNWwNYMdF4
         w/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zV0E11/9LhPWNRkhTaAWrfVN37Gj+T7MZnhY2lzUbYQ=;
        b=igc2+YI4UROW/nuoQG49ogTyToIQZaCDfc1kN4gCkBZ92/9KM2F5SkePxFMQG0ysQp
         DFg66Jpd5exRGaA7D5Zw5bMz5aTAjAwzkGM7lwksziuS8lQlvHab0dbe0zM2hukhwuiZ
         U5e7HGmBVwGDqvyPp4ZEu/RjKk/v0SjcHzksvZJHcaK7F9wgqTI19QuKjdj9Pe6fU1yO
         e8Li0bqhqCwAoOi0RhPiHS1sxFeXeU92tKPyF9Rl0/VsvOFNWOwCslFMtfFUUnCV7KPp
         cryyMB/lKhRSSTGhYFe9zZ70cOHHOJ9qIW6aN+euk5Q39Af6DvYzpm5MeAVG0d/uQqD9
         2jbg==
X-Gm-Message-State: APzg51BnBKXVeZ1lOHZTfiCDnYHfqEml/n7Js9t+HBq/7dUctpjpr7C1
        1U45reB5EG6su9SezF2WEmL4/DC4lWrDYql9M8UA
X-Google-Smtp-Source: ANB0VdaPc1UPVjrXhokGp7ZVUva0vlQqjrDytSozUr0kegRDLicjQLjOFTIOqvdffi6PjwVG6gvzgIFxxJhoo6UfSEs=
X-Received: by 2002:ac2:410d:: with SMTP id b13-v6mr689178lfi.19.1536894574455;
 Thu, 13 Sep 2018 20:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180827075020.GL27091@localhost>
 <CAFqZXNvADB-E_fjEaQpUymSVvfP-vXQXtk3K+nJ9DqrScHL8bQ@mail.gmail.com>
 <4819575.TSNxuEWROA@x2> <CAFqZXNtzSU0KjFwYzqJCQybEvJz1GhQZHxRfJ2hj=6o_RGGLLA@mail.gmail.com>
In-Reply-To: <CAFqZXNtzSU0KjFwYzqJCQybEvJz1GhQZHxRfJ2hj=6o_RGGLLA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Sep 2018 23:09:23 -0400
Message-ID: <CAHC9VhQwPsK1PJ=wiiG-jt-e5SXoBr0FeaL9dP=7kn2SUftDXQ@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     omosnace@redhat.com
Cc:     sgrubb@redhat.com, mlichvar@redhat.com, linux-audit@redhat.com,
        rgb@redhat.com, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Aug 27, 2018 at 6:38 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Monday, August 27, 2018 5:13:17 AM EDT Ondrej Mosnacek wrote:
> > > On Mon, Aug 27, 2018 at 9:50 AM Miroslav Lichvar <mlichvar@redhat.com>
> > wrote:
> > > > On Fri, Aug 24, 2018 at 02:00:00PM +0200, Ondrej Mosnacek wrote:
> > > > > This patch adds two auxiliary record types that will be used to
> > > > > annotate
> > > > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > > > been changed.
> > > >
> > > > It seems the "adjust" function intentionally logs also calls/modes
> > > > that don't actually change anything. Can you please explain it a bit
> > > > in the message?
> > > >
> > > > NTP/PTP daemons typically don't read the adjtimex values in a normal
> > > > operation and overwrite them on each update, even if they don't
> > > > change. If the audit function checked that oldval != newval, the
> > > > number of messages would be reduced and it might be easier to follow.
> > >
> > > We actually want to log any attempt to change a value, as even an
> > > intention to set/change something could be a hint that the process is
> > > trying to do something bad (see discussion at [1]).
> >
> > One of the problems is that these applications can flood the logs very
> > quickly. An attempt to change is not needed unless it fails for permissions
> > reasons. So, limiting to actual changes is probably a good thing.
>
> Well, Richard seemed to "violently" agree with the opposite, so now I
> don't know which way to go... Paul, you are the official tie-breaker
> here, which do you prefer?

The general idea is that we only care about *changes* to the system
state, so if a process is setting a variable to with a value that
matches it's current value I see no reason why we need to generate a
change record.

Another thing to keep in mind, we can always change the behavior to be
more verbose (*always* generate a record, regardless of value) without
likely causing a regression, but limiting records is more difficult
and more likely to cause regressions.

-- 
paul moore
www.paul-moore.com
