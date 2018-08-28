Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB3DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A637420880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uR/xG7Ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A637420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeH1Uu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:50:29 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38496 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1Uu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:50:29 -0400
Received: by mail-oi0-f68.google.com with SMTP id x197-v6so4117481oix.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AwAYf7IIpi2t/MDYz1AtdOB1AVbMWH70u2JMQJ1omT8=;
        b=uR/xG7EjzCa4pmyN9gpmYBy1wZqRI54R9dTba0+oFUMloZY4UXm7riLX8zdimUMHnD
         dtsBZZGFGySTheoJEgfNH1S+yxLXB63IsPL4uoPmnFOq/bwMpqBfJwARmD1GbcOLYWiU
         Ux36ZWVvMBBSbjfdFqoMKtzRggfjAPIMKxJxK8R/BzLJGmsr/hUjpHAUQh4SOMGy8MOL
         SevDNMBV0E67xSGjI3hw9JFE8maxq3X2GEn3vgBbFck790G7HmMYwTielwsnvUC7HI53
         bNAcKaJQaLuo2g5ejKQTyPNHjWdj2u9OjW5K7iOC2ECtOLVAu+8ur+TMO1O/NhKNbMsJ
         /00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=AwAYf7IIpi2t/MDYz1AtdOB1AVbMWH70u2JMQJ1omT8=;
        b=rtXPZMHechiIq4jCarwieB+hBBL17nMjvqC7mpIwyGnxINFUmTyFgffnv7/kYKL6Zb
         Cr0leOKwLF4e/q4GNQP4CCyjUybMteZDTpvz/ymISprzmshA4/AiiHSZ0M6eN9SY69Po
         nmvHk24gzqiZvOFxQm9hsyojtVAU43tFTgEgrH0lW/QTgzpBMNU3JP9CwwlF3j2P+u0B
         QofdqcTfeEXrkDVvcDWeCde02+bSn48qfpgvKxUYAgXRO3pGDOg2SWoGZs1/+jU+PhIP
         km6m/kocHmaF03AuZzhnkBHhM7W+m/UgNEkbGL9RuKGKStMKQP46ARIXvrusg02K7upN
         hbmA==
X-Gm-Message-State: APzg51AJPjg4Ed/9T4oUtOYfXK95Mr8HGx2cwlcH8QF8R/Z5JdJQAtXy
        otr58QHtwOsf6NYCla5w/vchpTY=
X-Google-Smtp-Source: ANB0VdZDPoABr5pgV2gv+RiTO2QEDMq24at9I/las891r9cgxdOEna4Xqrvver+HIUvMMFjg17e5Wg==
X-Received: by 2002:aca:4914:: with SMTP id w20-v6mr2123459oia.5.1535475475781;
        Tue, 28 Aug 2018 09:57:55 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id i204-v6sm1093363oia.41.2018.08.28.09.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 09:57:54 -0700 (PDT)
Received: from [192.168.1.249] (unknown [12.184.124.68])
        by serve.minyard.net (Postfix) with ESMTPSA id C39108AE;
        Tue, 28 Aug 2018 11:57:23 -0500 (CDT)
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
 <f6bd95db-0ca7-ccfa-3ef6-7e3a7a51031d@acm.org>
 <bfd99f3e-68db-d5bc-678b-b998ac447e72@caviumnetworks.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <02ffb24e-c4ca-835f-91ea-678843be4870@acm.org>
Date:   Tue, 28 Aug 2018 11:57:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bfd99f3e-68db-d5bc-678b-b998ac447e72@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 09:32 AM, George Cherian wrote:
>
> Hi Corey,
>
> On 08/28/2018 04:59 AM, Corey Minyard wrote:
>>
>> On 08/27/2018 01:07 AM, George Cherian wrote:
>>>
>>> Hi Corey,
>>>
>>> On 08/24/2018 06:37 PM, Corey Minyard wrote:
>>>>
>>>> On 08/24/2018 06:10 AM, George Cherian wrote:
>>>>> In ssif_probe error path the i2c client is left hanging, so that
>>>>> ssif_platform_remove will remove the client. But it is quite
>>>>> possible that ssif would never call an i2c_new_device.
>>>>> This condition would lead to kernel crash as below.
>>>>> To fix this leave only the client ssif registered hanging in error
>>>>> path. All other non-registered clients are set to NULL.
>>>>
>>>> I'm having a hard time seeing how this could happen.
>>>>
>>>> The i2c_new_device() call is only done in the case of dmi_ipmi_probe
>>>> (called from
>>>> ssif_platform_probe) or a hard-coded entry.  How does
>>>> ssif_platform_remove get
>>>> called on a device that was not registered with ssif_platform_probe?
>>>>
>>>
>>> Initially I also had the same doubt but then,
>>> ssif_adapter_hanlder is called for each i2c_dev only after initialized
>>> is true. So we end up not calling i2c_new_device for devices probed
>>> during the module_init time.
>>>
>>
>> I spent some time looking at this, and I don't think that's what is
>> happening.
>>
>> I think that i2c_del_driver() in cleanup_ipmi_ssif() is causing
>> i2c_unregister_device() to be called on all the devices, and
>> platform_driver_unregister() causes it to be called on the
>> devices that came in through the platform method.  It's
>> a double-free.
>>
>> Try reversing the order of i2c_del_driver() and 
>> platform_driver_unregister()
>> in cleanup_ipmi_ssif() to test this.
>>
> Reversing the call order didn't help, I am still getting the trace.

That's really strange.  Calling ssif_platform_remove() should result in
i2c_del_driver() being called on the device, and thus i2c_del_driver()
should't free it.  At least per you later analysis in this mail.

>
> You are partly correct on the double free scenario. I dont see double 
> free in normal operation. I see a double free only in probe failure case.
>
>
> I have added prints in i2c_unregister_device() to print the client.
> pr_err("client = %px\n", client);
>
> In normal case, I get 2 calls to i2c_unregister_device()
> Call 1: i2c-core:  client = ffff800ada315400 => called from 
> i2c_del_driver()
> This in turn calls ssif_remove, where we set addr_info->client to NULL.
>
> Call 2: i2c-core:  client = 0000000000000000 => called from 
> ssif_platform_remove()
> This is fine since i2c_unregister_device is NULL aware.
> This works fine without crashing .
>
> Now in the probe failing case, I get 2 calls to i2c_unregister_device()
> Call 1: i2c-core:  client = ffff800ad9897400 => called from 
> i2c_del_driver()
> This never calls ssif_remove, since the probe failed.
>
> Call 2: i2c-core:  client = ffff800ad9897400 => called from 
> ssif_platform_remove()
> This is a case of double free.
>
> Do you think the proposed patch itself is the solution or
> Is it that we should really leave addr_info->client hanging in probe
> error path at all?

I have been wondering that.

>
> NB: For easy simulation of the ssif_probe failing case I just replaced
> the
>
> ssif_info->thread = kthread_run(....) with
>
> ssif_info->thread = ERR_PTR(-4); so that the probe takes the goto out 
> path.
>

Ok, that was my next step, trying to reproduce this.  I can try that and 
look.

Quick question, though: Is this device coming through DMI? Or are you
registering this as a platform device someplace else?

-corey

