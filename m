Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C3621EF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8Qw1VKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C3621EF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934166AbeGCQjy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:39:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36588 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933792AbeGCQjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:39:52 -0400
Received: by mail-pg0-f67.google.com with SMTP id m19-v6so1228627pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ww9geydn5pw5H66UgKWm+8622ROtlPir+hEl4qOoS1Y=;
        b=c8Qw1VKTCGXTS/qMoS4qS7v+HIR5FQIlEUkCVZLgTmUaJODJW0LLjPArNSi/hZkiWh
         +o34sxNYbma5YogPbCiV+NGEjxQSrylUJvpJ4eIsj+Kac2rjoOfC4U7RhyWPCgWptNAp
         KQPLfQHForubXl/EfjsA4XhlHyduuwJMhzIAH+rTQl5QB10Gs0H5NzBTtarhhtU8QEOT
         NcbtnQccCmIvPRO2zVL2LksaC4cILMUEOUEa6ZDe3AwLRxuM0Dd0EveVprYYMagYX5fs
         +ohYlfmdH5XRNIlv6HXFH/+0H46ZkCKcE868ph88AHaSRugazXAVc/BalR9pE9i7bQqB
         VFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ww9geydn5pw5H66UgKWm+8622ROtlPir+hEl4qOoS1Y=;
        b=gSTwNFKOYXt5qmgN9GtJ6d58I3/2Xi1pSvu2ZqRl18y3mBuS3yfwcAwGRnU3ie4QzP
         n3CW/KSDX+mNMk701+llDGOp6MZUORVI3N3xtPdmLECA3iQbHPoKALsr2CtJfrW9aJHC
         St28ZW746ShpvUI1uOTTcAnwf13tSxf5elvMvf08uBGV/md35Fy61O9pXdw1Vc5dYgUl
         l+cVoUrhxi9gyzgtkKcuofoqKhHl2D9zauiLpyA3MfNWjaat4dWdLWXQfeEngy/MkvPD
         Sb3CGDzoNNe8i5LPeKe/4qFzxNAbUIZIGSNk+WxC7TMLGPPwaKl+nFMPJEOVvdjVmhHu
         SzrA==
X-Gm-Message-State: APt69E0VqNHWvuDI/0z35ShdMD7/KVvxBwIyG4hKM6C74+igr+rPm9Ze
        l4AH9xAPicPyBJPnMjSGzbM=
X-Google-Smtp-Source: AAOMgpfqWj6Q40fIN+T/INo43mywGLB8X5eKZ17OJH8GOhnXFUHA4p4AOstBmu9Gv25vJxhIrG0tzw==
X-Received: by 2002:a62:b612:: with SMTP id j18-v6mr30619755pff.199.1530635991853;
        Tue, 03 Jul 2018 09:39:51 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id v6-v6sm9628213pfa.28.2018.07.03.09.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:39:50 -0700 (PDT)
Date:   Wed, 4 Jul 2018 01:39:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: printk() from NMI backtrace can delay a lot
Message-ID: <20180703163948.GD391@tigerII.localdomain>
References: <bf037670-c647-b34a-486b-53ec3661b48e@i-love.sakura.ne.jp>
 <20180703043021.GA547@jagdpanzerIV>
 <20180703152944.GQ533219@devbig577.frc2.facebook.com>
 <20180703163145.GB391@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703163145.GB391@tigerII.localdomain>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/04/18 01:31), Sergey Senozhatsky wrote:
> it might be the case that we can do
> 
> 	serial_driver_handle_irq()
> 	{
> 		spin_loc(uart_port->lock);
> 
> 		.. TX / RX
> 
> 		spin_unlock(uart_port->lock);
> 
> 		tty_flip_buffer_push(uart_port->tty_port);
> 	}
> 
> This should break this chain
> 
> 	uart_port->lock -> pool->lock   // -> sheduler/etc.
> 
> 
> Can we do it? What am I missing?

Hmm, and we actually have some serial drivers that do tty_filp_buffer_push()
outside of uart_port->lock. For instance, drivers/tty/serial/efm32-uart.c
irqreturn_t efm32_uart_rxirq().

	-ss
