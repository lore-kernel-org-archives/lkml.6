Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1749BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B052080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKBFdrsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B052080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeKSCOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:14:08 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34815 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeKSCOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 21:14:08 -0500
Received: by mail-vs1-f66.google.com with SMTP id y27so16430654vsi.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oAvELmMDfLLvCTgSAORCiReuErvoUldHbTRk39dK5Xg=;
        b=JKBFdrswEeNtAlPwpfrMMuX8pnFLLpB+5DJh6lQE3Ev6z2oLY/DgoFP48aLefmsnyl
         skU665wmSeTLWBhVzQHMYt7VF5wZLt7s9UAz0E2ee30wIPzinpL0/C4+NW4MS188EjOP
         wrVjTa4uRI3g+r+blRu7twZ1RUilEWQPWBiWf6Tgs1R1YIX6TJjGd2FvK+wYjo8jRL/5
         6F+WcPBuqXlmERBWP7FpOJbLBKGjtO9/qQC8otNVurBpowLufgNL9693ZXOQDyqwclcf
         ti7UU8xMmpTSllBGh3u73kPahFrCaO8/YAw2nO2GpMNrzif6WdBPmOa2X7hZKN1CsAZb
         D99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oAvELmMDfLLvCTgSAORCiReuErvoUldHbTRk39dK5Xg=;
        b=HkXfGUFx+ZwIBkTqH4SySbr6JcokSadS09Ve024hThBK/D6HfaC5ao5nQFqdfaCetD
         tHYnShaiPYVPpbPyep82L26/rFJzJ+87bSiLNMMtrOJulEfjrI2FL9/uDr6jANLu0Nkv
         L+zoFjY6jOHBG/M9S935EvvnSrruG42BsIeZ+6SW66Nf4UFJGPedqjz0QrS9doGMAhxZ
         eBQm2WVDiPqbM/q16/RpDdTObkIKsGaVLWvvF3LporrrYK6cbcFa28HlTabn5t/P28wU
         vxTccDpb9UeuTKiG0K6+8E1DcQeQjM6VIQgcBSWgcSsxPN58EtfbouiSTr6juVwzZF4j
         YgqA==
X-Gm-Message-State: AGRZ1gJjFWuk/F662jCZY3JIpqXO3fHQPb5GzAPpWvtwioHlprYnynjT
        UWfUHgA5pUU+OFRfiLDTj4gpT7ULCF7eZTWkkYBzMQ==
X-Google-Smtp-Source: AJdET5cMihrzYQLrV2/23AtptT61pj7EWyHW2FFT/XHeX2W7ExwqE7gBJq3g8icuzmXkldHyW3RT2/0MlC7rstbEwcs=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr7846561vsc.171.1542556408696;
 Sun, 18 Nov 2018 07:53:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 07:53:27
 -0800 (PST)
In-Reply-To: <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 07:53:27 -0800
Message-ID: <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
> I fully agree that a more comprehensive, less expensive API for
> managing processes would be nice.  But I also think that this patch
> (using the directory fd and ioctl) is better from a security
> perspective than using a new file in /proc.

That's an assertion, not an argument. And I'm not opposed to an
operation on the directory FD, now that it's clear Linus has banned
"write(2)-as-a-command" APIs. I just insist that we implement the API
with a system call instead of a less-reliable ioctl due to the
inherent namespace collision issues in ioctl command names.

> I have an old patch to make proc directory fds pollable:
>
> https://lore.kernel.org/patchwork/patch/345098/
>
> That patch plus the one in this thread might make a nice addition to
> the kernel even if we expect something much better to come along
> later.

I've always commented on that patch. You never addressed my technical
objections. Why are you bringing up this patch again as if that
discussion had never happened? To review, that patch has various race
conditions, and even if it were technically correct, it'd be an abuse
of directory objects (in what other circumstance do we poll
directories?) and not logically generalizable to a model in which we
expose process exit status via the exit-monitoring API.
