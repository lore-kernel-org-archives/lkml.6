Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EACC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F785241DC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQOxaQRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F785241DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbeFVMn7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:43:59 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43091 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeFVMn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:43:57 -0400
Received: by mail-ot0-f195.google.com with SMTP id i19-v6so7324563otk.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=irfI0nFo1KeCKUAOKhXnoWL8wtmwKWrGjZ6K61EWv0A=;
        b=EQOxaQRwKBGNsgWycJ+918Qe9i98UMIpMoLA2SzSjShVdbrLtMeHptKovGTdWh8TSB
         mjhCbZiwSTxhHm16+s2XR6uUWjGcHnwAVy3Q19pzsxefFI8LFpZAIqxaSSXJ/tW8DMEE
         /wO9PCjBdyPF0j+s6GxTcje1Rz35Ss7HJfKR5u0pbw28B8LdNJVXP+eajwjjXl753LEd
         /1UoHoSds/xHMQS1Ll6Dhm8cngr03e8MqH5nTjJrjJNTWUwq3Yz0WftV0gtNN2PvFFxp
         Q0ToGxIr4qmzgjo/igXgEXyBrGjnUat8FRjwIZ0s1CLkN+/yevo14WZ7I1bVD9pupuLG
         sCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=irfI0nFo1KeCKUAOKhXnoWL8wtmwKWrGjZ6K61EWv0A=;
        b=fI7+cWYiXT6AzYGtbI4zAlxpd17k181X9o8dcDovjIdYcOVj5y0eqCxdSgZWzcZIhg
         dS+GskOrrXvq/BJbsAydqTlGTumTWCCv0gN2F8dnufgyqRl7MhfLFJl/lVDdG193Nzsr
         9M0ZutODR192196MRM1G7NQaZGGy92z2h8enmmQPJSwMG+Dm/b3xffjo87xzu7ffwNK0
         pyngVJ17pqM3Qo7d+RmK6AhvlOhVSzmzg/HEu+YxlF+1/o+Un/zvYy002UKyiVB6/L6w
         66Nw6f13ESfifF4ECSOYDmKFXlkfaN01TDU4JGVZMioC5tdMEzuJtLMARQljcANwwqk/
         EMGQ==
X-Gm-Message-State: APt69E1pdiSjsRfTh+okCEwptB7F+Vjk+XC9AR7dXGleolRJ9NSuPt7w
        PPssYbJs61Td/EHFHz75sg==
X-Google-Smtp-Source: ADUXVKJqeRTV9L+9EKeYma0aIJRkatKcE+ej41EeF1mZjREdVtuj8ZmFC6jHH/SNQMOEXS9kCY9tKQ==
X-Received: by 2002:a9d:17ce:: with SMTP id j72-v6mr905099otj.244.1529671436490;
        Fri, 22 Jun 2018 05:43:56 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id b63-v6sm3446054oia.4.2018.06.22.05.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 05:43:55 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id 8E961675;
        Fri, 22 Jun 2018 07:43:53 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH ] ipmi: kcs_bmc: fix IRQ exception if the channel is not
 open
To:     Haiyue Wang <haiyue.wang@linux.intel.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     luis.a.silva@dell.com, avi.fishman@nuvoton.com,
        openbmc@lists.ozlabs.org
References: <1529636218-280096-1-git-send-email-haiyue.wang@linux.intel.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <ea0a4cd3-2973-7ac8-c4a1-26379d9066cc@acm.org>
Date:   Fri, 22 Jun 2018 07:43:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529636218-280096-1-git-send-email-haiyue.wang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 09:56 PM, Haiyue Wang wrote:
> The original core KCS IRQ handling function 'kcs_bmc_handle_event' had
> a wrong logical desgin, it should force abort the KCS transaction only
> if the IBF flag is set, because multiple KCS channels share the same
> handle function; and it should return 0, which indicates that event of
> current channel is handled. An negative value -ENODATA will cause the
> IRQ handler of BMC KCS controller return IRQ_NONE, then IRQ moudle will
> treat this IRQ 'nobody cared', it will trigger IRQ exception.
>
>     irq 30: nobody cared (try booting with the "irqpoll" option)
>     CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.10.15-npcm750 #1
>     Hardware name: NPCMX50 Chip family
>     [<c010b264>] (unwind_backtrace) from [<c0106930>] (show_stack+0x20/0x24)
>     [<c0106930>] (show_stack) from [<c03dad38>] (dump_stack+0x8c/0xa0)
>     [<c03dad38>] (dump_stack) from [<c0168810>] (__report_bad_irq+0x3c/0xdc)
>     [<c0168810>] (__report_bad_irq) from [<c0168c34>] (note_interrupt+0x29c/0x2ec)
>     [<c0168c34>] (note_interrupt) from [<c0165c80>] (handle_irq_event_percpu+0x5c/0x68)
>     [<c0165c80>] (handle_irq_event_percpu) from [<c0165cd4>] (handle_irq_event+0x48/0x6c)
>     [<c0165cd4>] (handle_irq_event) from [<c0169664>] (handle_fasteoi_irq+0xc8/0x198)
>     [<c0169664>] (handle_fasteoi_irq) from [<c016529c>] (__handle_domain_irq+0x90/0xe8)
>     [<c016529c>] (__handle_domain_irq) from [<c01014bc>] (gic_handle_irq+0x58/0x9c)
>     [<c01014bc>] (gic_handle_irq) from [<c010752c>] (__irq_svc+0x6c/0x90)
>     Exception stack(0xc0a01de8 to 0xc0a01e30)
>     1de0:                   00002080 c0a6fbc0 00000000 00000000 00000000 c096d294
>     1e00: 00000000 00000001 dc406400 f03ff100 00000082 c0a01e94 c0a6fbc0 c0a01e38
>     1e20: 00200102 c01015bc 60000113 ffffffff
>     [<c010752c>] (__irq_svc) from [<c01015bc>] (__do_softirq+0xbc/0x358)
>     [<c01015bc>] (__do_softirq) from [<c011c798>] (irq_exit+0xb8/0xec)
>     [<c011c798>] (irq_exit) from [<c01652a0>] (__handle_domain_irq+0x94/0xe8)
>     [<c01652a0>] (__handle_domain_irq) from [<c01014bc>] (gic_handle_irq+0x58/0x9c)
>     [<c01014bc>] (gic_handle_irq) from [<c010752c>] (__irq_svc+0x6c/0x90)
>     Exception stack(0xc0a01ef8 to 0xc0a01f40)
>     1ee0:                                                       00000000 000003ae
>     1f00: dcc0f338 c0111060 c0a00000 c0a0cc44 c0a0cbe4 c0a1c22b c07bc218 00000001
>     1f20: dcffca40 c0a01f54 c0a01f58 c0a01f48 c0103524 c0103528 60000013 ffffffff
>     [<c010752c>] (__irq_svc) from [<c0103528>] (arch_cpu_idle+0x48/0x4c)
>     [<c0103528>] (arch_cpu_idle) from [<c0681390>] (default_idle_call+0x30/0x3c)
>     [<c0681390>] (default_idle_call) from [<c0156f24>] (do_idle+0xc8/0x134)
>     [<c0156f24>] (do_idle) from [<c015722c>] (cpu_startup_entry+0x28/0x2c)
>     [<c015722c>] (cpu_startup_entry) from [<c067ad74>] (rest_init+0x84/0x88)
>     [<c067ad74>] (rest_init) from [<c0900d44>] (start_kernel+0x388/0x394)
>     [<c0900d44>] (start_kernel) from [<0000807c>] (0x807c)
>     handlers:
>     [<c041c5dc>] npcm7xx_kcs_irq
>     Disabling IRQ #30
>
> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> ---
> Hi Corey,
>
> This patch looks introducing BIG modification, it should be easily
> understandable, and makes code clean & fix an error design, which
> is introduced by misunderstanding the IRQ return value.

I'm having a little trouble understanding your text above, so let me try 
to repeat
back to you what I'm thinking you are saying...

You have two (or more) devices using the same interrupt, and at least 
one is an
IPMI KCS device.  And interrupt comes in to the other device when the 
IPMI KCS
device is not running.  The original code issues an abort when that happens,
which is obviously incorrect.  It then returns -ENODATA, .

When the interrupt comes in for the abort handling, the driver will then 
issue
another abort, and again returns -ENODATA.  This time neither driver handles
the interrupt, resulting in the logs.

In general, I think the change you have here is good.  You don't want to
issue an abort in this case.  But...

If I am right, this fix doesn't completely solve the problem.  It does 
solve this
immediate problem, but what if there is an OS on the other end of the
KCS interface that sets the IBF flag?  The same situation will occur.  
In fact
it will occur even if there is only one handler for the interrupt.

Maybe it's best to have the interrupt disabled unless the device is open.
You have to handle the interrupt disable race on a close, but with the
sync functions that shouldn't be too hard.

-corey

>
> BR,
> Haiyue
> ---
>   drivers/char/ipmi/kcs_bmc.c | 31 ++++++++++---------------------
>   1 file changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> index fbfc05e..bb882ab1 100644
> --- a/drivers/char/ipmi/kcs_bmc.c
> +++ b/drivers/char/ipmi/kcs_bmc.c
> @@ -210,34 +210,23 @@ static void kcs_bmc_handle_cmd(struct kcs_bmc *kcs_bmc)
>   int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
>   {
>   	unsigned long flags;
> -	int ret = 0;
> +	int ret = -ENODATA;
>   	u8 status;
>   
>   	spin_lock_irqsave(&kcs_bmc->lock, flags);
>   
> -	if (!kcs_bmc->running) {
> -		kcs_force_abort(kcs_bmc);
> -		ret = -ENODEV;
> -		goto out_unlock;
> -	}
> -
> -	status = read_status(kcs_bmc) & (KCS_STATUS_IBF | KCS_STATUS_CMD_DAT);
> -
> -	switch (status) {
> -	case KCS_STATUS_IBF | KCS_STATUS_CMD_DAT:
> -		kcs_bmc_handle_cmd(kcs_bmc);
> -		break;
> -
> -	case KCS_STATUS_IBF:
> -		kcs_bmc_handle_data(kcs_bmc);
> -		break;
> +	status = read_status(kcs_bmc);
> +	if (status & KCS_STATUS_IBF) {
> +		if (!kcs_bmc->running)
> +			kcs_force_abort(kcs_bmc);
> +		else if (status & KCS_STATUS_CMD_DAT)
> +			kcs_bmc_handle_cmd(kcs_bmc);
> +		else
> +			kcs_bmc_handle_data(kcs_bmc);
>   
> -	default:
> -		ret = -ENODATA;
> -		break;
> +		ret = 0;
>   	}
>   
> -out_unlock:
>   	spin_unlock_irqrestore(&kcs_bmc->lock, flags);
>   
>   	return ret;


