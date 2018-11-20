Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF58CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB25D2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Vzi7x3jH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB25D2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbeKTK7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:59:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36935 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732464AbeKTK7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:59:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id u3-v6so96300pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5eCZiwLavQJ8ZNyD93IqedqjQ/60p+xopwQs1fTFo2k=;
        b=Vzi7x3jHqbz0UAxLtrFw5BfBI14/sobMSDw121lTTzWqebje6L9KCpoKFH2DA6SxBo
         42Wx8mect2FPIinjGncx73T0fkoLAc8f0+De4nz0AXrJmJzdVifMpnfS+zsK78J+9Ley
         MtayUykLzXagw5vgB2W79/n8znk+5qJlLPFtqjWbJUTenkjO39vUBe7s7qvMXmFcTl/t
         3v3rZOhsIFMWWp47jXUCYTCcctTmmKh1VEPAhzc/HVgMnSZnWhzfvbijl/j6xH0Z7nNx
         5fKWwvJigx8HH1WkdJdGA9K6oFH8m1l5qZtRSY/Z9XhJ4jETDbRaJc3LL9nKfm9Lunx2
         Bxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5eCZiwLavQJ8ZNyD93IqedqjQ/60p+xopwQs1fTFo2k=;
        b=im1wVQBtQUUP9Ior/GIl3yNZM6tSycNNMPbGhJmNM6z7fm4thaIK+FLHkCtXWTEW59
         /JsGieA5KP4s1lyn+Ns6xXXsARD/310De6K8+ENcNtymqnK7191V473ug6DER742Sxvr
         R/d80Z/XPr0hnuCkcfRlReK0dRFmwtcDKTOoevT+AwRIzJnbA6MGmFp0YO10DlUpo4+Y
         kfCxD4MLCbY0M1nMjcvRyvPTJ54LiMxHxifD+1M9jze4wGjvXQDceGS+aswAToZP1R3W
         LM5opLCk10IcM6m9bEdAE+8JOY0BhfihRr2gQ9aQ+P6iPAy8a5n0uy0hLVRdFqXApKg5
         XG7w==
X-Gm-Message-State: AGRZ1gLIqhnW0Pgi//I+uCMg6PQitqY8GrG4dCvHb/iqc3rkOeN3erMo
        uypiOfQByN6Aik2/G6sqOeEcGQ==
X-Google-Smtp-Source: AJdET5cgYe64KWTi8RJq9Z1KQJQsODE45oJ3HCB1eRnbQ/9flHKIpAq7x+5BtQ/VCLBE8854WnqvSQ==
X-Received: by 2002:a63:1c61:: with SMTP id c33mr21652475pgm.354.1542673978859;
        Mon, 19 Nov 2018 16:32:58 -0800 (PST)
Received: from brauner.io ([130.195.55.139])
        by smtp.gmail.com with ESMTPSA id m85-v6sm48130556pfj.171.2018.11.19.16.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 16:32:58 -0800 (PST)
Date:   Tue, 20 Nov 2018 01:32:50 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Daniel Colascione <dancol@google.com>,
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
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181120003247.a776bej54baxqoxv@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119223954.GA4992@cisco>
 <CAKOZuetQDziWeRLydHbDNv1abGM3LyF=WohLFvbzmtdT_+nBdg@mail.gmail.com>
 <20181119230709.GB4992@cisco>
 <CALCETrWyuQvTtksN1J1XbCFPka_rLOaFqa5W==EvGQvoaf9f3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWyuQvTtksN1J1XbCFPka_rLOaFqa5W==EvGQvoaf9f3Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 04:27:49PM -0800, Andy Lutomirski wrote:
> On Mon, Nov 19, 2018 at 3:07 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > These tools also care about ioctls. Adding a system call is a pain,
> > > but the solution is to make adding system calls less of a pain, not to
> > > permanently make the Linux ABI worse.
> >
> > For user-defined values of "worse" :)
> >
> 
> I tend to agree with Tycho here.  But I'm wondering if it might be
> worth considering a better ioctl.
> 
> /me dons flame-proof hat
> 
> We could do:
> 
> long better_ioctl(int fd, u32 nr, const void *inbuf, size_t inlen,
> const void *outbuf, size_t outlen);

I'm the writer of this patch so take this with a grain of salt.
I think it is a bad idea to stop this patch and force us to introduce a
new type of ioctl().
An ioctl() is also not easy to use for this task because we want to add
a siginfo_t argument which I actually think provides value and makes
this interface more useful.

> 
> and have a central table in the kernel listing all possible nr values
> along with which driver they belong to.  We could have a sane
> signature and get rid of the nr collision problem.
> 
> The major problem I see is that u32 isn't really enough to have a sane
> way to allow out-of-tree drivers to use this, and that we can't
> readily use anything bigger than u32 without indirection because we're
> out of syscall argument space.
