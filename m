Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vrIYI1h9GVswWgAAmS7hNA
	; Thu, 07 Jun 2018 18:47:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B2F8D608BF; Thu,  7 Jun 2018 18:47:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRbWhDm+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 19D116074D;
	Thu,  7 Jun 2018 18:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19D116074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932264AbeFGSra (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:47:30 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38094 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753169AbeFGSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:47:29 -0400
Received: by mail-wr0-f194.google.com with SMTP id e18-v6so2626015wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jq3fo19f6padLIIBgXrSmLayZed11pR10Zz/YBUntHE=;
        b=FRbWhDm+pQcfuJmLXtoO3ZCus4wRNQ1gYQF4DigY4rhnrGG8PcXsxwI2yWtnmXJqr0
         Vhca/OGOk5az6fgfLB/4P/ELFpIDFMF0beL17XZqdFC0gBIj6sCCB5qjwiCoOqNt0NFd
         ppySwaC0OLzHZPOOhbNE7inaBH/KR3YIHZN7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jq3fo19f6padLIIBgXrSmLayZed11pR10Zz/YBUntHE=;
        b=a97FMjLMdq9zHUgTBcE9kdoMSd22DQP6KPVsG6/hpEmihY5Tiy1t4Lb6Li5bjQP1U/
         fJJBbImPLQSQSftnGG46Rb9Fd38XtbeEJjdUyBLdcA/DKgCPaYsRRTbxXyOT1mz/NYuD
         dDKzXbWbVD93NY4K3C4MCOOA1de0hRBXvpaK2AELRPx6fMPRkeCyPbGNEnsHsYeIpqUg
         c+ZKZAZZXVSGmPwDnhalBaJ/1ZhBArleWoos2acrD7LQ+rZS4p44isu0xTUfXFjjEZ6N
         HbVxND6HLWpGBKbezjg+ftJImXpaTukxjo9r6ruIKfpQkNlsQzyDiXszEBbsY/Uxa4ah
         IsNg==
X-Gm-Message-State: APt69E37uvhpynAXUwH68zJDgWJM3S/W1nTPQVw09C2O8qEhVxyXQiPC
        TIoM8D9Fyfthr+gvj9W0zpKJWA==
X-Google-Smtp-Source: ADUXVKLhoWHs1M9Vj0aPiZyFRcbRoYEe/xl7kbGSeHOEI3SpmNcbbeU1jmIXweCNv0GR/mw6Xg5QIw==
X-Received: by 2002:adf:9341:: with SMTP id 59-v6mr2497149wro.80.1528397247901;
        Thu, 07 Jun 2018 11:47:27 -0700 (PDT)
Received: from [192.168.1.100] (aig34-1-88-167-228-121.fbx.proxad.net. [88.167.228.121])
        by smtp.gmail.com with ESMTPSA id p6-v6sm24210331wrq.19.2018.06.07.11.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:47:27 -0700 (PDT)
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
From: Thierry Escande <thierry.escande@linaro.org>
Message-ID: <d9ecdf72-7500-66d4-0360-231218cccbb4@linaro.org>
Date: Thu, 7 Jun 2018 20:47:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 07/06/2018 14:24, Petr Mladek wrote:
> On Mon 2018-06-04 13:37:08, Thierry Escande wrote:
>> If the test_printf module is loaded before the crng is initialized, the
>> plain 'p' tests will fail because the printed address will not be hashed
>> and the buffer will contain '(ptrval)' instead.
>> This patch adds a call to wait_for_random_bytes() before plain 'p' tests
>> to make sure the crng is initialized.
> 
> Hmm, my system did not boot with this patch and
> CONFIG_TEST_PRINTF=y
> 
> I guess that there was not enough entropy. It is basically a deadlock.
> The build-in module init calls are called when SMP is enabled but
> there is no real activity and the init calls are called sequentially.
> Therefore there is nothing that could produce some entropy, ...
> 
> I suggest to skip the test when crng is not ready.

Thanks for pointing this out.

The issue is that the crng_ready() is not available outside of random.c. 
I'll leave the call to wait_for_random_bytes() if test_printf is 
compiled as a module and use add_random_ready_callback() to check if 
crng is initialized otherwise. Does that sound ok to you?

Regards,
Thierry

> 
> Best Regards,
> Petr
> 
>> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
>> Acked-by: Tobin C. Harding <me@tobin.cc>
>> ---
>>   lib/test_printf.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/lib/test_printf.c b/lib/test_printf.c
>> index 71ebfa43ad05..839be9385a8a 100644
>> --- a/lib/test_printf.c
>> +++ b/lib/test_printf.c
>> @@ -260,6 +260,13 @@ plain(void)
>>   {
>>   	int err;
>>   
>> +	/*
>> +	 * Make sure crng is ready. Otherwise we get "(ptrval)" instead
>> +	 * of a hashed address when printing '%p' in plain_hash() and
>> +	 * plain_format().
>> +	 */
>> +	wait_for_random_bytes();
>> +
>>   	err = plain_hash();
>>   	if (err) {
>>   		pr_warn("plain 'p' does not appear to be hashed\n");
>> -- 
>> 2.14.1
>>
