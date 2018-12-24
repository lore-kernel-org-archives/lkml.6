Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E86C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8133721850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="eQLUhoZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbeLXSNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:13:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45675 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:13:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so12155220wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3tJJaN+0nHjG6o3hT/fiL3K5Igl+3VTS4TCm9SH/w8M=;
        b=eQLUhoZcwHlCJRuLr12+R2kvebMCYP/Yn74sw1Pe3060DXFy+U99Db6GhQULDK3ePH
         0jkEKzDkRn4IewaqfRyU3obH/noRkdSb3cVjEumqXEahFmwKcI1LAsvGbAXuNAuAbzww
         kEVoQWxnh4yNs1LqGUuPLBF96tmpm7bNVaQdVHb4WXOn40624rcFSTrvjO/82RplYfG3
         90H9Daoi9lLLwvWlsyH1t28JKrhldggHWBXxvqZgvk8yqgFeVjYm1cqFWyoekmwQNhP0
         jkFTHyRp3SHgk5YPK41JlPHXahGLqPmLcVeRn7am7FCR+ZwV27F39laXqYEPWcbI2STJ
         TmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3tJJaN+0nHjG6o3hT/fiL3K5Igl+3VTS4TCm9SH/w8M=;
        b=Fu3u8efkzX7/Ef98ZRlYFuoc6oBzbmbE8velOsFlFBdWI1HIiWQwTy4JrOvyOco6qV
         q0f6RK5p0cJNnfKvGy2+U9aJ126JuP96n5mnWPhkFVHSalcMA4vtrzxY5dvXbWEcmTMI
         FXJ/ohWrY3umFVD5PyLHKXIUF/tdYABhxSt1fXF+nob3razUmoty3eQsAgiu/XVAafsb
         tkMZCBcwXX0Q+EooYe3mTsC2JiO/8C2nsD3zGtcsUOG0ffphyekR0R/17yv62XGSYLER
         TdJnjOi1T7rVUrQkBhCWfjIMZR5osOQD/BTWN1oUpmSH4NHk8y+UKkaL77tNjTXsf7zQ
         O0Pg==
X-Gm-Message-State: AJcUukdqJmwXBOsCyH9gKK/ay5MOYySACBNDMNZuAgMYJqBRaCyyFrHO
        NfmBg+qMpFrIfwow/LiuvTcfBg==
X-Google-Smtp-Source: ALg8bN5sq7Eu/060VJahDDuYpJpOg1xEQmfhtD5AisjRjJsr/N9JNson/kGVlXPaxbvkAS/q2b06Vw==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr13410981wrq.175.1545675210979;
        Mon, 24 Dec 2018 10:13:30 -0800 (PST)
Received: from brauner.io (p5B2A6FBE.dip0.t-ipconnect.de. [91.42.111.190])
        by smtp.gmail.com with ESMTPSA id i186sm23515627wmd.19.2018.12.24.10.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 10:13:30 -0800 (PST)
Date:   Mon, 24 Dec 2018 19:13:24 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Gabriel C <nix.or.die@gmail.com>,
        Marcus Meissner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181224181322.n7n6d2y63gwnv7cb@brauner.io>
References: <20181223164954.hib4lbchftspidsd@suse.de>
 <20181223171703.s7jm6fkyosnsf33z@brauner.io>
 <20181223180609.GA102606@dtor-ws>
 <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
 <20181224091703.GB26796@kroah.com>
 <CAEJqkgj2EjQq_aaspRs7uyTL4LxC9dRUTheN25H+QhjkLjjpjQ@mail.gmail.com>
 <20181224105407.GA29719@kroah.com>
 <20181224173427.GA254245@dtor-ws>
 <CAHk-=wiTE+k8WkHoDLzxX2Qz8ko7W+BsXOhirS_j0FZaBMxDdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiTE+k8WkHoDLzxX2Qz8ko7W+BsXOhirS_j0FZaBMxDdA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 10:06:54AM -0800, Linus Torvalds wrote:
> On Mon, Dec 24, 2018 at 9:34 AM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Well, it appears that we can no longer extend uevent interface with new
> > types of uevents, at least not until we go and fix up all
> > udev-derivatives and give some time for things to settle.
> 
> How about having the users "opt in" for new events some way?
> 
> Do all the legacy events by default, but then if some user wants a
> "bind" event (or some other new event) add a model for the uevent
> interface to actually enable it.

So one possibility is to add a socket option for lib/kobject_uevent.c
that can be set via setsockopt. We did something like this in netlink
for strict property and header checking without breaking backwards
compatibility. That might be an option:

commit cd7f7df6ca3366be4ac79e824fdaa8d482270015
Merge: 272a66173bbc 8c6e137fbc7f
Author: David S. Miller <davem@davemloft.net>
Date:   Mon Oct 8 10:39:06 2018 -0700

    Merge branch 'rtnetlink-Add-support-for-rigid-checking-of-data-in-dump-request'

    David Ahern says:

    ====================
    rtnetlink: Add support for rigid checking of data in dump request

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=cd7f7df6ca3366be4ac79e824fdaa8d482270015

or adding a new flag that can be passed when opening a
NETLINK_KOBJECT_UEVENT socket.

Christian

> 
> Not using kernel versioning (nothing should *ever* look at the kernel
> version, since that makes things like backports a huge and
> insurmountable pain), but simply using some specific control channel.
> 
> > I guess reverting is the right solution here. I wish folks would yell
> > earlier though...
> 
> So nobody is actually using the new "bind" event, I take it? It's
> about a year and a half, and it's in 4.14 which is widely used, so
> reverting it has a risk too.
> 
> Which is why I too would hope people would be much more vocal about
> "that broke my setup".
> 
> But reverting does sound like the right thing to do if nobody is using
> it. It sounds like systemd udev does not, and if eudev is actively
> broken by this then how many other cases might there be?
> 
> I assume any locally modified udev rules would still be ok with the
> revert (since presumably any udev rule modification people did was to
> just ignore the bind/unbind events that no longer would be sent).
> 
>                 Linus
