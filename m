Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAF2C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60ADD2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="F6Mcx9sV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbeLXSmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:42:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36289 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeLXSmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:42:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so12212004wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6sUXm0JUWdvIVYEn/h9xu52KJpYnf+5LL8rn4TtAIW0=;
        b=F6Mcx9sVf7nMCHgxRoiNaGIgCZ0XFwpUAfyMoe1/lAEQr3AtbOgYxCxP52neZtLjZt
         1yFwjtDmgALWgFkV35CkKcuOHv1FxXGhx3RA/GyouEOxFBA4qm+9Iuq7psGKNsKlMu7T
         qKn7LQqrCAf+4MFABnzeE0nR9vQaXRwPQT3nM2OchzOTRQYcBw2xwC55DV/j1ir2yW8q
         F/p5OXsFpFgKN2zxnMKgFmfnt5/4JqxeRjsAy3/vHcqNs5JkdZ/rvDUAcQYPPobddNbP
         7BYB+WfueqCBu5j1klgr02vY0q5aBk3tcg/oC0CE08cDGep3L0xmMcbLtAxdjN9vkBrV
         XzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6sUXm0JUWdvIVYEn/h9xu52KJpYnf+5LL8rn4TtAIW0=;
        b=ekOP4uB8hbpEHZa7uH8E5ReZu2lZiUdRDzt2uOiAdjCxpncoaxFfIRGR9XgizjPRp8
         VHlvZsI/XSeaoMeOSmwc2qlwrIX6G/nNGAHkcVQHcypR4VsZJ79J6VxOyV0acYdnYETi
         C2x8bsu7CJ3hk7YkC5l2uEwnzgpynfxRoBtjb3WCbRI4VOMsZSpPT8I7b+q5pBtUQYp3
         BHK8y2SwNJ3vsf6tuydPB12AEjet/fgVzZgTnPy4KbYxxGskMjeghzpvLCfytRpbwDsV
         jBZMH189dEyV2/N8zdvxQH9p3rL/mITBxEfhynQNAzAwqy7q2BOyy/Z+jCWxPx4ysf9N
         3FDQ==
X-Gm-Message-State: AJcUukcv61k4sSV3c8FZgJdq8MhMYqze3UCaI79CuDUJ1qo+INOHmWXz
        9T1JxYiQTUO7XX0gyha/9eo1KA==
X-Google-Smtp-Source: ALg8bN5kyLLRc3Ftnfd8O1ShqkJopKnqunr+Sf+JqUtUGwHHvOL9qhqiQ+PWgkg5XiV2rdF8plbUww==
X-Received: by 2002:adf:fd03:: with SMTP id e3mr12177929wrr.280.1545676922406;
        Mon, 24 Dec 2018 10:42:02 -0800 (PST)
Received: from brauner.io (p5B2A6FBE.dip0.t-ipconnect.de. [91.42.111.190])
        by smtp.gmail.com with ESMTPSA id x3sm22559371wrd.19.2018.12.24.10.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 10:42:01 -0800 (PST)
Date:   Mon, 24 Dec 2018 19:42:00 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Gabriel C <nix.or.die@gmail.com>,
        Marcus Meissner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181224184159.vig2y3mbk2h3kasj@brauner.io>
References: <20181223171703.s7jm6fkyosnsf33z@brauner.io>
 <20181223180609.GA102606@dtor-ws>
 <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
 <20181224091703.GB26796@kroah.com>
 <CAEJqkgj2EjQq_aaspRs7uyTL4LxC9dRUTheN25H+QhjkLjjpjQ@mail.gmail.com>
 <20181224105407.GA29719@kroah.com>
 <20181224173427.GA254245@dtor-ws>
 <CAHk-=wiTE+k8WkHoDLzxX2Qz8ko7W+BsXOhirS_j0FZaBMxDdA@mail.gmail.com>
 <20181224181322.n7n6d2y63gwnv7cb@brauner.io>
 <CAHk-=wh1mdr+zFK+-PW-inaky+sn-M63VKuUAaYrz+D5PxpjpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1mdr+zFK+-PW-inaky+sn-M63VKuUAaYrz+D5PxpjpQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 10:28:20AM -0800, Linus Torvalds wrote:
> On Mon, Dec 24, 2018 at 10:13 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > So one possibility is to add a socket option for lib/kobject_uevent.c
> > that can be set via setsockopt. We did something like this in netlink
> > for strict property and header checking without breaking backwards
> > compatibility.
> 
> I'd actually prefer for it to be some /sys interface or other. Maybe
> it could even be per-device or class, and you could do something like
> 
>    echo "enable bind" > /sys/bus/serio/uevent
> 
> the uevent code already supports a per-node "filter" function, maybe
> that notion could be extended to also have a filter for uevent types.

Hm, then we maybe we should think about proper kernel-side uevent
filtering at some point (thinking out loud). But that's also a lot of
complexity and I'm not sure that udev users actually would want this.
Would be helpful if a current udev maintainer could comment on this (I
think recently Yu Watanabe stepped up to maintain systemd-udevd? But I
haven't got his mail address.)
But imho, if we can come up with something simple like a flag first as
opt-in we can still allow for more fine-grained filtering later...

Christian

> 
> But I'm just handwaving. Maybe it's better per uevent socket or something.
> 
>               Linus
