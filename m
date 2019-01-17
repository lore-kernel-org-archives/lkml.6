Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE77C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3EF2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547718670;
	bh=vRuyrwi/utZf5ZJB0f3JkuQBow6hVkgSW8X0NUjlbu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nik1mrDQKyNl5PzSJ+c45u9m5pmwoEmQLLh3jfq8qgffIwvX6ZqolyeJbOyywexOb
	 bIvLSn/0b6GVB/NKnMbNoCkUTV1N7zjsfTxNaG6QatAiriQM0wSunSSdxEoJbk2xHS
	 jjhunEXD6K7E/vcjKQqJ4l282hvWkc+WabElEeNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfAQJvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:51:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36270 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfAQJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:51:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so347485wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 01:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bg/7mvzWWV2nFDCF6wF7j+tIcsg/UbEH7R9M+HW5IVk=;
        b=LlMaT8UBLM4rbICbVrGENmH4S8z7DsTGizef2aXIKIoBugbMVrc8qwCZNAutuXXrFn
         eNSn6myBLzUkN5uZZlgipHBMqhC01SiE8CkIGxnipySElph2FFriHZK7BNLJjZ2l9sbl
         uydotTRWa82nScBG/vCdESPwR3VLbMZC+Eg1gRZEV9/Gynq+GeZH5SmSn/VHpD0KFnyG
         /vgo1kNo40A/B4XJ1K1N9RbvO1M8cpWnJ0FkGJ2vS+x3v+EuvUS7viJiN++a7eA46Eje
         HmTYExcLIrxHrMjNyaAVD7xmR7SHAlwBgv0t3btPGOB/o/xoZjNWXxuVX1uXMMqtLJbC
         /tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bg/7mvzWWV2nFDCF6wF7j+tIcsg/UbEH7R9M+HW5IVk=;
        b=M2oo4TEk4h1oqx+MFvkRSMJtj0pcYJA3iyZnBMzzw7X3MRl8NrtonaZNAeEjbZvIww
         +hQWeWIRbcvVyL/IvxSDaf6DAadN3dMPVNi0WAL9LpFnQB5hRkfY1+ZFqrqjaLurYyM0
         RkxZXvyMoCxQC/RbnpjjNQEH8D5v5+ZX0SMuSlzwopYLy6Y3H903+TQdpllGIsNY3Sfx
         IGzELRFN8ZrQEgRGz/tqcdJaFYkHrpe41DhioV+x0BsSUv5PTa322IIOfMyvKC3PCker
         LwxvAMsDIYaZPhGQ+hD+7033pwqkwdFozS1Ar6Tk94H4x6V2eWfAukrlywC4Mq932OZy
         JLjA==
X-Gm-Message-State: AJcUukdoU7cs9B/PKQl/L5qKxk5g2UHTFIiQgOE+bNPiGD5yfYOWZzXh
        kC89biffqiwFvix8huG2BCc=
X-Google-Smtp-Source: ALg8bN5AoTpmOGwaDacQvx+EoX391dzC0KjlvFBTg7r9dvmeff8eenJfNR4jrZuigSIJvDDF43f6yQ==
X-Received: by 2002:a1c:99ce:: with SMTP id b197mr11306573wme.75.1547718665633;
        Thu, 17 Jan 2019 01:51:05 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 125sm66491636wmm.26.2019.01.17.01.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 01:51:04 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:51:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] timer fix
Message-ID: <20190117095102.GA88466@gmail.com>
References: <20181221123453.GA102366@gmail.com>
 <20181223192926.GA3728@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181223192926.GA3728@osiris>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> > -	if (timr->it_requeue_pending == info->si_sys_private) {
> > +	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
> >  		timr->kclock->timer_rearm(timr);
> 
> FWIW, with this patch the vanilla glibc 2.28 self tests
> rt/tst-cputimer1, rt/tst-cputimer2, and rt/tst-cputimer3
> start to fail on s390:
> 
> rt/tst-cputimer1.out:
> clock_gettime returned timespec = { 0, 117181 }
> clock_getres returned timespec = { 0, 1 }
> Timed out: killed the child process
> rt/tst-cputimer1.test-result:
> FAIL: rt/tst-cputimer1
> original exit status 1
> 
> rt/tst-cputimer2.out:
> clock_gettime returned timespec = { 0, 9686 }
> clock_getres returned timespec = { 0, 1 }
> Timed out: killed the child process
> rt/tst-cputimer2.test-result:
> FAIL: rt/tst-cputimer2
> original exit status 1
> 
> rt/tst-cputimer3.out:
> clock_gettime returned timespec = { 0, 0 }
> clock_getres returned timespec = { 0, 1 }
> Timed out: killed the child process
> rt/tst-cputimer3.test-result:
> FAIL: rt/tst-cputimer3
> original exit status 1
> 
> I haven't looked any further into this, just reporting.. otherwise the
> test systems seem to be healthy.

Could you please check whether the top commit in tip:timers/urgent fixes 
it:

  93ad0fc088c5: posix-cpu-timers: Unbreak timer rearming

?

It's in tip:master as well and should show up in linux-next tomorrow.

Thanks,

	Ingo
