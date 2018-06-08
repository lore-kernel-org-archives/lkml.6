Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uXEGCOdlGltUIwAAmS7hNA
	; Fri, 08 Jun 2018 11:29:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E6397607E4; Fri,  8 Jun 2018 11:29:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/gESEU8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 92C64601D2;
	Fri,  8 Jun 2018 11:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92C64601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFHL3D (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:29:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33095 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbeFHL3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:29:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so6743342wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 04:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OHDzssc6IQS33Vgpo5N5myowHmy6qw3n8Nt8ExOrf9E=;
        b=F/gESEU8vWQMXETaWFjcdCmi1ExozPs71shczoqlX2DryXU8qZ5+rYJOg2sByE4ISp
         PD3ln8ifR3FfYeYVYuf3Uk4dOWlGm/eiAMNbZJg16rwGoXO+x6YPKRShvVULz8/YS0gG
         D4+EJGz+79sQgTm1ewcfMSYlBne57VB/1bDfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OHDzssc6IQS33Vgpo5N5myowHmy6qw3n8Nt8ExOrf9E=;
        b=HChhquE1zMxMexEkFmt7zEjuqLtyvUo8lCcty4PfOTLuKO634xoeZKr486Q7fZz2Du
         O3ULQiJZOljos9te0G0bsBF91b9LBUmYPhBNdel7atBQAMA0mwsNtkRkFWRMj0l0DRod
         hA1LYb9IDsIFEoYvuKp6WiEJ2+vBiG82r6fdM8kY8f0bldcRO6toRZ62MEaO/vwVWYJh
         qelcrICggkqprx9wx43PiiamI6p5HeINW+fN9w3CsrZ10d0wIadDMqRYJqgKPEtCAlN+
         s82ZFsNrRmjjX55hh/YFQUrZJ/SdFgh8VYUkcDMUk5Yp7BsZ0uDPbN9bG8+ntbWqGz8F
         iFlw==
X-Gm-Message-State: APt69E3uM5HVUHA77rifcZSHuvf6bCGjQjFZtLptsFbf8PYal4pxGkEO
        ZFjo5NpwqDVIRGKqCpKcWNawpSdeRUk=
X-Google-Smtp-Source: ADUXVKL16vPuZsuGE+9pMObVRVDOEf8AOE5T+QGLr9AuhC7QZpn3JDhZMhzptasPFrN2Eah6q6oAMA==
X-Received: by 2002:a1c:bf43:: with SMTP id p64-v6mr1229016wmf.71.1528457340461;
        Fri, 08 Jun 2018 04:29:00 -0700 (PDT)
Received: from [192.168.1.100] (aig34-1-88-167-228-121.fbx.proxad.net. [88.167.228.121])
        by smtp.gmail.com with ESMTPSA id n7-v6sm39816574wri.27.2018.06.08.04.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 04:28:59 -0700 (PDT)
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
 <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
 <d9ecdf72-7500-66d4-0360-231218cccbb4@linaro.org>
 <20180608080437.n2b5nv73d3kp6yhb@pathway.suse.cz>
 <0fa30e13-c16f-95d8-d1ef-fd45e7a99888@linaro.org>
 <CAHp75Vc5_+Kxsvgws9Oq-hOgbQ8-ocxeKa4AuhC0uJ0oKsu+BA@mail.gmail.com>
 <a8ab166e-a2b9-b0fc-9717-ffd8fcbcd386@linaro.org>
 <20180608112230.77zsd5y7we7hiqei@pathway.suse.cz>
From: Thierry Escande <thierry.escande@linaro.org>
Message-ID: <5484aaf1-ec14-0013-c2c1-fcb3e95b975d@linaro.org>
Date: Fri, 8 Jun 2018 13:28:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608112230.77zsd5y7we7hiqei@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/2018 13:22, Petr Mladek wrote:
> On Fri 2018-06-08 12:32:33, Thierry Escande wrote:
>> On 08/06/2018 11:46, Andy Shevchenko wrote:
>>> On Fri, Jun 8, 2018 at 12:07 PM, Thierry Escande
>>> <thierry.escande@linaro.org> wrote:
>>>
>>>> But as I type I realize it's not necessary. I will simply enclose the call
>>>> to wait_for_random_bytes() by #if IS_MODULE() #endif so it gets called only
>>>> if built as a module, which is how run_kselftest.sh wants it... If
>>>> test_printf is compiled built-in and the crng is not yet initialized the
>>>> test will fail anyway so there is no need to add an extra check.
>>>
>>> Unfortunately I can't support this as is.
>>> We have environments where crng will be ready minutes after the boot.
>>> It's unacceptable.
>>>
>>> So, we need to have means to not delay test for so long.
>>
>> I agree we can't delay test execution for too long. In my case the crng is
>> ready only a few seconds after the boot. So we may just skip this plain 'p'
>> printf test if crng is not ready then.
> 
> Alternative solution would be to accept
> const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
> as a valid result. It would make sense to print some warning in that case.
> 
> In each case, it would look ugly to use add_random_ready_callback()
> wihtout passing a callback. If you really needed to check crng_ready(),
> it would be better to make it public.

Agree but even with crng_ready() public we would have to block the test 
until it's ready which is not good either.

Accepting "(ptrval)" as a valid result seems the least bad alternative...

Regards,
Thierry
