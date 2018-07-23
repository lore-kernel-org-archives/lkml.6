Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1196320856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqkVZauV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1196320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbeGWNyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:54:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43257 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388387AbeGWNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:54:11 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so188562plk.10;
        Mon, 23 Jul 2018 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=h2zOp8N41hjFBXWdWltMHfPidr0OHBeNgSBD5+vsZoA=;
        b=SqkVZauVyohq/OqfI4hHROOTR2ycy7dpiErS0L++iby19OQH3btbHIUOyGSNBIE5yn
         0CR785Vi/xlbKkSxWWli0utGWMXIYRP1Ut2Lpkj2z848ziMFOZL9pfx8ZBhyHpJpz9oS
         Z1BgMETxpv2S2Wldo0rlVDiauV7STiQpeW4BXC8otRKxSDmhSqQARKtjeactX/3TFRQs
         TJQmZeXw6opDSJ0btQ1xH8JvSBlkBqojJ675NMpgpOzPH9BCKgsOIMwPvEl3QEJITeCy
         rcuMSRdzpYOf/llJSIyNVvKwRJzesvZNfLuzUGSNv1q3MoTkAKauZoOyEyTHzJwuA+mE
         enHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=h2zOp8N41hjFBXWdWltMHfPidr0OHBeNgSBD5+vsZoA=;
        b=T37wadqtxu2vNq1+rnvheswgEGwbiGMFgiVHEpMraxOtzdFInNJYa1RFhSoQDmNrWF
         78hBqNKWYK/WDVCBrqainYvz+6Y7izI0i/Wn0ZC2Fm6C+SrsuxM/+6UT7ddaoaxp6+cx
         3EFCccL+68sVOkosOecuTkiSVEfXzuQqpe7oZW2z3Qg1yquKekGwwMaAHwQFiBl9a2l/
         EVFJyR0n6UfnM1nIoWZDz/rqf/sFfK0OeJuMr5BTjb/PeyMwqY8PDWD0C8CRph2gswgx
         SsrLc7Mc69TdM/a6D1clhlLNJ6XNRqCcP/y3yhwHf6wAapUem2nYh17rvNFSbtGN5yp0
         hTuQ==
X-Gm-Message-State: AOUpUlELrAib1zp2wdhUX0VU3oU5ubhnxZl+MvXQWoO+EsqMwKHkJBfZ
        Q27wXncr7prty81kVKGNUrYmWTz5
X-Google-Smtp-Source: AAOMgpeGmVqcBqFnE1IKfoQ/5sYXMxb7NNyG5+HLkKRpQdsYwd0tfWDURF8QbuRNR8+ldUATsmxYvg==
X-Received: by 2002:a17:902:9687:: with SMTP id n7-v6mr12509026plp.33.1532350385479;
        Mon, 23 Jul 2018 05:53:05 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:101.5.211.5? ([2402:f000:1:1501:200:5efe:6505:d305])
        by smtp.gmail.com with ESMTPSA id k12-v6sm14818916pfj.30.2018.07.23.05.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 05:53:04 -0700 (PDT)
Subject: Re: [PATCH] firewire: sbp2: Replace GFP_ATOMIC with GFP_KERNEL in
 sbp2_scsi_queuecommand()
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180723085801.6711-1-baijiaju1990@gmail.com>
 <20180723142418.4aef4910@kant>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <78f1f5e5-1080-c801-eae5-72f5cbff0b63@gmail.com>
Date:   Mon, 23 Jul 2018 20:53:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180723142418.4aef4910@kant>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply :)


On 2018/7/23 20:24, Stefan Richter wrote:
> Adding Cc: LSML
>
> On Jul 23 Jia-Ju Bai wrote:
>> sbp2_scsi_queuecommand() is only set to .queuecommand of
>> "struct scsi_host_template", and this function pointer is never called
>> in atomic context.
> As far as I remember, scsi_host_template::queuecommand() can be invoked
> from either process context or tasklet context, predominantly the latter.
>
> I haven't followed recent developments of the block and scsi stack, hence
> don't know if this has changed fundamentally.
>
> But even if it is purely process context now and no spinlocks held, the
> memory allocation must be done so that the kernel does not go into memory
> reclaim. Otherwise this could deadlock.

Okay.
In fact, my tool does not find that queuecommand() can be called from 
tasklet context.
Maybe my tool is not very accurate when handling the function pointer call.

>
>> sbp2_scsi_queuecommand() calls kzalloc() with GFP_ATOMIC,
>> which is not necessary.
>> GFP_ATOMIC can be replaced with GFP_KERNEL.
>>
>> This is found by a static analysis tool named DCNS written by myself.
> I doubt that static analysis, even if very sophisticated, can detect
> deadlock scenarios such as I noted.

Sorry, I am not sure to understand the deadlock scenarios you mentioned.
Could you please give an example?
Maybe I can write a static tool to detect such deadlocks.

>
>> I also manually check the kernel code before reporting it.
> What does it mean?  Did you run-time test it, for which actual SBP-2
> hardware is required?  (Such a test could detect GFP-KERNEL use in atomic
> context, but would not reliably detect memory reclaim related deadlocks.)

Sorry, my description here may bring misunderstanding.
It means that I manually review the code and validated my report, 
instead of perform runtime testing, because I do not have the hardware.
Maybe I neglected something in my code review, so I am not very 
confident...

>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   drivers/firewire/sbp2.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firewire/sbp2.c b/drivers/firewire/sbp2.c
>> index 6bac03999fd4..a7cd9d87eb02 100644
>> --- a/drivers/firewire/sbp2.c
>> +++ b/drivers/firewire/sbp2.c
>> @@ -1463,7 +1463,7 @@ static int sbp2_scsi_queuecommand(struct Scsi_Host *shost,
>>   	struct sbp2_command_orb *orb;
>>   	int generation, retval = SCSI_MLQUEUE_HOST_BUSY;
>>   
>> -	orb = kzalloc(sizeof(*orb), GFP_ATOMIC);
>> +	orb = kzalloc(sizeof(*orb), GFP_KERNEL);
>>   	if (orb == NULL)
>>   		return SCSI_MLQUEUE_HOST_BUSY;
>>   
> NACK for GFP_KERNEL, but I am curious whether a weaker GFP set than ATOMIC
> is possible in scsi_host_template::queuecommand.

like what? GFP_NOIO or GFP_NOFS?


Best wishes,
Jia-Ju Bai
