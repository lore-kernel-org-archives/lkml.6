Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCB8ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36982146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5+l3VlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36982146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeIOBbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:31:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42971 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeIOBbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:31:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so8490495ljc.9;
        Fri, 14 Sep 2018 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o95ffNe9LLpHd9bMC6AhZhuffWZP8KYcCsNn22CV8CI=;
        b=e5+l3VlYJLhqOph8GbHia7/RQw8PS95vYhFf++rdZyrd9PsFj3hY1++98thXVlW375
         tsPaaYYIU5+Bu+Ha5mdxsYxUdvYt016Ln7GS6zDYQwkd3lG8QofIQukgCWbLO4yAnxoe
         /h+VqN+P8WrkrixLNOm3y0Yfe2ZZzb0i6u9qCjmuWkLP/i9dh3VojCSfmroTfcEdBdJi
         yb8XCWekgoE6vlMuzp2n52fj868QD0OVJBrrcd6vGSwzX43gqC3UHMNBdsm9o9aBbj5f
         c5TdF6nxanP7sgBTToHs4ZkTQEKl4nXTf148GRtNaOgvNcWFQLMLZUtZZlvrR2T61tv+
         +IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o95ffNe9LLpHd9bMC6AhZhuffWZP8KYcCsNn22CV8CI=;
        b=L59P57hG3IF+eDS3uf/nY8EJ0ks4YgQJ0lnbe53Fikd4+Cv0RkSu/zufEorOL1Prd6
         1zD/f0WQ+Vi56YqBKdPcdBpNPXIGDoLvhTu7wR4mjpdAUUvArR1cLz6O4C715p/la7Ul
         AzxwvKsuEAiKVoFXubv6VPoWw1r++piMADnchN9lWG7VAWmKJq6KcwYxcqenSfzFMlcP
         nOuFtQqaMd/DcGSslzBFQI5sbgHhXz9elfUpSdlIsv0l9qm2rCZ95N9jfgdejgh8la9Q
         CmoOnpc/VyxU9Hzj72kmoyqXZIc4EiMdKfTk5nKJzMtq33ANFzp26e6bLOp3WotyC1Jo
         40Uw==
X-Gm-Message-State: APzg51Dard7dGSWw/gLLwCR6WjucajdLl2EGv8r5ngEG9daXR4E+/OBX
        AYkbZiikVeSMU1XlG+TJcTbRvUNa
X-Google-Smtp-Source: ANB0VdZjXjdEwQEslxEKgC1SQWrbnf52F65L43KUwbjcyASTOgbpEIZkcJ4F131KrTL1FEvhiXpxJw==
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr8564861ljj.53.1536956142134;
        Fri, 14 Sep 2018 13:15:42 -0700 (PDT)
Received: from [192.168.1.18] (bkp132.neoplus.adsl.tpnet.pl. [83.28.183.132])
        by smtp.gmail.com with ESMTPSA id v63-v6sm1373200lje.20.2018.09.14.13.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 13:15:41 -0700 (PDT)
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com> <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com> <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com> <20180914081822.GA21830@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9c14ee7c-f172-bb0c-d9a8-8aeee408f716@gmail.com>
Date:   Fri, 14 Sep 2018 22:15:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914081822.GA21830@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 09/14/2018 10:18 AM, Pavel Machek wrote:
> Hi!
> 
>>>> How do I politely explain that the original implementation was wrong for certain devices?
>>>
>>> Implementation? Device tree is hardware description.
>>
>> Yes this hardware description is incorrect.  The hardware description is
>> describing a MFD but this LED driver (and a couple others) only perform
>> 1 function and that is to drive a LED string.
> 
> So what? Does not seem incorrect to me. Maybe the description should
> not be in MFD directory, but other than that...
> 
>>>> Isn't code and documentation supposed to be pushed in stages
>>>> together?
>>>
>>> Device tree is _not_ documentation. And yes, it is normally pushed
>>> together. But that did not happen here, and bindings are already in.
>>
>> Hmm..  Its not documentation but it is in the Documentation folder.
>> And just because the bindings are in does not mean they cannot be
>> changed.
> 
> You may want to learn more about device tree and/or talk to the device
> tree maintainers. This is an old article. https://lwn.net/Articles/561462/

The article title is "Device trees as ABI". A device tree is defined
in the "*.dts" file that is then compiled to a dtb blob, which
constitutes the ABI. And this ABI should be kept backwards compatible.

What is discussed here is a documentation of bindings, i.e. according
to ePAPR: "requirements for how specific types and classes of devices
are represented in the device tree".

From the bindings documented in the
Documentation/devicetree/bindings/mfd/ti-lmu.txt only
ti,lm3532-backlight is used in the mainline dts file
(arch/arm/boot/dts/omap4-droid4-xt894.dts).

Having the above it seems that there is no risk of breaking any
users.

> NAK on this patch. I see that this binding has problems, but
> introducing different binding for subset of devices is _not_ a fix.
> 
>>> What about the multi function devices? They should have same binding.
>>
>> The MFD devices defined are not in contention here only the SFD.
> 
> I'd like to see common solutions for SFD and MFD, as the hardware is
> similar, and that includes the code. Having code that is easier to
> maintain is important, and having many drivers are harder to maintain
> than one driver.
> 
> Milo's code looks better than yours in that regard. I disagree about
> Milo's code being "nightmare" to modify, and care about "easy to
> maintain" more than "binary size".

Easy to maintain will be a dedicated LED class driver.

-- 
Best regards,
Jacek Anaszewski
