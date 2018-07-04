Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87337C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A864223F8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A864223F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbeGDNqY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:46:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56090 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753664AbeGDNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:44:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so5874791wmv.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 06:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c5doDLToCf7xuS0dLC6q1LJr7ceYL3srvl5X6vkh+Kk=;
        b=Um6zYGXRx9HCfN7XcJdm9nPADmWhAGX1/C1sOD1IsJMefgsYFkRND9rOMC/RjfPtOr
         +Z724It7gLe9moy5uXEYVNxuQaO6ndVpk/WxEhuNaa9NNwj+xRZdO7LgnreTPX5lz1st
         /1dDCBfZGLYfAdRXX5mnyXItKijI61bZVSPIIe21+0T2cZLW0LSWNlT8U3WLseXtYI6N
         /GLrIqKyyyqCP5e4BOkFLro8MQsJnBhp/hTHGHkdOI8QQ7l4vyGO2OANPRtv/tyJlSRp
         UUqsXffTPKLYJfzPR50HEkpZheLGqM3L2OzAzChfB0DzBSq9qULJMPz5TRTenR73rJtT
         Gtrg==
X-Gm-Message-State: APt69E2nfxO2zzbTutEBtrI71d8qUdgUYZLWOMA2iRt1wjB6cMvQnq2c
        OLMByoQLn6atq44c8LtUZ8dMJPH9MzA=
X-Google-Smtp-Source: AAOMgpdj1mP/qrfKs47oMlc0b48fTm74/+NA4X+/AR549zDaK8eMdpcak5nyxFZ1iBQ7UMwnh3g5Sg==
X-Received: by 2002:a1c:6c14:: with SMTP id h20-v6mr1764377wmc.138.1530711860122;
        Wed, 04 Jul 2018 06:44:20 -0700 (PDT)
Received: from [10.201.33.7] ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id e3-v6sm7402057wmd.2.2018.07.04.06.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 06:44:19 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Javier Martinez Canillas <javier@dowhile0.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local>
 <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local>
 <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local>
 <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com>
 <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
 <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041332340.9872@fox.voss.local>
 <CABxcv=kL0eV9mygvX=LvqNobyyi0ySHAo1O3v2t7+q3mk_rZyA@mail.gmail.com>
 <alpine.DEB.2.20.1807041420160.9872@fox.voss.local>
 <CABxcv==xgZb5iyupLvFno=JNnxWnkyD8stFjACz_x756Lm2yRA@mail.gmail.com>
 <alpine.DEB.2.20.1807041501420.11004@fox.voss.local>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <96736265-f7ef-fff7-eb28-6a9715024e00@redhat.com>
Date:   Wed, 4 Jul 2018 15:44:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1807041501420.11004@fox.voss.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 03:24 PM, Nikolaus Voss wrote:
> On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:
>> On Wed, Jul 4, 2018 at 2:31 PM, Nikolaus Voss
>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>> On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:
>>>>
>>>> On Wed, Jul 4, 2018 at 1:46 PM, Nikolaus Voss
>>>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>>
>>>
>>> [snip]
>>>
>>>> But this discussion isn't really related to your patch. I think is
>>>> correct but just said that (b) wasn't a justification to leave the I2C
>>>> table, points (a) and (c) are though. I won't really be convinced that
>>>> the fallback is the correct thing to do or even a good idea.
>>>
>>>
>>> I didn't want to annoy you, I just wanted to understand why you think
>>> fallback is such a bad thing that you call it a bug. And I see, it has its
>>> drawbacks ;-). Anyway, thanks for taking the time to clarify this,
>>>
>>
>> Oh, I'm not annoyed, sorry if I sounded that way. What I tried to say
>> is that I've a strong opinion on this and won't be convinced otherwise
>> :)
>>
>> So for me is a bug because that would mean that either an entry is
>> missing in an OF device table or a DTS has a node with a compatible
>> string without a vendor prefix.
> 
> Yes, I see your point (and your strong opinion :-)), but AFAIK vendor 
> prefix is not mandatory... At least for vendor-agnostic drivers like 

The latest Device Tree specification [0] says about the compatible string:

"The recommended format is 'manufacturer,model', where manufacturer is a
string describing the name of the manufacturer (such as a stock ticker
symbol), and model specifies the model number".

> "regulator-fixed" (very popular in dts files). My point is not bloating

I don't think the "regulator-fixed" is a good example. Since the Device Tree
should describe the hardware. The "regulator-fixed" is a convenient way to
describe a fixed voltage regulator but I think is more of an exception.

I'm pretty sure that the DT maintainers wouldn't ack a DT binding with a
compatible string that doesn't have a manufacture prefix nowadays.

> drivers with large redundant (from a driver-functional view) tables when 
> one table could be enough for a properly working driver. Having three 

You need the OF table anyways for module autoload since the I2C core will report
a OF module alias. You can only do the I2C fallback trick if your driver can't
be build as a module. But even in that case you would be ignoring the vendor.

> different names for exactly the same isn't very beautiful IMO.
>

I agree with you on that. But abusing a table used by another firmware interface
isn't beautiful either. So I think the best is to have consistency and always
use the same table for the same firmware interface.

> I hope you're still not annoyed...
> 

Don't worry for that, it's very hard to get my annoyed :)

> Niko
> 

[0]: https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.2

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
