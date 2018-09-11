Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01933C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE69B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d12NN2WX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE69B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeIKVtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:49:19 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:42062 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKVtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:49:18 -0400
Received: by mail-io0-f171.google.com with SMTP id n18-v6so4101507ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kgMvqsSYNFt5t2b/PRteCZfR0wIyyy6iKFyV92u+J1A=;
        b=d12NN2WXz0/a/te+7AwkyN1906Wq4HzzyVAxMH4gVDHVmdUk/O2NsQSYJpacaOiRjo
         ZzNUh+WyQOz+kQ1CLQMPQby9kEpK42zm1G8weFPePytU0VxJJhhTb4TRe9WCf834XFjo
         aBXQp6ECv1hvmKOqJj2ivxa/s5/wQJ75uacDBuYv8uVXa3ff1tBq33z94Go4C6QAX4ll
         2xGcURhdhNVfqelWdqmQ0AjHmcAx6vMT4I6nFL8/ZR3iUejRgMKc6P/8Q3O8faKyV6mO
         sSWqkPtgr8ltpNqAoxgvWgnNsUNp0hMkkTLAT9XE1KGCplEzKSWlEVAtOE9StNREkdE9
         8BlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kgMvqsSYNFt5t2b/PRteCZfR0wIyyy6iKFyV92u+J1A=;
        b=Q2dSNbdoXQ4dz9C9LJ7rrq/e+Lyk6GI8lcZE98xwX9/aJIVNXDxMxir7jJxeBqDREd
         CvlM6RZfq4SgdUAQUh1WIHt+a1H1RWPTmaa8TJbpSD88BWwQz2/hqn3TGzdyHRahPULz
         +XBpxV/EKtJmZG+h3XrePmU0daqEKRdXUIbFlZodC/nFM8ZbBTkUnG7ptKjDeF5pNDbm
         7mFewQRva4X1RVngpQRgMbPraq0f7Kex3XPaLq7Dqp9wJsYEJqr61E3oXoW3adE3/YjA
         zSByJ5+DduT16KGp47p7yUzVIf3H8nBgQtj5QraE0OwQl0VcrunwUByn+PBTWdcxoPAF
         Fk6g==
X-Gm-Message-State: APzg51AEiAth1U2huaMxQrWtOt1XmV8beSKJsEXypM1cpe2jaPLqzfKG
        ehPCk6+9I7OW/FvyTXTlZ5TqyA5rcZQ=
X-Google-Smtp-Source: ANB0VdYUjw4a0vNnTp9D7piYBmJF8eutEt22I5tkfyv4KP4SSQCcoWKcEUjWoquQ2177UjDfyW+ELw==
X-Received: by 2002:a6b:ac45:: with SMTP id v66-v6mr23576053ioe.66.1536684548232;
        Tue, 11 Sep 2018 09:49:08 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id 14-v6sm688234itu.20.2018.09.11.09.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:49:06 -0700 (PDT)
Subject: Re: [REGRESSION] bfq probe failed on 4.19-rc3
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <s5ha7ooxbps.wl-tiwai@suse.de>
 <8b5a7dc9-2dc1-16ee-4b05-a72eb6680c77@kernel.dk>
 <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd71494f-4595-7586-4c46-000f2b2029aa@kernel.dk>
Date:   Tue, 11 Sep 2018 10:49:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <x49a7ooj7zp.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 10:48 AM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 9/11/18 10:03 AM, Takashi Iwai wrote:
>>> Hi,
>>>
>>> I noticed that bfq doesn't appear in the I/O scheduler list on
>>> 4.19-rc3.  It seems that blkcg_policy_register() at the beginning of
>>> bfq_init() returns -ENOSPC, hence the probe aborts silently.
>>>
>>> Is this already addressed?
>>
>> Haven't heard about this one before. What kernel did you last use that
>> worked?
> 
> I'm guessing you just need to update the maximum number of policies:
> 
> /*
>  * Maximum number of blkcg policies allowed to be registered concurrently.
>  * Defined here to simplify include dependency.
>  */
> #define BLKCG_MAX_POLS          3

That is my guess too, hence the suggestion to try and disable the
iolatency policy. Just tried here without, and it works, rebooting
with to verify that we're running out of policy slots.

-- 
Jens Axboe

