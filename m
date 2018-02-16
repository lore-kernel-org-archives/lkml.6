Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbeBPUNo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:13:44 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:39838 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeBPUNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:13:42 -0500
X-Google-Smtp-Source: AH8x2240BlpCt/J7Ua37q9qTJTTJWlQtjdrEf8L28a+YvK3NvR/7Ja0Obbjq/Amb+58ipLavSHUXjKL5PkG+G1q1JhY=
MIME-Version: 1.0
In-Reply-To: <20180216194415.6103-1-david.daney@cavium.com>
References: <20180216194415.6103-1-david.daney@cavium.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 22:13:40 +0200
Message-ID: <CAHp75VfRDWC1DAhHK-B_2rGLdLGG_FjHmYAmRS5ucspaUoJygA@mail.gmail.com>
Subject: Re: [PATCH v4] rtc: isl12026: Add driver.
To: David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 9:44 PM, David Daney <david.daney@cavium.com> wrote:
> The ISL12026 is a combination RTC and EEPROM device with I2C
> interface.  The standard RTC driver interface is provided.  The EEPROM
> is accessed via the NVMEM interface via the "eeprom0" directory in the
> sysfs entry for the device.

> +config RTC_DRV_ISL12026
> +       tristate "Intersil ISL12026"

depends on OF

> +static struct i2c_driver isl12026_driver = {
> +       .driver         = {
> +               .name   = "rtc-isl12026",
> +               .of_match_table = of_match_ptr(isl12026_dt_match),

/of_match_ptr//

> +       },
> +       .probe_new      = isl12026_probe_new,
> +       .remove         = isl12026_remove,
> +};

-- 
With Best Regards,
Andy Shevchenko
