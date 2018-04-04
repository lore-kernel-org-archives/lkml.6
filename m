Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeDDQ5r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:57:47 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35500 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeDDQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:57:44 -0400
X-Google-Smtp-Source: AIpwx49x+EyHNx6f6hEA1f2qaYL8h4NB4T8y6d+qbJ4qbXMLg8mMh55tPJ3T1XK5c/6nRft6Bk+h8fXA1dE/eGCvzvM=
MIME-Version: 1.0
In-Reply-To: <20180402163242.GC14165@lunn.ch>
References: <1522250043-8065-5-git-send-email-tharvey@gateworks.com>
 <20180330010757.GA12896@roeck-us.net> <CAJ+vNU3ARKLK5AcssEP-_P8AmwnAnS8VtAEO1ppwum2jpCqAYQ@mail.gmail.com>
 <20180330181954.GA17580@roeck-us.net> <CAJ+vNU1f+SH16hs3heMA_A2KcbzbXXmJtPxi0uiL4+4tNWgYoQ@mail.gmail.com>
 <20180402163242.GC14165@lunn.ch>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 4 Apr 2018 09:57:42 -0700
Message-ID: <CAJ+vNU2RxHngXa00=zx84ifJ6wWh=vN84shRsT5sWYG1G74zeA@mail.gmail.com>
Subject: Re: [v3,4/4] watchdog: add Gateworks System Controller support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>, Mark Brown <broonie@kernel.org>,
        linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 9:32 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> The 'use case' we have been using this in for a couple years is that
>> users who want to use this watchdog will enable it externally (we have
>> a command in the bootloader) and if enabled the kernel driver (that
>> I'm proposing here which we've been using out-of-tree) will register
>> the watchdog device and the userspace watchdog process can open the
>> device and start tickling it. If the watchdog is never enabled (or
>> disabled via the bootloader command) the kernel driver fails to probe
>> and the SoC's watchdog can be used.
>
> Hi Tim
>
> Is there any reason not to give the user the choice to use both
> watchdogs? Normally you write drivers to expose the hardware, and then
> let the users choice if they want to use it.
>

Andrew,

I don't know what value the SoC watchdog has if you have the GSC
watchdog available that can power cycle the board but I would agree
normally you would expose all of them. I suppose this may be a
different case because I'm expecting the user to go and manually
enable the watchdog instead of using the kernel to do it which means
if its not enabled its not really available to be used.

Tim
