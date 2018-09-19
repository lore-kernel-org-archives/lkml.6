Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31BDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F21C2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="jEwfMybW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F21C2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbeISURB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:17:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36912 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbeISURB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:17:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id n11-v6so7242637wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=atqhyWvxUMpa8+0E4S2dnyTiW9FjJ3lRkgEmrt5LRmw=;
        b=jEwfMybWtG2EkaKCbpkCohFFePAuDMguTlJVQvb0XnvnmixF/GAJzkbx5Jy4Z9pB2f
         Ep9RWMWyJht06Az2lsIR53ASqotRIZbI2L/ZQmyye3MAwP+mMsRMoLgjL2B1Lruf7seI
         vF14a8R/svAt5GoZkhgup9pQ2BJlGC+3A7K9kEhTH8MV575Cv2hJFZ4VyQrOLG68UzEl
         M/0CSiMKVcgbVfjkxY8MnYdqmkLxkSXjJ72Wh2biIOnnnWF/z0Zl8W78/MlNC5YmCVDX
         J90FXHBfKb1QKAsBnSL4cr09rwrwjW6qWijlTdeU03LRyxGfcxRRcjubJnzQoVqsXgAN
         7zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=atqhyWvxUMpa8+0E4S2dnyTiW9FjJ3lRkgEmrt5LRmw=;
        b=GZnsM5TdWPhAFyyK91Ot+Ni1lu1JAxqOIJg0kFwBoY3Zv+3m44jppwrqCUyzT1GSc2
         WWXYzVEmycoZmI2tTGsBcMkcKb9QyGsAkQGDbWt3IlTlrJfCVRPMDI5LGUajJiUjsYH5
         8/QYiXnjypW3uVTBeJNMpsRqRLUQWUwMt3SLXtnSlD8FPySngOa/gZDKor5qco2HA1cf
         la1hilyulI2wQl9W3xebtz5jJbs1HH6rveQ2IOOiPI5ef/SZC4c4LAoznfJ9Nw6GkrEY
         s1o1R6EkBIS6MgUaOHWARoLTh+hmChPAFob1naB/tMsb6GofL0RqFUP5HVFwNBCL/2r3
         j3Rw==
X-Gm-Message-State: APzg51DXZC64LxHgeJ9rLKAj7PadX0HB2HnLnJAQQWLMfG/6MsdVXlvM
        q2XH/kBObi7jXz2hpdnhskH1t/BbtFuyQodj
X-Google-Smtp-Source: ANB0VdbkFQ0/3H4yJjH5cKNegYl4t+SrqDP/Keath7kz2on3jnr+znvHZCnVyD0pi6jr9XKeTN7ZjA==
X-Received: by 2002:a1c:2ed4:: with SMTP id u203-v6mr20484941wmu.19.1537367925679;
        Wed, 19 Sep 2018 07:38:45 -0700 (PDT)
Received: from cisco ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id 185-v6sm7490901wmy.38.2018.09.19.07.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 07:38:44 -0700 (PDT)
Date:   Wed, 19 Sep 2018 08:38:42 -0600
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
Message-ID: <20180919143842.GN4672@cisco>
References: <20180906152859.7810-1-tycho@tycho.ws>
 <20180906152859.7810-5-tycho@tycho.ws>
 <CALCETrWZmN4FeCSwemfMeayupBmQ-NqpVWQuqSU34CLvzdx8gw@mail.gmail.com>
 <20180919095536.GM4672@cisco>
 <C1406292-7496-459F-A76A-20C9EFBB12D6@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C1406292-7496-459F-A76A-20C9EFBB12D6@amacapital.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 07:19:56AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Sep 19, 2018, at 2:55 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> > 
> >> On Wed, Sep 12, 2018 at 04:52:38PM -0700, Andy Lutomirski wrote:
> >>> On Thu, Sep 6, 2018 at 8:28 AM, Tycho Andersen <tycho@tycho.ws> wrote:
> >>> The idea here is that the userspace handler should be able to pass an fd
> >>> back to the trapped task, for example so it can be returned from socket().
> >>> 
> >>> I've proposed one API here, but I'm open to other options. In particular,
> >>> this only lets you return an fd from a syscall, which may not be enough in
> >>> all cases. For example, if an fd is written to an output parameter instead
> >>> of returned, the current API can't handle this. Another case is that
> >>> netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If netlink
> >>> ever decides to install an fd and output it, we wouldn't be able to handle
> >>> this either.
> >> 
> >> An alternative could be to have an API (an ioctl on the listener,
> >> perhaps) that just copies an fd into the tracee.  There would be the
> >> obvious set of options: do we replace an existing fd or allocate a new
> >> one, and is it CLOEXEC.  Then the tracer could add an fd and then
> >> return it just like it's a regular number.
> >> 
> >> I feel like this would be more flexible and conceptually simpler, but
> >> maybe a little slower for the common cases.  What do you think?
> > 
> > I'm just implementing this now, and there's one question: when do we
> > actually do the fd install? Should we do it when the user calls
> > SECCOMP_NOTIF_PUT_FD, or when the actual response is sent? It feels
> > like we should do it when the response is sent, instead of doing it
> > right when SECCOMP_NOTIF_PUT_FD is called, since if there's a
> > subsequent signal and the tracer decides to discard the response,
> > we'll have to implement some delete mechanism to delete the fd, but it
> > would have already been visible to the process, etc. So I'll go
> > forward with this unless there are strong objections, but I thought
> > I'd point it out just to avoid another round trip.
> > 
> > 
> 
> Can you do that non-racily?  That is, you need to commit to an fd *number* right away, but what if another thread uses the number before you actually install the fd?

I was thinking we could just do an __alloc_fd() and then do the
fd_install() when the response is sent or clean up the case that the
listener or task dies. I haven't actually tried to run the code yet,
so it's possible the locking won't work :)

> Do we really allow non-“kill” signals to interrupt the whole process?  It might be the case that we don’t really need to clean up from signals if there’s a guarantee that the thread dies.

Yes, we do, because of this: https://lkml.org/lkml/2018/3/15/1122

I could change that to just be a killable wait, though; I don't have
strong opinions about it and several people have commented that the
code is kind of weird.

Tycho
