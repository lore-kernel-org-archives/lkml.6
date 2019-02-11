Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF2BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAA220838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549882546;
	bh=SsKlMn5w9nyiAatHpJxqKE/lpoMbVdgn+GWqtKas180=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hQb8bkA1U9DnuNohE7uVeDgwREb0KDYgU/jZdUye4mbwYc4xFp8I5CioEOKM2U1g2
	 r1lrngTa/Y6AUggQCnvDh4uxCwHJLzobw3FUHOImHSqlAhCSD237H8FJZY24xA+L5B
	 1f9WgiAGVOWQM/XKgnvr8D15KyvtCpc4rhPJtzD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfBKKzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:55:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52336 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:55:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so16944112wml.2;
        Mon, 11 Feb 2019 02:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KMN64kOtJBFkKLD7eH5E1tsIkp4xo4LmSrCHlHm3ADQ=;
        b=QDtcr3wyAWwC1Feiwyp3X/8YTfaIdNpEWSGZejYjQTG/rj0trYk0vC6rQn4y2cNbXv
         il1Avd23/d1Hd8k+uTbZBtAoIRuLEkjW3uPerX4NcbTux104Th18LvFAtlUMw0zOO1LL
         tLmqEa0y4zRbQ5L3wXHA0BYGnh9on2hBdn58O1L8DaUmAwdWpiMdKB6WiTyS7C6wf6Bh
         MC78xcq2N19Sr8d1ee6X2SFh4BhB3mZOszFFAIe2XAVy/T1Xcb8vx1blQzxEH3d3ygOa
         1lUqargunUNH4IWUAEw1tmMjRZ4VOjSK4lFppReznME5P372JKKIbFQpvePfCELqMthw
         iSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KMN64kOtJBFkKLD7eH5E1tsIkp4xo4LmSrCHlHm3ADQ=;
        b=pne4pS2JNvI7BA1U8r2TvIXJxOUUITozzkbhA2bMYD3ZsLqYf9hrPrAd3mwh6L8Vl9
         wuJqLQVWpu2/ruYuQ6Oa2KHA9Y1tKkQqkwnblf0EPg2YJ8PC2Vl2EiVr9eXejr7oxb5A
         YUykoU4FhYzRuVGs01dyYqr2h7b2Kr+Gj9Y7lsH72SJ+1wrurRTA0BukymPJEdqmcfPz
         fCKAAiDW2MYQR8XSB8Lh6jiAC6HZA6s5YhBjg4pF8qAMbMwcVsGI5HXnE2YggHeKjuRT
         GnWu3HBI4fSOkCq0ZzFuDIgEzP52qdGKQ4hnZiI03EIVFgPHzfQH8w5bxvmHp2N7NOS1
         hnDw==
X-Gm-Message-State: AHQUAuYeqGJ7bP/gtMix7eJrHHwAfQIFB9YGQYPNd27ttTAd048mfTs+
        EP/F93LyJtTPev6eQiw/t2Q=
X-Google-Smtp-Source: AHgI3IYfCwXm72SvHpZjHfYZL/JOp3IzO2HnfloWBghOcIo+EQ24FCA5PhxAIN+bIRKZbXHjD7QYjw==
X-Received: by 2002:a1c:a6c9:: with SMTP id p192mr2919879wme.58.1549882540793;
        Mon, 11 Feb 2019 02:55:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s8sm22757121wrn.44.2019.02.11.02.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 02:55:40 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:55:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211105537.GA59133@gmail.com>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <a610aeb2-b1cb-0d57-8078-97d1051481f9@redhat.com>
 <20190211071159.GA55579@gmail.com>
 <20190211103927.GA118071@gmail.com>
 <20190211105214.GA30880@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211105214.GA30880@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Will Deacon <will.deacon@arm.com> wrote:

> On Mon, Feb 11, 2019 at 11:39:27AM +0100, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > > Sounds good to me - I've merged this patch, will push it out after 
> > > testing.
> > 
> > Based on Peter's feedback I'm delaying this - performance testing on at 
> > least one key ll/sc arch would be nice indeed.
> 
> Once Waiman has posted a new version, I can take it for a spin on some
> arm64 boxen if he shares his workload.

Cool, thanks!

	Ingo
