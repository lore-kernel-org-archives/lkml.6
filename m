Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeENTty (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:49:54 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:45233 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeENTtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:49:52 -0400
X-Google-Smtp-Source: AB8JxZpfdMEcQioyT7F3s093xDeGCgix8ojwTSk7lUdkXoy9ml8keNxkhBDUGUC/C3GJe15AECJJVNTz09gx0F+CfBk=
MIME-Version: 1.0
In-Reply-To: <86c2bc2f-e622-9447-e4bb-b4ee37e2d44a@ti.com>
References: <20180510174717.26540-1-dmurphy@ti.com> <20180510174717.26540-2-dmurphy@ti.com>
 <41267191-1308-6b9b-78fa-2893a525b49a@gmail.com> <17630aca-1225-df61-7a5d-a921ecd9c78c@ti.com>
 <86c2bc2f-e622-9447-e4bb-b4ee37e2d44a@ti.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 22:49:51 +0300
Message-ID: <CAHp75VcFR4zUOhRjNLN1nMirirVaK-WjYa5Kwa9dL__-bjnLuA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] leds: lm3601x: Introduce the lm3601x LED driver
To: Dan Murphy <dmurphy@ti.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, "Andrew F. Davis" <afd@ti.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:40 PM, Dan Murphy <dmurphy@ti.com> wrote:
> On 05/11/2018 06:56 AM, Dan Murphy wrote:

>>>> +        ret = of_property_read_string(led->strobe_node, "label", &name);

>>>> +        ret = of_property_read_u32(led->strobe_node,

>>>> +        ret = of_property_read_u32(led->strobe_node,

>>> Common LED bindings state that flash-max-microamp and
>>> flash-max-timeout-us properties are mandatory.
>>
>> OK.
>
> OK I looked at the max776973 driver and well if the flash-max-microamp and
> flash-max-timeout-us nodes are missing it sets a default value for each if the
> node is not present.
>
> So should we remove this code from the Max77693 driver too and fail probe as being asked
> in this driver?

I would also add that using device_property_*() API is much better
then using OF specific one. It will help IoT / DIY entusiasts use them
on non-DT platforms.


-- 
With Best Regards,
Andy Shevchenko
