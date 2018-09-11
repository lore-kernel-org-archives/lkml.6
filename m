Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A0C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD95020866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFYneO1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD95020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeIKX22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:28:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44099 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeIKX22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:28:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so27028044wro.11;
        Tue, 11 Sep 2018 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HXO0L8fYwpZh8qAkyIdR9ggXbPoPhyP2n3VEJpNT3as=;
        b=OFYneO1h+BDYKthMo7XsiJrw7T9qkJDMQzT3TIZZqANs4jZ4CJJH6fSgMl+ffX/CCD
         vQbZO69SrABfHkp5jGHzrNjyGFfhvESXgm1RII1hGJv03AUpFbetQUBa/4JvLiBUj8QY
         JewvVQ6W4sXci5gY/nmh3njnMMnRb2qWH2c7FozlGwG9wiWoYrIB5/CdlkVazRWNVA4t
         1izpAVoAc7x0ADUFNrVE19Wk6RXE0rrCxhq9S/7tFItWLjtPNnMDv5LaDZDM8Beu5AyG
         SS1nJzILR1d9r3Ury43sbs6s1cy3FscpDDTeqcqdYp6QTtXkoPdicnWF5r25+dC+gm3B
         k/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HXO0L8fYwpZh8qAkyIdR9ggXbPoPhyP2n3VEJpNT3as=;
        b=E227zldSyzEkuRz/PdBcFn39Z/r64cDqF8YezC1J79COR+bk8Qyk7nrw4Ai1AOas/H
         Bn6csS2yq2414Rv+OQDPzUhPlZgOl4nmAi6KtD346HwR6WaUQnD8mNt7UQLlB8ctPO8V
         HAn1pzmVlxzgRkCn+c1zIWji6OXwgPlPKeOjJEjyvStZN4/AgOXVIetI/6vUn5l1WLyJ
         D/6AdVad5cV6kaNKbuEB5/SGfgyaPkh6CIH+l1vATnahwEewi4sH82abUOpkNvyL47U0
         wNmeY9gNffXK6PyP/EyypkEbhByJuuht/veZ5AscOrScH3cR2YOZD9WNu6kQX0gm7N6I
         28pQ==
X-Gm-Message-State: APzg51DDJlGNyo+yszFHOx/9N20pR4ZNrNjgUUOq8wC72il0NimXfA6W
        49BSg/7Z+WD/61db7ukWXtR9d91c
X-Google-Smtp-Source: ANB0VdbE1BuN2iMvYB4HB+jygJdech4Eb34QA00nucQNnPN+YWBKEsWVCyJACQE7SruAvaPjzIwClA==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr15488408wrx.157.1536690473330;
        Tue, 11 Sep 2018 11:27:53 -0700 (PDT)
Received: from [192.168.1.18] (bks43.neoplus.adsl.tpnet.pl. [83.28.186.43])
        by smtp.gmail.com with ESMTPSA id j191-v6sm2586103wmb.37.2018.09.11.11.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:27:52 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180906135005.6718-1-dmurphy@ti.com>
 <20180906211617.GB16899@amd> <b8ac9d52-f16d-5fc4-0e9a-9246b9f984c5@ti.com>
 <20180907133228.GA16297@amd> <70f7506c-6a3d-3830-59a4-a246dc6163f7@ti.com>
 <226b8770-7041-39a4-5a06-6002a7c1225f@gmail.com>
 <20a814ce-a4c5-0649-6677-6b85a5fd2321@ti.com>
 <59561e0f-e3b9-7898-a300-90b198ad14e6@gmail.com>
 <20d9ea9e-bbb8-2240-97cc-615e3fbcef8c@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <5127d46f-2d43-41e8-dde0-5ee42a9d47bb@gmail.com>
Date:   Tue, 11 Sep 2018 20:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20d9ea9e-bbb8-2240-97cc-615e3fbcef8c@ti.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 09/10/2018 09:51 PM, Dan Murphy wrote:
> Jacek
> 
> On 09/10/2018 02:07 PM, Jacek Anaszewski wrote:
>> Dan, Pavel,
>>
>> On 09/10/2018 04:37 PM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 09/08/2018 02:53 PM, Jacek Anaszewski wrote:
>>>> Dan,
>>>>
>>>> On 09/07/2018 03:52 PM, Dan Murphy wrote:
>>>> [...]
>>>>>>
>>>>>>> And I think Jacek pointed out that the bindings references in this bindings
>>>>>>> don't even exist.
>>>>>>>
>>>>>>> I am thinking we need to deprecate this MFD driver and consolidate these drivers
>>>>>>> in the LED directory as we indicated before.  I did not find any ti-lmu support
>>>>>>> code.
>>>>>>>
>>>>>>> ti-lmu common core code and then the LED children appending the feature differentiation.
>>>>>>
>>>>>>> Need some maintainer weigh in here.
>>>>>>
>>>>>> Hehe. I'm maintnainer. Fun.
>>>>>
>>>>> I know.  I want to see if there was any other opinion.  Especially for the LED driver.
>>>>>
>>>> [...]
>>>>
>>>> I have a question - is this lm3697 LED controller a cell of some MFD
>>>> device? Or is it a self-contained chip?
>>>>
>>>
>>> This is a self contained chip.  And the LM3697 only function is a LED driver.
>>> It does not have any other special functions like the LM363X drivers for GPIO and Regulator support.
>>
>> This is an argument for merging it as a standalone LED class driver
>> then. It is even more justifiable, taking into account uncertainties
>> related to the proper way of adding the support for it to the existing
>> MFD driver, whereas the code reuse would be the only advantage of having
>> thus support in MFD subsystem.
>>
> 
> Does the argument carry over to the other devices?

If we want to be consequent - yes.

> Like the LM3632 (part of the ti-lmu) has flash and torch and no other special functions
> so it would look like the lm3601x family with different register mappings.

Yes, this is obvious candidate for LED class flash driver.

> The LM3631 seems to also be just a LED driver with no extra functionality
> 
> I could go buy an EVM and put together a driver for that device as well using the lm3601x as
> reference.

I'm not going to encourage you to make this expense, but to put it
politically - I'd happily welcome those drivers in the LED subsystem ;-)

-- 
Best regards,
Jacek Anaszewski
