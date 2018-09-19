Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D384C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2873B2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="0ZVV7E75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2873B2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbeISPcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:32:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55034 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeISPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:32:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id c14-v6so5556024wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 02:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OFB/MHMgh0Ap32ZYn2KzCunWcMDGOn12r0Z0szLw7J4=;
        b=0ZVV7E751Kl/BJqthEr0nAnfpX0a/QFX8ZW9jfjpyQSDwxsNPVhpm4owCLzit1yamr
         6rhw2pXg+/SMJ71T0BJI6x3o0OzDxWuRgnM6wqM4h6dlmL2SrzViGkEKQ6fu3ev1H6Ds
         OTNa0rA+YhDzOjA3Kuhnvjmu3eCFfcTLpBLg1WtiCfygB2q7Y1vxOfJpCNLjwINv7S+j
         N4GuatKjDeS0tk6Ud6Ctts7oJt2fJschjcQoaAgHnlQOZptPGF3rWaUNQbBjtUlmP2RG
         laFlpRFLNd5+CiCcJ84sTpewSwyoc08zx3aolvnFnmRFxF8pew5em798nHj5Ey9DlLQg
         aECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OFB/MHMgh0Ap32ZYn2KzCunWcMDGOn12r0Z0szLw7J4=;
        b=SQh7yMvX70RTjgWPi14Yt2BFPTmHKh1Ycdge17DBx8kdTp8hJ5wX/tuRfBmWX9/qm4
         4XzCsD4TDRXx3e1oIEGayWwJUDRrnnRzblXCZRBtoe7RmW5itw6L4y9wjQy5GMrsxnoi
         MRSdoIL3l22MhBDXVlIVX0JhTZ+qrk9cYLKdkHt9YZTmtcw/7eSq+oGETuRM5L1m7t+8
         Xeau7sLwZpQ8IfcYkJKlAWVyBim29NsL4ZMiAu1zU8jSQRp9vR3hReTZ8e0kf3R3fFIc
         2oOpBke96144iR/deqI6trQUUPCHLPXHtp0UkdCOK2GShG9HsGKJQKawVpqF/FMDV+sb
         xgog==
X-Gm-Message-State: APzg51Dg1pXb6dD0BbKU78RhCWyrZJVUp7QvvFJqpnNbMALt13xF51ch
        o2prk8Vz9Rs4LijxHxUmxc8jBmpkNeW7pPOV
X-Google-Smtp-Source: ANB0Vdaz5aECQNtTLeePawbBcdY6soe+20FTAAAt6TTlmYLZxzlNxy8HaQYnh3ebN9k+NDwNT+RYJg==
X-Received: by 2002:a1c:40d5:: with SMTP id n204-v6mr19418064wma.44.1537350939353;
        Wed, 19 Sep 2018 02:55:39 -0700 (PDT)
Received: from cisco ([173.38.220.62])
        by smtp.gmail.com with ESMTPSA id x15-v6sm17614359wrt.53.2018.09.19.02.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 02:55:38 -0700 (PDT)
Date:   Wed, 19 Sep 2018 03:55:36 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via
 USER_NOTIF
Message-ID: <20180919095536.GM4672@cisco>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-5-tycho@tycho.ws>
 <CALCETrWZmN4FeCSwemfMeayupBmQ-NqpVWQuqSU34CLvzdx8gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWZmN4FeCSwemfMeayupBmQ-NqpVWQuqSU34CLvzdx8gw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 04:52:38PM -0700, Andy Lutomirski wrote:
> On Thu, Sep 6, 2018 at 8:28 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> > The idea here is that the userspace handler should be able to pass an fd
> > back to the trapped task, for example so it can be returned from socket().
> >
> > I've proposed one API here, but I'm open to other options. In particular,
> > this only lets you return an fd from a syscall, which may not be enough in
> > all cases. For example, if an fd is written to an output parameter instead
> > of returned, the current API can't handle this. Another case is that
> > netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If netlink
> > ever decides to install an fd and output it, we wouldn't be able to handle
> > this either.
> 
> An alternative could be to have an API (an ioctl on the listener,
> perhaps) that just copies an fd into the tracee.  There would be the
> obvious set of options: do we replace an existing fd or allocate a new
> one, and is it CLOEXEC.  Then the tracer could add an fd and then
> return it just like it's a regular number.
> 
> I feel like this would be more flexible and conceptually simpler, but
> maybe a little slower for the common cases.  What do you think?

I'm just implementing this now, and there's one question: when do we
actually do the fd install? Should we do it when the user calls
SECCOMP_NOTIF_PUT_FD, or when the actual response is sent? It feels
like we should do it when the response is sent, instead of doing it
right when SECCOMP_NOTIF_PUT_FD is called, since if there's a
subsequent signal and the tracer decides to discard the response,
we'll have to implement some delete mechanism to delete the fd, but it
would have already been visible to the process, etc. So I'll go
forward with this unless there are strong objections, but I thought
I'd point it out just to avoid another round trip.

Tycho
