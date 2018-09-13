Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216A0C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D0320882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="zNyghv5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D0320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIMOe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:34:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44006 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeIMOe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:34:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id z27-v6so4045490edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 02:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UZQdXaxoRG+0tAk3Cn6xebBBU7hBeb3zc2jsH0lfFQI=;
        b=zNyghv5VIHbiJ/ZdW8k7H2pWQjjw2FvppXdAmspgcj5uQyugNBQou75HLPZ9vO8YZY
         yE9i24h8sBqx+cKzWqDDLrqK7WSXpIIg37gy+UN7+VNVV/0IzhU6c/qCtimd6svYBmWL
         1BZEqVgjYUXkS1i99x7XGBUx8MCDjiW8HazLV0oAe7puxycYGDCI+HdelUeTgvDVUwrj
         Kdv2al00FqKy9ayLc/xkCryIqYkwbn49xPtF/Vu1yjNZBiDkrueu3rckLrqOFFvlWacB
         p7n+ArT+tlT4wF+tr4xxKUZmFKnTTCYI8LSb7zXm29DhRsih4NO98gsvMAVpRZYneFCu
         pAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UZQdXaxoRG+0tAk3Cn6xebBBU7hBeb3zc2jsH0lfFQI=;
        b=Pw26Jwf364Zvk5+FSkYsF/hD/3g0rVz+k9JXliYOi2eJjDez0YFb+BRfpl6OR7E1Bg
         zT3qUKlmMRXxoenVcLcoJQmaxByOyp8DmBWEj+k+4YpFC14S9Lwh88DqWqLYxDrN8cK1
         KR3WXW+6tAg02QTNAKwlurt7GGRhT2OiLi9LwCfCT12X35kKUgD+9YeXovfYn5fxkBNU
         O31a6JxW7XAj5gBxs38AbASKh//mbLmrDo46HJr0z6G7aQt2Ah3xXEAjSxOfP0DeHZ2d
         8uWxBHNYvpfkcuih2uLTvjnTWkJep52zinWDEeLFFqG13kAwaiWXA/xUIFJB+VxXVo4C
         5kRQ==
X-Gm-Message-State: APzg51D2kSluW8kSYKKh/NjAu/vGGWFvnC7S6OEPeDnRnnmoutzDppHX
        pEijOTCJTF53aCoaybeT+2JyHA==
X-Google-Smtp-Source: ANB0VdZEMjJ8COAelopoDs5TpU6ZjfloEC1UQ4ukpnsAK6oYx3gEmoonjb5275NdMIfzLLLLvypX1Q==
X-Received: by 2002:a50:95a8:: with SMTP id w37-v6mr9966939eda.33.1536830747907;
        Thu, 13 Sep 2018 02:25:47 -0700 (PDT)
Received: from cisco (85-220-54-220.dsl.dynamic.simnet.is. [85.220.54.220])
        by smtp.gmail.com with ESMTPSA id p28-v6sm4848165eda.85.2018.09.13.02.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 02:25:46 -0700 (PDT)
Date:   Thu, 13 Sep 2018 03:25:44 -0600
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
Message-ID: <20180913092544.GC4672@cisco>
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

Yes, I like this. It also future (or current-) proofs the API against
instances where we return an FD in a structure and not via the return
code of the syscall.

Tycho
