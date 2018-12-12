Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9527C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEA72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544609837;
	bh=W1GBO3GeYTuu4M845xp+iEJqGRKWnNJREo2As80UdBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SMh4GWx1c8Jy5At7xm8By1EEV0m5k5S1M4uJ3QCt8K94e7YxvQ/JCwc/pEhZz4mdA
	 EMg5pLSxiggXduLXPq5vgCl8tllIrDcWBQnJ/O7kpRMq0WIOJkVCS+5zqz2a2XFlg1
	 Z+AdlQn5lxwYJRLh6kFGTRf4sGEU3yDqTXH5HQfk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEA72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeLLKRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:17:16 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38623 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeLLKRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:17:16 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so14567532oii.5;
        Wed, 12 Dec 2018 02:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+10hSmsp/rU+JVU4vz4Ml32VNDJmF0tfJ0D2i4zNYI=;
        b=VUbD18BuMN+5yKQtMBqeItr8SBZRgD/NOPbuB57Snw1Ti8YxZj9C2QDmfBuaYPZyyt
         FPape202iASbEX3s1D4vv2/1pjImVkFxwHZh1o6XIPlwienEyTDjdJCy3py1rihykyja
         +ejKX4IwtYkKWofGVQAohQK6626+5ZMDPOjKR2bGkULrPGQlt5s+7qZnRfjFSynwNgdJ
         7vr3xlROGEpR5h3aV/OoAUYw0Fn6pBrbe+b88X8/NQIa6BJ/ZKKXriJLNvzacy3fjaIW
         dDX/FaDOBoEEtNYAmudR8v51QUZfUhEn4pXCaXqh9YakeyPXckPgYgMPueMnWQsym/1l
         NZfQ==
X-Gm-Message-State: AA+aEWZvy9D9UtPYKJLmlOgz/FZe7K1oYoJcqJ+fvyWnzoYikmn+zDnv
        Wdo66CNQ7Aa7/CvIAwvjtSWXpqEHorHHOqqkxqg=
X-Google-Smtp-Source: AFSGD/VrLgbXWacibdAHZsorj8esS1nhqBbscoC1DPJkRVArvsHs8ycUZfv9/1JhNlyvK+zYfPkik7JH+aOUUWUpLtE=
X-Received: by 2002:aca:368a:: with SMTP id d132mr52537oia.193.1544609835322;
 Wed, 12 Dec 2018 02:17:15 -0800 (PST)
MIME-Version: 1.0
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <20181210122104.GL5289@hirez.programming.kicks-ass.net>
 <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com>
 <20181210225134.GB24811@worktop.programming.kicks-ass.net>
 <CAJZ5v0jvbDCCgy=nUfb-yZCYGOxe4-XexbvnmeBm8ZPDPBaK4w@mail.gmail.com>
 <20181212094610.GW5289@hirez.programming.kicks-ass.net> <CAPDyKFpPGosZ69ZgMZMASGZxTn1kxu5GrJ7rZoXKn8MC05SMTQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpPGosZ69ZgMZMASGZxTn1kxu5GrJ7rZoXKn8MC05SMTQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Dec 2018 11:17:03 +0100
Message-ID: <CAJZ5v0gNqUO59_xQAdk-rVR6JJCZ4RfHbNJOUuBWSyy6yN6pjw@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:57 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 12 Dec 2018 at 10:46, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Dec 11, 2018 at 10:51:48AM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Dec 10, 2018 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > Dunno; it could be cold cachelines, at which point it can be fairly
> > > > expensive. Also, being stuck with API is fairly horrible if you want to
> > > > 'fix' it.
> > >
> > > All of the cache lines involved should've been touched earlier in this
> > > code path by the governor.  At least menu and the new one both touch
> > > them.
> > >
> > > The API part I'm not too worried about.  I know it is useful and two
> > > other people have told that to me already. :-)
> >
> > Like said on IRC; I mostly wanted to raise the issue of overhead due to
> > stats and ABI -- it's something I've been bitten by too many times :/
> >
> > If you're confident you're hitting the same lines with the already
> > extant accouning (time and usage) and you cannot make the whole lot
> > conditional because of ABI (bah) then I'll not stand in the way here.
> >
> > I agree the numbers are useful, I'm just weary of overhead.
>
> I tend to agree. So then why not move this to debugfs, it seems like
> it's really there it belongs. No?

The "usage" and "time" counters are there in sysfs already and they
are ABI, so putting the new ones into debugfs only makes them harder
to use for no real gain.
