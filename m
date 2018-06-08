Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xZ85BklHGltKHQAAmS7hNA
	; Fri, 08 Jun 2018 09:07:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF897607E4; Fri,  8 Jun 2018 09:07:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ho+54WoW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6684F602FC;
	Fri,  8 Jun 2018 09:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6684F602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeFHJHQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:07:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45853 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHJHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:07:14 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so12563756wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jPBUqT9TcPVLpzyKaKJeMyOZjrXCcHlVjX+KXOjAYTc=;
        b=ho+54WoWhNx2GOmO9T5P4fnWcbICZlhzk1QBnRPA/MqmBPXNo8+8GiqjKV976PtXvn
         l1lE+OsxddtOrHUyGB6oNMSfWJcqz8y2KhqyFRW9o6lB7MhVW2PPHHGC27iIGleOQLYl
         vmPGYxF8jFQXD1xQuAgLmYuuUlDXsMRQxA0AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPBUqT9TcPVLpzyKaKJeMyOZjrXCcHlVjX+KXOjAYTc=;
        b=HAf2JWvSl5iT8IGy3Q7zy+gL5bmOs25IXU6qEbhF431P35LZETwN6mHXRfhb9tqFoe
         J/PIc90zKMhGet0Knvl0v9cZKWZTxnigTEGixbbpram1+TKk4J3H4FE3epVwzojGzU26
         vYN2x4VRpZyEjlL8iwB62nMYQlWokdcv/gKBnTfg+lanvZc/lMuHpzBJvmZQXhxbHTHv
         CapVcyh8ZY6yoyDQi0z3+xIAyBDQ7AaviWLIrVW4rBOFjZTbLDpAj80c0orlMYeFoK6q
         43BISh/FtCLU/1c/+10Bmx5v1knLTljkOnY7xos/IvL0foDqxDEp6CEoPsDTivBXsvJZ
         DucQ==
X-Gm-Message-State: APt69E3m/uB1iNfZPdCj61ITO2QiMbm3XQaClgGuVxXdY37JwFyZChON
        Is5CTR5WLXJePVXxegVlz+lIeg==
X-Google-Smtp-Source: ADUXVKKFcl1PEVLyM4SaRCCkBL1fu9G3pClA18ggIk/1omptftvaKVBZqIKaM8DeZHWSi76/jm7RtQ==
X-Received: by 2002:adf:f8c2:: with SMTP id f2-v6mr4091253wrq.237.1528448833499;
        Fri, 08 Jun 2018 02:07:13 -0700 (PDT)
Received: from [192.168.1.100] (aig34-1-88-167-228-121.fbx.proxad.net. [88.167.228.121])
        by smtp.gmail.com with ESMTPSA id d90-v6sm1103867wmi.26.2018.06.08.02.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 02:07:12 -0700 (PDT)
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
 <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
 <d9ecdf72-7500-66d4-0360-231218cccbb4@linaro.org>
 <20180608080437.n2b5nv73d3kp6yhb@pathway.suse.cz>
From: Thierry Escande <thierry.escande@linaro.org>
Message-ID: <0fa30e13-c16f-95d8-d1ef-fd45e7a99888@linaro.org>
Date: Fri, 8 Jun 2018 11:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608080437.n2b5nv73d3kp6yhb@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/2018 10:04, Petr Mladek wrote:
> On Thu 2018-06-07 20:47:25, Thierry Escande wrote:
>> Hi Petr,
>>
>> On 07/06/2018 14:24, Petr Mladek wrote:
>>> On Mon 2018-06-04 13:37:08, Thierry Escande wrote:
>>>> If the test_printf module is loaded before the crng is initialized, the
>>>> plain 'p' tests will fail because the printed address will not be hashed
>>>> and the buffer will contain '(ptrval)' instead.
>>>> This patch adds a call to wait_for_random_bytes() before plain 'p' tests
>>>> to make sure the crng is initialized.
>>>
>>> Hmm, my system did not boot with this patch and
>>> CONFIG_TEST_PRINTF=y
>>>
>>> I guess that there was not enough entropy. It is basically a deadlock.
>>> The build-in module init calls are called when SMP is enabled but
>>> there is no real activity and the init calls are called sequentially.
>>> Therefore there is nothing that could produce some entropy, ...
>>>
>>> I suggest to skip the test when crng is not ready.
>>
>> Thanks for pointing this out.
>>
>> The issue is that the crng_ready() is not available outside of random.c.
>> I'll leave the call to wait_for_random_bytes() if test_printf is compiled as
>> a module and use add_random_ready_callback() to check if crng is initialized
>> otherwise. Does that sound ok to you?
> 
> Great, I was not aware of add_random_ready_callback().
> 
> I suggest to make the decision in test_printf_init()
> and run all tests either as the callback or immediately.
> 

The run_kselftest.sh script relies on the error code returned by 
modprobe to check if the test is passed or not. So the init function has 
to return the test results and we cannot defer the test execution in the 
random ready callback if the crng is not yet initialized at __init.

My idea was to use add_random_ready_callback() as a non blocking test 
when compiled built-in as it returns -EALREADY if crng is already 
initialized.

But as I type I realize it's not necessary. I will simply enclose the 
call to wait_for_random_bytes() by #if IS_MODULE() #endif so it gets 
called only if built as a module, which is how run_kselftest.sh wants 
it... If test_printf is compiled built-in and the crng is not yet 
initialized the test will fail anyway so there is no need to add an 
extra check.

Regards,
Thierry
