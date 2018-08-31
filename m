Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59674C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA922083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHJioEaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA922083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeHaQUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:20:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40479 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbeHaQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:20:42 -0400
Received: by mail-oi0-f67.google.com with SMTP id l202-v6so21225986oig.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/sG/oN/4vqoFV3QWXgOpmNwU+ECPrzxsM/lZz1P+HJg=;
        b=nHJioEaZgnivGL3DqOQ3iyK51CVx/kV7w++5rGqJTgGefaUh+EJzAvxE5f+gKVSxBr
         8LEgpqlu0ERofiBJNpsIUk99aNuAMzT1Iq/qDIiejmvCXS+vQwN6HLD7S02ZvYItOg6B
         dbW+kGO1p+87hOiXwnCQ4UkiwN9SqUjdu1HJ8CwOJujGl0PGOmbfXswFpuehgmUA72Q5
         iIVjW6bly7RArh+FxLBfo/a48SbfC8X9G6R59cTbRFO32lvFSYhkvZBVnP54xVhl4mll
         zJHirFoKRC0iXXZruE5gyQek9FvUZ8JS2gKkp0ZR1TA2xUdIzZhzfeGke3I10CQmuzr6
         Ea+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=/sG/oN/4vqoFV3QWXgOpmNwU+ECPrzxsM/lZz1P+HJg=;
        b=cBXnBl66kgdDk0X3lMqEIdxBMeRAYRG6G56wJkJewCD0GRTKzcdWTRXCNv5xrCRXjP
         fP97Tnxpds/xz6rRfHLdLBYKGl0bmr2GBcnO9wDo6byyMlmdjh/7M74f8yPkRmSfpN0q
         gMjjPkT9vEsj8d/ycnqc/qa3j3FEyjitshVB57+ksHZeKYyMaB6SQGaRSQvTROs/hEcI
         ABrOXlA7WgLL8KmW+BWZdufeBKRr2R7O59qpp4srBZNUun/76eW4E822dhFkUGIDQzXe
         XNY2uEe4Tw6vqzHFYACG6yApLZmjyhX8nUhVc+NGf6AkXTpzKsRdN0v6rOjM9VmM521m
         TO2g==
X-Gm-Message-State: APzg51B9dv6VFJLc3psQKOnDJb9FWxtMU3RheQN3tlYYZeWEIEhQDku/
        4nW7T4KTnUtMq9G+z3vzXw==
X-Google-Smtp-Source: ANB0VdZezEYGUynIFC34IgYfdHKV5rUdbIIY0Vq4pfEfnksr8I/k3rAM2WooN8wGHVJzWOwit/LciA==
X-Received: by 2002:aca:b609:: with SMTP id g9-v6mr7348121oif.148.1535717609267;
        Fri, 31 Aug 2018 05:13:29 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id n15-v6sm4755727oic.33.2018.08.31.05.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 05:13:28 -0700 (PDT)
Received: from [IPv6:2001:470:b8f6:1b:9498:12d2:b5d9:7f7b] (unknown [IPv6:2001:470:b8f6:1b:9498:12d2:b5d9:7f7b])
        by serve.minyard.net (Postfix) with ESMTPSA id 6871E3A8;
        Fri, 31 Aug 2018 07:13:27 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH] ipmi: Fix I2C client removal in the SSIF driver
To:     George Cherian <gcherian@caviumnetworks.com>,
        George Cherian <george.cherian@cavium.com>
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
References: <1535652846-17636-1-git-send-email-minyard@acm.org>
 <a57476f6-a1e5-d47b-766b-5a2221aba026@caviumnetworks.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <fb47a9d3-c033-e2ab-1c49-a376190a83da@acm.org>
Date:   Fri, 31 Aug 2018 07:13:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a57476f6-a1e5-d47b-766b-5a2221aba026@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 06:58 AM, George Cherian wrote:
>
>
> On 08/30/2018 11:44 PM, minyard@acm.org wrote:
>>
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> The SSIF driver was removing any client that came in through the
>> platform interface, but it should only remove clients that it
>> added.  On a failure in the probe function, this could result
>> in the following oops when the driver is removed and the
>> client gets unregistered twice:
>>
>>   CPU: 107 PID: 30266 Comm: rmmod Not tainted 4.18.0+ #80
>>   Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference 
>> firmware version 7.0 08/04/2018
>>   pstate: 60400009 (nZCv daif +PAN -UAO)
>>   pc : kernfs_find_ns+0x28/0x120
>>   lr : kernfs_find_and_get_ns+0x40/0x60
>>   sp : ffff00002310fb50
>>   x29: ffff00002310fb50 x28: ffff800a8240f800
>>   x27: 0000000000000000 x26: 0000000000000000
>>   x25: 0000000056000000 x24: ffff000009073000
>>   x23: ffff000008998b38 x22: 0000000000000000
>>   x21: ffff800ed86de820 x20: 0000000000000000
>>   x19: ffff00000913a1d8 x18: 0000000000000000
>>   x17: 0000000000000000 x16: 0000000000000000
>>   x15: 0000000000000000 x14: 5300737265766972
>>   x13: 643d4d4554535953 x12: 0000000000000030
>>   x11: 0000000000000030 x10: 0101010101010101
>>   x9 : ffff800ea06cc3f9 x8 : 0000000000000000
>>   x7 : 0000000000000141 x6 : ffff000009073000
>>   x5 : ffff800adb706b00 x4 : 0000000000000000
>>   x3 : 00000000ffffffff x2 : 0000000000000000
>>   x1 : ffff000008998b38 x0 : ffff000008356760
>>   Process rmmod (pid: 30266, stack limit = 0x00000000e218418d)
>>   Call trace:
>>    kernfs_find_ns+0x28/0x120
>>    kernfs_find_and_get_ns+0x40/0x60
>>    sysfs_unmerge_group+0x2c/0x6c
>>    dpm_sysfs_remove+0x34/0x70
>>    device_del+0x58/0x30c
>>    device_unregister+0x30/0x7c
>>    i2c_unregister_device+0x84/0x90 [i2c_core]
>>    ssif_platform_remove+0x38/0x98 [ipmi_ssif]
>>    platform_drv_remove+0x2c/0x6c
>>    device_release_driver_internal+0x168/0x1f8
>>    driver_detach+0x50/0xbc
>>    bus_remove_driver+0x74/0xe8
>>    driver_unregister+0x34/0x5c
>>    platform_driver_unregister+0x20/0x2c
>>    cleanup_ipmi_ssif+0x50/0xd82c [ipmi_ssif]
>>    __arm64_sys_delete_module+0x1b4/0x220
>>    el0_svc_handler+0x104/0x160
>>    el0_svc+0x8/0xc
>>   Code: aa1e03e0 aa0203f6 aa0103f7 d503201f (7940e280)
>>   ---[ end trace 09f0e34cce8e2d8c ]---
>>   Kernel panic - not syncing: Fatal exception
>>   SMP: stopping secondary CPUs
>>   Kernel Offset: disabled
>>   CPU features: 0x23800c38
>>
>> So track the clients that the SSIF driver adds and only remove
>> those.
>>
>> Reported-by: George Cherian <george.cherian@cavium.com>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   drivers/char/ipmi/ipmi_ssif.c | 17 ++++++-----------
>>   1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> George, your fix was close, but not quite right.  The following
>> should fix the problem, obvious in hindsight :-).  Thanks for working
>> with me on this.
>>
> Thanks Corey!!!
> This works for me now.
>

Thanks.  Can I add a Tested-by: from you?

-corey

>> -corey
>>
>> diff --git a/drivers/char/ipmi/ipmi_ssif.c 
>> b/drivers/char/ipmi/ipmi_ssif.c
>> index e7e8b86..ca4f7c4 100644
>> --- a/drivers/char/ipmi/ipmi_ssif.c
>> +++ b/drivers/char/ipmi/ipmi_ssif.c
>> @@ -182,6 +182,8 @@ struct ssif_addr_info {
>>          struct device *dev;
>>          struct i2c_client *client;
>>
>> +       struct i2c_client *added_client;
>> +
>>          struct mutex clients_mutex;
>>          struct list_head clients;
>>
>> @@ -1639,15 +1641,7 @@ static int ssif_probe(struct i2c_client 
>> *client, const struct i2c_device_id *id)
>>
>>    out:
>>          if (rv) {
>> -               /*
>> -                * Note that if addr_info->client is assigned, we
>> -                * leave it.  The i2c client hangs around even if we
>> -                * return a failure here, and the failure here is not
>> -                * propagated back to the i2c code.  This seems to be
>> -                * design intent, strange as it may be.  But if we
>> -                * don't leave it, ssif_platform_remove will not remove
>> -                * the client like it should.
>> -                */
>> +               addr_info->client = NULL;
>>                  dev_err(&client->dev, "Unable to start IPMI SSIF: 
>> %d\n", rv);
>>                  kfree(ssif_info);
>>          }
>> @@ -1667,7 +1661,8 @@ static int ssif_adapter_handler(struct device 
>> *adev, void *opaque)
>>          if (adev->type != &i2c_adapter_type)
>>                  return 0;
>>
>> -       i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
>> +       addr_info->added_client = i2c_new_device(to_i2c_adapter(adev),
>> + &addr_info->binfo);
>>
>>          if (!addr_info->adapter_name)
>>                  return 1; /* Only try the first I2C adapter by 
>> default. */
>> @@ -1840,7 +1835,7 @@ static int ssif_platform_remove(struct 
>> platform_device *dev)
>>                  return 0;
>>
>>          mutex_lock(&ssif_infos_mutex);
>> -       i2c_unregister_device(addr_info->client);
>> +       i2c_unregister_device(addr_info->added_client);
>>
>>          list_del(&addr_info->link);
>>          kfree(addr_info);
>> -- 
>> 2.7.4
>>

