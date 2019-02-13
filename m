Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689C4C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350EC222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOxNlfEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbfBMBbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:31:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43579 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfBMBbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:31:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so335451pfh.10;
        Tue, 12 Feb 2019 17:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u8ORMKanCS7msn/j0yfqCuZ7sBg7zyiiY6K/xZBXzfE=;
        b=UOxNlfEzKZ73BS9nodoz3m03nyqKSaIcikvL56L+IIaBGBXJV7xCq+tkB6iHN3QV3o
         j+ZZPXlWK59IEwmQQrw2rHo4WiB0Eye2OEPY9S5CHB0jou07C4ov30hMlh8dATiWvZ6p
         PDhaOmcKYIKeqN2SHlOFnzA201T+1xN9qkq2Q93N+ktJTdXjCe3OqxiHwgDAinXLOfQ4
         wxDansatpHODcQL9MFrr9M1q2Zs8Q1T+soDge/jqASvFV9XCb6SbnuiQ+S+hLzh3U+Xq
         lgjypN2dK53dGP6yn/mHUCCGWfBo1766xnPeNt7iuXIaYTbmuHLMlAWPE/vJ8WvWCEfq
         Xz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u8ORMKanCS7msn/j0yfqCuZ7sBg7zyiiY6K/xZBXzfE=;
        b=kQkBnkvPzVqin4iCfkXwwigAkEYRdhXFReS4i9MPUGoggi2iwif04FfvlVXdDogEzG
         Bv4L70lRl7aTpQLaqjESvnDRTfKW4aY5w8d5qrw7wX/mwNY9PRfSVAdR0uEv01QcSKT9
         QJbTlwBy0UDJAJ+Uvq9TO6vlab0Gv2EuZcgX19+XCpYMB+HJ6ILO62Omm8mHUPWTlmZ9
         dw+7p4+WAfRywuPN3WokiB1+39cQadaa4ppXNQJQgD2Pkw5QsYIee7G+kClLq5+gz8rI
         /XPXmohFeGJm8OBt35VsNq16K7XTkbG0UuV3deONAxfJ4HRKc65TMDcl1+Vhnf7+2bgF
         ETCw==
X-Gm-Message-State: AHQUAuZtuE9KvcbCr5T5SexuxuQ960LLjFW1L0sfypGeLz2EdcMsaBmS
        XlTb6I778+H4gSvfKkwGSQk=
X-Google-Smtp-Source: AHgI3IY67RCYsR89ZR2YAYx9h6Vw1+tyhszNf16YTwbdjFCzbsAG/vJqVdsswWzWxMFpgDZERj5Egw==
X-Received: by 2002:a62:b2c3:: with SMTP id z64mr6886232pfl.149.1550021466360;
        Tue, 12 Feb 2019 17:31:06 -0800 (PST)
Received: from localhost ([39.7.15.189])
        by smtp.gmail.com with ESMTPSA id k17sm190245pfj.92.2019.02.12.17.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 17:31:05 -0800 (PST)
Date:   Wed, 13 Feb 2019 10:31:01 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20190213013101.GA8097@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
>
> 1. The printk buffer is protected by a global raw spinlock for readers
>    and writers. This restricts the contexts that are allowed to
>   access the buffer.

[..]

> 2. Because of #1, NMI and recursive contexts are handled by deferring
>    logging/printing to a spinlock-safe context. This means that
>    messages will not be visible if (for example) the kernel dies in
>    NMI context and the irq_work mechanism does not survive.

panic() calls printk_safe_flush_on_panic(), which iterates all per-CPU
buffers and moves data to the main logbuf; so then we can flush pending
logbuf message

	panic()
	  printk_safe_flush_on_panic();
	  console_flush_on_panic();

We don't really use irq_work mechanism for that.

> 3. Because of #1, when *not* using features such as PREEMPT_RT, large
>    latencies exist when printing to slow consoles.

Because of #1? I'm not familiar with PREEMPT_RT; but logbuf spinlock
should be unlocked while we print messages to slow consoles
(call_consoles_drivers() is protected by console_sem, not logbuf
lock).

So it's

	spin_lock_irqsave(logbuf);
	vsprintf();
	memcpy();
	spin_unlock_irqrestore(logbuf);

	console_trylock();
	for (;;)
	    call_console_drivers();
	    				// console_owner handover
	console_unlock();

Do you see large latencies because of logbuf spinlock?

> 5. Printing to consoles is the responsibility of the printk caller
>    and that caller may be required to print many messages that other
>    printk callers inserted. Because of this there can be enormous
>    variance in the runtime of a printk call.

That's complicated. Steven's console_owner handover patch makes
printk() more fair. We can have "winner takes it all" scenarios,
but significantly less often, IMO. Do you have any data that
suggest otherwise?

> 7. Loglevel INFO is handled the same as ERR. There seems to be an
>    endless effort to get printk to show _all_ messages as quickly as
>    possible in case of a panic (i.e. printing from any context), but
>    at the same time try not to have printk be too intrusive for the
>    callers. These are conflicting requirements that lead to a printk
>    implementation that does a sub-optimal job of satisfying both
>    sides.

Per my experience, fully preemptible "print it sometime maybe"
printk() does not work equally well for everyone.

	-ss
