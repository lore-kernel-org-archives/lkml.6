Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967460AbeBNLcc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:32:32 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36323 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967342AbeBNLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:32:29 -0500
X-Google-Smtp-Source: AH8x225l4ppvY0I7pIDb4YL9r67HGMKlKTscafqTY+4B4X9XtT0UItk1Pg5Teoi9WC+Hc7J9k8xEZ5K5RkUxxSOl5WM=
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mdxaa43_znQg3Pd8gdBC-kPuxFnxf3CiQ=k7nPT4EVraQ@mail.gmail.com>
References: <20180213183946.1662-1-brgl@bgdev.pl> <CAHp75VeqaOwaAriXw3Ppvi6dtcK+yyTJUUpmj6gaxY8PLtzwpA@mail.gmail.com>
 <CAMRc=Mdxaa43_znQg3Pd8gdBC-kPuxFnxf3CiQ=k7nPT4EVraQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2018 13:32:26 +0200
Message-ID: <CAHp75Vcxwke9Uw5+7wVz9vuMT9xDASCekMQqa4mdsznjSvpEoQ@mail.gmail.com>
Subject: Re: [PATCH v2] reset: add support for non-DT systems
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 10:59 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 2018-02-13 20:17 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> On Tue, Feb 13, 2018 at 8:39 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:

>>> +               for (index = 0; lookup->dev; index++, lookup++) {
>>> +                       if (strcmp(dev_id, lookup->dev))
>>> +                               continue;
>>> +
>>> +                       if ((!id && !lookup->id) ||
>>> +                           (id && lookup->id && !strcmp(id, lookup->id))) {
>>> +                               rstc = __reset_control_get_internal(rcdev,
>>> +                                                               index, shared);
>>> +                               break;
>>> +                       }
>>
>> Wouldn't be slightly more readable
>>
>>       if (id && lookup->id) {
>>         if (strcmp(id, lookup->id))
>>           continue;
>>       } else if (id || lookup->id) {
>>         continue;
>>       }
>>
>>       rstc = __reset_control_get_internal(rcdev, index, shared);
>>       break;
>>
>
> You'd get less indentations, yes but I wanted to emphasize the
> condition on which we want to stop in this line.

It doesn't matter (indentation) here, esp. taking into consideration
that you already have another condition by which you continue the
loop.
My proposal adds consistency and from my point of view makes easier to parse.

You check all false conditions in a row, end up with a true one.

>>> +       if (!rstc)
>>> +               return optional ? NULL : ERR_PTR(-ENOENT);
>>
>> Isn't simpler
>>
>> if (!optional && !rstc) // or other way around, depending which might
>> be more offten
>>  return ERR_PTR(...);
>>
>
> IMO it's just a matter of taste.

I think in my proposal it's more straight forward. Easier to parse by reader.

-- 
With Best Regards,
Andy Shevchenko
