Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbeDKLOv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:14:51 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40418 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbeDKLOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:14:47 -0400
X-Google-Smtp-Source: AIpwx49hY5w+S//SuQc3B6GKeyyAUzdyn/XHgxcOuAFYjBCXdkHf/ATV1fgN/XWL/bQbBCeVcfXWUI/JMfDlDstE5f4=
MIME-Version: 1.0
In-Reply-To: <47dab3e5-1232-dbaf-2dc0-d71d83ef8d38@axentia.se>
References: <20180410131206.25760-1-brgl@bgdev.pl> <20180410131206.25760-2-brgl@bgdev.pl>
 <390fac56-8656-ebbb-5405-0a44f1773157@axentia.se> <CAMRc=Me66c+ySsmU9bePG7KFU1sTH0OHTfoxrxC_z6Txbu3tqQ@mail.gmail.com>
 <47dab3e5-1232-dbaf-2dc0-d71d83ef8d38@axentia.se>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Apr 2018 13:14:46 +0200
Message-ID: <CAMRc=MdNppn0370xAYG76zCjnXPzma0CoVTXR_Vv+uc9EbM_EA@mail.gmail.com>
Subject: Re: [PATCH 1/4] eeprom: at24: don't assign the i2c ID table to at24_driver
To: Peter Rosin <peda@axentia.se>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Van Asbroeck <svendev@arcx.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-11 12:12 GMT+02:00 Peter Rosin <peda@axentia.se>:
> On 2018-04-11 12:09, Bartosz Golaszewski wrote:
>> 2018-04-11 11:56 GMT+02:00 Peter Rosin <peda@axentia.se>:
>>> On 2018-04-10 15:12, Bartosz Golaszewski wrote:
>>>> We switched to using probe_new(), so this is no longer used
>>>> by i2c core.
>>>
>>> It seems to be used in i2c_device_match() ???
>>>
>>> This could easily be me not understanding something...
>>>
>>
>> Yes, but i2c core no longer uses the id_table field in struct
>> i2c_driver. We call i2c_device_match() ourselves instead of letting
>> i2c core do it and pass the driver data to probe().
>>
>> Hope that helps,
>> Bartosz
>>
>
> But, i2c_device_match is a static function in the core. I think you
> are confusing it with i2c_match_id, which is in fact called from
> the static i2c_device_match (with is a bus operation).
>

Right. So probe_new() in i2c no longer has the id parameter and the
users are supposed to call i2c_match_id() themselves but
i2c_device_match() still expects the id_table to be present in struct
i2c_driver. I should have tested it with some board that uses platform
data.

Consider this patch dropped.

Thanks for spotting that,
Bartosz
