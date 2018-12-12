Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEDCC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D232086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hd6qsrUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D232086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeLLM54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:57:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34311 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeLLM5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:57:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so13465217lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 04:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJI5mXglmLLeuDuDIzwfHoLpvAjlwOEXgpe3x/GSLAg=;
        b=hd6qsrUyz2giHhN6yPGD9k+1rv0T2CiaPR+E7WKv+Cu7V55U6tIT4dtpllK+ir7bjc
         I9hKIT3/hTrAxWv8pwuFJhkuDaaeUtz7HYfzweajtkWhnwcfHXwS53p8LGOOfsYKZvhL
         ja7joUgFkucs+zQYFIjFysIlZPwMz3MP73x9zWk6I/hiud7ST4qAB4eEtowoZGRsKgtl
         UbywYEC+r5B41OrKaP13QxX4M9vUnrkCoM+pzzO7Ck18fLsajEiqYlK3uCgh9jhBwxKI
         lsGiO4G5a18XNRaTEm4gJRiT82SnL0/TaG2BhowO0+vLpplJBCxEOLhUqOYs1R/R4d53
         W/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJI5mXglmLLeuDuDIzwfHoLpvAjlwOEXgpe3x/GSLAg=;
        b=cBAsVJyGbu3BzLLg7+2wZ33hlciVbf2Dk7bUv6htvqMs9gBQWMiZs0Lsi5NOwKCcyG
         G9Kt68b3uG4inZRUj70BR3lhlxxAWUoeF6TdV+07oDvdeKTq2yCm9YNQ2kO/KFLmhC2Q
         vLS+z4p056MRNVsB47yzvmltkGik1GhKmsoSpoRXBYh3fOSZAkhltW8+8acNfDdDy1QD
         8UrZhnWcaDejrAH6S9W22UPwnSEFMm1f0VvBlClfj/NWKU+v48vU5EQ7rGjYZy7VWd3z
         M2QCsALLlTFzMb0pKlylCG+uEQr2V6IzWHgZrqSxNUd+CB80VYdvbwyTM+9rifgpqlh4
         KbsA==
X-Gm-Message-State: AA+aEWaOsubNqFr0Y3NGMynD21DajrtV8ktkqDkIlLscpo1/bPnAtkB5
        d1lPiE12CI3O0LyHHUt19vs0GbpM7PkxwRhh1E4t
X-Google-Smtp-Source: AFSGD/W0ZrWglJ+0kOnL+KTibbBA6QozhY/11TtmWZdvvuYhaslljkRdQ1PeHxFobmB7j/1m15pkOCVb332SBXLDuJk=
X-Received: by 2002:a19:5402:: with SMTP id i2mr11312177lfb.128.1544619473447;
 Wed, 12 Dec 2018 04:57:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <CAHC9VhRqMt2k+pL7YF0MaZQfXZzttyHAXBJhHH56Mvswii4EKg@mail.gmail.com>
 <20181211224107.vdeksnc5bd5bb7mb@madcap2.tricolour.ca> <CAHC9VhSkKqdm=q5r4Y0-kEg2j84-AG5omo6frfORXVcJ_orUaw@mail.gmail.com>
 <20181212024511.iftyuvwueh2mbolb@madcap2.tricolour.ca>
In-Reply-To: <20181212024511.iftyuvwueh2mbolb@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Dec 2018 07:57:41 -0500
Message-ID: <CAHC9VhQMpXQ6H6+e0D=zLkaCvMgqysa6NjzJDoWsZuqm5fEzmw@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 0/4] audit: config_change normalizations and
 event record gathering
To:     rgb@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, viro@zeniv.linux.org.uk,
        sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 9:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-12-11 18:26, Paul Moore wrote:
> > On Tue, Dec 11, 2018 at 5:41 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2018-12-11 17:31, Paul Moore wrote:
> > > > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > ...
> >
> > > > > Richard Guy Briggs (4):
> > > > >   audit: give a clue what CONFIG_CHANGE op was involved
> > > > >   audit: add syscall information to CONFIG_CHANGE records
> > > > >   audit: hand taken context to audit_kill_trees for syscall logging
> > > > >   audit: extend config_change mark/watch/tree rule changes
> > > > >
> > > > >  kernel/audit.c          | 33 +++++++++++++++++++++++----------
> > > > >  kernel/audit.h          |  4 ++--
> > > > >  kernel/audit_fsnotify.c |  4 ++--
> > > > >  kernel/audit_tree.c     | 28 +++++++++++++++-------------
> > > > >  kernel/audit_watch.c    |  8 +++++---
> > > > >  kernel/auditfilter.c    |  2 +-
> > > > >  kernel/auditsc.c        | 12 ++++++------
> > > > >  7 files changed, 54 insertions(+), 37 deletions(-)
> > > >
> > > > In order to make sure expectations are set appropriately, as we are at
> > > > -rc6 right now this is not something that would go into audit/next now
> > > > (assuming everything looks okay on review), it would go into
> > > > audit/next *after* the upcoming merge window.
> > >
> > > I agree it is a bit late for this.  I wasn't expecting it to go in this
> > > one.  I'm filling the queue since I'm blocked on other review for
> > > ghak81(5.5wks), ghak90(5.5wks), ghak100(3.5wks).  ghak90 missed another
> > > merge window.
> >
> > As discussed previously, GHAK81
> > (https://github.com/linux-audit/audit-kernel/issues/81) is something
> > that I consider part of the audit container ID work (GHAK90).  I
> > believe it's time to stop treating it as a separate issue.
>
> Fine by me.  It was included in the ghak90 patchset this time and still
> is in v5, waiting to get the questions replied to that arose out of the
> review of v4 around Hallowe'en.

If you knew ([1]) I didn't want GHAK81 treated as a separate issue,
but instead included as part of GHAK90, why did you bother separating
it out in your latest nag emails?

[1]I didn't feel like digging through my sent mail to find out when we
discussed this last so I could include a passive aggressive date, that
exercise is left to the reader.  I'm sure you'll understand.

--
paul moore
www.paul-moore.com
