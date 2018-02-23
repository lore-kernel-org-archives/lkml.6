Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeBWLlp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:41:45 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40080 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBWLlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:41:44 -0500
X-Google-Smtp-Source: AG47ELuPOEePhiDdFgQhQMFg64M9FJ8rahfX+tuKVxYT072PxFZft/eLNqChnS+H0KrnfE1pUTtPKdXLsghNNEq9FiY=
MIME-Version: 1.0
In-Reply-To: <91e55d2b-abd0-35b4-cc18-98a96288f8de@lechnology.com>
References: <20180219165837.28913-1-brgl@bgdev.pl> <72cd2af4-ed6b-8c1b-2488-b999976b894a@lechnology.com>
 <1519123185.3470.5.camel@pengutronix.de> <8ef4b901-f38d-d885-e7bc-657202a2e248@lechnology.com>
 <1519299294.7447.4.camel@pengutronix.de> <91e55d2b-abd0-35b4-cc18-98a96288f8de@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Feb 2018 12:41:43 +0100
Message-ID: <CAMRc=MfAvuQHf52Exs4MxG=sKJibTd8dZEbBED4_HAOah2c3kw@mail.gmail.com>
Subject: Re: [PATCH v4] reset: add support for non-DT systems
To: David Lechner <david@lechnology.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-22 17:44 GMT+01:00 David Lechner <david@lechnology.com>:
> On 02/22/2018 05:34 AM, Philipp Zabel wrote:
>>
>> On Tue, 2018-02-20 at 10:40 -0600, David Lechner wrote:
>> [...]
>>>>
>>>> In your case the platform code that adds the lookup may be identical to
>>>> the code that registers the struct reset_controller_dev, but that
>>>> doesn't have to be the case. I'm not sure how that is supposed to work
>>>> for the phy framework (I see no platform code adding phy lookups, only
>>>> drivers).
>>>>
>>> In our use case, we would be adding the lookup in the driver rather than
>>> in the platform code, which is why I am suggesting doing it like the phy
>>> framework.
>>
>>
>> Shouldn't it be the job of the platform code to describe the connections
>> between reset controller and peripheral module reset
>> inputs?
>
>
>
> I guess that depends on who you ask. There are many clock driver that
> register clkdev lookups in drivers/clk/, so that is what we have done
> with the clock driver we are working on. The clock device is also the
> reset controller, so it makes sense to me to register the reset lookup
> in the same place that we are registering the clkdev lookup.
>
> We have a platform_device_id for each possible configuration, so that
> it works very much like the device tree compatible string. You register
> a platform device in the board file with the proper name and the driver
> takes care of the reset because it knows which connections there are
> based on the device name.

I sent another attempt. Since the in-progress psc driver has all the
clocks in the driver code, it makes sense to do the same for resets.

Bart
