Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE5EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2057F208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFjCzbWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2057F208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeH1DTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:19:19 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46014 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeH1DTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:19:19 -0400
Received: by mail-oi0-f67.google.com with SMTP id t68-v6so1223185oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D6nCmQ48omCh6GpYXVKCB2afNcjRqrasMsUFwhIs+GQ=;
        b=TFjCzbWq1sgHlWqTm4rMdthMkEFpp3d7QumQUMKJkQifeT15wdZfO0yAz2hy3Dttlg
         E9FJ4Zjc5XWpPjl/bEvs2YZbVYEovAqDEL5wyheRiZEqPOWs3D90iyFm+Aq5smCzpG04
         DuVtwlKEWtIA1oki3+wGjnu1Pc4A7bCyaOGgiSntklTFzE0UNYrCvnZlCHOIkHod/3AE
         sF7FNzvC02rzxMq9nx5fS9R4sOFsOxkxv9AQFItnCGpzb3Tumv01O2IAU0g82gi5/Axt
         w2uhuevFOZmNl7KRUTT7gCqC4okhCe/RX5KVvn3z1+MYdL0LQA5Xq3NhQX/kXGc3XOom
         tjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=D6nCmQ48omCh6GpYXVKCB2afNcjRqrasMsUFwhIs+GQ=;
        b=p7IXyE9oVzxK3XaVr89Jyv+0dXhPFZaJs+8u+qxIjMeq+2RmXASNIeLdfUovP13O9H
         OCVIMUuYhOU21Nq3FXtLnj91wMwVZOJAYjG4MdVGyigUfpUhikKxS7EXS7QUo3oiqPtm
         uYVLtYgcJNKsxyJktSzPIsKqCly67ppp9dRwe9HSAHOV893qNwmgzbO7ymuader1zybu
         7iXucmV/rSHuetCWFBe16ddOEwJjU4rjnw1ewoq9Zx67CMcCai3UUdmU1ZXfOqkCIqkX
         5HKTiFY9ECCzKWoL3micNkDF08d+FX1GCpqMqCfFToIk0DlJI/l2XtOKY2OY+h04mpHE
         V4dg==
X-Gm-Message-State: APzg51Af/FY+82pFBkzh8oXlyJIWGNkjCBW/97g0BBU5dK8W7VMKpfQW
        t38Y8oYoO5usQlDbwGMlBg==
X-Google-Smtp-Source: ANB0VdYol95MBPeprWPpdiVdCRwQqG595LRZK0oqf4J3l2hG/w8Uc7srs2TGmcMpvM9i2T32/mdsyA==
X-Received: by 2002:aca:efd7:: with SMTP id n206-v6mr750496oih.70.1535412629204;
        Mon, 27 Aug 2018 16:30:29 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id v202-v6sm556053oie.47.2018.08.27.16.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:30:28 -0700 (PDT)
Received: from [IPv6:2001:470:b8f6:1b:fcd1:4328:3a3e:96be] (unknown [IPv6:2001:470:b8f6:1b:fcd1:4328:3a3e:96be])
        by serve.minyard.net (Postfix) with ESMTPSA id AE9F7677;
        Mon, 27 Aug 2018 18:29:56 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH 1/2] ipmi_ssif: Unregister i2c device only if created by
 ssif
To:     George Cherian <gcherian@caviumnetworks.com>,
        George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org
References: <1535109010-5074-1-git-send-email-george.cherian@cavium.com>
 <c25ed354-5971-389a-0439-369171b5aabc@acm.org>
 <0661f015-754e-a419-bbe0-8d1c4de57ad6@caviumnetworks.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <f6bd95db-0ca7-ccfa-3ef6-7e3a7a51031d@acm.org>
Date:   Mon, 27 Aug 2018 18:29:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0661f015-754e-a419-bbe0-8d1c4de57ad6@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 01:07 AM, George Cherian wrote:
>
> Hi Corey,
>
> On 08/24/2018 06:37 PM, Corey Minyard wrote:
>>
>> On 08/24/2018 06:10 AM, George Cherian wrote:
>>> In ssif_probe error path the i2c client is left hanging, so that
>>> ssif_platform_remove will remove the client. But it is quite
>>> possible that ssif would never call an i2c_new_device.
>>> This condition would lead to kernel crash as below.
>>> To fix this leave only the client ssif registered hanging in error
>>> path. All other non-registered clients are set to NULL.
>>
>> I'm having a hard time seeing how this could happen.
>>
>> The i2c_new_device() call is only done in the case of dmi_ipmi_probe
>> (called from
>> ssif_platform_probe) or a hard-coded entry.  How does
>> ssif_platform_remove get
>> called on a device that was not registered with ssif_platform_probe?
>>
>
> Initially I also had the same doubt but then,
> ssif_adapter_hanlder is called for each i2c_dev only after initialized
> is true. So we end up not calling i2c_new_device for devices probed
> during the module_init time.
>

I spent some time looking at this, and I don't think that's what is
happening.

I think that i2c_del_driver() in cleanup_ipmi_ssif() is causing
i2c_unregister_device() to be called on all the devices, and
platform_driver_unregister() causes it to be called on the
devices that came in through the platform method.  It's
a double-free.

Try reversing the order of i2c_del_driver() and platform_driver_unregister()
in cleanup_ipmi_ssif() to test this.

-corey

> ssif_platform_remove() get called during removal of ipmi_ssif.
> In case during ssif_probe() if there is a failure before
> ipmi_smi_register then we leave the addr_info->client hanging.
>
> In case of normal functioning without error, we set addr_info->client
> to NULL after ipmi_unregiter_smi in ssif_remove.
>
>> Small style comment inline...
> I will make the changess and sent out a v2!!
>
> Thanks,
> -George
>>
>>>   CPU: 107 PID: 30266 Comm: rmmod Not tainted 4.18.0+ #80
>>>   Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference 
>>> firmware version 7.0 08/04/2018
>>>   pstate: 60400009 (nZCv daif +PAN -UAO)
>>>   pc : kernfs_find_ns+0x28/0x120
>>>   lr : kernfs_find_and_get_ns+0x40/0x60
>>>   sp : ffff00002310fb50
>>>   x29: ffff00002310fb50 x28: ffff800a8240f800
>>>   x27: 0000000000000000 x26: 0000000000000000
>>>   x25: 0000000056000000 x24: ffff000009073000
>>>   x23: ffff000008998b38 x22: 0000000000000000
>>>   x21: ffff800ed86de820 x20: 0000000000000000
>>>   x19: ffff00000913a1d8 x18: 0000000000000000
>>>   x17: 0000000000000000 x16: 0000000000000000
>>>   x15: 0000000000000000 x14: 5300737265766972
>>>   x13: 643d4d4554535953 x12: 0000000000000030
>>>   x11: 0000000000000030 x10: 0101010101010101
>>>   x9 : ffff800ea06cc3f9 x8 : 0000000000000000
>>>   x7 : 0000000000000141 x6 : ffff000009073000
>>>   x5 : ffff800adb706b00 x4 : 0000000000000000
>>>   x3 : 00000000ffffffff x2 : 0000000000000000
>>>   x1 : ffff000008998b38 x0 : ffff000008356760
>>>   Process rmmod (pid: 30266, stack limit = 0x00000000e218418d)
>>>   Call trace:
>>>    kernfs_find_ns+0x28/0x120
>>>    kernfs_find_and_get_ns+0x40/0x60
>>>    sysfs_unmerge_group+0x2c/0x6c
>>>    dpm_sysfs_remove+0x34/0x70
>>>    device_del+0x58/0x30c
>>>    device_unregister+0x30/0x7c
>>>    i2c_unregister_device+0x84/0x90 [i2c_core]
>>>    ssif_platform_remove+0x38/0x98 [ipmi_ssif]
>>>    platform_drv_remove+0x2c/0x6c
>>>    device_release_driver_internal+0x168/0x1f8
>>>    driver_detach+0x50/0xbc
>>>    bus_remove_driver+0x74/0xe8
>>>    driver_unregister+0x34/0x5c
>>>    platform_driver_unregister+0x20/0x2c
>>>    cleanup_ipmi_ssif+0x50/0xd82c [ipmi_ssif]
>>>    __arm64_sys_delete_module+0x1b4/0x220
>>>    el0_svc_handler+0x104/0x160
>>>    el0_svc+0x8/0xc
>>>   Code: aa1e03e0 aa0203f6 aa0103f7 d503201f (7940e280)
>>>   ---[ end trace 09f0e34cce8e2d8c ]---
>>>   Kernel panic - not syncing: Fatal exception
>>>   SMP: stopping secondary CPUs
>>>   Kernel Offset: disabled
>>>   CPU features: 0x23800c38
>>>
>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>> ---
>>>   drivers/char/ipmi/ipmi_ssif.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/char/ipmi/ipmi_ssif.c 
>>> b/drivers/char/ipmi/ipmi_ssif.c
>>> index 18e4650..ccdf6b1 100644
>>> --- a/drivers/char/ipmi/ipmi_ssif.c
>>> +++ b/drivers/char/ipmi/ipmi_ssif.c
>>> @@ -181,6 +181,7 @@ struct ssif_addr_info {
>>>       struct device *dev;
>>>       struct i2c_client *client;
>>>
>>> +     bool client_registered;
>>>       struct mutex clients_mutex;
>>>       struct list_head clients;
>>>
>>> @@ -1658,6 +1659,8 @@ static int ssif_probe(struct i2c_client 
>>> *client, const struct i2c_device_id *id)
>>>                * the client like it should.
>>>                */
>>>               dev_err(&client->dev, "Unable to start IPMI SSIF: 
>>> %d\n", rv);
>>> +             if (!addr_info->client_registered)
>>> +                     addr_info->client = NULL;
>>>               kfree(ssif_info);
>>>       }
>>>       kfree(resp);
>>> @@ -1672,11 +1675,14 @@ static int ssif_probe(struct i2c_client 
>>> *client, const struct i2c_device_id *id)
>>>   static int ssif_adapter_handler(struct device *adev, void *opaque)
>>>   {
>>>       struct ssif_addr_info *addr_info = opaque;
>>> +     struct i2c_client *client;
>>>
>>>       if (adev->type != &i2c_adapter_type)
>>>               return 0;
>>>
>>> -     i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
>>> +     client = i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
>>> +     if (client)
>>> +             addr_info->client_registered = true;
>>>
>>
>> How about..
>>     if (i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo))
>>         addr_info->client_registered = true;
>>
>> No need for the client variable.
>>
>> -corey
>>
>>>       if (!addr_info->adapter_name)
>>>               return 1; /* Only try the first I2C adapter by 
>>> default. */
>>
>>

