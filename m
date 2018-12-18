Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AE3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FE521841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/3IqqXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeLRLiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:38:08 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44951 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeLRLiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:38:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so17699822qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 03:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p6ogAw12iJP/Qm8PVaTDXa92e63t3R3tjnyMvGKKzUk=;
        b=c/3IqqXl0Ty2V4N8v7BeFnPQEzvigtiu89gesRCTIJAMv38Nla714QjuOdLQrj78Hx
         XQX+eSalnyIwUWw/tLUwh4oue3V2zKmAkzWYlpKclZ8R0dcfvpH2Yj+lMzWhtevKk/NY
         n1yNScyoVsQwjP34BE3qa7kSDrG9X5ApFlT0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=p6ogAw12iJP/Qm8PVaTDXa92e63t3R3tjnyMvGKKzUk=;
        b=oBoPjiXe5uEievYt0XUrvCRxg9tcXYubh+iYyxcQQ9sQY9OlnWEFAaSUURW6FezWfP
         mWQmMNdt1JyFtZC7YfnK9aVPcF2N2BZA1HFY6/XghgXixk2Q9HgoEX74zKPcWbvRu4+Z
         xc2JJEMJUN2E4ENb/eCT2LObZW1Mz9LdfadPf9dW7VZhDDiL4EpNph44HuTTVOToKfML
         LtLIrpox4kbsKptfdY0VaDAUANL27aSHf0rWXsqeaqe47HW5jyyxtQrGgPWLvUMatmlR
         gifC/vjDaDZqSOybHe/UXMUcJ1RM11EhlLC3cJEoYQ6ifGrm+uhLgr05Ah5B7NZUPsuV
         BiDg==
X-Gm-Message-State: AA+aEWZtsuuoi8DX7RLOhzCVTE/DIQegxQm5k4er9dH7zQrwjZiJNuIQ
        a8SzxBY8Y9ZmijTBiQm414NUVw==
X-Google-Smtp-Source: AFSGD/WTTFrUti63CVrODWGpciKlpJ6+qdUtVyvErxpwt52mh+5bQtyvl/vtcYVT4942uVaIZwGhzA==
X-Received: by 2002:a0c:872a:: with SMTP id 39mr16625618qvh.1.1545133083629;
        Tue, 18 Dec 2018 03:38:03 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.31])
        by smtp.gmail.com with ESMTPSA id x202sm6184842qka.67.2018.12.18.03.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 03:38:02 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: selftests/net: udpgso: LTS kernels supportability ?
To:     shuah <shuah@kernel.org>
References: <bbabafb5-e16c-4025-31d0-d9e5feb5f39a@linaro.org>
 <1d2c9a10-6caf-49ff-b921-8b93dbe96f78@kernel.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <1de7a003-0aac-1f4f-b836-267136e30a0a@linaro.org>
Date:   Tue, 18 Dec 2018 09:37:58 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1d2c9a10-6caf-49ff-b921-8b93dbe96f78@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/18 4:42 PM, shuah wrote:
> Hi Rafael,
> 
> On 12/17/18 10:53 AM, Rafael David Tinoco wrote:
>> Shuah,
>>
>> I was recently investigating some errors coming out of our functional
>> tests and we, Dan and I, came up with a discussion that might not be new
>> for you, but, interests us, in defining how to better use kselftests as
>> a regression mechanism/tool in our LKFT (https://lkft.linaro.org).
>>
>> David / Willem,
>>
>> I'm only using udpgso as an example for what I'd like to ask Shuah. Feel
>> free to jump in in the discussion if you think its worth.
>>
>> All,
>>
>> Regarding: udpgso AND https://bugs.linaro.org/show_bug.cgi?id=3980
>>
>> udpgso tests are failing in kernels bellow 4.18 because of 2 main
>> reasons:
>>
>> 1) udp4_ufo_fragment does not seem to demand the GSO SKB to be > than
>> the MTU for older kernels (4th test case in udpgso.c).
>>
>> 2) setsockopt(...UDP_SEGMENT) support is not present for older kernels.
>> (commits "udp: generate gso with UDP_SEGMENT" and its fixes seem to be
>> needed).
> 
> This case is easy right? Based on the test output below , I can see that
> the failure is due to
> 
> ./udpgso: setsockopt udp segment: Protocol not available. setsockopt()
> is returning an error to clearly indicate that this options isn't
> supported. This will be a test change to say test is a skip as opposed
> to fail.

You referred to (2). (1) isn't that straightforward.

> We have a solution for this - test should SKIP as opposed to FAIL.
> 
>> With that explained, finally the question/discussion:
>>
>> Shouldn't we enforce a versioning mechanism for tests that are testing
>> recently added features ? I mean, some of the tests inside udpgso
>> selftest are good enough for older kernels...
> 
> Right - we do have generic way to handle that by detecting if feature is
> supported and skip instead of using Kernel version which is going to be
> hard to maintain.

You can't distinguish case (1) failures between real failures OR older
kernel behaving differently then testcase expects.

>>
>> But, because we have no control over "kernel features" and "supported
>> test cases", we, Linaro, have to end up blacklisting all selftests that
>> have new feature oriented tests, because one or two test cases only.
>>
>> This has already been solved in other functional tests projects:
>> allowing to check the running kernel version and deciding which test
>> cases to run.
>>
> 
> I would like to see effort going into fixing tests to skip when a
> feature isn't supported. I think that is the solution that will be
> maintainable in the long run.
> 
>> Would that be something we should pursue ? (We could try to make patches
>> here and there, like this case, whenever we face this). Or... should we
>> stick with mainline/next only when talking about kselftest and forget
>> about LTS kernels ?
>>
> 
> There is a middle of the road solution to run Kselftest from the same
> kernel release on LTS kernels and report the results as it is turning
> out be adding overhead in interpreting results when mainline/next
> Kselftest are run on LTS.
> 
> Kselftest mainline/next tends to be in a state where there could be bugs
> in tests like the one you are finding in the example you used to
> describe the problem. As we find them we fix them. That is just the
> nature of mainline/next
> 
> Maybe for LTS kernels it is better for you to stay with Kselftest from
> the same release or close to it. For example, running 4.20 Kselftest on
> 4.4 is going to result in more skips/(false fails) than running 4.4
> Kselftest on 4.4 even though it might provide better coverage. It is a
> judgment call on the overhead vs. advantage running newer Kselftest from
> mainline/next on LTS.
> 
> I don't think versioning (skip or release based) can fully address the
> problem you are seeing considering the fluid nature of mainline/next.

Alright. I needed a statement in that direction to decide how to better
address our "regressions" for LTS kernels.

> 
> thanks,
> -- Shuah

Thanks a lot.

-- 
Rafael D. Tinoco
Linaro - Kernel Validation
