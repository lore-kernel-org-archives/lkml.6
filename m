Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C22C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED91208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZEYQSt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED91208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754299AbeFUBX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:23:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43530 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754077AbeFUBX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:23:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so646231pfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QfgHYq4DOhue+2uitNTdGB/P2lky38ba7yx+RokfkBE=;
        b=YZEYQSt7SUdv/H83VhGiWr9a1b+KhtEH7HQeBvpXlnXI0CZ8wuHFc888hLz5ttMkP1
         tEd9b7oUBzj8eFxCBjsf1IvvZ143UQFUa55CNcWYwtHhOnZ1ZAceOMGpDfeOyNj8gbKH
         aIhINEqNq7bE3/XG8/x+jwAiuItiaKw7e9Zlr7PuCgGI0ojnLsB/JwEVHBvXjZxaxB0v
         pwV3Vewl3x5sHC+vTVsCkiXc+aSExI4368jR6VvXzGxM2GvQa3tYnoDnDuaEGh24kSte
         ldAWL5JV8ixmdbox7uqIl9PQx835kgyYmg5kHNOfcFF0HhOistMpGhyLjCjAoUOK+DoT
         oJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QfgHYq4DOhue+2uitNTdGB/P2lky38ba7yx+RokfkBE=;
        b=nK+4M0TMP+e25K0CFRlR7qA5AziWeiUBgB5VNYdc89b2pOLytcj+rNl8cGirelOXVV
         TmyChBC0K7f3mQoeUEkeCEizJBC/FxvD0kYT5wc/iJGHHihQiGyi+t+MNHRYO4mOCnTt
         ZEkBS140ijH0rIkQNjDonA9lUQNP6nZOv7z0Otlk7gAe4MuyWiMoQstHAw43XDWdU84G
         FpAGZkFryV3LTRgVmJUa/092tnN68oSYESOSbw3BriOYUAD8Voe41kOVvIrWmUSmMhlS
         IrsLUcP4ZdffnwJ+VNjvGlHje3lc607hBYVFNngtspyqV0deGXFnF6EjYFwfl6Izeyt/
         Zw9w==
X-Gm-Message-State: APt69E26p80SkpVZzZ9f3M5ldczekgVX10cT5vnvxDW9einNqSTely6t
        c3xGyEyhHhiIc2n3XBAJXqw=
X-Google-Smtp-Source: ADUXVKJnXJyod9/jrKrDb6ebOdOVJS+5QeLhSHYQLOrxVUO0w9CFplT4nbnPZw3pOANheKc8A2A7vw==
X-Received: by 2002:a65:450c:: with SMTP id n12-v6mr20871629pgq.242.1529544208071;
        Wed, 20 Jun 2018 18:23:28 -0700 (PDT)
Received: from localhost ([39.7.59.103])
        by smtp.gmail.com with ESMTPSA id s19-v6sm6440976pfe.97.2018.06.20.18.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 18:23:26 -0700 (PDT)
Date:   Thu, 21 Jun 2018 10:23:23 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hoeun Ryu <hoeun.ryu@lge.com.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Hoeun Ryu <hoeun.ryu@lge.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] panic: move bust_spinlocks(0) after
 console_flush_on_panic() to avoid deadlocks
Message-ID: <20180621012323.GB15462@jagdpanzerIV>
References: <1528091179-3015-1-git-send-email-hoeun.ryu@lge.com.com>
 <20180620143004.9dd0cf834acfcff5bd1bcb58@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620143004.9dd0cf834acfcff5bd1bcb58@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 14:30), Andrew Morton wrote:
> > From: Hoeun Ryu <hoeun.ryu@lge.com>
> > 
> >  Many console device drivers hold the uart_port->lock spinlock with irq enabled
> > (using spin_lock()) while the device drivers are writing characters to their devices,
> > but the device drivers just try to hold the spin lock (using spin_trylock()) if
> > "oops_in_progress" is equal or greater than 1 to avoid deadlocks.
> > 
> >  There is a case ocurring a deadlock related to the lock and oops_in_progress. A CPU
> > could be stopped by smp_send_stop() while it was holding the port lock because irq was
> > enabled. Once a CPU stops, it doesn't respond interrupts anymore and the lock stays
> > locked forever.
> > 
> >  console_flush_on_panic() is called during panic() and it eventually holds the uart
> > lock but the lock is held by another stopped CPU and it is a deadlock. By moving
> > bust_spinlocks(0) after console_flush_on_panic(), let the console device drivers
> > think the Oops is still in progress to call spin_trylock() instead of spin_lock() to
> > avoid the deadlock.
> 
> hm.  Sergey, is this at all related to the UART printk deadlock change
> which you're presently discussing in
> http://lkml.kernel.org/r/20180615093919.559-1-sergey.senozhatsky@gmail.com?

Hi Andrew,

Not exactly. The change I'm discussing is a little different - it's about
re-entrant UART [+ circular locking in TTY], when UART deadlocks us because
of printk()-s issued by MM/tty/WQ/sched/other core kernel stuff/etc

Example:
	IRQ -> uart -> tty -> WQ -> printk -> uart

	-ss
