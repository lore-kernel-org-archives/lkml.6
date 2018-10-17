Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DA7ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A730D21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn52/ci1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A730D21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJQVcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:32:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37819 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQVcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:32:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so13217998pfi.4;
        Wed, 17 Oct 2018 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uk2371rWzRB+gtfe9hne5B1Zsq8KA4mf55vd7E4BvwE=;
        b=Nn52/ci18Xj0ndbuUnEp3srCLirYBljQl4JtYeAKFt2ccJUNd3oua7LHMl11h7Q4Fr
         uj1D2pvfM9mK/zf9FYsyDZDj43exacD0MazZGI5ym5A4v8q/oVR5XAa4xDpbCSIt91Dh
         rXVHGNyB2NOk6j+c8yz4HOrJ8yEQy7VPD/In+iLMLNAM23Zy/pR15YjJDi0bGe9wtF3n
         FeH0wXbsOc3lSTw8gPdEwG7iryeXmVNonhw54Sp2Grsy+QCeIu2eAS7Tc0bFvihHkfTC
         aHWeNimzyBDB4zsFCOkujVm7K0MXQT8XXGCk1J65YAKGvzqnwODBP+S07FK52KTsuVw5
         /bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uk2371rWzRB+gtfe9hne5B1Zsq8KA4mf55vd7E4BvwE=;
        b=fNvAZhOIn6ri8gYUO2QPlhQvTen26O+6H4SMVdwOcVkVl+ViEQHVeGYPMgO1SmK5dl
         hNIF+Lfapg/zCBjbbjb7pJ+8rpI1FGWmAoahTiwx5Vtl1VDxS6U2UZ1++4jL6Lw6pDfh
         m2AXWimN6MiGa2CVB9qzH+I+rmBC4sjmnolp+8n3mjCa6KvyI1fUqC88WCaxA/bD6fk3
         rR8265tXDBmRGfJBMKozJ5RBOlfYd+iO6f28QLVDqe5MeuIYmpPhXxucrVcexahxqWAn
         Fzrgb0ODmIm/v1t0P8pWb/Dy2WnpavcMa4lPBXb0eRriCUzH7r9DRaHNlDKK329vDKcf
         /IsQ==
X-Gm-Message-State: ABuFfoh8us2aGmrYojWE+Ap53Spymce5lQ7rC/StlkGj3ds3mt+dMkn1
        57oIFMvCllvmJAudGUhVDoY=
X-Google-Smtp-Source: ACcGV62s+AK3dwCkf3JahbDUrZHwN593Mfv/jCBcR8JL6Sy4YTkRH+84w9DDWvQ9SpNUnaWy6IiaQw==
X-Received: by 2002:a63:fa09:: with SMTP id y9-v6mr24452779pgh.177.1539783410678;
        Wed, 17 Oct 2018 06:36:50 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id s23-v6sm21917071pgg.67.2018.10.17.06.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 06:36:49 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 17 Oct 2018 22:36:38 +0900
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181017133638.GA426@tigerII.localdomain>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
 <20181016125415.GA3121@hirez.programming.kicks-ass.net>
 <20181017043251.GC1068@jagdpanzerIV>
 <20181017075728.GF3121@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017075728.GF3121@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/17/18 09:57), Peter Zijlstra wrote:
> On Wed, Oct 17, 2018 at 01:32:51PM +0900, Sergey Senozhatsky wrote:
> > This probably will be a bit more hairy. logbuf is written to by many
> > sources and is read from by many sides, including user-space [both read()
> > and write()]. So we will need more flags/magic around memcpy(). A simple,
> > "grab the logbuf entry, set the proper offset to point to the next available
> > logbuf record and then do memcpy()" won't suffice. We need a flag for
> > "memcpy() complete, we can read this entry". Otherwise:
> 
> Sure, but lockless buffers mostly have reserve and commit stages anyway.
> Exactly to avoid that problem.

Right. So it should be a lockless ringbuffer supporting multiple
parallel readers and multiple parallel writers from multiple contexts
(task, sortirq, irq, NMI); with sane wrap around, etc. And we probably
need to somehow keep the existing format of logbuf entries to avoid
breakages in crash tool, and so on. It will take a lot of time, I'm
afraid.

> > All right. OK. So we are on the same page here:
> 
> > - Have more opinions on this. People please speak out.
> > - Have clear "let's do it" from Cc-ed people.
> > 
> > 
> > If we are really doing this, then let's split it and have
> > incremental changes. Namely, what I suggest is:
> 
> I'd start by replacing logbuf with the lockless buffer and ripping out
> the current nmi/safe/etc.. bollocks.
> 
> There is absolutely no point what so ever in doing anything until that
> is sorted.

Peter, you have your point, however, I think I have a slightly different
priority list. On the top of my list - deadlocks in printk(). That's the
whole reason I sent this series. Deadlocks are real. We have real reports;
in the best case in form of lockdep splats; in the worst case - nothing,
simply because the system deadlocks in printk(), and even more - printk()
can deadlock in panic(). So addressing deadlocks in printk() will fix a
rather big, real problem. Then we can have fun with the rest of the things
you have mentioned. What do you think?

	-ss
