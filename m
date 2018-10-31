Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0874FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8430920657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="e2lQWd93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8430920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeKAFGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:06:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44345 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKAFGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:06:15 -0400
Received: by mail-io1-f66.google.com with SMTP id c6-v6so10626332iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sGUDT3d0xGX9nzCqAFlO/TsNrsvwmDdDmWDkS06eAqM=;
        b=e2lQWd93t3JdZt73GEXiKCWmm/A7HOJtev+XOnqgCcvDpBpNyY3KyeLTHVGN1jX2Vb
         NWSxF8/B20hmo5K3YgS/MHgBPUxmebVo7Aw45FiKv3T2PDMo2RMiIsmyjcepx0tWSCWp
         kQb/gbdIesJgfPZwUyOR5HIRC9Q80ZZpReM47am6wZRoah5L3Q0l7AG+nUKmqwc64iGi
         3eX6sgBtvwMPHIkptCSiyn90Wy2kZh/HXSA22haZVvMCtKP+Mymj9gk16ec4tAHRt/Da
         eT2R2kRVz21o9W61sc8k58jWRxd/qKVNyhYoROdVlStzUga4pTgsZgGwyJR5X2ZXvpwO
         bs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sGUDT3d0xGX9nzCqAFlO/TsNrsvwmDdDmWDkS06eAqM=;
        b=gsrMFYuFmmlKMZc/3rmEhzZazcZ7R1nRvG7h977U1X5UCYReaKKI9w5DP3qQ4J0Kgp
         UTim7S18Wks5Rh+GSMr3dWK3o2zni4IMVJV1hfKY8By1cvqJP/h63X1i4cZfxwy9wO9a
         UjlayDTC7xvbkFFtwF8w+RmPHXLT+cNigO/833+IoqRBu8Uj2Xo21KwDSKCS5wyOGLGx
         F24e6JuKDwCYHVDWcAhmXpC1hdJCBf9zc7LuAaReTUIHOVgwfpyvUq7RvLMqWurEcbVG
         nM/VH5ib5jG67hyXUo2MdqW4DtbG5jYrSsUrcw3gltXH+jDx+ektDAw3EisSB4x7gDge
         FLaQ==
X-Gm-Message-State: AGRZ1gKnWiJz+3VRPxDnENwx44VJ/Xv/0ffHQ09ReZuxBohdcnxYXXyf
        qUAqLep4LfrO+NJhuwGEy1Ly9Q==
X-Google-Smtp-Source: AJdET5fX9zvwSwvhvLQoh00CtuS6+soK+KOhpafHuVriAXpBPYVzEI/FIIzVc72KI7czAUDsn7aBsA==
X-Received: by 2002:a6b:1b8f:: with SMTP id b137-v6mr3037616iob.26.1541016400087;
        Wed, 31 Oct 2018 13:06:40 -0700 (PDT)
Received: from cisco ([65.154.54.146])
        by smtp.gmail.com with ESMTPSA id x8-v6sm8226575ioj.44.2018.10.31.13.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 13:06:39 -0700 (PDT)
Date:   Wed, 31 Oct 2018 14:06:37 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3] Implement /proc/pid/kill
Message-ID: <20181031200637.GE2180@cisco>
References: <20181029221037.87724-1-dancol@google.com>
 <20181031155912.45088-1-dancol@google.com>
 <20181031175448.GC2180@cisco>
 <CAKOZuevrFxWLY1J1DVPNGaEy8UbkD1r_M9T9FQTOtSrqp-G0qw@mail.gmail.com>
 <20181031181717.GD2180@cisco>
 <CAKOZuetdSK8jhD1snja8p4AQTNPrLOugQrVn642RCH8S4QBGFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuetdSK8jhD1snja8p4AQTNPrLOugQrVn642RCH8S4QBGFg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 07:33:06PM +0000, Daniel Colascione wrote:
> On Wed, Oct 31, 2018 at 6:17 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > On Wed, Oct 31, 2018 at 06:00:49PM +0000, Daniel Colascione wrote:
> >> On Wed, Oct 31, 2018 at 5:54 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> >> > Why not just use an ioctl() like Jann suggested instead of this big
> >> > security check? Then we avoid the whole setuid writer thing entirely,
> >>
> >> Don't you think a system call would be better than a new ioctl?
> >
> > We already have a kill() system call :)
> 
> kill(2) is useless this purpose: it accepts a numeric PID, but we'd
> need it to accept a process file descriptor instead. It's true that
> the existing kill(1) binary might be the vehicle for using a
> hypothetical new system call, but that's a separate matter.
> 
> >> With either an ioctl or a new system call, though, the shell would
> >> need a helper program to use the facility, whereas with the existing
> >> approach, the shell can use the new facility without any additional
> >> binaries.
> >
> > ...and a binary to use it!
> >
> > The nice thing about an ioctl is that it avoids this class of attacks
> > entirely.
> 
> Let's stop talking about adding an ioctl. Ioctls have problems with
> namespacing of the request argument; it's not safe, in general, to
> issue an ioctl against a file descriptor of an unknown type.

So don't lose track of the fd type. I'm not sure I see this as a big
problem.

> You don't know how that FD will interpret your request code. The two
> good options before us are a write(2) interface and a new system
> call. I think both are defensible. But I don't see a good reason to
> consider adding an ioctl instead of a system call.

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1729911.html
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1729921.html

maybe? :)

> All of this is moot if the new comprehensive process interface that
> comes out of LPC ends up being better anyway.

+1, I think a way to do all of this sort of thing would be nice.

> > either. Using this from the shell is still racy, because if I do
> > something like:
> >
> > echo 9 > /proc/$pid/kill
> >
> > There's exactly the same race that there is with kill, that $pid might
> > be something else.
> 
> > Of course I could do some magic with bind mounts or
> > my pwd or something to keep it alive, but I can already do that today
> > with kill.
> 
> You can't do it today with kill. The idea that keeping a open file
> descriptor to a /proc/pid or a file within it prevents PID reuse is
> widespread, but incorrect.

Good to know :)

Tycho
