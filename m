Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD564C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573572075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDQgjvKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573572075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeFUOR4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:17:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33304 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbeFUORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:17:55 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so3414250wro.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l1N8sDdXrs/iIAkD6Wgn9Zg5MzmwNisWx7qIgIPkFXQ=;
        b=uDQgjvKqIw6MS8HYdu2iqNzuTSYaOH/yQMh0saZx2uTH1PJHHktotyF4OrVquYaZT8
         /7ITbDO5/dzQAzxbgCd66ukxumkdFFNdGgpiWxq0n5uthL41kawMzYtOwwqWkfGdA7sF
         xTyQo3Bw7wPsVxs8t/MPzrFz232cUi+WwSwiVOU/1cV7im6YwsyYgQNw1KAIUSLoNyS5
         3wd3Gey2sBpMEBSn4FgACNUYuJh6Ukjb/6wsObKEpzZ3+NVNRFHgwpJNvrOAJmortb7j
         XGsKqQA/lL4iohei+SdEz2E93C0jzalBLDersailvTx+fo6ME3it/GmtsKo7V01inkH/
         mDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=l1N8sDdXrs/iIAkD6Wgn9Zg5MzmwNisWx7qIgIPkFXQ=;
        b=HVIgGd4E/cxeOkVP9ABCGUc9ZqbmHqfMTlWj4kvaUMaMSnMCUf+MkjCsDNCkMl5ZWa
         rnHXuBAJ6lhLGBAXfOqMWEomjFcc9XSQgD/HBWt0vPjauktvyCyaRPZLXnSgIoid5eHx
         r8EwEZ98abCq7L8CpvQGmBgu9zY+eZ+7vG99Z48PZXcp30dCeLENvlDPbrdV2euQNkVN
         XXLvimFw8n5RRcuL/pj0u5AHbqNvrPt/FuzD8Wncpz9ygSIPtJ+4WjSUKZ3vj5iR1ycI
         ailFwJM/i/yKpG9rv736+3bwL1BmhiID/HPBav1gr5getmEjMeXG7rhcETx6qa3YefY1
         0u9A==
X-Gm-Message-State: APt69E1JFOruoGHFrI5mBLs9cFcOyigpXubtFhUcQMVDoRwZNlpoywuY
        yfL2zIcao2eXlYO/bFocee0=
X-Google-Smtp-Source: ADUXVKJIkezHF2k0Y1u2bIsK59dieu8jhduO+4w8KdYzrm6Vgvs5qPpnrElLcpasjFAuVDvWCoXEWg==
X-Received: by 2002:adf:ec89:: with SMTP id z9-v6mr2690068wrn.160.1529590674602;
        Thu, 21 Jun 2018 07:17:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n56-v6sm12905348wrn.72.2018.06.21.07.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 07:17:53 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:17:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] semaphore: use raw_spin_lock_irq instead of
 raw_spin_lock_irqsave
Message-ID: <20180621141751.GA11853@gmail.com>
References: <alpine.LRH.2.02.1805301120180.3104@file01.intranet.prod.int.rdu2.redhat.com>
 <20180621135014.GA31371@gmail.com>
 <20180621140259.GA8492@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621140259.GA8492@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Mikulas Patocka <mpatocka@redhat.com> wrote:
> > 
> > > The sleeping functions down, down_interruptible, down_killable and
> > > down_timeout can't be called with interrupts disabled, so we don't have to
> > > save and restore interrupt flag.
> > > 
> > > This patch avoids the costly pushf and popf instructions on the semaphore
> > > path.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > 
> > > ---
> > >  kernel/locking/semaphore.c |   21 ++++++++-------------
> > >  1 file changed, 8 insertions(+), 13 deletions(-)
> > 
> > I've applied this to the locking tree, I suspect we can do this on the condition 
> > that it doesn't explode in early boot code (which has irqs disabled) and doesn't 
> > generate early boot lockdep splats either.
> 
> Hm, this blew up pretty quick on a pretty regular x86-64 PC white-box, during 
> early bootup:
> 
>   PANIC: early exception 0x08 IP 246:10 error ffffffff811537b2 cr2 0xffff88000240cff8
> 
> and I think it's due to your patch - verifying that now.

Yeah, went away after removing that patch. So I'm skipping this for now.

Thanks,

	Ingo
