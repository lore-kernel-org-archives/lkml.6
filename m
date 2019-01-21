Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE6C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD3C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab3i4kQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfAURdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:33:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37530 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfAURdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:33:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so24378649qtt.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wDUxeFaSYvKRKHXXSFYwJW0gh3AaKBcnGdE66u3qBM=;
        b=ab3i4kQbSOE0dkVN/hNQOsvxn7T7HuQ8okyfMuonv48pM6EitOZxWbpinYBQhQKOZD
         08UdZzfpYS8pQN3QlOQvfw7NGV4ptNcRkQk9kDjZN15s+MsdGKd5gn4PMXQr3mM9xves
         GnKJy/gfSpSjCTa83IuSU4BxVqdnXkdgNgD1RH4KxBmI2jchvC9iqRuLZ6R0nr9oYSGk
         Uc0a1MVkxOHXig3eoqBjGBPeEvAedLiiLrxb0zaLcJaOy04/05Jm+MfO7e+RsjHtzjRL
         7uRPqhtu+zgi/kjS38fGfV3DsBs4dLvgVY7D38fMrskcsT6TfYSIwT7V5H7RFimGlkns
         1V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wDUxeFaSYvKRKHXXSFYwJW0gh3AaKBcnGdE66u3qBM=;
        b=olyDVAEFkZ6POv2CXnjssM+q/PLrzaTVx+MG8OyuN0jhOckN94mQwiRGUotxMuE3Yi
         gD0gP1U87If9b9VYzwb6kF5/fEKHncCMb2FNoYgAbBf4HkQLS17QqvOZvncQPx9Vr6ff
         MOddCxlNkaIyNDHTWfKIiTkSCTkHWAV5vbMq/QM62UF6SYWV6WnEwBIcjeeXgqdH+Zw/
         GTJ3H9cUvy0SXErQIiTqkbCMYXFK29AS6GtA2woNJOqIy1RlShufhh9UDCaBO3n8GhkI
         6Xhov6nmwx1V+O2KBPE7OJVfI5exLzQWdk4Mtcxdnad3tscWlCOu2sLzbI+9tM2kEtvt
         NMFw==
X-Gm-Message-State: AJcUukeAOip90m3s9jg56dSNbEtdLAS7bIGEWAi2fvyO5Sp7cmPYBJxs
        Us6UJi/rrSZ0edcNRqUyg+dfz0o2NdqrNUIyi74=
X-Google-Smtp-Source: ALg8bN4e+yJH0OPYF19qFO8dP2ePbG4PYRj4lZM6E2xxuP4ZAxfZZ1lZob3wAsLCKjqzuzcv/kcKO5NQRebnzpCAZD0=
X-Received: by 2002:a0c:a8e3:: with SMTP id h35mr26102099qvc.92.1548091980007;
 Mon, 21 Jan 2019 09:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20190110043653.25901-1-mdf@kernel.org>
In-Reply-To: <20190110043653.25901-1-mdf@kernel.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 21 Jan 2019 18:32:48 +0100
Message-ID: <CAFqH_53Mdh6chEDTkNH_ZGC6scHhXXgp7zdDaSS2Xfd--dfrNQ@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: Add cros_ec_readmem() helpers for
 I2C/SPI based ECs
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, moritz@ettus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz,

Missatge de Moritz Fischer <mdf@kernel.org> del dia dj., 10 de gen.
2019 a les 5:40:
>
> Add cros_ec_readmem() helpers for I2C/SPI based ECs.
> Unlike the LPC based ECs the I2C/SPI based ones cannot just directly
> read the mapped region, but have to resort to EC_CMD_READ_MEMMAP.
>
> This is useful for things like accessing fan speeds or temperatures.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> Hi all,
>
> This can be used for a hwmon or thermal driver such as [1], but also
> alone can be used with 'ectool' via the ioctl() interface.
>

ooi, did you try this with a Chromebook? Or only with your device?

I was a bit worried on the side effects to expose this command to
userspace, so I did a quick test, and to be honest I didn't like the
result. Issuing the ioctl resulted on a reboot on the Chromebook I
tested, which is not good. I didn't investigate more but I can say
that this change, at least, will need some rework. I'll try to
investigate a bit more on what is happening.

Thanks,
 Enric

> Thanks,
> Moritz
>
>
> Changes from v2:
> - Addressed KBuild complaint about max() with size_t vs unsigned int
>   parameters
>
> Changes from v1:
> - Moved to drivers/platform/proto
>
>
> [1] https://patchwork.kernel.org/patch/9670517/ (needs work)
> ---
>  drivers/platform/chrome/cros_ec_i2c.c   |  1 +
>  drivers/platform/chrome/cros_ec_proto.c | 39 +++++++++++++++++++++++++
>  drivers/platform/chrome/cros_ec_spi.c   |  1 +
>  include/linux/mfd/cros_ec.h             | 12 ++++++++
>  4 files changed, 53 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> index ef9b4763356f..c3a9bee37b1d 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -303,6 +303,7 @@ static int cros_ec_i2c_probe(struct i2c_client *client,
>         ec_dev->irq = client->irq;
>         ec_dev->cmd_xfer = cros_ec_cmd_xfer_i2c;
>         ec_dev->pkt_xfer = cros_ec_pkt_xfer_i2c;
> +       ec_dev->cmd_readmem = cros_ec_readmem;
>         ec_dev->phys_name = client->adapter->name;
>         ec_dev->din_size = sizeof(struct ec_host_response_i2c) +
>                            sizeof(struct ec_response_get_protocol_info);
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index cc7baf0ecb3c..d2ba662fc713 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -636,3 +636,42 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
>         return host_event;
>  }
>  EXPORT_SYMBOL(cros_ec_get_host_event);
> +
> +int cros_ec_readmem(struct cros_ec_device *ec, unsigned int offset,
> +                   unsigned int bytes, void *dest)
> +{
> +       struct ec_params_read_memmap *params;
> +       struct cros_ec_command *msg;
> +       int ret;
> +
> +       if (offset >= EC_MEMMAP_SIZE - bytes)
> +               return -EINVAL;
> +
> +       msg = kzalloc(sizeof(*msg) + max_t(size_t, sizeof(*params), bytes),
> +                     GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
> +
> +       msg->version = 0;
> +       msg->command = EC_CMD_READ_MEMMAP;
> +       msg->insize = bytes;
> +       msg->outsize = sizeof(*params);
> +
> +       params = (struct ec_params_read_memmap *)msg->data;
> +       params->offset = offset;
> +       params->size = bytes;
> +
> +       ret = cros_ec_cmd_xfer_status(ec, msg);
> +       if (ret < 0) {
> +               dev_warn(ec->dev, "cannot read mapped reg: %d/%d\n",
> +                        ret, msg->result);
> +               goto out_free;
> +       }
> +
> +       memcpy(dest, msg->data, bytes);
> +
> +out_free:
> +       kfree(msg);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_readmem);
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 2060d1483043..b95c1a25adfc 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -666,6 +666,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
>         ec_dev->irq = spi->irq;
>         ec_dev->cmd_xfer = cros_ec_cmd_xfer_spi;
>         ec_dev->pkt_xfer = cros_ec_pkt_xfer_spi;
> +       ec_dev->cmd_readmem = cros_ec_readmem;
>         ec_dev->phys_name = dev_name(&ec_spi->spi->dev);
>         ec_dev->din_size = EC_MSG_PREAMBLE_COUNT +
>                            sizeof(struct ec_host_response) +
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index de8b588c8776..0228fb42dcda 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -335,6 +335,18 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
>   */
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>
> +/**
> + * cros_ec_readmem - Read mapped memory in the ChromeOS EC
> + *
> + * @ec: Device to read from
> + * @offset: Offset to read within the mapped region
> + * @bytes: number of bytes to read
> + * @data: Return data
> + * @return: 0 if Ok, -ve on error
> + */
> +int cros_ec_readmem(struct cros_ec_device *ec, unsigned int offset,
> +                   unsigned int bytes, void *dest);
> +
>  /* sysfs stuff */
>  extern struct attribute_group cros_ec_attr_group;
>  extern struct attribute_group cros_ec_lightbar_attr_group;
> --
> 2.20.1
>
