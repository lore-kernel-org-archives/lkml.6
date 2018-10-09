Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49EAC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC85214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 12:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC85214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJITws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:52:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53584 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeJITws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:52:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id y11-v6so1705126wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 05:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dM1b/kNq8b/5hForRMWb+8uWwWe2vZiaohTxRCH1Mw8=;
        b=Q+tSW0b7eDWmxI4NwO3zEMnuCfihiizcYQnEE35ogTwY0PAY/U1pupbol4aPx9fS9G
         o6dpADhZhhX7R+A7QVX5HFf6CLigL7bndnPIcTt19dtqiyraZNj/5CSgHHSiSGZYlGzT
         dz0hhvDgJtjbLhDyOG9Kg5MvmH5yxD14SBVHZ3iGlR7ZkxvPQ9lD8HN+SMlTHph9FznF
         NLbPzQjD7VM4TdoYCZ7ZpQRmSSU+006tCK+ldxxCK3khwRd8EoGNFnQD3uyWF4ls0w7G
         +STTLbrtHdravV9z9DTNrMtSvbwmXjXwswaUoN+GAD2oYbXK4w4cFKIZr5zIlimVAESP
         bL2A==
X-Gm-Message-State: ABuFfoj+RGOYQhm7WNNPk22hE1hfuifYYJMw0IFjzJffd6SPLhvb0oG9
        mTL5aECNbU8J8rmljnBfMCFiUA==
X-Google-Smtp-Source: ACcGV61eq7MowspJbFGgd/u3BBvy69EEE/IucXK9CvDqXQ2juUn+a0pTaRt9/H7W9eBP9tmkusVrvg==
X-Received: by 2002:a1c:a683:: with SMTP id p125-v6mr1915470wme.24.1539088561871;
        Tue, 09 Oct 2018 05:36:01 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id x186-v6sm28788514wmx.24.2018.10.09.05.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 05:36:01 -0700 (PDT)
Date:   Tue, 9 Oct 2018 14:35:58 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        will.deacon@arm.com, andrea.parri@amarulasolutions.com,
        dietmar.eggemann@arm.com, patrick.bellasi@arm.com,
        henrik@austad.us, linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181009123558.GF9130@localhost.localdomain>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009105112.bhqlrabdt5ae5qmm@linutronix.de>
 <9837aa4b-1bd4-bc6a-84f7-0b8704995d44@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9837aa4b-1bd4-bc6a-84f7-0b8704995d44@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/18 13:56, Daniel Bristot de Oliveira wrote:
> On 10/9/18 12:51 PM, Sebastian Andrzej Siewior wrote:
> >> The main concerns I have with the current approach is that, being based
> >> on mutex.c, it's both
> >>
> >>  - not linked with futexes
> >>  - not involving "legacy" priority inheritance (rt_mutex.c)
> >>
> >> I believe one of the main reasons Peter started this on mutexes is to
> >> have better coverage of potential problems (which I can assure everybody
> >> it had). I'm not yet sure what should we do moving forward, and this is
> >> exactly what I'd be pleased to hear your opinions on.
> > wasn't the idea that once it works to get rid of rt_mutex?

Looks like it was (see Peter's reply).

> As far as I know, it is. But there are some additional complexity
> involving a -rt version of this patch, for instance:
> 
> What should the protocol do if the thread migrating is with migration
> disabled?
> 
> The side effects of, for instance, ignoring the migrate_disable() would
> add noise for the initial implementation... too much complexity at once.
> 
> IMHO, once it works in the non-rt, it will be easier to do the changes
> needed to integrate it with -rt.
> 
> Thoughts?

Makes sense to me. Maybe we should just still keep in mind eventual
integration, so that we don't take decisions we would regret.
