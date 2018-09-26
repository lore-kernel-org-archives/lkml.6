Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5566FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EE021480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UogGTugC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EE021480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeIZQKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:10:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33351 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:10:31 -0400
Received: by mail-qt1-f193.google.com with SMTP id i10-v6so16547870qtp.0;
        Wed, 26 Sep 2018 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJDlH6lx2quBqOTR2G5084Q8GqD13Br1jToi4PO+4pY=;
        b=UogGTugCjETbGa64lTdRQE+AOJa4TXBnVzdIcRFa3PkYt+mN+wAsM8w2ii1SvS+SwM
         PzI7Q1rk+EkvPValZNv8ZP6O/jUbjF8udh+jL9/mUfCrirWCIW01rKSNCa7JxnlthFQC
         sZX/thTC35zfJYgUPYwH/uc5fHDgtIQWNiYPo3T5LPzX/Ac6OFgmzsM8exmFHmVrHlUH
         bzL4lK4ajPtKNSg9xnX+lEfheeckGxg4gDSCLqwfbKSc0KhGx1E6Bdb9bwwfJAQHtPNg
         PdvBgHydRUNCxzsAggnp+GkUaTmuCC4aUsGphKOGFSXCsN7gMK2sySlLtB8xcmopc+vo
         lDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJDlH6lx2quBqOTR2G5084Q8GqD13Br1jToi4PO+4pY=;
        b=dv2ibMOmmZ5T/VdJGqfuYQ7b7iTlaRg9m86vwqeDwlC6YGk+H3gdIBDVNkPKcxRDiS
         iNv5Co8FIUN2Ey7otZZ9z6gMW6CqKYXke/N1KLv2TNYGYxbWVBYoRGDvUM/9AAl7m15l
         eRlG5SLh+I+L2pTei5GsEdHbpW47FsXPmRvCd0XCKaCVxWkDq2lK/uikgBW7mWXpmLhk
         S0PQ3lFka689hT+4WenwDZyl6sYrKiDHuH5V/Do4Ee9kLXbyUx93DZ+x5Ul8w5xQO0Qv
         eScXW+Llk95Y/oQBiRTeeDMW1YFBoneaY3aVrmvpi7jjmUFW8WfUlJNZDpzMjoSmGckN
         ikgQ==
X-Gm-Message-State: ABuFfogDYrY3h88yxN7b9OfK5qggJJN6mLMZ9K1dG1PaZnjtN1s8x4Cb
        Xdoj8EAQrCZUQ2/0bFiM9EnaoItMlKw4b9e266U=
X-Google-Smtp-Source: ACcGV60dM9IWXKJz5+x3jKMhsctHBbxm4btEmbEdmPdsPeQsXGVN3puMwauQyuolTTGB2RavpyPS86CMZfcbwt48Ups=
X-Received: by 2002:ac8:2f86:: with SMTP id l6-v6mr3779541qta.83.1537955900538;
 Wed, 26 Sep 2018 02:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180831151828.15175-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20180831151828.15175-1-benjamin.tissoires@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 12:58:09 +0300
Message-ID: <CAHp75VdELtEv4LYHXGRVqc+G=Mq0WzQrX1soK2_bApcc19jNWQ@mail.gmail.com>
Subject: Re: [PATCH v3] platform/x86: surface3_power: MSHW0011 rev-eng implementation
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Stephen Just <stephenjust@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 6:18 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> The MSHW0011 device is a chip that replaces the battery firmware
> by using ACPI operation regions on the Surface 3.
> It is unclear whether or not the chip will be reused somewhere else
> (under Windows, the chip is called "Surface Platform Power Driver"
> and the driver is provided by Microsoft).
>
> The values have been obtained by reverse engineering, and are subject to
> errors. Looks like it works on overall pretty well.
>
> I couldn't manage to get the IRQ correctly triggered, so I am using a
> good old polling thread to check for changes. This is something
> to be fixed in a later version.

I have pushed to my review and testing queue for bots playing with it!
But below my review.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=106231
>

Remove this blank line.

> +// SPDX-License-Identifier: GPL-2.0+

> +

No need for this blank line either.

> +/*
> + * Supports for the power IC on the Surface 3 tablet.
> + *
> + * (C) Copyright 2016-2018 Red Hat, Inc
> + * (C) Copyright 2016-2018 Benjamin Tissoires <benjamin.tissoires@gmail.com>
> + * (C) Copyright 2016 Stephen Just <stephenjust@gmail.com>

> + *
...and for this.

> + */

> +#include <asm/unaligned.h>

I'm pretty sure this should go after linux/*.h ones

> +#include <linux/acpi.h>
> +#include <linux/freezer.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/slab.h>
> +#include <linux/uuid.h>


> +       char    model[10];
> +       char    serial[10];
> +       char    type[10];
> +       char    OEM[10];

These 10:s is something worth to define:

#define SURFACE_3_STRLEN 10

or alike.

> +
> +

One blank line is enough

> +#define MSHW0011_EV_2_5                        0x1ff

Is it mask? Value? Some threshold?

> +       static const guid_t mshw0011_guid =
> +               GUID_INIT(0x3F99E367, 0x6220, 0x4955,
> +                         0x8B, 0x0F, 0x06, 0xEF, 0x2A, 0xE7, 0x94, 0x12);

Can you move this outside of the function?

> +       char buf[10];

Same definition as I mentioned above?


> +       /* get serial number */
> +       ret = i2c_smbus_read_i2c_block_data(client, MSHW0011_BAT0_REG_SERIAL_NO,
> +                                           10, buf);

10 -> sizeof() ?

> +       if (ret != 10) {

Ditto.

> +               dev_err(&client->dev, "Error reading serial no: %d\n", ret);
> +               return ret;
> +       }

> +       snprintf(bix->serial, ARRAY_SIZE(bix->serial),
> +                "%*pE%*pE", 3, buf + 7, 6, buf);

It would be one line with format string as "%3pE%6pE" followed by two pointers.

> +       /* get OEM name */
> +       ret = i2c_smbus_read_i2c_block_data(client, MSHW0011_BAT0_REG_OEM,
> +                                           4, buf);
> +       if (ret != 4) {

4 to be defined? Or separate buffer?

> +               dev_err(&client->dev, "Error reading cycle count: %d\n", ret);
> +               return ret;
> +       }
> +       snprintf(bix->OEM, ARRAY_SIZE(bix->OEM), "%*pE", 3, buf);

Depending on the above it might be either "%3pE" or '...sizeof(buf) -
1, buf...'.

> +       status = ret;

> +

No need to have this blank line.

> +       if (status != cdata->charging)
> +               mshw0011_notify(cdata, cdata->notify_mask,
> +                               MSHW0011_NOTIFY_ADP1, &ret);

> +       bat_status = bst.battery_state;

> +

Ditto.

> +       if (bat_status != cdata->bat_charging)
> +               mshw0011_notify(cdata, cdata->notify_mask,
> +                               MSHW0011_NOTIFY_BAT0_BST, &ret);

> +       ret = mshw0011_bix(cdata, &bix);
> +       if (ret < 0)
> +               return ret;

Unlike here, would be nice to add a blank line.

> +       if (bix.last_full_charg_capacity != cdata->full_capacity)
> +               mshw0011_notify(cdata, cdata->notify_mask,
> +                               MSHW0011_NOTIFY_BAT0_BIX, &ret);

> +       if (!value64 || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> +               ret = AE_BAD_PARAMETER;
> +               goto err;
> +       }
> +
> +       sb = &ares->data.i2c_serial_bus;
> +       if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> +               ret = AE_BAD_PARAMETER;
> +               goto err;
> +       }

Side note: It would be a good candidate to use my (not yet upstreamed) helper.

> +       handle = ACPI_HANDLE(&client->dev);

> +

Remove this blank line.

> +       if (!handle)
> +               return -ENODEV;

> +static void mshw0011_remove_space_handler(struct i2c_client *client)
> +{
> +       acpi_handle handle = ACPI_HANDLE(&client->dev);
> +       struct mshw0011_handler_data *data;
> +       acpi_status status;
> +

I would prefer to see handle assignment here followed by immediate check.

> +       if (!handle)
> +               return;

> +       struct i2c_board_info board_info;
> +       struct device *dev = &client->dev;
> +       struct i2c_client *bat0;

> +

Redundant.

> +       struct mshw0011_data *data;
> +       int error, mask;

> +       data->notify_mask = mask == MSHW0011_EV_2_5;

Since it's a mask, append _MASK and use GENMASK() above.

-- 
With Best Regards,
Andy Shevchenko
