Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013BDC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0C92070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 14:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7USWmup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfADOlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:41:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36448 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfADOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 09:41:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so17603633pgm.3;
        Fri, 04 Jan 2019 06:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YV868BSnqnIpzGIYscB7tjr1nqGgfKm0TkrgdpnBBUI=;
        b=c7USWmup4cr6FSe4RkKzx+dSbWVd9UTpZ7w9satUS77iG5fEIF9YUIafhwfpMaX9jq
         aJyp+lNBvuOW0oAqOx1N/FIyfYg20qsEYzrvif7zZdMqEAABJecA3ZBJdZ6SXi+r/XeZ
         fwPzkYdA8+M5K449pVm2gBKAm/SzJff0/MuIIfPZf9xG5kZwPMAuuU3IwDV+rWsMS7H7
         Cu6Eozk2ktIYvyoxknVQZAO9vlyDPhc0zRlPPRTBsx7ufg03ssSLoB+eQdbNTlGOKJvg
         bPtR1giew9yXkqX581cwihHtVMunuuTJr3LLJdbfn1OIa687sJXi+zhS0S9ftMbrQNpj
         Zrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YV868BSnqnIpzGIYscB7tjr1nqGgfKm0TkrgdpnBBUI=;
        b=dMWDKemjzbT3anVcP4ccvGVrBH1El0uvRKeM2I+PFW0YsS+cLWQ9fgqpAP/oLK80E3
         Sw9Z2fPzydAdcnB0CZ5pobtepI81Kdr8S/ogDWAxu4rHcn+4W7GnZq9HyJn1mfuUAFi+
         xqjy6OcswVdZiYnIlQh5ifzH6KV6zXZgilPQpNfHTC28i93GIpbEjLgAzU8f5Db2oIBo
         u+aoQ4gWKc6PbNKPMR6pGMtfs8GQl36e8yZFBwx94J2RZl8UggXYRDbocnTiboSV5Luf
         MKYB4pNp2z9/AO/o35xecDuqX5An54rx3c4ZBkkof2izde34H/WGADv8nsoquIMmi+vn
         jR/g==
X-Gm-Message-State: AA+aEWYi8ZCgApNT2h9NI6CdaGEAv//Q6NGEYmppJRbLNb1l17wG0ADD
        0HvPUBqe/l4rBE1rDmuwVsjzNk38
X-Google-Smtp-Source: AFSGD/WEVdN+VSxjldZ/THORMqoKH19xFMLLOs/V4hUGPA/z1zn/5MC3m5/OEcHhbsYv4rbFcl3Kyw==
X-Received: by 2002:a62:7086:: with SMTP id l128mr52352453pfc.68.1546612895235;
        Fri, 04 Jan 2019 06:41:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26sm76625679pfh.61.2019.01.04.06.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 06:41:34 -0800 (PST)
Subject: Re: [PATCH 4/4] pmbus (dps650ab): add power supply driver
To:     Xiaoting Liu <xiaoting.liu@hxt-semitech.com>, jdelvare@suse.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, shunyong.yang@hxt-semitech.com,
        dongsheng.wang@hxt-semitech.com
References: <cover.1546591275.git.xiaoting.liu@hxt-semitech.com>
 <e0ad8b6bb620f9fc2f818cbda66825c297f73d67.1546591275.git.xiaoting.liu@hxt-semitech.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0b42721e-2cef-a943-e4da-dd2f2a2a97f2@roeck-us.net>
Date:   Fri, 4 Jan 2019 06:41:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e0ad8b6bb620f9fc2f818cbda66825c297f73d67.1546591275.git.xiaoting.liu@hxt-semitech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 1:05 AM, Xiaoting Liu wrote:
> The Delta dps650ab provides main power and standby power to server.
> dps650ab can be detected by MFR_ID and MFR_MODEL referring to
> manufacturer's feedback. This patch adds driver to moniter power
> supply status.
> 
> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
> ---
>   drivers/hwmon/pmbus/Kconfig    |  10 +++++
>   drivers/hwmon/pmbus/Makefile   |   1 +
>   drivers/hwmon/pmbus/dps650ab.c | 100 +++++++++++++++++++++++++++++++++++++++++
>   drivers/hwmon/pmbus/pmbus.c    |   3 ++
>   4 files changed, 114 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 629cb45f8557..de4638396592 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -184,4 +184,14 @@ config SENSORS_ZL6100
>            This driver can also be built as a module. If so, the module will
>            be called zl6100.
> 
> +config SENSORS_DPS650AB
> +       tristate "Delta DPS650AB"
> +       default n
> +       help
> +         If you say yes here you get hardware monitoring support for the
> +         Delta DPS650AB controller.
> +
> +         This driver can also be built as a module. If so, the module will
> +         be called dps650ab.
> +
>   endif # PMBUS
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index ea0e39518c21..414818230a26 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_SENSORS_TPS53679)        += tps53679.o
>   obj-$(CONFIG_SENSORS_UCD9000)  += ucd9000.o
>   obj-$(CONFIG_SENSORS_UCD9200)  += ucd9200.o
>   obj-$(CONFIG_SENSORS_ZL6100)   += zl6100.o
> +obj-$(CONFIG_SENSORS_DPS650AB) += dps650ab.o
> diff --git a/drivers/hwmon/pmbus/dps650ab.c b/drivers/hwmon/pmbus/dps650ab.c
> new file mode 100644
> index 000000000000..3c300e621f5a
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/dps650ab.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Hardware monitoring driver for DELTA DPS650AB
> + *
> + * Copyright (c) 2018 Huaxintong Semiconductor Technology Co., Ltd.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "pmbus.h"
> +
> +#define DPS650AB_MFR_ID                        "DELTA"
> +#define DPS650AB_MFR_MODEL             "DPS-650AB-16 A"
> +
> +static int dps650ab_probe(struct i2c_client *client,
> +                        const struct i2c_device_id *id)
> +{
> +       struct pmbus_driver_info *info;
> +       u8 buf[I2C_SMBUS_BLOCK_MAX];
> +       int ret;
> +
> +       memset(buf, 0, I2C_SMBUS_BLOCK_MAX);
> +

I don't think this is needed.

> +       if (!i2c_check_functionality(client->adapter,
> +                                    I2C_FUNC_SMBUS_READ_BYTE_DATA
> +                               | I2C_FUNC_SMBUS_READ_WORD_DATA
> +                               | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> +               return -ENODEV;
> +
> +       ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +       if (ret < 0) {
> +               dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
> +               return ret;
> +       }
> +
> +       if (strncmp(buf, DPS650AB_MFR_ID, strlen(DPS650AB_MFR_ID))) {

It might make sense to verify the length of the returned string as well,
unless strings such as "DELTAX" are accepted on purpose. But even if
that is the case I would prefer an added check of "ret < strlen(DPS650AB_MFR_ID)"
over the memset() above....

> +               dev_err(&client->dev, "DPS650AB_MFR_ID unrecognised\n");
> +               return -ENODEV;
> +       }
> +
> +       ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +       if (ret < 0) {
> +               dev_err(&client->dev, "Failed to read PMBUS_MFR_MODEL\n");
> +               return ret;
> +       }
> +
> +       if (strncmp(buf, DPS650AB_MFR_MODEL, strlen(DPS650AB_MFR_MODEL))) {

... to ensure that nothing bad slips through here. As currently written, the code
accepts a MFR_ID of "DELTA50AB-16 A" combined with a MFR_MODEL "DPS-6" as valid.

> +               dev_err(&client->dev, "DPS650AB_MFR_MODEL unrecognised\n");

It would be a nice touch to actually list the unrecognized model. Otherwise
the message is quite useless. Same for MFR_ID.

> +               return -ENODEV;
> +       }
> +
> +       info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       info->pages = 1;
> +       info->format[PSC_VOLTAGE_IN] = linear;
> +       info->format[PSC_VOLTAGE_OUT] = linear;
> +       info->format[PSC_CURRENT_IN] = linear;
> +       info->format[PSC_CURRENT_OUT] = linear;
> +       info->format[PSC_POWER] = linear;
> +       info->format[PSC_TEMPERATURE] = linear;
> +
> +       info->func[0] = PMBUS_HAVE_VIN
> +               | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN
> +               | PMBUS_HAVE_STATUS_INPUT
> +               | PMBUS_HAVE_POUT | PMBUS_HAVE_FAN12
> +               | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> +               | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +               | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> +               | PMBUS_HAVE_STATUS_TEMP;
> +       info->func[1] = info->func[0];
> +
> +       return pmbus_do_probe(client, id, info);
> +}
> +
> +static const struct i2c_device_id dps650ab_id[] = {
> +       {"dps650ab", 1},
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, dps650ab_id);
> +
> +static struct i2c_driver dps650ab_driver = {
> +       .driver = {
> +               .name   = "dps650ab",
> +       },
> +       .probe          = dps650ab_probe,
> +       .remove         = pmbus_do_remove,
> +       .id_table       = dps650ab_id,
> +};
> +
> +module_i2c_driver(dps650ab_driver);
> +
> +MODULE_AUTHOR("Liuxiaoting <xiaoting.liu@hxt-semitech.com");
> +MODULE_DESCRIPTION("PMBus driver for DPS650AB");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
> index aa4cf9636e99..930e8a3e2366 100644
> --- a/drivers/hwmon/pmbus/pmbus.c
> +++ b/drivers/hwmon/pmbus/pmbus.c
> @@ -204,6 +204,8 @@ static int pmbus_probe(struct i2c_client *client,
>   static const struct pmbus_device_info sgd009_pmbus_info = {
>                                  1, PMBUS_SKIP_STATUS_CHECK};
>   static const struct pmbus_device_info pmbus_info = {0, 0};
> +static const struct pmbus_device_info dps650ab_pmbus_info = {
> +                               1, PMBUS_SKIP_STATUS_CHECK};

Something is conceptually wrong here. Either this change or a new driver,
but not both.

>   /*
>    * Use driver_data to set the number of pages supported by the chip.
>    */
> @@ -227,6 +229,7 @@ static int pmbus_probe(struct i2c_client *client,
>          {"tps544c20", (kernel_ulong_t)&default_pmbus_info},
>          {"tps544c25", (kernel_ulong_t)&default_pmbus_info},
>          {"udt020", (kernel_ulong_t)&default_pmbus_info},
> +       {"dps650ab", (kernel_ulong_t)&dps650ab_pmbus_info},

Also, FWIW, this should be kept in alphabetic order.

>          {}
>   };
> 
> --
> 1.8.3.1
> 
> 
> 
> 
> This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.
> 
> 
> 

