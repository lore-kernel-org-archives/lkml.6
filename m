Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECBBC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4042083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxb0fLzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4042083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbeFTXAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:00:24 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36292 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754018AbeFTXAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:00:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so561765plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Q8eXOyPHbhOLHzsmOX7c8FnyLOpbmkOA6pumQpgXxWM=;
        b=Cxb0fLztEM+7tvb742vYc0D/r6ZJ0l0TfD0fq0WE1lznt5pO7F0nPMgvcbRW7dxpzG
         4bipTqC1vCaelFlgXJHZO1YnvqRdjTz3MZk+X95OTDsRKXsXnYMEyu8tMD72Z0KOy2y2
         HTScpf2A2lYi64XmysME3mb6tm5RYxIpc6b1GKPh+dcsfWRMrKeOdAMPFRYwilDhDgMj
         y9KqLzquE/xTBoVyEPDdliDM03NhQVzJYr7IMA0HciYnABY+WHngKjlUHYa3sSOwNHDm
         SFdSyJ3iwCLMWitVl4Opepx71KAaSbvnQYa1gFRNc8Jc0qZBu44JU66Y0oQKIMSwiCou
         ngYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Q8eXOyPHbhOLHzsmOX7c8FnyLOpbmkOA6pumQpgXxWM=;
        b=YMgCeKxK1rPzw1mq+32zcfBLToEfbpi2KoqFtmX9ez8uHOm4TmrPG2PggefKd/06Gs
         6tVWkjBJ7RMDwW8iMSUvGk8+JrtLkz4ug0rj8tE28ABB1J8CzT5RfL4SOc5tza+jZuMH
         WqiR2Eh+YjmJWrZ+aZARvBsoPLBJ1OtNGxV4jEEplP0EB0LAa9GdTuVc2zifVBSXxn1b
         XwwnyWWJ4vw4w0pfT2Ntryg9xHe1x808pa160SKCY+gNicpxv4FUIau+uP5IeAq44Ez8
         PdAT26YS//D0aJBhYYRA9X8lx79/nYcKfewMe4hEOY5JpR3iI7i2/teLAIDamoz+ut81
         jblw==
X-Gm-Message-State: APt69E2GnlwKot9m6Oah0TFUNifpgqxLGSTQWgAAxoWYXk8MrZA53IN7
        KIXm1yllAt56zdc29LO2wQ==
X-Google-Smtp-Source: ADUXVKLxCkC7eSxC4RAoZ3dJMV/BQmJspuXjIeRKZ2uB+BZXmP1FqKna/Y5627Uir12ry1VwiRefGw==
X-Received: by 2002:a17:902:1127:: with SMTP id d36-v6mr26129332pla.267.1529535620843;
        Wed, 20 Jun 2018 16:00:20 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 14-v6sm4274046pgc.63.2018.06.20.16.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 16:00:19 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id F3C4B66B;
        Wed, 20 Jun 2018 18:00:17 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi: Cleanup oops on initialization failure
To:     Meelis Roos <mroos@linux.ee>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
References: <alpine.LRH.2.21.1806191553040.28622@math.ut.ee>
 <1529497606-3857-1-git-send-email-minyard@acm.org>
 <alpine.LRH.2.21.1806201725520.28187@math.ut.ee>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <7c9a293d-02e7-96c3-4760-f2d066e9dfd6@acm.org>
Date:   Wed, 20 Jun 2018 18:00:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1806201725520.28187@math.ut.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 09:26 AM, Meelis Roos wrote:
>> Commit 93c303d2045b3 "ipmi_si: Clean up shutdown a bit" didn't
>> copy the behavior of the cleanup in one spot, it needed to
>> check for a non-NULL interface before cleaning it up.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Tested-by: Meelis Roos <mroos@linux.ee>
>
>
> The corresponding dmesg:
>
> [    7.372830] IPMI System Interface driver.
> [    7.373034] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
> [    7.373109] ipmi_si: SMBIOS: mem 0x0 regsize 1 spacing 1 irq 0
> [    7.373182] ipmi_si: Adding SMBIOS-specified kcs state machine
> [    7.373352] ipmi_si: Trying SMBIOS-specified kcs state machine at mem address 0x0, slave address 0x20, irq 0
> [    7.373479] ipmi_si dmi-ipmi-si.0: Could not set up I/O space
>
>> BTW, can you send me at least the IPMI portion of the output of
>> dmidecode for your machine?  I have seen a lot of these where the
>> address in the SMBIOS tables is incorrect, and I'm wondering if
>> it's something in the driver, or if it's really the tables that
>> are bad.
> Handle 0x001B, DMI type 38, 18 bytes
> IPMI Device Information
>          Interface Type: KCS (Keyboard Control Style)
>          Specification Version: 2.0
>          I2C Slave Address: 0x10
>          NV Storage Device: Not Present
>          Base Address: 0x0000000000000000 (Memory-mapped)
>          Register Spacing: Successive Byte Boundaries

Thanks a bunch.  It looks like the SMBIOS tables are wrong.  I
wonder if this is what some vendor do if there is no IPMI device
installed.  I guess I need to add a check for this.

-corey

>> Thanks for reporting this.  On your tested-by I'll send this up
>> to Linus.
>>
>> -corey
>>
>>   drivers/char/ipmi/ipmi_si_intf.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
>> index 3d0add6..a5987f8 100644
>> --- a/drivers/char/ipmi/ipmi_si_intf.c
>> +++ b/drivers/char/ipmi/ipmi_si_intf.c
>> @@ -2088,8 +2088,10 @@ static int try_smi_init(struct smi_info *new_smi)
>>   	return 0;
>>   
>>   out_err:
>> -	ipmi_unregister_smi(new_smi->intf);
>> -	new_smi->intf = NULL;
>> +	if (new_smi->intf) {
>> +		ipmi_unregister_smi(new_smi->intf);
>> +		new_smi->intf = NULL;
>> +	}
>>   
>>   	kfree(init_name);
>>   
>>

