Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A0AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6CA208B6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dowhile0-org.20150623.gappssmtp.com header.i=@dowhile0-org.20150623.gappssmtp.com header.b="zhPO6C5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6CA208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933683AbeGDL0W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:26:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38856 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932594AbeGDL0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:26:19 -0400
Received: by mail-it0-f68.google.com with SMTP id v83-v6so7567760itc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZN4cdtwiCKYUIxSI2oO8Rjv2EvNVl0Tb8mnFdtXeuxk=;
        b=zhPO6C5RJ4R7vk32QjiQxGaiCU2uyqcj0Q9B5+TPBmWNI/ZypAFgCEAKxeTWvU0gsW
         N9cBxlKRrvZTwb7ZALQFETYDgLaloPjJlafItawQMjNZ13Tk62YXl0UkL1rYk5PwNlmK
         5BRJ/Ln5L82C3UHhq85YjETjzj8C9UUlVpgjmwOUts+aiS7QFYm/AwAvr1qExnyB6wTp
         Qqam46b93cOkDsVPwDVrG9AfjE+Y+Ql7RmKB46em9MTkP1yWpyzT3QS+4g8g0KUvNwsO
         aeuc+L2+gWTtT+lUZmir/gXQ2bmJQxNZnuklvpx3b87aHqAotqsuR8qmUsJ5J0ZvFZGA
         82Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZN4cdtwiCKYUIxSI2oO8Rjv2EvNVl0Tb8mnFdtXeuxk=;
        b=iCtMifRXr3shDy0snuGz4ldCi/CW8x6Dp8cb5DyvSCUwz5EWXiGlYm0GUEW6391nCS
         ZgqSrW6cHKEfhx6GlmNFlaKAPoAZfJBVCqMkBEhB2mpV2YydnSB9w6cr+k/ZmLFOXiZP
         msD09g+dlaleAROaS4GXiQpVT1/Wsf+C3FNXxmq72B3QqbRpg0/3dXxgm3v7aByfvIKW
         xsDHT73RVVfDzYTNOt1VkfM39DIzxhh9CyQkgGFvylhZ3w2Ad9en9r7DzxpLyTWJCuh5
         bpcl2CDpowl5K9WEAMQSv5dGsLzBfrohKfxjLCevC+hTitDsdQh5Djl/ZQeNKuykvBZr
         ot6g==
X-Gm-Message-State: APt69E1FLWPrsSfvufpqrcUF8WerQMQW4hlbVpbDLcUjIJ8jcHvO9tF3
        T4UyBLnTwqL9vks6qLeHkoP9o6yPUFJSiLXvvAhdXA==
X-Google-Smtp-Source: AAOMgpckghkc5Pjr45aw1s/oRbd6+nfpptM7yxqetyghlYplUQSUCyHYomf1JvwlG39pLjW68lTW3kjnHULStdLboE4=
X-Received: by 2002:a24:1dd6:: with SMTP id 205-v6mr1393700itj.132.1530703579233;
 Wed, 04 Jul 2018 04:26:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:f017:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 04:26:18 -0700 (PDT)
X-Originating-IP: [195.166.127.210]
In-Reply-To: <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local> <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
 <10258a21-db42-2c4e-91d6-e9227e11f53b@redhat.com> <alpine.DEB.2.20.1807041304490.9558@fox.voss.local>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Wed, 4 Jul 2018 13:26:18 +0200
Message-ID: <CABxcv==_JaiX7-++MRFTHmaikWbNin_YbaWuiqiuZAAuWPgvwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

On Wed, Jul 4, 2018 at 1:15 PM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Wed, 4 Jul 2018, Javier Martinez Canillas wrote:

[snip]

>> I think Nikolaus is correct, assuming that the driver can be used on
>> legacy
>> platforms that register the I2C devices using board files / platform data.
>> In that case you still need a I2C device ID table for (a) and (c) as he
>> said.
>>
>> I don't buy on (b) though, that's a bug in my opinion. If you register an
>> I2C
>> device via DT then you must have a OF device ID entry that matches the
>> device
>> and the same for ACPI. You can't rely on the I2C device table to do the
>> match.
>
>
> Ok, in my opinion it is an elegant way of not bloating the driver when no
> explicit handling (e.g. reading DT properties) is needed. Just adding an
> of_device_id doesn't change any driver functionality then but only maps to
> an already existing i2c_table_id.
>

I disagree, in the case of OF for example a compatible string is
composed of both a vendor a device, the complete tuple is what should
be matched.

But with the fallback, only the device portion would be used so both
<foo,bar> and <baz,bar> will match against the i2c device with id
"bar". It may or may not be correct but the vendor portion is very
important to disambiguate.

>>
>> I would also remove the struct i2c_device_id .driver_data fields from the
>> I2C
>> device ID table, since are not used and just makes reading the code
>> confusing
>> (only the struct i2c_device_id .name is used as far as I can see).
>
>
> Valid point, thanks. I will change that.
>
>>
>>> Javier, just a summary of the above. Nikolaus switched one driver to
>>> use ->probe_new() hook and left i2c ID table at the same time.
>>> My understanding that this table is not anymore in use.
>>>
>>> But I have to admit I didn't see entire picture of this. Can you shed a
>>> light?
>>>
>>
>> So to shed some light, in the past even {OF,ACPI}-only drivers needed an
>> I2C ID
>> table because: 1) the .probe callback had a struct i2c_device_id *
>> parameter
>> and 2) the I2C core always reported a modalias of the form i2c:<foo> even
>> for
>> devices registered via OF.
>
>
> It could have been a null pointer and device driver binding (and
> auto-loading) done just via driver.name.
>

I'm not sure I understood this comment.

> Niko
>

Best regards,
Javier
