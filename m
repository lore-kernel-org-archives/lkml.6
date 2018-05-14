Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753701AbeENRSy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:18:54 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45867 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeENRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:18:42 -0400
X-Google-Smtp-Source: AB8JxZobnW5O/T3b4CgEAoYIXV372/1ASNzt46B/NjlpZ4JuXkSSqJAhqi0sPontL718PCZR8Oxh+mo8xYANB+NSMtc=
MIME-Version: 1.0
In-Reply-To: <20180514093326.30314-1-anders.roxell@linaro.org>
References: <20180510152719.6e37b10e@endymion> <20180514093326.30314-1-anders.roxell@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 20:18:37 +0300
Message-ID: <CAHp75VdJEzDsvJmv812wvc5p=frqc3KU8HW=y4cGULYEp4=SKQ@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: i801: fix unused-function warning
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Jean Delvare <jdelvare@suse.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EHJ2nb016224

On Mon, May 14, 2018 at 12:33 PM, Anders Roxell
<anders.roxell@linaro.org> wrote:
> With CONFIG_PM, we get a harmless build warning:
> drivers/i2c/busses/i2c-i801.c:1723:12: warning: ‘i801_resume’ defined but not used [-Wunused-function]
>  static int i801_resume(struct device *dev)
>             ^~~~~~~~~~~
> drivers/i2c/busses/i2c-i801.c:1714:12: warning: ‘i801_suspend’ defined but not used [-Wunused-function]
>  static int i801_suspend(struct device *dev)
>             ^~~~~~~~~~~~

> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int i801_suspend(struct device *dev)

The better pattern is to get rid of ugly ifdef and supply
__maybe_unused annotation to each function in question.


-- 
With Best Regards,
Andy Shevchenko
