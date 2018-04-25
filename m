Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756567AbeDYSaA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:30:00 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33087 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756168AbeDYS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:29:51 -0400
X-Google-Smtp-Source: AB8JxZpdeq5pR+0yy1SXbObsFcL582ROouVfhkaHJb7vG9k9oLQvC9RGmOeg0aZ31voUnCZUWQEEwQ==
Subject: Re: Lack of suspend/resume/shutdown ordering between GPIO providers
 and consumers
To: Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        jeffy.chen@rock-chips.com, enric.balletbo@collabora.com,
        josephl@nvidia.com, opendmb@gmail.com, rjw@rjwysocki.net
References: <dc0c15eb-3dab-f512-aed6-045528fcec2c@gmail.com>
 <03711276-d854-7f87-f2e2-c64716b09dbe@ti.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <206bea0c-dbba-1bc3-d13b-dbc41d12c08b@gmail.com>
Date: Wed, 25 Apr 2018 11:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <03711276-d854-7f87-f2e2-c64716b09dbe@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/2018 11:06 AM, Grygorii Strashko wrote:
> 
> 
> On 04/24/2018 05:58 PM, Florian Fainelli wrote:
>> Hi Linus, Rafael, all
>>
>> Our GPIO controller driver: gpio-brcmstb.c has a shutdown callback which
>> gets invoked when the system is brought into poweroff aka S5. So far so
>> good, except that we also wish to use gpio_keys.c as a possible wake-up
>> source, so we may have a number of GPIO pins declared as gpio-keys that
>> allow the system to wake-up from deep slumber.
>>
>> Recently we noticed that we could easily get into a state where
>> gpio-brcmstb.c::brcmstb_gpio_shutdown() gets called first, and then
>> gpio_keys.c::gpio_keys_suspend() gets called later, which is too late to
>> have the enable_irq_wake() call do anything sensible since we have
>> suspend its parent interrupt controller before. This is completely
>> expected unfortunately because these two drivers are both platform
>> device instances with no connection to one another except via Device
>> Tree and the use of the GPIOLIB APIs.
> 
> You can take a look at device_link_add() and Co.

OK, though that requires a struct device references, so while I could
certainly resolve the device_node -> struct device that corresponds to
the GPIO provider , that poses a number of issues:

- not all struct device_node have a corresponding struct device
reference (e.g: clock providers, interrupt controllers, and possibly
other custom drivers), though in this case, they most likely do have one

- resolving a struct device associated with a struct device_node is
often done in a "bus" specific way, e.g: of_find_device_by_node(), so if
the GPIO provider is e.g: i2c_device, pci_device etc. etc. this might
not work that easily

I think this is what Dmitry just indicated in his email as well.

> 
> But it's little bit unclear what exactly you have issue with:
> - shutdown
> - suspend
> 
> above are different (at least as it was before) and gpio-brcmstb.c
>  brcmstb_gpio_shutdown() should not be called as part of suspend !?
> may be you mean brcmstb_gpio_suspend?

The issue exists with shutdown (through the use of "poweroff"), that is
confirmed, but I cannot see how it does not exist with any suspend state
as well, for the same reason that the ordering is not strictly enforced.
--
Florian
