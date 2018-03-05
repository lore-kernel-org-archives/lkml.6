Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbeCELAH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:00:07 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36448 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeCELAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:00:04 -0500
X-Google-Smtp-Source: AG47ELtzUNWoWnJV0oeZ2B80k7Kjm4uwMXgf9SvwjJ/Pur/Q0ZhwD3oLU1pI73JJNHeYxubEsMyE99eMKmSbLpAqYIw=
MIME-Version: 1.0
X-Originating-IP: [90.77.100.34]
In-Reply-To: <CABxcv=nQpd-RPPzWbCpdWQjK7VzZyXtWSCTB3JHBA-uLygoC+A@mail.gmail.com>
References: <20171203214050.11482-1-javierm@redhat.com> <CABxcv=nQpd-RPPzWbCpdWQjK7VzZyXtWSCTB3JHBA-uLygoC+A@mail.gmail.com>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Mon, 5 Mar 2018 12:00:03 +0100
Message-ID: <CABxcv=myJZw1zVtbkSW-5xhxeK71YtV3jOvBdGgoB92m67R4bw@mail.gmail.com>
Subject: Re: [PATCH] i2c: core: report OF style module alias for devices
 registered via OF
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello Wolfram,

On Sun, Jan 7, 2018 at 2:17 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>
> On Sun, Dec 3, 2017 at 10:40 PM, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> The buses should honor the firmware interface used to register the device,
>> but the I2C core reports a MODALIAS of the form i2c:<device> even for I2C
>> devices registered via OF.
>>
>> This means that user-space will never get an OF stype uevent MODALIAS even
>> when the drivers modules contain aliases exported from both the I2C and OF
>> device ID tables. For example, an Atmel maXTouch Touchscreen registered by
>> a DT node with compatible "atmel,maxtouch" has the following module alias:
>>
>> $ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
>> i2c:maxtouch
>>
>> So udev won't be able to auto-load a module for an OF-only device driver.
>> Many OF-only drivers duplicate the OF device ID table entries in an I2C ID
>> table only has a workaround for how the I2C core reports the module alias.
>>
>> This patch changes the I2C core to report an OF related MODALIAS uevent if
>> the device was registered via OF. So for the previous example, after this
>> patch, the reported MODALIAS for the Atmel maXTouch will be the following:
>>
>> $ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
>> of:NtrackpadT<NULL>Catmel,maxtouch
>>
>> NOTE: This patch may break out-of-tree drivers that were relying on this
>>       behavior, and only had an I2C device ID table even when the device
>>       was registered via OF. There are no remaining drivers in mainline
>>       that do this, but out-of-tree drivers have to be fixed and define
>>       a proper OF device ID table to have module auto-loading working.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>
> Any comments on this patch?
>

Is this patch under your radar? Should I keep pushing for it or just give up?

Best regards,
Javier
