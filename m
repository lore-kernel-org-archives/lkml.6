Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBA4C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21BE20BEC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpSa0qjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21BE20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934710AbeGDKTb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:19:31 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33009 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933862AbeGDKT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:19:28 -0400
Received: by mail-ua0-f194.google.com with SMTP id g18-v6so3134740uak.0;
        Wed, 04 Jul 2018 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tdBArjcc1matlQ0iR03GHlXgkoI7jKk2Od9X65ZmdpU=;
        b=JpSa0qjTipReanSZh/vR6OPuJVNf6se5aHYrWssHmfc7uL58Ac89+glIXSgXnwPTKr
         dLUF7+gV9naHk7HhtXtdldw3feP9jfiSyNgNk35WPwN/HFR4KRNGJwQXnc2te6nCCdAV
         VLhGUxcZVHTbEiE8F/YtZs3AE6aMMzjKaDMx1nuewcQCUUd5HyqL3eZ0ah+EyMWkGPSu
         6HFnXOmDXg8A0EdiYcWQpv+36MgjiUleMuRttKua63Ys0XRlaDom5gIbjN4YKLD3Ti2+
         SWOaupWu063h8fppwe/aIhwJzZQHNJ0wp75HAMIVA92xKhSvCNDH2Z1PwSKHpQngmqYw
         P+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tdBArjcc1matlQ0iR03GHlXgkoI7jKk2Od9X65ZmdpU=;
        b=cflA7xqcu413mYcg525tyMmkq+RLDzIDYCreKwCFU8kY40W8u1/SSwtWB+dtn/BSan
         uw1fQjl9oOxb2PffSNTI+hqxuAMzVty9w09TRrQyxeMjXZyqerJL5OUnXDrnYukJWJVJ
         CdH2Xq9fj7pn86oPtEXS0LnELqBAERpnS26hQmvjt3f4zdTwuH/itkCELJTblW0CrHoI
         2pUomKNl5ZOaRkNSOj4Ph7BpStq2XDJ8kojQHCxrKNMGkRbR62m8KxrlqAmNK0ns6Qyk
         kU12J1nB2WsRhvg1ZO5YPKp0UCzTj8pkcSTO2VpH/G7r0sIFfrCeJPruqCDmG57NiHdH
         TnMQ==
X-Gm-Message-State: APt69E1P22P5lY3Lgr5eNxfyb0MV9WMCV0K5GWBDJ4ep27/Cga7o2Ndr
        DF/7UlQa9mq6nMBAikskqAljxGa/Q48/uB5S3Zg=
X-Google-Smtp-Source: AAOMgpciX7dLdKVE+FcY4aCjR5Jj05ulCHVHDONo/9vg7HVeYCw3wS59vqYAk2aSoUPZNAJp7Q+eQwORT+4L9il4jIg=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr776664ual.28.1530699567572;
 Wed, 04 Jul 2018 03:19:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 03:19:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1807041119360.8194@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
 <alpine.DEB.2.20.1807040728490.6169@fox.voss.local> <CAHp75VdkeVEuJtcGB4unoSJqRh2r+_7aGJ+BPKO2ABriVQigvQ@mail.gmail.com>
 <alpine.DEB.2.20.1807041100360.7891@fox.voss.local> <CAHp75VdxtfkrV0bT=4yeYcSUFncTvjBfVC1haOUPpdOaOohmLg@mail.gmail.com>
 <alpine.DEB.2.20.1807041119360.8194@fox.voss.local>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 13:19:26 +0300
Message-ID: <CAHp75VcQrd134aA54_nZtGr3YaXAtwZLXpj6Oi1=BOSMynEvVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summon Javier to the discussion.
For my opinion he is an expert in this topic.

On Wed, Jul 4, 2018 at 12:42 PM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>> On Wed, Jul 4, 2018 at 12:09 PM, Nikolaus Voss
>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>>>> On Wed, Jul 4, 2018 at 9:37 AM, Nikolaus Voss
>>>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>>> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>>>>>> On Tue, Jul 3, 2018 at 9:06 AM, Nikolaus Voss
>>>>>> <nikolaus.voss@loewensteinmedical.de> wrote:

>>>>>>> struct i2c_device_id argument of probe() is not used, so use
>>>>>>> probe_new()
>>>>>>> instead.

>>>>>> This makes...
>>>>>>
>>>>>>>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);

>>>>>> ...this table obsolete IIUC. At least that's what I did when switched
>>>>>> to ->probe_new() in some drivers.
>>>>>>
>>>>>> If I'm mistaken (again? :-) ) I would hear from someone to point me
>>>>>> how it can be used after a switch.

>>>>> It is still used by the i2c-core in i2c_device_match() if DT and ACPI
>>>>> matching fails.

>>>>> And it is used to create the corresponding modaliases for
>>>>> driver loading.

>>>> My question is "How?!"
>>>> I don't really see any points to match against it after switching to
>>>> ->probe_new().
>>>>
>>>> Could you point me to the code path in i2c (or OF?) core for that?

>>> As written above in i2c-core-base.c: i2c_device_match() ->
>>> i2c_match_id(driver->id_table,...
>>>
>>> This is used for driver matching before probe() or probe_new() of the
>>> device
>>> driver can be called. probe_new() actually is a function signature change
>>> only.

>> Okay, IIUC we got a match. What should we do with it? The table is not
>> used in ->probe_new() (in i2c core), so, you can't say which line
>> matched there.

> The table is not used by the driver, but is necessary to
>
> a) bind an i2c device declared via i2c_board_info with type field set
>    to one of the names of the i2c_device_id table to this driver
> b) bind an i2c device declared via DT or ACPI but with no match in of_id/
>    acpi_id table but an i2c_device_id table match to this driver (fallback
>    matching)
> c) create the right modaliases at compile time for this driver to make
>    module auto-loading work in case of a) and b)

Javier, just a summary of the above. Nikolaus switched one driver to
use ->probe_new() hook and left i2c ID table at the same time.
My understanding that this table is not anymore in use.

But I have to admit I didn't see entire picture of this. Can you shed a light?

-- 
With Best Regards,
Andy Shevchenko
