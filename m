Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2811C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F411218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdXWZzDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeLXJRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:17:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44474 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbeLXJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:17:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so5378793pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 01:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rNXd2KUfL3/FLaqpz0NMeGk919yij6J2VNJCCgXUtiM=;
        b=DdXWZzDDCCapuOb2wx+mQdz+H9cEZ/8NRLrHQLkLj4Oz3vuTDgQKyxUshCNTWHvH6o
         v9QoYp+XMtkYDe6SmJuEs5O2ZfhdGpCIbcrEVj+k0PKUTUEgOEbb7ZgskvKHtFAl/5Bb
         scDd1MXRfHOiffEyct2vLpa/+fHB5uqTm4dFbFlZ8Smcii4iedX+BLxhW6GsMdHgt0dW
         yKAuCIvPUWOW6AuMnoKiV4eIIH51bRMeTwq37MpF2vnrwisE2H7dpRuW5MlE6ATBx9r4
         SO+8DIpJhrfDuIAAWne81bdyJHzNfIkTwA/ArbAxiSHSxyPJZhOx1RcS3kFMuK+pxZ7n
         o3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rNXd2KUfL3/FLaqpz0NMeGk919yij6J2VNJCCgXUtiM=;
        b=MH1FK/hYE+QH/46n14stXJZeN03BNctW6w3/DruP8WIl06dKYKdfrvoKV10N6nyLUH
         22ntnftW19z0zmtI3W4zGiAxW1GCCGbrKkfsWUqh+ybyhfw+z7DEgHOMANvIRyq0YvPn
         ekNHxe7Ea4HUTkcBj8wpvTp1aOnVJSwxUyTRfE3eq4M96zaaz8dVQmPgI+tTFH5Q5vcC
         89uNEljNwDn11TSj8UUJ8U+Zj8JZwE8hv689ZjeJJc893LKYdDOAlWVLX7LG6V1i69IK
         oGr0fLnwgMq46Cy24s+D0KKW2TqC2z/D82DwWEhcZpO33Vs6b6bj+80KHFUxZNvHGnc2
         TzWQ==
X-Gm-Message-State: AJcUuken7YIG8jiVLW8vJlmuheWd1OVfz9L5dfvKJkrnPW8svG7ApaMm
        Ep+Q+BBupfRHuKrzQh4vbZwOFRON
X-Google-Smtp-Source: ALg8bN6Pd89klEoZBUfXeUFl/8apVUjFh/0O/tTaUVPPTSEA9t2Iqx3diKH4kOBHIe5qdjI0Kt9mQA==
X-Received: by 2002:a63:df50:: with SMTP id h16mr11839830pgj.421.1545643067080;
        Mon, 24 Dec 2018 01:17:47 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b27sm43628149pfh.113.2018.12.24.01.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 01:17:46 -0800 (PST)
Date:   Mon, 24 Dec 2018 01:17:44 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Marcus Meissner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FYI: Userland breakage caused by udev bind commit
Message-ID: <20181224091744.GA122208@dtor-ws>
References: <20181223164954.hib4lbchftspidsd@suse.de>
 <20181223171703.s7jm6fkyosnsf33z@brauner.io>
 <20181223180609.GA102606@dtor-ws>
 <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkgjSX8PW-NXa8CoMzx=2P5LOiDz0MCHoZ03zE7wZ=n2dKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 08:31:27AM +0100, Gabriel C wrote:
> Am So., 23. Dez. 2018 um 19:09 Uhr schrieb Dmitry Torokhov
> <dmitry.torokhov@gmail.com>:
> 
> [ also added Linus to CC on that one too ]
> >
> > On Sun, Dec 23, 2018 at 06:17:04PM +0100, Christian Brauner wrote:
> > > On Sun, Dec 23, 2018 at 05:49:54PM +0100, Marcus Meissner wrote:
> > > > Hi,
> > > >
> > > > I am the maintainer of libmtp and libgphoto2
> > > >
> > > > Some months ago I was made aware of this bug:
> > > >     https://bugs.kde.org/show_bug.cgi?id=387454
> > > >
> > > > This was fallout identified to come from this kernel commit:
> > > >
> > > >     commit 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
> > > >     Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > >     Date:   Wed Jul 19 17:24:30 2017 -0700
> > >
> > > Fwiw, the addition of {un}bind events has caused issues for
> > > systemd-udevd as well and is tracked here:
> > > https://github.com/systemd/systemd/issues/7587
> > > I haven't been aware of this until yesterday and it seems that so far
> > > this hasn't been brought up on lkml until you did now.
> >
> > The fallout was caused by premature enabling of the new events in
> > systemd/udev by yours truly (even though the commit has Lennart's name
> > on it due to how it was merged):
> >
> > https://github.com/systemd/systemd/commit/9a39e1ce314d1a6f8a754f6dab040019239666a9
> >
> > "Add handling for bind/unbind actions (#6720)
> >
> > Newer kernels will emit uevents with "bind" and "unbind" actions. These
> > uevents will be issued when driver is bound to or unbound from a device.
> > "Bind" events are helpful when device requires a firmware to operate
> > properly, and driver is unable to create a child device before firmware
> > is properly loaded.
> >
> > For some reason systemd validates actions and drops the ones it does not
> > know, instead of passing them on through as old udev did, so we need to
> > explicitly teach it about them."
> >
> > Similarly it is now papered over in systemd/udev until we make it
> > properly handle new events:
> >
> > https://github.com/systemd/systemd/commit/56c886dc7ed5b2bb0882ba85136f4070545bfc1b
> >
> > "sd-device: ignore bind/unbind events for now
> >
> > Until systemd/udev are ready for the new events and do not flush entire
> > device state on each new event received, we should ignore them."
> >
> 
> And how about peoples still uses systemd < 235 and newer kernels ?

Should work exactly as it was with older kernels as it ignores
bind/unbind attributes.

> 
> > > >
> > > > If distributions would be using libmtp and libgphoto2 udev rules
> > > > that just triggered on "add" events, and not the new "bind" events,
> > > > the missing "attribute tagging" of the "bind" events would confused the
> > > > KDE Solid device detection and make the devices no longer detected.
> > > >
> > > > This did not affect distributions that rely on the newer "hwdb"
> > > > device detection method.
> > > >
> > > > I have released fixed libmtp and libgphoto2 versions in November, so
> > > > this is under control, but wanted to bring this up as a "kernel caused
> > > > userland breakage".
> >
> > Given that we explicitly enabled these new events in systemd/udev code
> > this is actually "userspace caused userspace breakage" case.
> 
> I really do not agree with you here .. Is kernel -> userspace breakage
> and while userspace is trying to workaround even much more breaks.
>

Not sure I follow your logic. We enabled handling new events in
systemd/udev. This thing broke systemd/udev. We now disabled this new
thing in systemd/udev.

Thanks.

-- 
Dmitry
