Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8ECC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418E920870
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0LgvdGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418E920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeHHL10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:27:26 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39061 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHL1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:27:25 -0400
Received: by mail-ua0-f193.google.com with SMTP id g18-v6so1576615uam.6;
        Wed, 08 Aug 2018 02:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lw91odd7mFo2rSD6rlRDM6tcvhlXtHl+4K5e1E4VRpI=;
        b=u0LgvdGX14tR71glTpT7M5lKxqvo2QhvaIu0h6rns346SyTtjaxJ9336XUizMQG3u1
         n+IY2OY2uAOlS9TF53cyo1+bFwhZblavfwlN8DmD6EPeZqPzpyxLsXH04HKFsMU1Ns1Q
         Sjb9quPFobhvFdLHF8MSK2/l3lJhEr195M85KbhPUk7gzpbYjMWOMdZ/0OXH2wGYVNa0
         rrCMeNZ/SzWLFk/qaw035/CwUiYvT8KrhRzvCVH52nxtLRA6vGsbqFkOPuarzb5ArK+T
         70JKyCdIMcjOfNInleYbrgpqh1UPt3Yed7CWkURvHxw7f5AfnX6Xz1GmJKOtyMhN0XJp
         MfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lw91odd7mFo2rSD6rlRDM6tcvhlXtHl+4K5e1E4VRpI=;
        b=HOL/mu1Ilg64RaFXohF+97ZCJR2QfLXxcA1cpFKEePtUter14GtFAKXhldzpu5IgT/
         cfto/eeGgreW7PVDG4hyKKMhKF0PosYUtnAp4O8+9R8nP/0TOqHkNQ2/nXI1lY+F0HpF
         JItlEu0bC9fu8SkAoLgdkbd/d3IOgKuZyBsISJrOIgp1b0iduPoRLzYzxBJu4mFXhQRH
         IIlcBB9DGvcRYG7gbVRvb054DT7ONlBOxZeK4LMNHxaKaF62Gaq5jXd/YCfzed7hywic
         npVxjQoBiJRPTqu5Rso0DDV92awzO9JQnnpqxlpwlRu/QBk7MhnG0b2eZhz19E8vw7M1
         sbWQ==
X-Gm-Message-State: AOUpUlEul4sUOH+HKD6Z1mKgzFf3m/TJqfSJmLBf0y3/F/NE+eYv9+/3
        sBYrys1LRPPqY0SVMr9uM+qxfhpC4VPVDViECow=
X-Google-Smtp-Source: AA+uWPwa3J2Ra9OR87roolEbtVNkzkPeBQo9iF/DVNI8lqqGiNI5KF8Dyk1Tat/cJ5S0Mrgcnlgk6mVP3dIX/OjLzQk=
X-Received: by 2002:a1f:b503:: with SMTP id e3-v6mr1256290vkf.97.1533719317786;
 Wed, 08 Aug 2018 02:08:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 02:08:36 -0700 (PDT)
In-Reply-To: <20180808083006.31919-5-hdegoede@redhat.com>
References: <20180808083006.31919-1-hdegoede@redhat.com> <20180808083006.31919-5-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 12:08:36 +0300
Message-ID: <CAHp75Vchow81kAaJ-b5Fr2ZjG7huasvM7HOfaKQzso7jaG2xXg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] i2c: Add multi-instantiate pseudo driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 11:30 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
> i2c-device.
>
> But in some rare cases the manufacturer has decided to describe multiple
> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
>
> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
> code to support this corner-case.
>
> This commit introduces a new i2c-multi-instantiate driver which fixes this
> in a different way. This new driver can be built as a module which will
> only loaded on affected systems.
>
> This driver will instantiate a new i2c-client per I2cSerialBus resource,
> using the driver_data from the acpi_device_id it is binding to to tell it
> which chip-type (and optional irq-resource) to use when instantiating.
>
> Note this driver depends on a platform device being instantiated for the
> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().

Thanks for an update! My comments below.

> +struct i2c_inst_data {
> +       const char *type;
> +       int irq_idx;
> +};

> +struct i2c_multi_inst_data {

> +       int no_clients;

Name a bit confusing. What about num_clients?

> +       struct i2c_client *clients[0];
> +};
> +
> +static int i2c_multi_inst_probe(struct platform_device *pdev)
> +{
> +       struct i2c_multi_inst_data *multi;
> +       const struct acpi_device_id *match;
> +       const struct i2c_inst_data *inst_data;
> +       struct i2c_board_info board_info = {};
> +       struct device *dev = &pdev->dev;
> +       struct acpi_device *adev;
> +       char name[32];
> +       int i, ret;
> +
> +       match = acpi_match_device(dev->driver->acpi_match_table, dev);
> +       if (!match) {
> +               dev_err(dev, "Error ACPI match data is missing\n");
> +               return -ENODEV;
> +       }
> +       inst_data = (const struct i2c_inst_data *)match->driver_data;
> +
> +       adev = ACPI_COMPANION(dev);
> +

> +       /* Count number of clients to instantiate */
> +       for (i = 0; inst_data[i].type; i++) {}
> +
> +       multi = devm_kmalloc(dev,
> +                       offsetof(struct i2c_multi_inst_data, clients[i]),
> +                       GFP_KERNEL);
> +       if (!multi)
> +               return -ENOMEM;

Here I see the following:
 - it's kinda unusual use of offsetof(), perhaps i*sizeof() + sizeof()
would be more understandable
 - there is no guard against i == 0

To solve both, it might be like

struct i2c_multi_inst_data {
       int num_clients;
       struct i2c_client *clients;
};

...
multi = devm_kmalloc(sizeof(*multi), GFP_KERNEL);
if (!multi)
 return -ENOMEM;

multi->clients = devm_kcalloc(i, sizeof(*multi->clients), GFP_KERNEL);
if (ZERO_PTR_OR_NULL(multi->clients))
 return -ENOMEM;

But I would like to hear your (other's) opinion(s).

> +
> +       multi->no_clients = i;
> +
> +       for (i = 0; i < multi->no_clients; i++) {
> +               memset(&board_info, 0, sizeof(board_info));
> +               strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
> +               snprintf(name, sizeof(name), "%s-%s", match->id,
> +                        inst_data[i].type);
> +               board_info.dev_name = name;
> +               board_info.irq = 0;

> +               if (inst_data[i].irq_idx != -1) {

>= 0 sounds more robust

> +                       ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
> +                       if (ret < 0) {

> +                               dev_err(dev, "Error requesting irq at index %d: %d\n",
> +                                       inst_data[i].irq_idx, ret);

irq -> IRQ in the message.

> +                               goto error;
> +                       }
> +                       board_info.irq = ret;
> +               }
> +               multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
> +               if (!multi->clients[i]) {
> +                       dev_err(dev, "Error creating i2c-client, idx %d\n", i);
> +                       ret = -ENODEV;
> +                       goto error;
> +               }
> +       }
> +
> +       platform_set_drvdata(pdev, multi);
> +       return 0;
> +
> +error:

> +       while (--i >= 0)

It can be simple

while (i--)

> +               i2c_unregister_device(multi->clients[i]);
> +
> +       return ret;
> +}
> +
> +static int i2c_multi_inst_remove(struct platform_device *pdev)
> +{
> +       struct i2c_multi_inst_data *multi = platform_get_drvdata(pdev);
> +       int i;
> +
> +       for (i = 0; i < multi->no_clients; i++)
> +               i2c_unregister_device(multi->clients[i]);
> +
> +       return 0;
> +}
> +
> +static const struct i2c_inst_data bsg1160_data[]  = {
> +       { "bmc150_accel", 0 },
> +       { "bmc150_magn", -1 },
> +       { "bmg160", -1 },
> +       {}
> +};
> +
> +/*
> + * Note new device-ids must also be added to i2c_multi_instantiate_ids in
> + * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> + */
> +static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
> +       { "BSG1160", (unsigned long)bsg1160_data },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
> +
> +static struct platform_driver i2c_multi_inst_driver = {
> +       .driver = {
> +               .name = "I2C multi instantiate pseudo device driver",

> +               .acpi_match_table = ACPI_PTR(i2c_multi_inst_acpi_ids),

We don't need ACPI_PTR for the driver which depends on ACPI.
In the general case we have an inconsistency with variable definition
(might be unused).

> +       },
> +       .probe = i2c_multi_inst_probe,
> +       .remove = i2c_multi_inst_remove,
> +};
> +module_platform_driver(i2c_multi_inst_driver);
> +
> +MODULE_DESCRIPTION("I2C multi instantiate pseudo device driver");
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
