Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB36AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3ED20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="WPnC58vB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3ED20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJaA0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:26:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40583 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeJaA0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:26:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id m15so11479067otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ej+TBrMycnKrRcD4swUe6/SvOGhchNFh6tJY76T68lw=;
        b=WPnC58vBHQPd3RVFa2EoaMW59gNLB1nPsiJpTsraDGPlOhmBhqozToWfL+7Y8dxTJv
         MEOmVnFM6mXYR9jCeZaOW9N0dKne+gbTNCnc3tmCXLOHoFZdtCWeCtfSY8jzaDGsp5lw
         jnQlbSTjnD7iAf2Tv6O8dGp+z3x5geX1IaZ9vs/vWtDt13n8yY+tt/UFVkNKqtprszDE
         2kxKleiTevI4wX4yacOcvHM+kZKiK6CK0zCGSsZpgPpeWjCzQfUfvwKh/qko4zeygUCt
         eJcWM0+IYDRmZnGXPp4dTRWd5D5ElIyuC7EkrePgTc0QA3TM2tkoURD6tzt8OwA/qEN5
         wAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ej+TBrMycnKrRcD4swUe6/SvOGhchNFh6tJY76T68lw=;
        b=c76r3r0snGteVasKqDnmryopYOiCqW/idOeHMMmKE6eus324H6pPpw9UT8ri2e4dZP
         78GAA3P77bobo5Ut2npqt9SvGbTqTddGvkYKEs7BwYaOe4roguUaNRboxZgnRMh3mlMh
         jkLLfDq29SDn9Z4s59yJa7QSxga5Ghdy8i4YtWDTBwwSEk/d2VRxB4fWu/Kt8L+Abb4e
         AE6jGaSJ4mcRuKpV4lXtFBapcDzc0r9f+43Z/IBpUsdQE0yYMk42Ke99a6Go1B5EhpyI
         d+v+AQHSxnY4ugszOXSzdJ0Vnh8b4S/nYQlffiJ4629aQgO7qGJg1RTcOovb3e9U4Bsq
         vHPQ==
X-Gm-Message-State: AGRZ1gIbT1BbCMWvh7tal/cl7OY4jVIftiU0Xxydi2I6kQSbrIIhnln1
        lun7YbXJLqNgpG6ReAI0Xqjj1w==
X-Google-Smtp-Source: AJdET5cwX7k28oEp81+8hyseG5ahwwp8CEWuWAXRtudK/mqiMFpqQcmmSaN677AZKq5g5vuvvaolvg==
X-Received: by 2002:a9d:4194:: with SMTP id p20mr4632713ote.266.1540913556022;
        Tue, 30 Oct 2018 08:32:36 -0700 (PDT)
Received: from cisco ([128.107.241.161])
        by smtp.gmail.com with ESMTPSA id a42sm7166674otj.46.2018.10.30.08.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 08:32:34 -0700 (PDT)
Date:   Tue, 30 Oct 2018 09:32:31 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181030153231.GB7343@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181030143235.GA3385@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030143235.GA3385@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Tue, Oct 30, 2018 at 03:32:36PM +0100, Oleg Nesterov wrote:
> On 10/29, Tycho Andersen wrote:
> >
> > +	/* This is where we wait for a reply from userspace. */
> > +	err = wait_for_completion_interruptible(&n.ready);
> > +	mutex_lock(&match->notify_lock);
> > +
> > +	/*
> > +	 * If the noticiation fd died before we re-acquired the lock, we still
> > +	 * give -ENOSYS.
> > +	 */
> > +	if (!match->notif)
> > +		goto remove_list;
> > +
> > +	/*
> > +	 * Here it's possible we got a signal and then had to wait on the mutex
> > +	 * while the reply was sent, so let's be sure there wasn't a response
> > +	 * in the meantime.
> > +	 */
> > +	if (err < 0 && n.state != SECCOMP_NOTIFY_REPLIED) {
> > +		/*
> > +		 * We got a signal. Let's tell userspace about it (potentially
> > +		 * again, if we had already notified them about the first one).
> > +		 */
> > +		n.signaled = true;
> > +		if (n.state == SECCOMP_NOTIFY_SENT) {
> > +			n.state = SECCOMP_NOTIFY_INIT;
> > +			up(&match->notif->request);
> > +		}
> 
> I am not sure I understand the value of signaled/SECCOMP_NOTIF_FLAG_SIGNALED...
> I mean, why it is actually useful?
> 
> Sorry if this was already discussed.

:) no problem, many people have complained about this. This is an
implementation of Andy's suggestion here:
https://lkml.org/lkml/2018/3/15/1122

You can see some more detailed discussion here:
https://lkml.org/lkml/2018/9/21/138

> > +		wake_up_poll(&match->notif->wqh, EPOLLIN | EPOLLRDNORM);
> > +
> > +		mutex_unlock(&match->notify_lock);
> > +		err = wait_for_completion_killable(&n.ready);
> > +		mutex_lock(&match->notify_lock);
> 
> And it seems that SECCOMP_NOTIF_FLAG_SIGNALED is the only reason why
> seccomp_do_user_notification() doesn't do wait_for_completion_killable() from
> the very beginning.
> 
> But my main concern is that either way wait_for_completion_killable() allows
> to trivially create a process which doesn't react to SIGSTOP, not good...
> 
> Note also that this can happen if, say, both the tracer and tracee run in the
> same process group and SIGSTOP is sent to their pgid, if the tracer gets the
> signal first the tracee won't stop.
> 
> Of freezer. try_to_freeze_tasks() can fail if it freezes the tracer before
> it does SECCOMP_IOCTL_NOTIF_SEND.

I think in general the way this is intended to be used these things
wouldn't happen. Of course, it would be pretty easy for someone who
was malicious and had the ability to create a user namespace to
exhaust pids this way, so perhaps we should drop this part of the
patch. I have no real need for it, but perhaps Andy can elaborate?

Tycho
