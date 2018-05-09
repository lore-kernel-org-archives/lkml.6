Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933734AbeEIDuh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 23:50:37 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35392 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933702AbeEIDuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 23:50:35 -0400
X-Google-Smtp-Source: AB8JxZoOCcVs0WSekq3A9Gms1liZSemP6RqLXAQ81EOUCEORSZaea3OekRRD102uxO1wVEUBfCcua4jCeSIz7VJRasQ=
MIME-Version: 1.0
In-Reply-To: <c5770e4a-9445-d4ef-cc1f-a7a84599c4a1@roeck-us.net>
References: <1525772367-20627-1-git-send-email-mine260309@gmail.com>
 <8a801894-4293-d2e8-4673-3d9ff5c2a5bb@roeck-us.net> <CAARXrtmO=wsPK6bfO0E7fvAkqEJUV1kQSYK1gWXkUhmKytq42A@mail.gmail.com>
 <c5770e4a-9445-d4ef-cc1f-a7a84599c4a1@roeck-us.net>
From: Lei YU <mine260309@gmail.com>
Date: Wed, 9 May 2018 11:50:34 +0800
Message-ID: <CAARXrt=ZA7sz_CvNUxHRvie3YfErU-5d5ewHry=mgxb6Uz-+TA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Use 24MHz clock
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 11:43 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>
> I am not going to accept this change, period. This is not one, it is five
> steps
> backward. If "aspeed_set_clock_source(priv->regmap, 0)" changes the clock
> speed,
> or the clock source, read it later, and attach to the correct clock. If that
> doesn't work, fix the problem in the clock subsystem. Hacking the driver is
> just
> plain wrong.
>
> Also, if the idea in DT is to provide a different clock to the watchdog on
> purpose,
> maybe the call to "aspeed_set_clock_source(priv->regmap, 0)" is wrong.

Exactly!
My first change (not sent to mailing list) is to remove the call of
"aspeed_set_clock_source(priv->regmap, 0)", instead, checking the clock
source, and use either 24M or the memory controller clock.
But that make things a bit more complicated and Aspeed suggests to use 24M
clock. So I sent this simplified change.

It's OK to not accept this change, the fix in DT will fix the issue as well.
Please drop this.
Thanks!
