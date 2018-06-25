Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E36C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C41B26076
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGiB5VHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C41B26076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935010AbeFYTe4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:34:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43029 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933030AbeFYTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:34:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id a14-v6so6495528pgw.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AYYY8oentgDPnKeJvPcB4NjuzxX0nIowa+7ecrSG1Zo=;
        b=DGiB5VHz/zpBocvjo3TC6eElpGzNnKr++x/SmEoaIM8o3+6aZ8A5VDjRgYIXRuoso9
         fVeSXRw3eX7uT+7uVFE59aLs52DTEvGEMQjN+cmjaNyytvjfEc1xJuBf3UA602ab6UZI
         sTdtTskCnt3YcHNdO2g9q8Rq1Dq+UnkilVrSVpF1SLxxUKI1W+P3wSMrvXOXFLTKtZjo
         DnWVmvxJ1d4zIk2wh5uYFVxaroxgfrUMjDTC+toTyM6Nb5HQXGkF1VtFK8aNkhZFXSXl
         9bZn/tZcXTbsi7Axm/1SZbZ6QU7/9FbWhKCn8bc/o0YVdFM5MZzDtuVctcz6Ved2W+iq
         +glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=AYYY8oentgDPnKeJvPcB4NjuzxX0nIowa+7ecrSG1Zo=;
        b=owZojEJiBHVNfENSO8oH1y9OKYtgpbaqQf/oS2cmlqwrdQJ//55jUvkUIFEismqCyB
         yl8nLSDcXjl0b7h6+KYtmYhLq3d6K2vQt/vxrWcLdp5On89PvR780jt1qNPSKYYlaXSB
         CwswEEBSEyx5l97MJ6XQcvFAvg9v05MTvAnw6q4lZNXyejgpYp6IVe9DrLKi1SmT57o/
         7KD2kCMkCMrs5UOmOd9WjrLx9nNMR6WVjOJHXTOfIXV2Uip8jiuOGVzMBlzRlItrBOuk
         S5YD3VqWELNQpXzAmE2rCCKAUqxwIciULpMmjuDwrEMYVllHixWCLBUHwgJ50nSRVmru
         1J/g==
X-Gm-Message-State: APt69E3i0M8SjaGUvsT/lCZpPPOkR9IpM10et5nxXkgWu2tbLpdafJw5
        jI4TcatDgIPkPT8amSDhgg==
X-Google-Smtp-Source: ADUXVKJBzCLndJkQEHkxxdy9OKR+f8QPSvL/NYSVlg0iLpMkNX3N3g/CyUT1RgL1EJfq528h6hKCig==
X-Received: by 2002:a63:2d45:: with SMTP id t66-v6mr11580370pgt.381.1529955294706;
        Mon, 25 Jun 2018 12:34:54 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id q69-v6sm37311505pfl.16.2018.06.25.12.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 12:34:53 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id EB92977C;
        Mon, 25 Jun 2018 14:34:50 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH v2] ipmi: kcs_bmc: fix IRQ exception if the channel is not
 open
To:     Haiyue Wang <haiyue.wang@linux.intel.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     luis.a.silva@dell.com, avi.fishman@nuvoton.com,
        openbmc@lists.ozlabs.org
References: <1529761873-323254-1-git-send-email-haiyue.wang@linux.intel.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <3d5b2b55-381b-562a-9c02-52a8bdfc1a0d@acm.org>
Date:   Mon, 25 Jun 2018 14:34:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529761873-323254-1-git-send-email-haiyue.wang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/2018 08:51 AM, Haiyue Wang wrote:
> When kcs_bmc_handle_event calls kcs_force_abort function to handle the
> not open (no user running) KCS channel transaction, the returned status
> value -ENODEV causes the low level IRQ handler indicating that the irq
> was not for him by returning IRQ_NONE. After some time, this IRQ will
> be treated to be spurious one, and the exception dump happens.
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
> It needs to change the returned status from -ENODEV to 0. The -ENODEV
> was originally used to tell the low level IRQ handler that no user was
> running, but not consider the IRQ handling desgin.
>
> And multiple KCS channels share one IRQ handler, it needs to check the
> IBF flag before doing force abort. If the IBF is set, after handling,
> return 0 to low level IRQ handler to indicate that the IRQ is handled.

I've looked at this some more, and I think it's ok, especially with the 
better description.

I'm going to submit this for the current release after it sits in next 
for a bit.

Thanks,

-corey

> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> ---
> v1 -> v2:
>    - Change the commit message to be more understandable.
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


