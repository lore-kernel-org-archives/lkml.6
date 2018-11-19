Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7020B20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsvo+Ub9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7020B20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbeKTFe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:34:58 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33715 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeKTFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:34:58 -0500
Received: by mail-yb1-f194.google.com with SMTP id i78-v6so13016817ybg.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E8mVeOV4zyh38SPqW03Y50APSG9h32kL2H9AswbrU+A=;
        b=lsvo+Ub9C50lbsGJvijQ7wgyjGGrYIVfly/MvCuRSBStMpYdXKFVsswzW3ptEuGLHZ
         OVXZYNugWluMv81mF3k2gsRSPIVOOFhNjv9rh+HCg40Q7stbmavRIIfl/xADVrk+9xct
         +Ob33QSnO778+zokTTct1vzK8YlexkcrHJqkZnsPz9ATI5Td3ZiWMpCMmeZQpGO9iV0y
         BKJspAoXsh//oRk+9PlmDrcUkklGSKQQlIvI1CMJqI8cPvWT4xss28C9pCtvmq7NGwel
         716CR9NouCxRm+8SWLGlvGH67HSBuD1GOw4xDOt7PCQvN9jYMS3MKGwqMtTwsrwKzc2e
         OsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E8mVeOV4zyh38SPqW03Y50APSG9h32kL2H9AswbrU+A=;
        b=CQEEtD8mAc+a8Sy5/GgAEO44QRSqytJ7VhGCEBOMV+KmyQwRUmmgwMi6l/7Vq9C9XZ
         iMYfBBj9JpPSF1ztCBoebcwSkS6KUS4RQUHRUlNEaOik+WpCxqdEdpfRHsnkO5NtHRba
         ZxY+XIYahzFT2rdHeV33K9RI3HPOjuEyFojEux6YjUja6z1ahQMHvya4REVpM2F/+f80
         kIGHdcw0OinOCl81Fj9DRSq8LVBiKb7rzzLEdPUopyXz597WMATRt1Unr4LadOl3LMAR
         QpNwQNEqbDqUZNrEbh506XXNZ79h6aTZD75noVRpRilLLjuKIviMxPwXst3GCaYDAXuy
         fWnQ==
X-Gm-Message-State: AA+aEWY7v55OfyEFPpBToaib+GinlioZ3L/doKE3Cc/djyxyf3rkx4p7
        QMztD7He74Dmq/UBmY4HJ3o=
X-Google-Smtp-Source: AFSGD/WY57ITjI4FIXWWAwWjwBRF7ZCNz1EOf8S5HnpZh+XQxehOk/REx6qBTfdpQMMpgjLmLKt4vw==
X-Received: by 2002:a25:6b08:: with SMTP id g8-v6mr6419710ybc.280.1542654599038;
        Mon, 19 Nov 2018 11:09:59 -0800 (PST)
Received: from [10.67.49.23] (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id h63-v6sm9609815ywb.110.2018.11.19.11.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 11:09:58 -0800 (PST)
Subject: Re: [PATCH] sched: Do not bug in __sched_setscheduler() when pi is
 not used
To:     Steven Rostedt <rostedt@goodmis.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Andrew Morton <akpm@osdl.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>
References: <20170309101842.1449d49a@gandalf.local.home>
 <46a07263-3327-94b6-f6b8-a0a17ae7bfee@broadcom.com>
 <20181119151311.GA5340@kroah.com>
 <20181119104654.47623a42@gandalf.local.home>
 <20181119162432.GB13065@kroah.com>
 <20181119113537.3aa4f05e@gandalf.local.home>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <06f2927d-5d5d-aca5-6a2e-e48836e4782c@gmail.com>
Date:   Mon, 19 Nov 2018 11:09:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119113537.3aa4f05e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/18 8:35 AM, Steven Rostedt wrote:
> On Mon, 19 Nov 2018 17:24:32 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>> On Mon, Nov 19, 2018 at 10:46:54AM -0500, Steven Rostedt wrote:
>>> On Mon, 19 Nov 2018 16:13:11 +0100
>>> Greg KH <gregkh@linuxfoundation.org> wrote:
>>>   
>>>>> Can this patch also be applied to the stable trees? The offending commit
>>>>> was first introduced in 4.2.    
>>>>
>>>> What is the git commit id of this patch in Linus's tree?  
>>>
>>> 896bbb2522587e3b8eb2a0d204d43ccc1042a00d
>>>
>>> The subject was changed when it was applied.  
>>
>> Ah, that helps.
>>
>> But why is this really needed in the older kernels?  You want to crash
>> your machine if someone got things wrong?  Given that I doubt this is
>> being hit anymore, why is it needed in 4.9.y and 4.4.y?
> 
> The problem is that it can crash when people didn't get it wrong (by
> using sysrq).
> 
> The bug happened when we combined two functions into one, and where the
> BUG_ON() from one was now added to the other function. The one (where
> pi is true) requires the function to be called with interrupts
> disabled. The other did not have this requirement (and pi happens to be
> false). Thus, you can trigger the BUG_ON(in_interrupt()) with a simple
> sysrq key stroke, and crash your kernel when it did nothing wrong.
> 
>>
>> Also, it doesn't apply there so someone needs to do the backport...
>>
> 
> I did the change against v4.2.8 below.

Thanks Steven! Here is the local 4.9 backport:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 917be221438b..6b3fff6a6437 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4087,8 +4087,8 @@ static int __sched_setscheduler(struct task_struct *p,
        int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
        struct rq *rq;

-       /* may grab non-irq protected spin_locks */
-       BUG_ON(in_interrupt());
+       /* The pi code expects interrupts enabled */
+       BUG_ON(pi && in_interrupt());
 recheck:
        /* double check policy once rq lock held */
        if (policy < 0) {


> 
> -- Steve
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6776631676e0..b2af7989eb5b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3682,7 +3682,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  	int reset_on_fork;
>  
>  	/* may grab non-irq protected spin_locks */
> -	BUG_ON(in_interrupt());
> +	BUG_ON(pi && in_interrupt());
>  recheck:
>  	/* double check policy once rq lock held */
>  	if (policy < 0) {
> 


-- 
Florian
