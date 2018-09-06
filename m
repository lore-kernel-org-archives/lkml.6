Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FF5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938F220844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="g0LXsEq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938F220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeIFXHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:07:06 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43152 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbeIFXHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:07:06 -0400
Received: by mail-qk1-f194.google.com with SMTP id 130-v6so8010784qkd.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 11:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VgAEINDHJWOqEu7ZL77Hcum8imLIYrZX0+D80Qh/F2k=;
        b=g0LXsEq2Qx3uOUpC2qSWnoUDeauaNIWJar8iLJhVr/HIMe9CE+RKRv/lD6NU0ebbWf
         UqfWg7i0g7qH6RTlAPa44pyHz0ktbbasZ/GSFS3KYI1p/K7arpxYXh1TcP1rn6v/LUu7
         CJfNWRTGgBKLJsCCVAYLA+qgeTPn9dzxb2QXV6njmC85GN8BO6GxzqUrn+PxD4SKJXMM
         HPPIFX+ehbwlx6XRZPNZigHfsNGzOe6oSg3uC035pWw3Lj7PHFkDnrufp0lXrDY9lff8
         yYpcYmeNNWkDDWhWGI53bi4q2SozPBHTtiNausNcjs1pjYANSVrjqkHe+4oZN6HjleDT
         Wejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgAEINDHJWOqEu7ZL77Hcum8imLIYrZX0+D80Qh/F2k=;
        b=iQOTU75gZvi1CDZtZZbMK/OibdXRwaszBRQ3SRz7gOoQ31r9CZaYS9jnmsZuC3Mcoa
         IiF1L6gMyyweQjgD4vF9Q/538WolgBouJM7a8EcvAd/pXi0I2PmkTURpC9/ozzcnSIZR
         OyhgCl9Ijbo1K9ucA8eKBpfGyEhfY2QOyHmwOn/jhFntdmc/1NS3gM30Bme30zlL9+pP
         MR1w1fM/J7unoCtFH5Bm4GE/TsDaocdjqfZ2AXHYRGDkQQHbes4WbLVyD3ztaaU4dKLU
         MPDqGKa/M4zj/SKUSSj72k4NC4f21Y1nyF5fKd5qyFsy7XpUvwr5o9etMupWDZabAyho
         E9Gg==
X-Gm-Message-State: APzg51ATkcKNEgQRkaZ4j8JtgzkR58VJIBvzL1xM05QWYq5pJlyaCvLa
        nlqAOvgSgGldxbcLfySNery9Vw==
X-Google-Smtp-Source: ANB0VdYmP5htjq6xcaXyGyyR1Z4Z9LBuqjuENdwcSOCrPUi0qjnn09OmI0g/hEMxnUIYhEH9QiVLQw==
X-Received: by 2002:a37:c0d3:: with SMTP id v80-v6mr3202703qkv.256.1536258622742;
        Thu, 06 Sep 2018 11:30:22 -0700 (PDT)
Received: from cisco.cisco.com ([173.38.117.76])
        by smtp.gmail.com with ESMTPSA id i85-v6sm4242726qkh.3.2018.09.06.11.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 11:30:21 -0700 (PDT)
Date:   Thu, 6 Sep 2018 12:30:18 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>, suda.akihiro@lab.ntt.co.jp
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via
 USER_NOTIF
Message-ID: <20180906183018.GC3326@cisco.cisco.com>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-5-tycho@tycho.ws>
 <CAG48ez2oQnAb=OMGOUz0GfSWMsjqydPe8dmp6L=QswSQpSpVXA@mail.gmail.com>
 <20180906162246.GB3326@cisco.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906162246.GB3326@cisco.cisco.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:22:46AM -0600, Tycho Andersen wrote:
> On Thu, Sep 06, 2018 at 06:15:18PM +0200, Jann Horn wrote:
> > On Thu, Sep 6, 2018 at 5:29 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > The idea here is that the userspace handler should be able to pass an fd
> > > back to the trapped task, for example so it can be returned from socket().
> > [...]
> > > diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
> > > index d1498885c1c7..1c0aab306426 100644
> > > --- a/Documentation/userspace-api/seccomp_filter.rst
> > > +++ b/Documentation/userspace-api/seccomp_filter.rst
> > > @@ -235,6 +235,9 @@ The interface for a seccomp notification fd consists of two structures:
> > >          __u64 id;
> > >          __s32 error;
> > >          __s64 val;
> > > +        __u8 return_fd;
> > > +        __u32 fd;
> > > +        __u32 fd_flags;
> > 
> > Normally,  syscalls that take an optional file descriptor accept a
> > signed 32-bit number, with -1 standing for "no file descriptor". Is
> > there a reason why this uses a separate variable to signal whether an
> > fd was provided?
> 
> No real reason other than I looked at the bpf code and they were using
> __u32 for bpf (but I think in their case the fd args are not
> optional). I'll switch it to __s32/-1 for the next version.

Oh, I think there is a reason actually: since this is an API addition,
the "0" value needs to be the previously default behavior if userspace
doesn't specify it. Since the previously default behavior was not to
return an fd, and we want to allow fd == 0, we need the extra flag to
make this work.

This is really only a problem because we're introducing this stuff in
a second patch (mostly to illustrate how extending the response
structure would work). I could fold this into the first patch if we
want, or we could keep the return_fd bits if the illustration is
useful.

Tycho
