Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08533C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A841B22DFB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="nC0CZtDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A841B22DFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934112AbeFVAvk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:51:40 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41919 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934052AbeFVAvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:51:38 -0400
Received: by mail-qt0-f193.google.com with SMTP id y20-v6so4620945qto.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 17:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b5z48HeJ1lP4NZgcMC1Xib0kcwWubGoVrtOpUOakYu8=;
        b=nC0CZtDxrf9nv7egcQzflXi3k/lu+RztX69n0MQhUmFzi5DjB2MGBFJz6R7JibnR8e
         +zg8B9P1Qh8JJvN5m5NGGKrswCi4zWBhhMWZA14RvvGRFeCsVXfZwC8qlHo9jPZ+MeMI
         Z0O1/Ug+j7JiwIySVUpG8jIVRpNT5YkepQueOpR7PLj5YqXz0PfQ59CS18PXh12TpMKs
         OOy/gy47RqsNRounZmYf1hB25NMc0LawlPWiLREtpMVH2UK0a6MJCeqaNY7SMIazxDSd
         VDXyUFHxK2mnAxdtctoRo0+1JlOgEzhfojrdDGqFnL1ALu6h2e+frYV9iN+CtmEscNFi
         7LcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b5z48HeJ1lP4NZgcMC1Xib0kcwWubGoVrtOpUOakYu8=;
        b=NrpQaMxgzdsV0CizGE9SE/emgN+gRVXYPaJlt7AgLG0CXpP4Dwfpoo1gwjbA+gS2pv
         FO1CK/hLAnokRw90qLxqmi+jK7L8XemMjrVNW8ZPq9tyJkwxNT4x70+291Xhxx61yz5r
         eC682U4ycqIyOK7aWGz+QCHre7ygcSCrmvytNWlJDr7O/VxX9bMSvgt3Am1lJ4WI0f3i
         1wqI26YFgO3tpi8lx+nnEbWoCUaEgEtXmLHRTx0tyxbvbVTouuGJTcqY8kKMRW8JGoi4
         sVHc8wgi47ewbZmjn9M6NMSDW5TpqibR8n5h4lHYOXwGmCWQsS5sWfSMMDTYLmZNTI4v
         rbHQ==
X-Gm-Message-State: APt69E0FTLaljiUjevYtQcuq+YzLpJsAfc65CzR8z/r6QWJZOWRazvBj
        826p6OqX1hA2usovRynU53IYeQ==
X-Google-Smtp-Source: ADUXVKJcojlNIdrZOXMVrw728SZEYEuWFW4LYPVUPW6qoaicZjPzS0oMqavLolEmWo9ENIwzMnDrNw==
X-Received: by 2002:ac8:2931:: with SMTP id y46-v6mr26022891qty.416.1529628697814;
        Thu, 21 Jun 2018 17:51:37 -0700 (PDT)
Received: from cisco ([173.38.117.67])
        by smtp.gmail.com with ESMTPSA id v123-v6sm4152739qka.79.2018.06.21.17.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 17:51:36 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:51:34 -0600
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
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH v4 4/4] seccomp: add support for passing fds via
 USER_NOTIF
Message-ID: <20180622005134.GJ3992@cisco>
References: <20180621220416.5412-1-tycho@tycho.ws>
 <20180621220416.5412-5-tycho@tycho.ws>
 <CAG48ez0d+tRsfvstU3Kd7T=kkdKbbfpNS+19NLTchhSL1fUyNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0d+tRsfvstU3Kd7T=kkdKbbfpNS+19NLTchhSL1fUyNg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:34:18AM +0200, Jann Horn wrote:
> On Fri, Jun 22, 2018 at 12:05 AM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > The idea here is that the userspace handler should be able to pass an fd
> > back to the trapped task, for example so it can be returned from socket().
> [...]
> > +Userspace can also return file descriptors. For example, one may decide to
> > +intercept ``socket()`` syscalls, and return some file descriptor from those
> > +based on some policy. To return a file descriptor, the ``return_fd`` member
> > +should be non-zero, the ``fd`` argument should be the fd in the listener's
> > +table to send to the tracee (similar to how ``SCM_RIGHTS`` works), and
> > +``fd_flags`` should be the flags that the fd in the tracee's table is opened
> > +with (e.g. ``O_EXCL`` or similar).
> 
> fd_flags only contains file descriptor flags (meaning only O_CLOEXEC).
> O_EXCL is a file creation flag, so setting it here wouldn't make sense.
> Setting file status flags like O_APPEND does make sense, but those are
> stored in the `struct file` and don't need to be passed separately;
> the caller can e.g. set them via fcntl(fd, F_SETFD, flags) or on
> open().
> (The fcntl.2 manpage explains these.)

Ugh, yes, O_CLOEXEC is what I meant. Thanks, I'll clarify.

Tycho
