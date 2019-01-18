Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3FAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94CE2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="N49JeN95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfARPHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:07:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33057 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfARPG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:06:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so11412558eds.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 07:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UG5RazuzYfJ1KO5e7eanUh1SuAeL9m8MpJpRXdF/EjI=;
        b=N49JeN95ffAVpN0Ow+fFUGlTvlwLtCpmy1HYRnxnjCKlRGS44WCu3yPGlctAmvEjiq
         ekQhs+NZRGsJ8iPgag+ukPujxhqsuhsxvO8PEv/bejj3PL8KPqJewYAfOb4ydeK1WzZV
         g4QauCXm2d8BwCqpRRCDlMFqhcNgVNbk73mUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UG5RazuzYfJ1KO5e7eanUh1SuAeL9m8MpJpRXdF/EjI=;
        b=GGbZBARphRTzyRwfox8nXwYPlBVNB5Tq8wFGbfjcn7QRaRJ2h6aTC5sqvrFvH1eSS6
         Pqdy4Mxiom5ZgUQ1e3muO+4McTUYQ5Zce+T5IWWeU3wlGCBhAblItKWl+OxZXV/vH3JK
         Q0xCPYvrtL7kqgkU/J+RxuAy5xBTAl9v9i8KC7Rc+L26q8H5PrG0tYRzI+8WisuC1Jv2
         CtrKbDVovQdBjnwCdGR6hd63eN7vCA7v4IvmWxKdoncrfyCHQdHs5phyGhZWB0URsH0j
         oSJqrYM9fIDm0c6pCDvWEu0YxeChlkFOycstyKGtGakEWyYGkzEhgzSoIPtMWAsJwdIc
         3wJA==
X-Gm-Message-State: AJcUukcN7wk4QJ83FSRuhJbzs+fv6nI1rF8pnxQ/TusJ6bn3Fbt4oBAI
        89s/Byof26O+2Mw9QpZV/OW7Lw==
X-Google-Smtp-Source: ALg8bN6tueaa2pvZGhoOAOZG6+I0Vm4IMz1EZQT98HNrDp/g5KJB/PBzt7H+6aKin2LQ73MIm9iuSA==
X-Received: by 2002:aa7:d487:: with SMTP id b7mr15699887edr.256.1547824017471;
        Fri, 18 Jan 2019 07:06:57 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id i8-v6sm2260291eja.45.2019.01.18.07.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 07:06:56 -0800 (PST)
Date:   Fri, 18 Jan 2019 16:06:50 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 0/5] sched refcount_t conversions
Message-ID: <20190118150650.GA8790@andrea>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:27:25PM +0200, Elena Reshetova wrote:
> I would really love finally to merge these old patches
> (now rebased on top of linux-next/master as of last friday),
> since as far as I remember none has raised any more concerns
> on them.
> 
> refcount_t has been now successfully used in kernel in many places,
> helped to detect bugs and mistakes in logic of refcounters.
> 
> This series, for scheduler and task struct specifically,
> replaces atomic_t reference counters with the new refcount_t type
> and API (see include/linux/refcount.h).
> By doing this we prevent intentional or accidental
> underflows or overflows that can lead to use-after-free vulnerabilities.
> 
> The patches are fully independent and can be cherry-picked separately.
> More information about each conversion in each patch separately.
> 
> Elena Reshetova (5):
>   sched: convert sighand_struct.count to refcount_t
>   sched: convert signal_struct.sigcnt to refcount_t
>   sched: convert numa_group.refcount to refcount_t
>   sched/task_struct: convert task_struct.usage to refcount_t
>   sched/task_struct: convert task_struct.stack_refcount to refcount_t

For the series, please feel free to add:

Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

(You may still want to update the references to the 'refcount-vs-atomic'
 doc. in the commit messages.)

  Andrea


> 
>  fs/exec.c                        |  4 ++--
>  fs/proc/task_nommu.c             |  2 +-
>  include/linux/init_task.h        |  1 +
>  include/linux/sched.h            |  5 +++--
>  include/linux/sched/signal.h     |  5 +++--
>  include/linux/sched/task.h       |  4 ++--
>  include/linux/sched/task_stack.h |  2 +-
>  init/init_task.c                 |  6 +++---
>  kernel/fork.c                    | 24 ++++++++++++------------
>  kernel/sched/fair.c              | 12 ++++++------
>  10 files changed, 34 insertions(+), 31 deletions(-)
> 
> -- 
> 2.7.4
> 
