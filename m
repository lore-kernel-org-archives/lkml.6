Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeBIRW0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 12:22:26 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:52000 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeBIRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 12:22:20 -0500
X-Google-Smtp-Source: AH8x227FZkrbISatEelNFL7RSHnl3TrJnxjqg7XELNhfpgh98rl+wka1oGxMFAWmyOINLznWJWhnpDEjk69u2FMIy0M=
MIME-Version: 1.0
X-Originating-IP: [90.77.100.34]
In-Reply-To: <a81cf234-f103-1787-6a4a-fc59bb50cb4d@redhat.com>
References: <CALieaeczi5iZPgKVdHw1B3ouyWcd2U_cqPzEYqvT+8JW4Uwi3A@mail.gmail.com>
 <a81cf234-f103-1787-6a4a-fc59bb50cb4d@redhat.com>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Fri, 9 Feb 2018 18:22:19 +0100
Message-ID: <CABxcv=mT2T-FJqR=WzfW-woN0Q4gusZ6H_83vkkGWc4Km-qQDQ@mail.gmail.com>
Subject: Re: i2c: core: report OF style module alias for devices registered
 via OF
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Dmitry Mastykin <mastichi@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, Jan 16, 2018 at 3:11 PM, Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Hello Dmitry,
>
> On 01/16/2018 02:55 PM, Dmitry Mastykin wrote:
>> On Sun, 3 Dec 2017 22:40:50 +0100, Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
>>
>>> The buses should honor the firmware interface used to register the device,
>>> but the I2C core reports a MODALIAS of the form i2c:<device> even for I2C
>>> devices registered via OF.
>>>
>>> This means that user-space will never get an OF stype uevent MODALIAS even
>>> when the drivers modules contain aliases exported from both the I2C and OF
>>> device ID tables. For example, an Atmel maXTouch Touchscreen registered by
>>> a DT node with compatible "atmel,maxtouch" has the following module alias:
>>>
>>> $ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
>>> i2c:maxtouch
>>>
>>> So udev won't be able to auto-load a module for an OF-only device driver.
>>> Many OF-only drivers duplicate the OF device ID table entries in an I2C ID
>>> table only has a workaround for how the I2C core reports the module alias.
>>>
>>> This patch changes the I2C core to report an OF related MODALIAS uevent if
>>> the device was registered via OF. So for the previous example, after this
>>> patch, the reported MODALIAS for the Atmel maXTouch will be the following:
>>>
>>> $ cat /sys/class/i2c-adapter/i2c-8/8-004b/modalias
>>> of:NtrackpadT<NULL>Catmel,maxtouch
>>>
>>> NOTE: This patch may break out-of-tree drivers that were relying on this
>>>       behavior, and only had an I2C device ID table even when the device
>>>       was registered via OF. There are no remaining drivers in mainline
>>>       that do this, but out-of-tree drivers have to be fixed and define
>>>       a proper OF device ID table to have module auto-loading working.
>>>
>>
>> Hello Javier,
>> thank you for your patch!
>>
>
> Thanks a lot for testing!
>
> Hopefully Wolfram will review/merge this soon, otherwise in the meantime drivers
> are going to add I2C device ID tables just as a workaround or new drivers won't
> include a OF device ID tables since these aren't really required today.
>

Another gentle ping for this.

Best regards,
Javier
