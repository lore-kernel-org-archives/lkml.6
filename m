Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA8BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E5C24065
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1qM8PJja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E5C24065
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeGEPLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbeGEPLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:11:20 -0400
Received: from mail.kernel.org (dyndsl-178-142-077-060.ewe-ip-backbone.de [178.142.77.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971CB24065;
        Thu,  5 Jul 2018 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530803479;
        bh=HYbge8BSQk/DxdwzweunQX9Q8JtGsvktpiOE0pVQ5l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1qM8PJja5uoVCPmt9tYHuqrIpuZndbJnyXhAisFLZ2vo0+jqzV5fK99juXG9CbhEN
         OTqNL1ju4WvQQ0VOm2PXhF1O3cV2kFsladV4QUdtsAnNj4GQMIU2tyHKbJBZC/A8E0
         uo8aOBvb74eBpsE9WlcZR6WUftdgahBW1Umg2Ssk=
Date:   Thu, 5 Jul 2018 17:11:16 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        miguel.ojeda.sandonis@gmail.com, kernel@collabora.com
Subject: Re: [PATCH v4 2/3] power: supply: add cros-ec USBPD charger driver.
Message-ID: <20180705151116.rc5tdzqodnhfndsd@earth.universe>
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
 <20180502154418.2153-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bk5qlvt2twby37uq"
Content-Disposition: inline
In-Reply-To: <20180502154418.2153-3-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bk5qlvt2twby37uq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 02, 2018 at 05:44:17PM +0200, Enric Balletbo i Serra wrote:
> From: Sameer Nanda <snanda@chromium.org>
>=20
> This driver gets various bits of information about what is connected to
> USB PD ports from the EC and converts that into power_supply properties.
>=20
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>=20
> Changes in v4:
> - [2/3] Drop cros_ec_device->charger as is not used.
>=20
> Changes in v3:
> - [2/3] Add missing POWER_SUPPLY_PROP_USB_TYPE and a list of supported US=
B types.
> - [2/3] Fix SPDX header -> GPL-2.0+
> - [2/3] Unregister blocking_notifier_chain on remove.
>=20
> Changes in v2:
> - [2/3] Add SPDX header, use devm_ variant and drop .owner
> - [2/3] Removed the PD log functionality (will be send on a follow up pat=
ch)
> - [2/3] Removed the extra custom sysfs attributes (will be send on a foll=
ow up patch)
>=20
>  drivers/power/supply/Kconfig              |  10 +
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/cros_usbpd-charger.c | 544 ++++++++++++++++++++++
>  3 files changed, 555 insertions(+)
>  create mode 100644 drivers/power/supply/cros_usbpd-charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 428b426842f4..046eb23ba6f0 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -624,4 +624,14 @@ config CHARGER_RT9455
>  	help
>  	  Say Y to enable support for Richtek RT9455 battery charger.
> =20
> +config CHARGER_CROS_USBPD
> +	tristate "ChromeOS EC based USBPD charger"
> +	depends on MFD_CROS_EC
> +	default n
> +	help
> +	  Say Y here to enable ChromeOS EC based USBPD charger
> +	  driver. This driver gets various bits of information about
> +	  what is connected to USB PD ports from the EC and converts
> +	  that into power_supply properties.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index e83aa843bcc6..907e26f824b2 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -83,3 +83,4 @@ obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
>  obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
> +obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-charger.o
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> new file mode 100644
> index 000000000000..3a0c96fd1bc1
> --- /dev/null
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -0,0 +1,544 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Power supply driver for ChromeOS EC based USB PD Charger.
> + *
> + * Copyright (c) 2014 - 2018 Google, Inc
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +
> +#define CHARGER_DIR_NAME			"CROS_USBPD_CHARGER%d"
> +#define CHARGER_DIR_NAME_LENGTH			sizeof(CHARGER_DIR_NAME)
> +#define CHARGER_CACHE_UPDATE_DELAY		msecs_to_jiffies(500)
> +#define CHARGER_MANUFACTURER_MODEL_LENGTH	32
> +
> +#define DRV_NAME "cros-usbpd-charger"
> +
> +struct port_data {
> +	int port_number;
> +	char name[CHARGER_DIR_NAME_LENGTH];
> +	char manufacturer[CHARGER_MANUFACTURER_MODEL_LENGTH];
> +	char model_name[CHARGER_MANUFACTURER_MODEL_LENGTH];
> +	struct power_supply *psy;
> +	struct power_supply_desc psy_desc;
> +	int psy_usb_type;
> +	int psy_online;
> +	int psy_status;
> +	int psy_current_max;
> +	int psy_voltage_max_design;
> +	int psy_voltage_now;
> +	int psy_power_max;
> +	struct charger_data *charger;
> +	unsigned long last_update;
> +};
> +
> +struct charger_data {
> +	struct device *dev;
> +	struct cros_ec_dev *ec_dev;
> +	struct cros_ec_device *ec_device;
> +	int num_charger_ports;
> +	int num_registered_psy;
> +	struct port_data *ports[EC_USB_PD_MAX_PORTS];
> +	struct notifier_block notifier;
> +};
> +
> +static enum power_supply_property cros_usbpd_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_USB_TYPE
> +};
> +
> +static enum power_supply_usb_type cros_usbpd_charger_usb_types[] =3D {
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +	POWER_SUPPLY_USB_TYPE_C,
> +	POWER_SUPPLY_USB_TYPE_PD,
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,
> +	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID
> +};
> +
> +static int cros_usbpd_charger_ec_command(struct charger_data *charger,
> +					 unsigned int version,
> +					 unsigned int command,
> +					 void *outdata,
> +					 unsigned int outsize,
> +					 void *indata,
> +					 unsigned int insize)
> +{
> +	struct cros_ec_dev *ec_dev =3D charger->ec_dev;
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg =3D kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version =3D version;
> +	msg->command =3D ec_dev->cmd_offset + command;
> +	msg->outsize =3D outsize;
> +	msg->insize =3D insize;
> +
> +	if (outsize)
> +		memcpy(msg->data, outdata, outsize);
> +
> +	ret =3D cros_ec_cmd_xfer_status(charger->ec_device, msg);
> +	if (ret >=3D 0 && insize)
> +		memcpy(indata, msg->data, insize);
> +
> +	kfree(msg);
> +	return ret;
> +}
> +
> +static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
> +{
> +	struct ec_response_usb_pd_ports resp;
> +	int ret;
> +
> +	ret =3D cros_usbpd_charger_ec_command(charger, 0, EC_CMD_USB_PD_PORTS,
> +					    NULL, 0, &resp, sizeof(resp));
> +	if (ret < 0) {
> +		dev_err(charger->dev,
> +			"Unable to get the number or ports (err:0x%x)\n", ret);
> +		return ret;
> +	}
> +
> +	return resp.num_ports;
> +}
> +
> +static int cros_usbpd_charger_get_discovery_info(struct port_data *port)
> +{
> +	struct charger_data *charger =3D port->charger;
> +	struct ec_params_usb_pd_discovery_entry resp;
> +	struct ec_params_usb_pd_info_request req;
> +	int ret;
> +
> +	req.port =3D port->port_number;
> +
> +	ret =3D cros_usbpd_charger_ec_command(charger, 0,
> +					    EC_CMD_USB_PD_DISCOVERY,
> +					    &req, sizeof(req),
> +					    &resp, sizeof(resp));
> +	if (ret < 0) {
> +		dev_err(charger->dev,
> +			"Unable to query discovery info (err:0x%x)\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(charger->dev, "Port %d: VID =3D 0x%x, PID=3D0x%x, PTYPE=3D0x%x\=
n",
> +		port->port_number, resp.vid, resp.pid, resp.ptype);
> +
> +	snprintf(port->manufacturer, sizeof(port->manufacturer), "%x",
> +		 resp.vid);
> +	snprintf(port->model_name, sizeof(port->model_name), "%x", resp.pid);
> +
> +	return 0;
> +}
> +
> +static int cros_usbpd_charger_get_power_info(struct port_data *port)
> +{
> +	struct charger_data *charger =3D port->charger;
> +	struct ec_response_usb_pd_power_info resp;
> +	struct ec_params_usb_pd_power_info req;
> +	int last_psy_status, last_psy_usb_type;
> +	struct device *dev =3D charger->dev;
> +	int ret;
> +
> +	req.port =3D port->port_number;
> +	ret =3D cros_usbpd_charger_ec_command(charger, 0,
> +					    EC_CMD_USB_PD_POWER_INFO,
> +					    &req, sizeof(req),
> +					    &resp, sizeof(resp));
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to query PD power info (err:0x%x)\n", ret);
> +		return ret;
> +	}
> +
> +	last_psy_status =3D port->psy_status;
> +	last_psy_usb_type =3D port->psy_usb_type;
> +
> +	switch (resp.role) {
> +	case USB_PD_PORT_POWER_DISCONNECTED:
> +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		port->psy_online =3D 0;
> +		break;
> +	case USB_PD_PORT_POWER_SOURCE:
> +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		port->psy_online =3D 0;
> +		break;
> +	case USB_PD_PORT_POWER_SINK:
> +		port->psy_status =3D POWER_SUPPLY_STATUS_CHARGING;
> +		port->psy_online =3D 1;
> +		break;
> +	case USB_PD_PORT_POWER_SINK_NOT_CHARGING:
> +		port->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		port->psy_online =3D 1;
> +		break;
> +	default:
> +		dev_err(dev, "Unknown role %d\n", resp.role);
> +		break;
> +	}
> +
> +	port->psy_voltage_max_design =3D resp.meas.voltage_max;
> +	port->psy_voltage_now =3D resp.meas.voltage_now;
> +	port->psy_current_max =3D resp.meas.current_max;
> +	port->psy_power_max =3D resp.max_power;
> +
> +	switch (resp.type) {
> +	case USB_CHG_TYPE_BC12_SDP:
> +	case USB_CHG_TYPE_VBUS:
> +		port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +		break;
> +	case USB_CHG_TYPE_NONE:
> +		/*
> +		 * For dual-role devices when we are a source, the firmware
> +		 * reports the type as NONE. Report such chargers as type
> +		 * USB_PD_DRP.
> +		 */
> +		if (resp.role =3D=3D USB_PD_PORT_POWER_SOURCE && resp.dualrole)
> +			port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_PD_DRP;
> +		else
> +			port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +		break;
> +	case USB_CHG_TYPE_OTHER:
> +	case USB_CHG_TYPE_PROPRIETARY:
> +		port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID;
> +		break;
> +	case USB_CHG_TYPE_C:
> +		port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_C;
> +		break;
> +	case USB_CHG_TYPE_BC12_DCP:
> +		port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_DCP;
> +		break;
> +	case USB_CHG_TYPE_BC12_CDP:
> +		port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_CDP;
> +		break;
> +	case USB_CHG_TYPE_PD:
> +		if (resp.dualrole)
> +			port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_PD_DRP;
> +		else
> +			port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_PD;
> +		break;
> +	case USB_CHG_TYPE_UNKNOWN:
> +		/*
> +		 * While the EC is trying to determine the type of charger that
> +		 * has been plugged in, it will report the charger type as
> +		 * unknown. Additionally since the power capabilities are
> +		 * unknown, report the max current and voltage as zero.
> +		 */
> +		port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +		port->psy_voltage_max_design =3D 0;
> +		port->psy_current_max =3D 0;
> +		break;
> +	default:
> +		dev_err(dev, "Port %d: default case!\n", port->port_number);
> +		port->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +	}
> +
> +	port->psy_desc.type =3D POWER_SUPPLY_TYPE_USB;
> +
> +	dev_dbg(dev,
> +		"Port %d: type=3D%d vmax=3D%d vnow=3D%d cmax=3D%d clim=3D%d pmax=3D%d\=
n",
> +		port->port_number, resp.type, resp.meas.voltage_max,
> +		resp.meas.voltage_now, resp.meas.current_max,
> +		resp.meas.current_lim, resp.max_power);
> +
> +	/*
> +	 * If power supply type or status changed, explicitly call
> +	 * power_supply_changed. This results in udev event getting generated
> +	 * and allows user mode apps to react quicker instead of waiting for
> +	 * their next poll of power supply status.
> +	 */
> +	if (last_psy_usb_type !=3D port->psy_usb_type ||
> +	    last_psy_status !=3D port->psy_status)
> +		power_supply_changed(port->psy);
> +
> +	return 0;
> +}
> +
> +static int cros_usbpd_charger_get_port_status(struct port_data *port,
> +					      bool ratelimit)
> +{
> +	int ret;
> +
> +	if (ratelimit &&
> +	    time_is_after_jiffies(port->last_update +
> +				  CHARGER_CACHE_UPDATE_DELAY))
> +		return 0;
> +
> +	ret =3D cros_usbpd_charger_get_power_info(port);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D cros_usbpd_charger_get_discovery_info(port);
> +	port->last_update =3D jiffies;
> +
> +	return ret;
> +}
> +
> +static void cros_usbpd_charger_power_changed(struct power_supply *psy)
> +{
> +	struct port_data *port =3D power_supply_get_drvdata(psy);
> +	struct charger_data *charger =3D port->charger;
> +	int i;
> +
> +	for (i =3D 0; i < charger->num_registered_psy; i++)
> +		cros_usbpd_charger_get_port_status(charger->ports[i], false);
> +}
> +
> +static int cros_usbpd_charger_get_prop(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
> +{
> +	struct port_data *port =3D power_supply_get_drvdata(psy);
> +	struct charger_data *charger =3D port->charger;
> +	struct cros_ec_device *ec_device =3D charger->ec_device;
> +	struct device *dev =3D charger->dev;
> +	int ret;
> +
> +	/* Only refresh ec_port_status for dynamic properties */
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		/*
> +		 * If mkbp_event_supported, then we can be assured that
> +		 * the driver's state for the online property is consistent
> +		 * with the hardware. However, if we aren't event driven,
> +		 * the optimization before to skip an ec_port_status get
> +		 * and only returned cached values of the online property will
> +		 * cause a delay in detecting a cable attach until one of the
> +		 * other properties are read.
> +		 *
> +		 * Allow an ec_port_status refresh for online property check
> +		 * if we're not already online to check for plug events if
> +		 * not mkbp_event_supported.
> +		 */
> +		if (ec_device->mkbp_event_supported || port->psy_online)
> +			break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D cros_usbpd_charger_get_port_status(port, true);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to get port status (err:0x%x)\n",
> +				ret);
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D port->psy_online;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D port->psy_status;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		val->intval =3D port->psy_current_max * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		val->intval =3D port->psy_voltage_max_design * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D port->psy_voltage_now * 1000;
> +		break;
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		val->intval =3D port->psy_usb_type;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D port->model_name;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D port->manufacturer;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
> +				       unsigned long queued_during_suspend,
> +				       void *_notify)
> +{
> +	struct cros_ec_device *ec_device;
> +	struct charger_data *charger;
> +	struct device *dev;
> +	u32 host_event;
> +
> +	charger =3D container_of(nb, struct charger_data, notifier);
> +	ec_device =3D charger->ec_device;
> +	dev =3D charger->dev;
> +
> +	host_event =3D cros_ec_get_host_event(ec_device);
> +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> +		cros_usbpd_charger_power_changed(charger->ports[0]->psy);
> +		return NOTIFY_OK;
> +	} else {
> +		return NOTIFY_DONE;
> +	}
> +}
> +
> +static void cros_usbpd_charger_unregister_notifier(void *data)
> +{
> +	struct charger_data *charger =3D data;
> +	struct cros_ec_device *ec_device =3D charger->ec_device;
> +
> +	blocking_notifier_chain_unregister(&ec_device->event_notifier,
> +					   &charger->notifier);
> +}
> +
> +static int cros_usbpd_charger_probe(struct platform_device *pd)
> +{
> +	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(pd->dev.parent);
> +	struct cros_ec_device *ec_device =3D ec_dev->ec_dev;
> +	struct power_supply_desc *psy_desc;
> +	struct device *dev =3D &pd->dev;
> +	struct charger_data *charger;
> +	struct power_supply *psy;
> +	struct port_data *port;
> +	int ret =3D -EINVAL;
> +	int i;
> +
> +	charger =3D devm_kzalloc(dev, sizeof(struct charger_data),
> +			       GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	charger->dev =3D dev;
> +	charger->ec_dev =3D ec_dev;
> +	charger->ec_device =3D ec_device;
> +
> +	platform_set_drvdata(pd, charger);
> +
> +	charger->num_charger_ports =3D cros_usbpd_charger_get_num_ports(charger=
);
> +	if (charger->num_charger_ports <=3D 0) {
> +		/*
> +		 * This can happen on a system that doesn't support USB PD.
> +		 * Log a message, but no need to warn.
> +		 */
> +		dev_info(dev, "No charging ports found\n");
> +		ret =3D -ENODEV;
> +		goto fail_nowarn;
> +	}
> +
> +	for (i =3D 0; i < charger->num_charger_ports; i++) {
> +		struct power_supply_config psy_cfg =3D {};
> +
> +		port =3D devm_kzalloc(dev, sizeof(struct port_data), GFP_KERNEL);
> +		if (!port) {
> +			ret =3D -ENOMEM;
> +			goto fail;
> +		}
> +
> +		port->charger =3D charger;
> +		port->port_number =3D i;
> +		sprintf(port->name, CHARGER_DIR_NAME, i);
> +
> +		psy_desc =3D &port->psy_desc;
> +		psy_desc->name =3D port->name;
> +		psy_desc->type =3D POWER_SUPPLY_TYPE_USB;
> +		psy_desc->get_property =3D cros_usbpd_charger_get_prop;
> +		psy_desc->external_power_changed =3D
> +					cros_usbpd_charger_power_changed;
> +		psy_desc->properties =3D cros_usbpd_charger_props;
> +		psy_desc->num_properties =3D
> +					ARRAY_SIZE(cros_usbpd_charger_props);
> +		psy_desc->usb_types =3D cros_usbpd_charger_usb_types;
> +		psy_desc->num_usb_types =3D
> +				ARRAY_SIZE(cros_usbpd_charger_usb_types);
> +		psy_cfg.drv_data =3D port;
> +
> +		psy =3D devm_power_supply_register_no_ws(dev, psy_desc,
> +						       &psy_cfg);
> +		if (IS_ERR(psy)) {
> +			dev_err(dev, "Failed to register power supply\n");
> +			continue;
> +		}
> +		port->psy =3D psy;
> +
> +		charger->ports[charger->num_registered_psy++] =3D port;
> +	}
> +
> +	if (!charger->num_registered_psy) {
> +		ret =3D -ENODEV;
> +		dev_err(dev, "No power supplies registered\n");
> +		goto fail;
> +	}
> +
> +	if (ec_device->mkbp_event_supported) {
> +		/* Get PD events from the EC */
> +		charger->notifier.notifier_call =3D cros_usbpd_charger_ec_event;
> +		ret =3D blocking_notifier_chain_register(
> +						&ec_device->event_notifier,
> +						&charger->notifier);
> +		if (ret < 0) {
> +			dev_warn(dev, "failed to register notifier\n");
> +		} else {
> +			ret =3D devm_add_action_or_reset(dev,
> +					cros_usbpd_charger_unregister_notifier,
> +					charger);
> +			if (ret < 0)
> +				goto fail;
> +		}
> +	}
> +
> +	return 0;
> +
> +fail:
> +	WARN(1, "%s: Failing probe (err:0x%x)\n", dev_name(dev), ret);
> +
> +fail_nowarn:
> +	dev_info(dev, "Failing probe (err:0x%x)\n", ret);
> +	return ret;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cros_usbpd_charger_resume(struct device *dev)
> +{
> +	struct charger_data *charger =3D dev_get_drvdata(dev);
> +	int i;
> +
> +	if (!charger)
> +		return 0;
> +
> +	for (i =3D 0; i < charger->num_registered_psy; i++) {
> +		power_supply_changed(charger->ports[i]->psy);
> +		charger->ports[i]->last_update =3D
> +				jiffies - CHARGER_CACHE_UPDATE_DELAY;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cros_usbpd_charger_pm_ops, NULL,
> +			 cros_usbpd_charger_resume);
> +
> +static struct platform_driver cros_usbpd_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +		.pm =3D &cros_usbpd_charger_pm_ops,
> +	},
> +	.probe =3D cros_usbpd_charger_probe
> +};
> +
> +module_platform_driver(cros_usbpd_charger_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS EC USBPD charger");
> +MODULE_ALIAS("platform:" DRV_NAME);
> --=20
> 2.17.0
>=20
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--bk5qlvt2twby37uq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAls+NRQACgkQ2O7X88g7
+priyw/+Ljz82VjMGODH/HiJbrrfuvgygwIveoHSwULc0dLacRRDAJ1t+X5eK8sd
uvcPg2r0e8uKoo1UQDPM4v+I0uZR0Hbe7Je6LwirZfd6QRaS2vxoN1UOUxRG9A/A
z+7ZYq2+cUcn/xs6/wjpHQpPVEzIcFybXI/qTJp4ckAqMxjyqa7jkIhNPRRqDc05
Pj7XRmwwCBJm3sociUjtDJH9rOWQ5sOPRtrOwSl7XwTxwIbQMeNG0H64UmsW3rCn
iEHj2WnCTa/bq0chg60mu+1WbxU02YZx+wA+0tSEmjg3r/57QWNj4WplGlU5WGPJ
cYwCwJFaE8AOfvqjxdlE6QLO8YhOOImV3SQed4F50pYZo8kc+4XQY3ueMDSbqHZH
QPyVNhebxSRhisFcZmz6ZIT14moZjN/X2qGT5jj7ioORHLkhKx8LBIZxYWBP/6sZ
yChDxjWFMWTGwGSbwEnwJaUZ0dF2b1RmvG/yuPR1rk9skJ7i6wbXQQB6YjcAXAMF
eNpoOKaApKhesZv5R09uFLwLHH2nhiFw1mG75OmWC2HdKTxiaEiI4nzIVQMs++/Z
LKEbZobxYnXcjgwOTwe+nikFUdwUt3RZV1603WBjmn2hkFEZeNOlMF/9O+K2WFv2
c5j8t6X3/xOPttpEUky1/knNk4rROF6HT8wPEp0yHx2MJuRc4FU=
=OKff
-----END PGP SIGNATURE-----

--bk5qlvt2twby37uq--
