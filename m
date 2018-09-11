Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB3C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FFA20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtuIGvXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FFA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeIKKCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:02:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46360 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeIKKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:02:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so11586596pga.13;
        Mon, 10 Sep 2018 22:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D8O6KbODzNH/4rq3B3TDuHdVP9YXrRxj++hoH+3R8dA=;
        b=XtuIGvXU8vpziprpRmkul0YA03Xi5Zf7WAcwicd+Ogr8BDpzjXoUOYxEp49Vm2K1GK
         uHjHdoD92hXeaRWlEZ0kbwybNqMAV0a+tkwVvlhMrNrNCG3DBs7FCn3Stoo/pWuiNowO
         rh3zjKKxrdFERAoz5vqTD8/zl7NscIFdYSNAjU38fmv7AT9dAZiXTXeZBVDWLrY98Ydo
         SprjfiXQb25YDiNYC/R++3FsjaaJQRF7L8McFol7hTpgE0+kLy0+DogUdHClGAYkM1zi
         IOzZ2Q2oPFF9Po0MqeCSNI+D6eDMf1k+Dnt5gAQqAgiQWe56wzyaGD8+IwpfLwpz6GXr
         w6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D8O6KbODzNH/4rq3B3TDuHdVP9YXrRxj++hoH+3R8dA=;
        b=m5GfON9OfDPKeOrKzn0otCIFpjx3LZj89/saSO0yUSsQ7HKOYu0lfNsSBE+UVzv/6e
         2VKhF3VUD+omFPJ9ZPT47umbqkEFwRKcXxPS5shG6Xmh5dk3C0IBFB5KiwVSdgH6Ihjt
         TLc83RxRt2XniOlrIlfICyYrFLS/g/1xXcUe//UUJvO8MiQOpQcywTuACtFCOdwhns8t
         IStv7zUTv/gMJo+aozf+KTs1VOIU4oXNb8XRipZtvwSCB4u0xuE5/ZkkvFAeVzqFETsL
         8zFUpza/bFNWd1FSdSZ/B3TysYL2Qh32iO6aNAI/C9XCiMiPlXnphihFbdqPmszr0TgE
         zsyg==
X-Gm-Message-State: APzg51CRurqNJPHiatRWV+dsXjYKoXw4XhMJgpRFIBFMJjYpb4GpYLfC
        WmpPB+9qAXptvLu3Auec2GUTc8+P
X-Google-Smtp-Source: ANB0VdY7aCYnL00I0U8pN/wnLcG65uF7lVyDrPKeS+qNRCVuf2wXbD+AffjKgLQB0fNzWncnu8QBBA==
X-Received: by 2002:a63:db15:: with SMTP id e21-v6mr26255964pgg.418.1536642294438;
        Mon, 10 Sep 2018 22:04:54 -0700 (PDT)
Received: from localhost ([39.7.19.225])
        by smtp.gmail.com with ESMTPSA id 1-v6sm38091098pfm.145.2018.09.10.22.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 22:04:53 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:04:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCHv3 2/6] tty/ldsem: Update waiter->task before waking up
 reader
Message-ID: <20180911050449.GB4065@jagdpanzerIV>
References: <20180911014821.26286-1-dima@arista.com>
 <20180911014821.26286-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911014821.26286-3-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/11/18 02:48), Dmitry Safonov wrote:
> There is a couple of reports about lockup in ldsem_down_read() without
> anyone holding write end of ldisc semaphore:
> lkml.kernel.org/r/<20171121132855.ajdv4k6swzhvktl6@wfg-t540p.sh.intel.com>
> lkml.kernel.org/r/<20180907045041.GF1110@shao2-debian>
> 
> They all looked like a missed wake up.
> I wasn't lucky enough to reproduce it, but it seems like reader on
> another CPU can miss waiter->task update and schedule again, resulting
> in indefinite (MAX_SCHEDULE_TIMEOUT) sleep.

Certainly, something suspicious is going on.

> @@ -118,6 +118,8 @@ static void __ldsem_wake_readers(struct ld_semaphore *sem)
>  		tsk = waiter->task;
>  		smp_mb();
>  		waiter->task = NULL;
> +		/* Make sure down_read_failed() will see !waiter->task update */
> +		smp_wmb();
>  		wake_up_process(tsk);

Hmm. I think wake_up_process() executes a full memory barrier, because
it accesses task state.

>  		put_task_struct(tsk);
>  	}
> @@ -217,7 +219,7 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
>  	for (;;) {
>  		set_current_state(TASK_UNINTERRUPTIBLE);

I think that set_current_state() also executes memory barrier. Just
because it accesses task state.

> -		if (!waiter.task)
> +		if (!READ_ONCE(waiter.task))
>  			break;
>  		if (!timeout)
>  			break;

	-ss
