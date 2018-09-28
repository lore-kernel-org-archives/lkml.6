Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3384AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C212F2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWKIghWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C212F2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeI2Dgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:36:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42838 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeI2Dgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:36:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id w81-v6so4909486oiw.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVQOrYQQFizQjvXpBS1py/Hn3EBucELMQiGGQ8ijEnQ=;
        b=cWKIghWwJENAA/BZy0XxzBh9Ev1ibl4ChghcZJVosPIsdU8nzwaVbHdDOjLps+a0Eu
         T3kN2Xxp6Z+ui6aOpbe9kB47ZTVWdmbIuUHYlN26aLwEH4zt7cal4vTu8r8fNKgVH+YH
         n3tFn64yARyRVb+s74mdlK4BPIZfe5VKw0D0E7CUsS7tVxtQRJYQx9SIvnON4YyA5ls2
         ZQn45XG7kLDOrPRvmvPNj24wpOiqiBDGXa46O3h+AbBTaNPr7vPlWdRC4G4Lsa5j4heC
         0ysCPDqaim5yOrIgBASN47ac1DUNCAD+e9wVhdXYvRlb6aT387eD0tWSa0BJsY5YDy8u
         2i+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVQOrYQQFizQjvXpBS1py/Hn3EBucELMQiGGQ8ijEnQ=;
        b=VXAnf27l96okcvsCv4KrEgW6BeH0klViO0vn8KsECxSlgcg3eyRJ1cKeJkbZtADy59
         TpemgGPPGPhikXmm3GrxaJB6y+W+BDoGNvyW73Slg60mjM/8wwZVA5vXZiHVyRKjUl3P
         T09+fvSyhsy1bUqIpkLBGvcl5ld+N+z+gbndbb+fme+5o5Id2ARjw8BL7Puoo/vlUKNB
         MwCZQwKYKNXtYJjX6wHWWOn9B1Cg25sp4hjX9fguMioYY/gbmERHhkH3IgxwMaQ8Yf3B
         fFSeqHH7KATtsfP3sj4tgf4re5Eo9ONWFMNSvZ/95eUD4QAHttPlfc/ZhfbrcHim435R
         6LFw==
X-Gm-Message-State: ABuFfogHtWsNFMmnbj+ZS/YtZRI7H/AsnNf4NkrlW9d1pzzOly8wHoiE
        WggabIWgHG15Cf2XBNPTiNkw9PYwPvmpNgBRjTXYb9WsG2pMQlwH
X-Google-Smtp-Source: ACcGV61X44fWJTU97aP+6AzLvpqvc3zAsmsC5J3VW/CFmOheFMo8iMwD1vEQhsCDUKHUh5JmZz+RdtLbY5Jc/2ekiVk=
X-Received: by 2002:aca:3b45:: with SMTP id i66-v6mr225544oia.312.1538169074897;
 Fri, 28 Sep 2018 14:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180928154648.6320-1-tycho@tycho.ws> <20180928154648.6320-3-tycho@tycho.ws>
 <CAG48ez2h51s1VG8hf1ASHHq88r5b+6rS4nSkgvre77jgsJLbhg@mail.gmail.com> <20180928205652.GC18045@cisco.lan>
In-Reply-To: <20180928205652.GC18045@cisco.lan>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 23:10:48 +0200
Message-ID: <CAG48ez1CpPmk6BFOztA-=w1U-pvaNBXou6JpcfMKx_ELGSwDVA@mail.gmail.com>
Subject: Re: [PATCH 3/3] seccomp: introduce read protection for struct seccomp
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:56 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Fri, Sep 28, 2018 at 10:33:34PM +0200, Jann Horn wrote:
> > On Fri, Sep 28, 2018 at 5:47 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > As Jann pointed out, there is a race between SECCOMP_FILTER_FLAG_TSYNC and
> > > the ptrace code that can inspect a filter of another process. Let's
> > > introduce read locking into the two ptrace accesses so that we don't race.
> >
> > Hmm. Is that true? The ptrace code uses get_nth_filter(), which holds
> > the siglock while grabbing the seccomp filter and bumping its
> > refcount. And TSYNC happens from seccomp_set_mode_filter(), which
> > takes the siglock. So this looks okay to me?
>
> Oh, yes, you're right. So I guess we should just change the comment to
> say we're using siglock to represent the read lock.

Hmm... actually, looking at this closer, I think you only need the
siglock for writing. As far as I can tell, any read (no matter if
current or non-current) can just use READ_ONCE(), because once a
seccomp filter is in a task's seccomp filter chain, it can't be freed
until the task reaches free_task() and calls put_seccomp_filter() from
there. And if the task whose seccomp filter you're trying to read can
reach free_task(), you have bigger problems.
