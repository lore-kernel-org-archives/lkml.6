Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67323C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFA4208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj854l0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFA4208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933653AbeGDJAa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:00:30 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41401 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932376AbeGDJA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:00:28 -0400
Received: by mail-vk0-f67.google.com with SMTP id j11-v6so2685614vke.8;
        Wed, 04 Jul 2018 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Te9tePIeRGvCFLjYI7IVvtZylw1vtXMf4yMzFsMjlJk=;
        b=Yj854l0vbYccmplHXWMDtDdgN96DjawR3oh0IcmMFwZ+TYH2IrnhoMLsrT51lwY7sV
         bGnWZTUvq0PpByBpeHgcP5JNyVXSyXYYqioYSie2VaVLk+HSP2KhflxjJzy6TIbM8nan
         I14ioI+8NiW/WuikhCxlja+IlafhLkwD8/TBGpnmrX6FKRJPOCDMm2uhSN3R9VxQA2E/
         9Px0aVBWQ+zdd/c7PAL2nXl3G5vdffC34P1lB8upHVEFe1Ubl2Hze9AqFugHQd2nUHGY
         mbNKFV1xJphMbhpHVIs/VOHBxG0cQsxdpxrMEZ0VGcQ62n4d/vuRA4PUt22r8EuQqdfV
         BkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Te9tePIeRGvCFLjYI7IVvtZylw1vtXMf4yMzFsMjlJk=;
        b=g4HGeIPTdknyHbo5D8OnQ3LfizDs5yd4+nF/CHQLWHfS0Kb+dBYOHwRKW8YAV4Yt1f
         jIge8XGNzDA0uPZCBeMcPcilV4ECgYL2st9UImxrj0LD9v9ttXKJIJxVZ7NjIj7QxNbM
         lMC+vyhwgyjmPH8/BglliJYEN/V7MO2WV+M90Qq4juyYn7WTQszT37WAFYGXZh9Z7lPE
         fU0kR6beVp5LKFASHh3RoRse/NlJQqVMLU1w3/Mwhs8pN0RQot9YfdBA67GGFS5soZrF
         H8zgibW37oasO3l6gmAX1AVtON+71uGk9ykfwuZVBX+DVdgKRHGgRJCEZMApU+VaZXMS
         uQfQ==
X-Gm-Message-State: APt69E3MhhD5pYMev6W03E82xP96E7Ql20lqSG1hTpv5hn6CEKqybUUw
        6gr7b9ZgFLdsRh1aQ2vDuZiS7R8ODxUcDINduzQ=
X-Google-Smtp-Source: AAOMgpd7QRHL33W+jxym7lga+FZZo+AInfBCKj7eWdB0w/jOSHcZ+so5oaM73vL3ZF4SCJmPu34xyce1ULFq1tLratA=
X-Received: by 2002:a1f:6dc4:: with SMTP id i187-v6mr571904vkc.131.1530694826366;
 Wed, 04 Jul 2018 02:00:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 02:00:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1807040846060.6169@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <1212fde5edcf360231282c9d2487712fc5b4d6f8.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75VfjHy9=4ZMJqb-2H5iXDjMpM=vm5kvz4PVA_jTUkoSJKA@mail.gmail.com> <alpine.DEB.2.20.1807040846060.6169@fox.voss.local>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 12:00:25 +0300
Message-ID: <CAHp75VfZt7jH+FDqWs8BAuEt3oT71RiVmWA04Vk9d_p1uNBDmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] IIO: st_accel_i2c.c: Simplify access to driver data
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 9:56 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>>
>> On Tue, Jul 3, 2018 at 8:41 AM, Nikolaus Voss
>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>
>>> Use device_get_match_data API to simplify access to driver data.
>>
>>
>> ..._data()
>>
>> But. You actually don't use it below.

> It is used, see below.

I meant the API call you mentioned in the commit message is not used
in this version and below you agree to use it eventually.

>>> Let acpi_device_id table entries point to the same driver data as
>>> of_device_id table entries and uniquify access to driver data by using
>>> device_get_match_data API.
>>
>>
>>>  #include <linux/acpi.h>
>>>  #include <linux/i2c.h>
>>>  #include <linux/iio/iio.h>
>>
>>
>>> +#include <linux/of_device.h>
>>
>>
>> (linux/property.h)
>>
>>> +       match = of_device_get_match_data(&client->dev);
>>> +       if (!match)
>>> +               match = acpi_device_get_match_data(&client->dev);
>>
>>
>> What I meant is to simply call
>>
>> match = device_get_match_data(...);
>
>
> Ok, this works, thank you. I will prepare a new patch version.
>
> This is where the match data is used:
>
>>
>>> +       if (match)
>>> +               strlcpy(client->name, match, sizeof(client->name));

> In this driver, match data is used to map DT compatible strings/ ACPI CIDs
> to the key strings (.._ACCEL_DEV_NAME) which are used to identify the actual
> device (and are also used in i2c_device_id table).

-- 
With Best Regards,
Andy Shevchenko
