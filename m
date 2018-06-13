Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85A93C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7D3208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jNDTyoZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7D3208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935332AbeFMK5e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:57:34 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35901 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935158AbeFMK5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:57:31 -0400
Received: by mail-it0-f65.google.com with SMTP id j135-v6so3242480itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IdPnS5WvLbmHSA3yZOak475oyfA+O2tCUVkeTr9h78s=;
        b=jNDTyoZZitmHHzs7pQnVpaAhsyGSK/i891Si9/Na+JxlK6IYayIvBLBn5EIcf04PjM
         QyZC61wvo96HaSk3Ese1/7wfqgzk1IvT3M5+5m9ylnUullVWvYLGrBE69I+tbq3jRKPl
         vwozz6WA4w6kgaomHW19dpvCC2Qoloak9pCKez58ccG3i/zCpW1CCOclkJjWvYa9ynrG
         vP1f1Rr9Ux9OjNPTpNc7l5377tTYBAlXw6fxL+hmX7vYs/RlGyzps7iDtfSC+DZr4RVN
         RYjkb6PqLV9PJWT1I4x84kyr5CBWfzoJ2pt3Akb3h+oy+NGbpQgNszOzVcihTEV/UfZi
         Ll+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IdPnS5WvLbmHSA3yZOak475oyfA+O2tCUVkeTr9h78s=;
        b=cvcIX2tuUTc76tm0/e681qDO4987ubrWwWxeUGpxvTIreF2d5YzVQ94k16P6O0TCZ7
         HsfdlkXkrPC6dLlchNOtqI6rIFqzSnVkQUqJ8ujRpVK375YT3iTCTOUF6QvKoujy1SVz
         maj+wAFTZZ2fQScIIB6PBMwQAVOnnuyXsHMW313SgqKIP6iLFf7Ssly0ETuez7FePPn+
         2B3bgIS+sTYf9QvLMnLOhvmCyKe2+Nwy1ciptEj6vGSaPjVPVTyP0SqnRw/WrVLmFilE
         +HrrDL8F2BQemyulgDCUl0IL9JXdEjfN+LPqMY/ufV4o9xyAeZ5OW4TtRcZ2PCOHg7ZZ
         lfBQ==
X-Gm-Message-State: APt69E3dA8v9sbtx0xGy3ggBeNMlRP6hP0MPN2AYOL6Av1nNMWwBOLUQ
        ERABpTmQpmVAMB56ucwpStnuekgMv3+EMLdRO9LX1Q==
X-Google-Smtp-Source: ADUXVKIipjZPJDkHCo6zZeVyvhmSklgQn8dtHzskdpMlaJAvyxUBCccdTE86bamXOnELMpAhUWW9S9sfBYT6A0fg4Ik=
X-Received: by 2002:a24:609:: with SMTP id 9-v6mr3949593itv.94.1528887450549;
 Wed, 13 Jun 2018 03:57:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2242:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 03:57:29
 -0700 (PDT)
In-Reply-To: <20180530031704.18597-3-fparent@baylibre.com>
References: <20180530031704.18597-1-fparent@baylibre.com> <20180530031704.18597-3-fparent@baylibre.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Wed, 13 Jun 2018 12:57:29 +0200
Message-ID: <CAOwMV_yN6DeKZdsRCVbnX4Th0cYmdmKNxV76LamZQQuqOAY3rw@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: supply: cros: add support for dedicated port
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Guillaume Pain <gpain@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Making sure this patch and the next one [1] are not being forgotten.

[1] https://patchwork.kernel.org/patch/10437565/

On Wed, May 30, 2018 at 5:17 AM, Fabien Parent <fparent@baylibre.com> wrote:
> ChromeOS devices can have one optional dedicated port.
> The Dedicated port is unique and similar to the USB PD ports
> except that it doesn't support as many properties.
>
> The presence of a dedicated port is determined from whether the
> EC's charger port count is equal to 'number of USB PD port' + 1.
> The dedicated port ID is always the last valid port ID.
>
> This commit keeps compatibility with Embedded Controllers that do not
> support the new EC_CMD_CHARGE_PORT_COUNT command by setting
> the number of charger port to be equal to the number of USB PD port
> when this command fails.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/power/supply/cros_usbpd-charger.c | 115 +++++++++++++++++++---
>  1 file changed, 101 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index 3a0c96fd1bc1..808688a6586c 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -12,8 +12,12 @@
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
>
> -#define CHARGER_DIR_NAME                       "CROS_USBPD_CHARGER%d"
> -#define CHARGER_DIR_NAME_LENGTH                        sizeof(CHARGER_DIR_NAME)
> +#define CHARGER_USBPD_DIR_NAME                 "CROS_USBPD_CHARGER%d"
> +#define CHARGER_DEDICATED_DIR_NAME             "CROS_DEDICATED_CHARGER"
> +#define CHARGER_DIR_NAME_LENGTH                (sizeof(CHARGER_USBPD_DIR_NAME) >= \
> +                                        sizeof(CHARGER_DEDICATED_DIR_NAME) ? \
> +                                        sizeof(CHARGER_USBPD_DIR_NAME) : \
> +                                        sizeof(CHARGER_DEDICATED_DIR_NAME))
>  #define CHARGER_CACHE_UPDATE_DELAY             msecs_to_jiffies(500)
>  #define CHARGER_MANUFACTURER_MODEL_LENGTH      32
>
> @@ -42,6 +46,7 @@ struct charger_data {
>         struct cros_ec_dev *ec_dev;
>         struct cros_ec_device *ec_device;
>         int num_charger_ports;
> +       int num_usbpd_ports;
>         int num_registered_psy;
>         struct port_data *ports[EC_USB_PD_MAX_PORTS];
>         struct notifier_block notifier;
> @@ -58,6 +63,12 @@ static enum power_supply_property cros_usbpd_charger_props[] = {
>         POWER_SUPPLY_PROP_USB_TYPE
>  };
>
> +static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
> +       POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_STATUS,
> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
>  static enum power_supply_usb_type cros_usbpd_charger_usb_types[] = {
>         POWER_SUPPLY_USB_TYPE_UNKNOWN,
>         POWER_SUPPLY_USB_TYPE_SDP,
> @@ -69,6 +80,11 @@ static enum power_supply_usb_type cros_usbpd_charger_usb_types[] = {
>         POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID
>  };
>
> +static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
> +{
> +       return port->port_number >= port->charger->num_usbpd_ports;
> +}
> +
>  static int cros_usbpd_charger_ec_command(struct charger_data *charger,
>                                          unsigned int version,
>                                          unsigned int command,
> @@ -102,6 +118,23 @@ static int cros_usbpd_charger_ec_command(struct charger_data *charger,
>  }
>
>  static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
> +{
> +       struct ec_response_charge_port_count resp;
> +       int ret;
> +
> +       ret = cros_usbpd_charger_ec_command(charger, 0,
> +                                           EC_CMD_CHARGE_PORT_COUNT,
> +                                           NULL, 0, &resp, sizeof(resp));
> +       if (ret < 0) {
> +               dev_err(charger->dev,
> +                       "Unable to get the number of ports (err:0x%x)\n", ret);
> +               return ret;
> +       }
> +
> +       return resp.port_count;
> +}
> +
> +static int cros_usbpd_charger_get_usbpd_num_ports(struct charger_data *charger)
>  {
>         struct ec_response_usb_pd_ports resp;
>         int ret;
> @@ -246,7 +279,10 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
>                 port->psy_usb_type = POWER_SUPPLY_USB_TYPE_SDP;
>         }
>
> -       port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
> +       if (cros_usbpd_charger_port_is_dedicated(port))
> +               port->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
> +       else
> +               port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
>
>         dev_dbg(dev,
>                 "Port %d: type=%d vmax=%d vnow=%d cmax=%d clim=%d pmax=%d\n",
> @@ -281,7 +317,8 @@ static int cros_usbpd_charger_get_port_status(struct port_data *port,
>         if (ret < 0)
>                 return ret;
>
> -       ret = cros_usbpd_charger_get_discovery_info(port);
> +       if (!cros_usbpd_charger_port_is_dedicated(port))
> +               ret = cros_usbpd_charger_get_discovery_info(port);
>         port->last_update = jiffies;
>
>         return ret;
> @@ -425,17 +462,56 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
>
>         platform_set_drvdata(pd, charger);
>
> +       /*
> +        * We need to know the number of USB PD ports in order to know whether
> +        * there is a dedicated port. The dedicated port will always be
> +        * after the USB PD ports, and there should be only one.
> +        */
> +       charger->num_usbpd_ports =
> +               cros_usbpd_charger_get_usbpd_num_ports(charger);
> +       if (charger->num_usbpd_ports <= 0) {
> +               /*
> +                * This can happen on a system that doesn't support USB PD.
> +                * Log a message, but no need to warn.
> +                */
> +               dev_info(dev, "No USB PD charging ports found\n");
> +       }
> +
>         charger->num_charger_ports = cros_usbpd_charger_get_num_ports(charger);
> -       if (charger->num_charger_ports <= 0) {
> +       if (charger->num_charger_ports < 0) {
>                 /*
>                  * This can happen on a system that doesn't support USB PD.
>                  * Log a message, but no need to warn.
> +                * Older ECs do not support the above command, in that case
> +                * let's set up the number of charger ports equal to the number
> +                * of USB PD ports
> +                */
> +               dev_info(dev, "Could not get charger port count\n");
> +               charger->num_charger_ports = charger->num_usbpd_ports;
> +       }
> +
> +       if (charger->num_charger_ports <= 0) {
> +               /*
> +                * This can happen on a system that doesn't support USB PD and
> +                * doesn't have a dedicated port.
> +                * Log a message, but no need to warn.
>                  */
>                 dev_info(dev, "No charging ports found\n");
>                 ret = -ENODEV;
>                 goto fail_nowarn;
>         }
>
> +       /*
> +        * Sanity checks on the number of ports:
> +        *  there should be at most 1 dedicated port
> +        */
> +       if (charger->num_charger_ports < charger->num_usbpd_ports ||
> +           charger->num_charger_ports > (charger->num_usbpd_ports + 1)) {
> +               dev_err(dev, "Unexpected number of charge port count\n");
> +               ret = -EPROTO;
> +               goto fail_nowarn;
> +       }
> +
>         for (i = 0; i < charger->num_charger_ports; i++) {
>                 struct power_supply_config psy_cfg = {};
>
> @@ -447,22 +523,33 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
>
>                 port->charger = charger;
>                 port->port_number = i;
> -               sprintf(port->name, CHARGER_DIR_NAME, i);
>
>                 psy_desc = &port->psy_desc;
> -               psy_desc->name = port->name;
> -               psy_desc->type = POWER_SUPPLY_TYPE_USB;
>                 psy_desc->get_property = cros_usbpd_charger_get_prop;
>                 psy_desc->external_power_changed =
>                                         cros_usbpd_charger_power_changed;
> -               psy_desc->properties = cros_usbpd_charger_props;
> -               psy_desc->num_properties =
> -                                       ARRAY_SIZE(cros_usbpd_charger_props);
> -               psy_desc->usb_types = cros_usbpd_charger_usb_types;
> -               psy_desc->num_usb_types =
> -                               ARRAY_SIZE(cros_usbpd_charger_usb_types);
>                 psy_cfg.drv_data = port;
>
> +               if (cros_usbpd_charger_port_is_dedicated(port)) {
> +                       sprintf(port->name, CHARGER_DEDICATED_DIR_NAME);
> +                       psy_desc->type = POWER_SUPPLY_TYPE_MAINS;
> +                       psy_desc->properties =
> +                               cros_usbpd_dedicated_charger_props;
> +                       psy_desc->num_properties =
> +                               ARRAY_SIZE(cros_usbpd_dedicated_charger_props);
> +               } else {
> +                       sprintf(port->name, CHARGER_USBPD_DIR_NAME, i);
> +                       psy_desc->type = POWER_SUPPLY_TYPE_USB;
> +                       psy_desc->properties = cros_usbpd_charger_props;
> +                       psy_desc->num_properties =
> +                               ARRAY_SIZE(cros_usbpd_charger_props);
> +                       psy_desc->usb_types = cros_usbpd_charger_usb_types;
> +                       psy_desc->num_usb_types =
> +                               ARRAY_SIZE(cros_usbpd_charger_usb_types);
> +               }
> +
> +               psy_desc->name = port->name;
> +
>                 psy = devm_power_supply_register_no_ws(dev, psy_desc,
>                                                        &psy_cfg);
>                 if (IS_ERR(psy)) {
> --
> 2.17.0
>
