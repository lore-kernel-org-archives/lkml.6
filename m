Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeDKKJM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:09:12 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34312 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeDKKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:09:11 -0400
X-Google-Smtp-Source: AIpwx4/3X7yyNOPEiE3BWCkQbtV7Ug5CPn+lYMZkQrtAp5kcZF0ObDk6FtofVe+/sMEsF8+H3vgKXSO6vDiZtjQX6QA=
MIME-Version: 1.0
In-Reply-To: <390fac56-8656-ebbb-5405-0a44f1773157@axentia.se>
References: <20180410131206.25760-1-brgl@bgdev.pl> <20180410131206.25760-2-brgl@bgdev.pl>
 <390fac56-8656-ebbb-5405-0a44f1773157@axentia.se>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Apr 2018 12:09:10 +0200
Message-ID: <CAMRc=Me66c+ySsmU9bePG7KFU1sTH0OHTfoxrxC_z6Txbu3tqQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] eeprom: at24: don't assign the i2c ID table to at24_driver
To: Peter Rosin <peda@axentia.se>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Van Asbroeck <svendev@arcx.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-11 11:56 GMT+02:00 Peter Rosin <peda@axentia.se>:
> On 2018-04-10 15:12, Bartosz Golaszewski wrote:
>> We switched to using probe_new(), so this is no longer used
>> by i2c core.
>
> It seems to be used in i2c_device_match() ???
>
> This could easily be me not understanding something...
>

Yes, but i2c core no longer uses the id_table field in struct
i2c_driver. We call i2c_device_match() ourselves instead of letting
i2c core do it and pass the driver data to probe().

Hope that helps,
Bartosz
