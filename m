Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5611C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EBF20671
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="xLa+anWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EBF20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeI2EBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:01:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40576 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeI2EBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:01:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id n31-v6so5328500pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p0Rn2oFe/6hznO3NPjkrSRQTmzEzp1V3hJsY2r8gT30=;
        b=xLa+anWEY5+H6jIchBEs6Z4+iLIsRAs/sVTxYqXsfCFmUqXqcRquXfrk5To0HW4btV
         3xIVcALC00nitap/OP2mPwgHElJU8niYEkci7b+29UziSQf8SA2yupT8XOI/4TF8esAb
         9p2mxbpm63Tncd9Qe2C23JZTZzuBi/kf5tfoCeaY1Yy+9cmoqT8JS06XDpaA8xwFt9Gv
         J/fHKU8OtWTFrDHZ/gQmHNEs/0nObmLyMQFT6GNUv3cHbFku9qudvZDohW34r08plwEk
         He5dqg1W4G2BOicfl3daAgQEzkUCBvmqknRp8eooblVo0GSaVWEi1hXqhlsE7gMLJGJF
         dUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p0Rn2oFe/6hznO3NPjkrSRQTmzEzp1V3hJsY2r8gT30=;
        b=JlrYGtBGL3OrvP9qw89+00kMn+Hy9N4zY6XmhzYubiUdEHLTUaxMeFAlhE4HcGHzwo
         PJYpHonAbadn1oj+gyXSUg+L9C2MdhMLbapfgAvM5dAZXUon+qijF3mKw6HzCSzWCD18
         lqSvqf3qimIiTIJ9C1i5lIIRqA1jmNZy1sw4+p6DchKE2J8ZGJuIfnpQyOKgkelObP8w
         NsD2k9jzplv6QsaowRWBlwE930q9RqG195WSNECnAx0K26P7X0BmxOW9Bhx2YHLWqhks
         WThdDCjSmTn0FHneJBVRyfENJ16Gh4SA5laK++HdPso1WZCq8jK7fIPm86luxuXr5p7S
         8E2A==
X-Gm-Message-State: ABuFfogVfLusTYYYIecXp41xll908Prr1dxCPjo1JrLuSwlsRBRcBoVO
        OHuapHkAPa0d0RpjamQvT2fJ6w==
X-Google-Smtp-Source: ACcGV62Q/98Gk+3+sbbMn3Lcs/IamJ2YyZW1oQ0oOHOlWCpMGdksdx3u8pTaLccGpbGwcpkI9xbwwg==
X-Received: by 2002:a17:902:1744:: with SMTP id i62-v6mr400856pli.315.1538170560082;
        Fri, 28 Sep 2018 14:36:00 -0700 (PDT)
Received: from cisco.lan ([128.107.241.171])
        by smtp.gmail.com with ESMTPSA id g3-v6sm6992930pgn.37.2018.09.28.14.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 14:35:58 -0700 (PDT)
Date:   Fri, 28 Sep 2018 15:35:57 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/3] seccomp: introduce read protection for struct seccomp
Message-ID: <20180928213557.GD18045@cisco.lan>
References: <20180928154648.6320-1-tycho@tycho.ws>
 <20180928154648.6320-3-tycho@tycho.ws>
 <CAG48ez2h51s1VG8hf1ASHHq88r5b+6rS4nSkgvre77jgsJLbhg@mail.gmail.com>
 <20180928205652.GC18045@cisco.lan>
 <CAG48ez1CpPmk6BFOztA-=w1U-pvaNBXou6JpcfMKx_ELGSwDVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1CpPmk6BFOztA-=w1U-pvaNBXou6JpcfMKx_ELGSwDVA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:10:48PM +0200, Jann Horn wrote:
> On Fri, Sep 28, 2018 at 10:56 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Fri, Sep 28, 2018 at 10:33:34PM +0200, Jann Horn wrote:
> > > On Fri, Sep 28, 2018 at 5:47 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > > As Jann pointed out, there is a race between SECCOMP_FILTER_FLAG_TSYNC and
> > > > the ptrace code that can inspect a filter of another process. Let's
> > > > introduce read locking into the two ptrace accesses so that we don't race.
> > >
> > > Hmm. Is that true? The ptrace code uses get_nth_filter(), which holds
> > > the siglock while grabbing the seccomp filter and bumping its
> > > refcount. And TSYNC happens from seccomp_set_mode_filter(), which
> > > takes the siglock. So this looks okay to me?
> >
> > Oh, yes, you're right. So I guess we should just change the comment to
> > say we're using siglock to represent the read lock.
> 
> Hmm... actually, looking at this closer, I think you only need the
> siglock for writing. As far as I can tell, any read (no matter if
> current or non-current) can just use READ_ONCE(), because once a
> seccomp filter is in a task's seccomp filter chain, it can't be freed
> until the task reaches free_task() and calls put_seccomp_filter() from
> there. And if the task whose seccomp filter you're trying to read can
> reach free_task(), you have bigger problems.

Ok; looks like get_nth_filter() took the siglock anyway. Since we get
the filters in these two functions in get_nth_filter(), I think it's
enough just to just,

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index f65d47650ac1..79d833ed4c34 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1001,7 +1001,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
 		return ERR_PTR(-EINVAL);
 	}
 
-	orig = task->seccomp.filter;
+	orig = READ_ONCE(task->seccomp.filter);
 	__get_seccomp_filter(orig);
 	spin_unlock_irq(&task->sighand->siglock);
 

since once it's returned from get_nth_filter() we don't need to worry
about multiple accesses?

Tycho
