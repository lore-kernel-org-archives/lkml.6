Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236BAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D126322360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/zjGRiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D126322360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeKOHAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:00:18 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33633 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeKOHAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:00:17 -0500
Received: by mail-yw1-f68.google.com with SMTP id z72-v6so7887799ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RDFdrO0t/ndgEa1f1xybGimoAq+XCBq3BKX8G9M290o=;
        b=O/zjGRiDxIFt+mlTqzJNAprVCa+lDoOlN3VV9gl6KYa54UWLnc7JZQr1YlMoniZR+E
         A1OdkxuzeZEtirBZJsZyX9Ara5aE4Ydaum+MFxPrZ21z4FL+pcd0KzuV9ltmf+UBw6GN
         vPa8mHePIjdZ6zCdTuD9g+Oaj3vVyi4WIZRXWFtQkOngVT8MxqnOicPisyVzAJJutQ3H
         Jtj9OvOErXVHttN0wacbtF/0Hcv4gQfqkYyGumqvek1kwtoV0hEnMVdN7v376rBO/+nO
         mQQZyIDCeERQh9pxQLaMG4wPedIZ0Ouay6M+Z61i0VwLq/TL9HlBToIBMg50KUe+x/3K
         yspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RDFdrO0t/ndgEa1f1xybGimoAq+XCBq3BKX8G9M290o=;
        b=WVgoAqHZTmnZvS4CINUEG8Ls90ewy84oARiHXuDSFnMOAFS80qy1SMEL2B/Ohc6F0m
         Dh9wtuNzgCSCclRZBay00vJszcdI8cNRAWTlRLNnuDJNhTgyAfTdXsbMShaM+n+qmYTh
         Sif525Rta5vqW6JZIf8RG44rnGfBnZT8Cz9PAGKOwwbhvPJVRJA8gJHCsRKvIj+rJ1zm
         9kjQg/EzjpW8h2n87lOK2QmCe45EjLAuqFhhuLstXDe0vwJjZCsxONXD8bnDgiyTqy3x
         kPIPP8CkL001yn7rsRot9wBQUBfFpPKbNjka2l0sgkS9LyMaY8P47R394peo8NstVi08
         QANg==
X-Gm-Message-State: AGRZ1gJ5qfRvUTC3SvzWWbB8eS8Tei8LEIhraQOS9ABYUhp9GTWq9+Yy
        AXrrqaKo/OgBOIOX1K5nle0=
X-Google-Smtp-Source: AJdET5eCXQAWqkxEviOIKkm33wIaXLt4BRLni8fn6aLcXofljPu7lowolOC8SlaT1UsRn3B2a4rZbg==
X-Received: by 2002:a0d:d107:: with SMTP id t7-v6mr3146214ywd.440.1542228928214;
        Wed, 14 Nov 2018 12:55:28 -0800 (PST)
Received: from [10.67.49.62] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id j131-v6sm7349277ywa.84.2018.11.14.12.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 12:55:27 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
X-Google-Original-From: Florian Fainelli <fainelli@broadcom.com>
Subject: Re: [PATCH] sched: Do not bug in __sched_setscheduler() when pi is
 not used
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        gregkh@linuxfoundation.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Andrew Morton <akpm@osdl.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>
References: <20170309101842.1449d49a@gandalf.local.home>
Openpgp: preference=signencrypt
Autocrypt: addr=fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <46a07263-3327-94b6-f6b8-a0a17ae7bfee@broadcom.com>
Date:   Wed, 14 Nov 2018 12:55:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20170309101842.1449d49a@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/17 7:18 AM, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> 
> When priority inheritance was added back in 2.6.18 to sched_setscheduler, it
> added a path to taking an rt-mutex wait_lock, which is not IRQ safe. As PI
> is not a common occurrence, lockdep will likely never trigger if
> sched_setscheduler was called from interrupt context. A BUG_ON() was added
> to trigger if __sched_setscheduler() was ever called from interrupt context
> because there was a possibility to take the wait_lock.
> 
> Today the wait_lock is irq safe, but the path to taking it in
> sched_setscheduler() is the same as the path to taking it from normal
> context. The wait_lock is taken with raw_spin_lock_irq() and released with
> raw_spin_unlock_irq() which will indiscriminately enable interrupts,
> which would be bad in interrupt context.
> 
> The problem is that normalize_rt_tasks, which is called by triggering the
> sysrq nice-all-RT-tasks was changed to call __sched_setscheduler(), and this
> is done from interrupt context!
> 
> Now __sched_setscheduler() takes a "pi" parameter that is used to know if
> the priority inheritance should be called or not. As the BUG_ON() only cares
> about calling the PI code, it should only bug if called from interrupt
> context with the "pi" parameter set to true.
> 
> Link: http://lkml.kernel.org/r/20170308124654.10e598f2@gandalf.local.home
> 
> Reported-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Tested-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Fixes: dbc7f069b93a ("sched: Use replace normalize_task() with __sched_setscheduler()")
> Cc: Andrew Morton <akpm@osdl.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Can this patch also be applied to the stable trees? The offending commit
was first introduced in 4.2.

Thank you!

> ---
>  kernel/sched/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3b31fc0..7292fa9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4129,8 +4129,8 @@ static int __sched_setscheduler(struct task_struct *p,
>  	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
>  	struct rq *rq;
>  
> -	/* May grab non-irq protected spin_locks: */
> -	BUG_ON(in_interrupt());
> +	/* The pi code expects interrupts enabled */
> +	BUG_ON(pi && in_interrupt());
>  recheck:
>  	/* Double check policy once rq lock held: */
>  	if (policy < 0) {
> 


-- 
Florian
