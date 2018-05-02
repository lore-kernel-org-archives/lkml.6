Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeEBKKg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:10:36 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55297 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeEBKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:10:34 -0400
X-Google-Smtp-Source: AB8JxZqAXE0nwgEJQkmeSrZG6Q8dc4CNZKdVGk+dLdEXA1VIUUHmIdwbBG8MFF4tYBt2xAqpS44OGlU6eii+gH+WuTc=
MIME-Version: 1.0
In-Reply-To: <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com> <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 12:10:32 +0200
Message-ID: <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: zynq: Setup chip->base based on alias ID
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 3:35 PM, Michal Simek <michal.simek@xilinx.com> wrote:

>> The only use case which I can think about is userspace sysfs
>> and then I would really like to know why these userspace
>> users cannot use the character device that is nowadays
>> supported by libgpiod and there is even patches for some
>> IoT libraries to use it. The character device makes the
>> GPIO Linux "base" irrelevant for userspace.
>>
>> GPIO sysfs is deprecated and moved to the obsolete ABI.
>>
>> If there are legacy applications that use this I would have
>> to consider it, but since this has been -1 since the driver
>> was merged I find that unlikely.
>
> Yes, it is about legacy application which I have seen recently and there
> is no source code for application calls it because board vendor doesn't
> provide it.
>
> You are right that -1 was used from the beginning in mainline but
> unfortunately this driver was in vendor tree for a while and it uses 0
> there.
>
> In upstreaming this was changed to -1 but customers have a lot of code
> which developed against vendor tree and they want to use
> latest&greatest. And without this they are not able to run that
> applications.
>
> I found that this logic is already in 5 drivers in mainline that's why I
> send this patch to be +1.

I see.

Sadly comaptibility with out-of-tree driver code is none of our
(community) business.

We do pay a lot of effort not to break the ABI to userspace, but
it needs to be an ABI coming from the mainline kernel, not from
a vendor tree.

So to the mainline kernel this is no regression.

Yours,
Linus Walleij
