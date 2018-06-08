Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GoejOmjvGlvbHAAAmS7hNA
	; Fri, 08 Jun 2018 21:04:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CFDC4607E4; Fri,  8 Jun 2018 21:04:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="gnkJb8Ne"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 04E03601D2;
	Fri,  8 Jun 2018 21:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04E03601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeFHVEi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:04:38 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39829 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbeFHVEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:04:36 -0400
Received: by mail-ot0-f195.google.com with SMTP id l15-v6so16228801oth.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OKeGko4c4eMdUHto+Radj03z6VgMYaKADmh907H74pg=;
        b=gnkJb8NebfOL5X8W1EOtooNeqy2xBkZnIgSCgoTVBCQfIIyQ4yZ1kuR0iYeIPFE4Be
         bEb9dmGVoXo4b7fyQXgOUCr9IEpydsUbqojv55aTEOPJDMs1nVGzwxUwqnpXchyFde2Z
         m+aWMQSXQjQPzYK/3uHfw10UtQEmOnUFVJ8i18pmgoFCbBQW2RdfdzFh1UccinLAOypw
         tEp+lIB73vF9KOEMqyv2KTuryMkEAvxIZ6DbRtB8mB79kx4lK5XD4vy6SXkiRrKwh2Pq
         8OSf6FL4UYa1tF+2TsxjPzFW8AnqbRocPaBRn+kkW+0jRb41+/QqUS1GE/ts7NCA/upv
         ywmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OKeGko4c4eMdUHto+Radj03z6VgMYaKADmh907H74pg=;
        b=mu0rPtpVP10KN59AgP1JNObYLmyz29ovEbn7k4TWH9u6MNFELGeMNwOPMwob0E6iFm
         YB/VwP3gKLego/Vthyt4GnqC+75DIkdJOyt89bnn8zzafplPrIn8Pyq14gBpd4FSCT7W
         qlX8xVXs1rFs4EeU0znLRyHUFu9QshnBCELy5E+rEs0lBmfhulEb9twtfdoP76hmK1Mz
         KKAhzOFPWxcwoDPrYKMi49gU6bJiL+CjDJifAwlJI4xOF0WrhTudY/ZygHs4YnaV7j/L
         IF3bfXBk1jAcMAjWc7U4iFlDorD0U4ZUn+RCQeLc99IB3Kmx/+Biwe1yQW8AEUb1HELl
         1RVA==
X-Gm-Message-State: APt69E2rxglc8i7CF1vSxEKa86/r4z9BpbY7qrRyYTXNNuWv9j6ZyXuC
        3e06Za+5VwVcEha7FdCmRBFCew==
X-Google-Smtp-Source: ADUXVKLODO5i+jsv+RqiJ/R2NpiOFHfFT9jq3PRaOUvgYepYtytzL6LRLNj5v9AmGz/OJVLYp9Zktg==
X-Received: by 2002:a9d:3851:: with SMTP id r17-v6mr4359172otd.335.1528491875495;
        Fri, 08 Jun 2018 14:04:35 -0700 (PDT)
Received: from cisco ([8.24.24.129])
        by smtp.gmail.com with ESMTPSA id o55-v6sm20231668otb.51.2018.06.08.14.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 14:04:34 -0700 (PDT)
Date: Fri, 8 Jun 2018 15:04:33 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v3 0/4] seccomp trap to userspace
Message-ID: <20180608210433.GA15707@cisco>
References: <20180531144949.24995-1-tycho@tycho.ws>
 <CAGXu5jKsLDSBjB74SrvCvmGy_RTEjBsMtR5dk1CcRFrHEQfM_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKsLDSBjB74SrvCvmGy_RTEjBsMtR5dk1CcRFrHEQfM_g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Fri, Jun 08, 2018 at 09:29:42AM -0700, Kees Cook wrote:
> On Thu, May 31, 2018 at 7:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> > Hi all,
> >
> > Here's a v3 of the seccomp trap to userspace, with all the nits from v2
> > fixed. Open questions from v2 are still:
> >
> > 1. is it ok not to use netlink?
> 
> Yeah, I think there isn't a sensible way to reuse that API, which is
> too bad. Let's just try to keep this interface future-proofed. :)

Yes, I think it is, assuming that we always use a zero value as the
"do the same thing as before" value. Perhaps I should write that
assumption down somewhere...

> > 2. what should the fd passing API look like? (see patch notes on this
> >    one for details of why the current one might (?) be a problem)
> 
> The only thing in my mind is avoiding the problems with other fd
> passing API (e.g. when do rlimits get checked, etc).

My read of get_unused_fd_flags() is that it does check RLIMIT_NOFILE,
so I think we're ok there.

My biggest concern was just about the case where we want to do
something besides return an fd from a syscall (e.g. install an fd, but
return it via some pointer or something), but I'm not aware of
anywhere we do that today, so maybe I'm worrying about it too much.

> > As an added bonus, I've also written some stress testing, with lots of
> > tasks and listeners (1000 of each) sharing the same notification thread,
> > and not found any issues so far. Code is here:
> > https://github.com/tych0/kernel-utils/blob/master/seccomp/notify_stress.c
> > although I haven't included it in the patchset.
> 
> That's excellent, thanks!
> 
> > v2: https://lkml.org/lkml/2018/5/17/627
> >
> > Tycho Andersen (4):
> >   seccomp: add a return code to trap to userspace
> >   seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
> >   seccomp: add a way to get a listener fd from ptrace
> >   seccomp: add support for passing fds via USER_NOTIF
> 
> I'm under a time crunch with the merge window, but after -rc2 I should
> have time to give this some close review. FWIW, I expect this to enter
> -next this cycle and get it into the 4.19 merge window: we need the
> feature and the alternatives have been well explored and don't look
> workable.

No rush. I am preparing a v4 with the various comments in this thread
fixed, hopefully I'll send it out early next week.

Tycho
