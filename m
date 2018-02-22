Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeBVUpP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:45:15 -0500
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35490 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBVUpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:45:12 -0500
X-Google-Smtp-Source: AH8x224n5pNh/9aUWC/banUsk8Dt8HTmUjatbMxEZ5wE7uZ+38VV1Qy32UQfFxSU2JHdHp5hGFmybA==
Date: Thu, 22 Feb 2018 15:45:09 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] pc104: Add EXPERT dependency for PC104 Kconfig
 option
Message-ID: <20180222204509.GB10834@sophia>
References: <cover.1514578085.git.vilhelm.gray@gmail.com>
 <5c573c758e07ee9539045c1b062b9bab1ad1669c.1514578085.git.vilhelm.gray@gmail.com>
 <CACRpkdbRkyzb9aML1-TEENWfpSDtjayVB_eEm9V1JKrAfaOMVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdbRkyzb9aML1-TEENWfpSDtjayVB_eEm9V1JKrAfaOMVA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 04:20:46PM +0100, Linus Walleij wrote:
>On Fri, Dec 29, 2017 at 9:14 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> PC/104 device driver Kconfig options previously had an implicit EXPERT
>> dependency by way of an explicit ISA_BUS_API dependency. Now that these
>> driver Kconfig options select ISA_BUS_API rather than depend on it, the
>> PC104 Kconfig option should have an explicit EXPERT dependency.
>>
>> The PC/104 form factor and bus architecture are common in embedded
>> and specialized systems, but uncommon in typical desktop setups. For
>> this reason, it is best to mask these devices and configurations via the
>> EXPERT Kconfig option because the majority of users will never need to
>> concern themselves with PC/104.
>>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>
>Patch applied to the GPIO tree for v4.17.
>
>I don't know what kind of definition of "expert" really applies here.
>
>Who in their right mind think that novices are using the kernel
>configuration interface. Isn't anyone doing kernel compiles
>entitled to be called an expert...
>
>Anyways I guess this has already been discussed.
>
>Yours,
>Linus Walleij

I'm inclined to agree with you on this point. I believe there is benefit
in masking uncommon hardware configurations such as PC/104 in order to
reduce clutter in the menus, but you are right that "expert" sounds
somewhat of a misnomer for this use case. I considered adding yet
another Kconfig option to mask these options, but since Kconfig code
isn't my forte, I ultimately decided to keep it simple and depend simply
on EXPERT.

The PC104 Kconfig option has been implicitly masked by EXPERT up to this
point, so I thought it best to keep it masked as it has been thus far.
However, since all this masking is essentially just an aesthetic matter,
I'm somewhat indifferent and open to removing the EXPERT dependency
as well; I'll let someone else make that call rather I.

William Breathitt Gray
