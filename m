Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50E0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5AF214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UgoYklyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5AF214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbeKVFjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:39:23 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39022 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeKVFjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:39:22 -0500
Received: by mail-yw1-f68.google.com with SMTP id v8-v6so2677252ywh.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNuqrGT/NMd7rncT4KFQR1s78MJuVfw2Ja01pud3yzI=;
        b=UgoYklyxKkXwWRECLiPNY/uwvuaSuRQDoZ4deZXBLlivntBJcRbApb8MUl+94GU68c
         j38acEnRbaAWSiIS3yE3ofUvsIteaX4XiFzjwNpw8av6HpMBvMfpWFoVUMFTBvXz7lHl
         e48r22/6y3m+KK1rMiKQnCTj7UDmVOhmGXLSGRHhcQZcGFUzrsc+W5SkNZbKRrYFfFvD
         oc2rHZWji753pI4zn+rEB+kg+Fgn4njlzV6ULGD3P7WyPVPG+TQSo9tB5nh/Rfjkm9br
         mjHLecoXzZE6+GocXgEWLQmJcPZ+k11y9qe6xTJ0V8NjOq8Ge0+/pZac1BzAKqL5s06R
         Ei/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNuqrGT/NMd7rncT4KFQR1s78MJuVfw2Ja01pud3yzI=;
        b=QBO6MB5WLoqrBN/b12zkFBlZf43NG3Zt8PeFF79HRVmjs3DOytRfPalkSz/R2JGiPY
         ANVtyohIc2mjfMGe6NM/o7XYGYXL1d5lV2dTfS0s/1+2hPv/JkW7Aq6aSP4gewYhfcnB
         SlrBJq30PfB1p3CNlnY1OJLJdQ3f6Teon1nJ4AQZr5fPAP0b4zDGTm6JiPxuGoVOc8Kg
         05cWaNB/xquCQR2zohEhbsG/RvT25Elsy0j8q64MBaFdue+EzYdmov8Uw53Ft0X2ITB6
         cH+W3r73NrB/j6Dqk3ZCCY6o8tMY4DhYuv9H92UEDjA+gZOq5Z+uCrgf4531oM+hBzHi
         mfNw==
X-Gm-Message-State: AA+aEWYj04m0ugUf98518LdQf60y8+fSUwKC74nMMamfTgo+mpdjqtyB
        z31STNW9ir3YRp91Ti6xo90EwT1deathHAWANQxUvQ==
X-Google-Smtp-Source: AFSGD/XCZPK7Y52V+57pXrP27Si7eZjWlklompPYvAAlnuFnkDBm2gSkaLSxs0uaan4fPm5b21VTDMW5iPgdWWyWnKg=
X-Received: by 2002:a81:af58:: with SMTP id x24mr3490693ywj.362.1542827029720;
 Wed, 21 Nov 2018 11:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20181121153444.24747-1-enric.balletbo@collabora.com> <20181121153444.24747-2-enric.balletbo@collabora.com>
In-Reply-To: <20181121153444.24747-2-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 21 Nov 2018 11:03:38 -0800
Message-ID: <CABXOdTfUR3ohK2so3Jb-nXBjv8rW-DD_E2O1jYEXqLYCcT=dAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: cros: allow to set input voltage and
 current limit.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Sameer Nanda <snanda@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying again, this time (hopefully if gmail lets me) in plaintext
mode. Sorry for the noise.

On Wed, Nov 21, 2018 at 7:34 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> This patch allows reading and writing the input voltage and current
> limit through the POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT and
> POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT sysfs properties. This allows
> userspace to see current values and to re-configure these values at
> runtime based on system-level knowledge or user input.
>
> By default there is no limit, this is reported as a -1 when reading from
> userspace. Writing a value will set the current or voltage limit in uA
> or uV, and writing any negative value will remove that limit.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/power/supply/cros_usbpd-charger.c | 117 ++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index 7e9c3984ef6a..f011ce71b30c 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -53,6 +53,8 @@ struct charger_data {
>  };
>
>  static enum power_supply_property cros_usbpd_charger_props[] = {
> +       POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +       POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>         POWER_SUPPLY_PROP_ONLINE,
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_CURRENT_MAX,
> @@ -80,6 +82,10 @@ static enum power_supply_usb_type cros_usbpd_charger_usb_types[] = {
>         POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID
>  };
>
> +/* Input voltage/current limit in mV/mA. Default to none. */
> +static u16 input_voltage_limit = EC_POWER_LIMIT_NONE;
> +static u16 input_current_limit = EC_POWER_LIMIT_NONE;
> +
>  static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
>  {
>         return port->port_number >= port->charger->num_usbpd_ports;
> @@ -324,6 +330,26 @@ static int cros_usbpd_charger_get_port_status(struct port_data *port,
>         return ret;
>  }
>
> +static int cros_usbpd_charger_set_ext_power_limit(struct charger_data *charger,
> +                                                 u16 current_lim,
> +                                                 u16 voltage_lim)
> +{
> +       struct ec_params_external_power_limit_v1 req;
> +       int ret;
> +
> +       req.current_lim = current_lim;
> +       req.voltage_lim = voltage_lim;
> +
> +       ret = cros_usbpd_charger_ec_command(charger, 0,
> +                                           EC_CMD_EXTERNAL_POWER_LIMIT,
> +                                           &req, sizeof(req), NULL, 0);
> +       if (ret < 0)
> +               dev_err(charger->dev,
> +                       "Unable to set the 'External Power Limit': %d\n", ret);
> +
> +       return ret;
> +}
> +
>  static void cros_usbpd_charger_power_changed(struct power_supply *psy)
>  {
>         struct port_data *port = power_supply_get_drvdata(psy);
> @@ -396,6 +422,18 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_USB_TYPE:
>                 val->intval = port->psy_usb_type;
>                 break;
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               if (input_current_limit == EC_POWER_LIMIT_NONE)
> +                       val->intval = -1;
> +               else
> +                       val->intval = input_current_limit * 1000;
> +               break;
> +       case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +               if (input_voltage_limit == EC_POWER_LIMIT_NONE)
> +                       val->intval = -1;
> +               else
> +                       val->intval = input_voltage_limit * 1000;
> +               break;
>         case POWER_SUPPLY_PROP_MODEL_NAME:
>                 val->strval = port->model_name;
>                 break;
> @@ -409,6 +447,82 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
>         return 0;
>  }
>
> +static int cros_usbpd_charger_set_prop(struct power_supply *psy,
> +                                      enum power_supply_property psp,
> +                                      const union power_supply_propval *val)
> +{
> +       struct port_data *port = power_supply_get_drvdata(psy);
> +       struct charger_data *charger = port->charger;
> +       struct device *dev = charger->dev;
> +       u16 intval;
> +       int ret;
> +
> +       /* U16_MAX in mV/mA is the maximum supported value */
> +       if (val->intval > U16_MAX * 1000)

The accepted upper limit is 0xffff * 1000, so this can result in an
intval of 0xffff after the divide
operation below. At the same time, EC_POWER_LIMIT_NONE is defined as
0xffff. This means
that setting a value of 65535000 will be interpreted as
EC_POWER_LIMIT_NONE and, when
read, will return -1. This is undesirable, but easy to fix by making
the above check ">="
instead of ">".

> +               return -EINVAL;
> +       else if (val->intval < 0)

Unnecessary else

> +               /* A negative number is used to clear the limit */
> +               intval = EC_POWER_LIMIT_NONE;
> +       else
> +               /* Convert from uA/uV to mA/mV */
> +               intval = val->intval / 1000;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +               ret = cros_usbpd_charger_set_ext_power_limit(charger, intval,
> +                                                       input_voltage_limit);
> +               if (ret < 0)
> +                       break;
> +
> +               input_current_limit = intval;
> +               if (input_current_limit == EC_POWER_LIMIT_NONE)
> +                       dev_info(dev,
> +                         "External Current Limit cleared for all ports\n");
> +               else
> +                       dev_info(dev,
> +                         "External Current Limit set to %dmA for all ports\n",
> +                         input_current_limit);
> +               break;
> +       case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +               ret = cros_usbpd_charger_set_ext_power_limit(charger,
> +                                                       input_current_limit,
> +                                                       intval);
> +               if (ret < 0)
> +                       break;
> +
> +               input_voltage_limit = intval;
> +               if (input_voltage_limit == EC_POWER_LIMIT_NONE)
> +                       dev_info(dev,
> +                         "External Voltage Limit cleared for all ports\n");
> +               else
> +                       dev_info(dev,
> +                         "External Voltage Limit set to %dmV for all ports\n",
> +                         input_voltage_limit);
> +               break;
> +       default:
> +               ret = -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int cros_usbpd_charger_property_is_writeable(struct power_supply *psy,
> +                                               enum power_supply_property psp)
> +{
> +       int ret;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +       case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +               ret = 1;
> +               break;
> +       default:
> +               ret = 0;
> +       }
> +
> +       return ret;
> +}
> +
>  static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
>                                        unsigned long queued_during_suspend,
>                                        void *_notify)
> @@ -525,6 +639,9 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
>
>                 psy_desc = &port->psy_desc;
>                 psy_desc->get_property = cros_usbpd_charger_get_prop;
> +               psy_desc->set_property = cros_usbpd_charger_set_prop;
> +               psy_desc->property_is_writeable =
> +                               cros_usbpd_charger_property_is_writeable;
>                 psy_desc->external_power_changed =
>                                         cros_usbpd_charger_power_changed;
>                 psy_cfg.drv_data = port;
> --
> 2.19.1
>
