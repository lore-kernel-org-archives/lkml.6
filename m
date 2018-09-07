Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A333C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B08A2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEEQLcpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B08A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbeIGTdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:33:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43182 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeIGTdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:33:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so7140920pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=36zAY2DHWxvvT0VTL3boJ68P+qNVmbWa8NyNfWlGihs=;
        b=MEEQLcpKfjQahwyI/CzENOnjPAeZNJkhX4lidOskuUsEq1v1i8BnAtA956tn3lIRL3
         7iTludnPv+it6+Fw1B76DzcwRqo2IoSecxXKjpGppXcaR6LnaRNxZ5pTbqwt81IWCLUa
         LrfULlujmZ8ZD2RwSCitlPRokNKLGkWwId/SeptVcAKLlVr9r2OyJqIdCepSrR7nTqmX
         JSD+15ucJ1YY84/JzL4xjmP2o4i29D1DkF0l7fxS3/MbaFA8Z1MJjZnD9TfY0EgF2TJi
         XrKiebNGVUzNE2ThoNw6OYUQlGTal3vLU07PJI7V3rXp+jLrhecty3YGUkRHVOuop4HC
         JQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=36zAY2DHWxvvT0VTL3boJ68P+qNVmbWa8NyNfWlGihs=;
        b=KY2ZWwRXkCJmgbdPR/l9Ctuykm+lNrc5Yj9q4STof3EMDXxB5icqFMhYEdcIP+vTqy
         EzMOaU0X8xl4b2VwLyhy3HUPPfqy5cdt5UboJmclCbRLeWOB+adAKRdKTRhi5aS02ch9
         m0x3xJGoCOt+pwBD1gmuLR0yKaf+FQuygf4UE/hSyRRhxddWP/o7+amMc1P3TRou9M22
         lmr9mN/Pka0vNNDEtOx8TBo4e/ANVF78st05JvpGIxF+SdFcqTQR8CtdvA0rfyzSx9uV
         rSnKnWpS+HJR9qgWzT4bDAFbbYvC1vZ9dF/iew74cy1dHPqY//P4QA2Ulh5q8lVSxjXi
         Lo8w==
X-Gm-Message-State: APzg51CgilKrYhoGpVcLoZZTxgJz2GsKvtf5TyxIORQgL0XRAnIXT5as
        tV+xyQiWxfLSWoRXGU4CipI=
X-Google-Smtp-Source: ANB0VdamAs74NcCkFZjT60/aZc1QCU9HY5S+qtM8CM7B941+3c1fpFOdMOP1VpywNllXozklYpdUBg==
X-Received: by 2002:a63:6849:: with SMTP id d70-v6mr8502822pgc.7.1536331946369;
        Fri, 07 Sep 2018 07:52:26 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id s16-v6sm10401751pfm.114.2018.09.07.07.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 07:52:25 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 7 Sep 2018 23:52:21 +0900
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907145221.GE482@tigerII.localdomain>
References: <20180905213334.03375777@vmware.local.home>
 <20180907073448.GL24106@hirez.programming.kicks-ass.net>
 <20180907094148.2444acc6@gandalf.local.home>
 <20180907134532.GD24106@hirez.programming.kicks-ass.net>
 <20180907095533.5b5febc2@gandalf.local.home>
 <20180907100128.64e08130@gandalf.local.home>
 <20180907140342.GH24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907140342.GH24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/07/18 16:03), Peter Zijlstra wrote:
> > 
> > I would even argue that placing printk_nmi_enter() between
> > lockdep_off() and ftrace_nmi_enter() is wrong because if in the future
> > printk_nmi_enter() were to do any ftrace tracing, it wont be caught, as
> > it was by having it before lockdep_off().
> > 
> > printk_nmi_enter() should not muck with IRQ state, nor should it do any
> > ftrace tracing. Since ftrace mucks with IRQ state when it gets enabled
> > or disabled, it will screw up lockdep, and lockdep will complain. That
> > way we can use lockdep not being off to catch this bug.
> 
> The very bestest solution is to rm -rf printk ;-)

Talented, capable and tremendously clever people had spent decades on
making printk what it is today. I feel responsible for respecting that
effort and, thus, my vote would be to keep printk around for a while.
... we also support !CONFIG_PRINTK builds ;)

	-ss
