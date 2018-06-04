Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeFDJkk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:40:40 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45465 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeFDJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:40:39 -0400
X-Google-Smtp-Source: ADUXVKIczm5ElEghAL7pn6r8v9AsFWdKfRcchgt0jqih85sa6kW1GhyG2zAv5wMg8poO/1ZJvS4oTamdahYQoDj9Hi8=
MIME-Version: 1.0
In-Reply-To: <20180604054452.GD17993@dell>
References: <20180511135030.14590-1-ckeepax@opensource.cirrus.com> <20180604054452.GD17993@dell>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Jun 2018 12:40:37 +0300
Message-ID: <CAHp75Vdcg2GQ4G-YF054iCob+f4=ZmfT_XLknMZm72nOB7D_mw@mail.gmail.com>
Subject: Re: [PATCH] mfd: arizona: Don't use regmap_read_poll_timeout
To: Lee Jones <lee.jones@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 8:44 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 11 May 2018, Charles Keepax wrote:

>> +     while (true) {
>> +             ret = regmap_read(arizona->regmap, reg, &val);
>>
>> +             if ((val & mask) == target)
>> +                     return 0;
>> +
>> +             if (ktime_compare(ktime_get(), timeout) > 0)
>> +                     break;
>> +
>> +             usleep_range(ARIZONA_REG_POLL_DELAY_US / 2,
>> +                          ARIZONA_REG_POLL_DELAY_US);
>> +     }

>From my point of view infinite loops not good for readability and maintenance.
Perhaps

do {
...
} while (ktime_compare(...));

?

-- 
With Best Regards,
Andy Shevchenko
