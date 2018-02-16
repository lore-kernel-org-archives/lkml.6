Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750884AbeBPVY6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:24:58 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46241 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeBPVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:24:55 -0500
X-Google-Smtp-Source: AH8x227pFtYsSRVz3fU3CjOpqSk2WzBucrN9l8Q7tAioK7aH76Z4FQ9ocmV2IhOMgVBBFN5FsGcg3v8wsgJBbZ6AKhU=
MIME-Version: 1.0
In-Reply-To: <55b1edec-f93d-a25b-1736-d08783576424@caviumnetworks.com>
References: <20180216194415.6103-1-david.daney@cavium.com> <CAHp75VfRDWC1DAhHK-B_2rGLdLGG_FjHmYAmRS5ucspaUoJygA@mail.gmail.com>
 <55b1edec-f93d-a25b-1736-d08783576424@caviumnetworks.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 23:24:53 +0200
Message-ID: <CAHp75Ve=yBCk3MTXUbGKU7L-67MXisLLg0OywL9iXX3jRX8HHA@mail.gmail.com>
Subject: Re: [PATCH v4] rtc: isl12026: Add driver.
To: David Daney <ddaney@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:19 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 02/16/2018 12:13 PM, Andy Shevchenko wrote:
>> On Fri, Feb 16, 2018 at 9:44 PM, David Daney <david.daney@cavium.com>
>> wrote:

>>> +config RTC_DRV_ISL12026
>>> +       tristate "Intersil ISL12026"

>> depends on OF

> It doesn't depend on CONFIG_OF, it builds just fine without it.

OK.
But then it's useless.

depends on OF || COMPILE_TEST

>>> +static struct i2c_driver isl12026_driver = {
>>> +       .driver         = {
>>> +               .name   = "rtc-isl12026",
>>> +               .of_match_table = of_match_ptr(isl12026_dt_match),

>> /of_match_ptr//

> of_match_ptr() needed if we build without CONFIG_OF

OK.
Have you tried to enable warnings?
You must get `defined but not used` one.

-- 
With Best Regards,
Andy Shevchenko
