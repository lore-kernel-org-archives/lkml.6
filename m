Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604962-1519585460-2-4649996465427599944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519585459; b=dlfdrXIIS/Aptn2CDVNpsvSz7AJGDRMuc+ZSe5MAQJplcgG
    UD7ztMHrhR8tHg9uY5Szs52xVJfoAIeTswoxxY0hD+M0x7sSV2dk4xWtgRve3rTH
    RLP6ggmUu/5RF+HVg0GsM9hIW1IczxlHYS1FlTlef5jEzVKzAbyYOIr1gjF6MES/
    Jh3BQ7ZKQ0dE3pkDT61htMosgVEL0CxZFhZwamiXU1zAxTmM2QytCAWa4DJfk1lZ
    9+JxjnT8HvLlTTN++18VIT9mwUwPY4bTc0/kRcC7cckqaP1ddMAJ+2BKRTJkeefN
    wTmEmpiwgsZGDS+QEKS1RPVycLEincofeO6upSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519585459; bh=Z5beVAykiKKdafJaGIBlCbfxbvhEjQufoI+CrWUNzws=; b=T
    ZJVrVty2FD2kgtjw5QlMKlIUoCVoGTvX2oMd4lfA+lZiKkXkz9skK4VdAQ+MVXnm
    u8NE0wCqO95XHQfiusbvJWPeHwbs97zOhnEmzCB529FxSuCbrMEE68I+zjcwLt2M
    6dfmT9FmQOFOYjPG5n/CPKfVLS1x40o8QM03a/G8CWTMreu8iQvEssIEkRQCe39w
    o67j5f+CiqnumlHMmwYae8nBnOjfirWqyu6PY/4uAMaAFXFkKxcotHgHC4wa1Gyr
    GItc3pG/XuBoPXaNV/X2UydKZbGX+AL96aTw+Pk4LfGGtHIZHcRWRITeRB4SoMvp
    xAiCV2PurWWcx8EW8E0Ew==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=HOP+qp97 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=HOP+qp97 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeBYTEP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 14:04:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbeBYTEO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 14:04:14 -0500
Subject: Re: [PATCH v2 01/12] drivers: base: Unified device connection lookup
To: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180225152510.10159-1-hdegoede@redhat.com>
 <20180225152510.10159-2-hdegoede@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6d89fe84-7196-fe60-86d9-29b05fa97ad8@infradead.org>
Date: Sun, 25 Feb 2018 11:04:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225152510.10159-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/25/2018 07:24 AM, Hans de Goede wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Several frameworks - clk, gpio, phy, pmw, etc. - maintain
> lookup tables for describing connections and provide custom
> API for handling them. This introduces a single generic
> lookup table and API for the connections.
> 
> The motivation for this commit is centralizing the
> connection lookup, but the goal is to ultimately extract the
> connection descriptions also from firmware by using the
> fwnode_graph_* functions and other mechanisms that are
> available.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Add a (struct devcon) cast to the DEVCON() macro
> ---
>  Documentation/driver-api/device_connection.rst |  43 ++++++++
>  drivers/base/Makefile                          |   3 +-
>  drivers/base/devcon.c                          | 139 +++++++++++++++++++++++++
>  include/linux/connection.h                     |  33 ++++++
>  4 files changed, 217 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/driver-api/device_connection.rst
>  create mode 100644 drivers/base/devcon.c
>  create mode 100644 include/linux/connection.h
> 
> diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
> new file mode 100644
> index 000000000000..d52604448356
> --- /dev/null
> +++ b/Documentation/driver-api/device_connection.rst
> @@ -0,0 +1,43 @@
> +==================
> +Device connections
> +==================
> +
> +Introduction
> +------------
> +
> +Devices have often connections to other devices that are out side of the direct

   Devices often have connections                       are outside of

> +child/parent relationship. A serial or network communication controller, which
> +could be a PCI device, may need to be able to get a reference to its PHY
> +component, which could be attached to for example the I2C bus. Some device

                    could be attached for example to the I2C bus.

> +drivers need to be able to control the clocks or the GPIOs for their devices,
> +and so on.
> +
> +Device connections are generic descriptions of any type of connection between
> +two separate devices.
> +
> +Device connections alone do not create a dependency between the two devices.
> +They are only descriptions which are not tied to either of devices directly.

                                                           of the devices directly.

> +A dependency between the two devices exists only if one of the two endpoint
> +devices requests a reference to the other. The descriptions themselves can be
> +defined in firmware (not yet supported) or they can be build-in.

                                                          built-in.

> +
> +Usage
> +-----
> +
> +Device connections should exist before device ``->probe`` callback is called for
> +either endpoint devices in the description. If the connections are defined in

                   device

> +firmware, this is not a problem. It should be considered if the connection
> +descriptions are "build-in", and need to be added separately.

                    "built-in",

> +
> +The connection description consist of the names of the two devices with the

                              consists

> +connection, i.e. the endpoints, and unique identifier for the connection which
> +is needed if there are multiple connections between the two devices.
> +
> +After a descriptions exist, the devices in it can request reference to the other

           description exists,

> +endpoint device, or they can request the description itself.
> +
> +API
> +---
> +
> +.. kernel-doc:: drivers/base/devcon.c
> +   : functions: __device_find_connection device_find_connection add_device_connection remove_device_connection

> diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
> new file mode 100644
> index 000000000000..6f9e4f7280a5
> --- /dev/null
> +++ b/drivers/base/devcon.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * Device connections
> + *
> + * Copyright (C) 2018 Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + */
> +
> +#include <linux/connection.h>
> +#include <linux/device.h>
> +
> +static DEFINE_MUTEX(devcon_lock);
> +static LIST_HEAD(devcon_list);
> +
> +/**
> + * __device_find_connection - Find physical connection to a device
> + * @dev: Device with the connection
> + * @con_id: Identifier for the connection
> + * @data: Data for the match function
> + * @match: Function to check and convert the connection description
> + *
> + * Find a connection with unique identifier @con_id between @dev and an other

                                                                        another

> + * device. @match will be used to convert the connection description to data the
> + * caller is expecting to be returned.
> + */
> +void *__device_find_connection(struct device *dev, const char *con_id,
> +			       void *data,
> +			       void *(*match)(struct devcon *con, int ep,
> +					      void *data))
> +{
> +	const char *devname = dev_name(dev);
> +	struct devcon *con;
> +	void *ret = NULL;
> +	int ep;
> +
> +	if (!match)
> +		return NULL;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(con, &devcon_list, list) {
> +		ep = match_string(con->endpoint, 2, devname);
> +		if (ep < 0)
> +			continue;
> +
> +		if (con_id && strcmp(con->id, con_id))
> +			continue;
> +
> +		ret = match(con, !ep, data);
> +		if (ret)
> +			break;
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(__device_find_connection);
> +
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/i2c.h>
> +#include <linux/pci.h>
> +
> +static struct bus_type *generic_match_buses[] = {
> +	&platform_bus_type,
> +#ifdef CONFIG_PCI
> +	&pci_bus_type,
> +#endif
> +#ifdef CONFIG_I2C
> +	&i2c_bus_type,
> +#endif
> +#ifdef CONFIG_SPI_MASTER
> +	&spi_bus_type,
> +#endif
> +	NULL,
> +};
> +
> +/* This tries to find the device from the most common bus types by name. */
> +static void *generic_match(struct devcon *con, int ep, void *data)
> +{
> +	struct bus_type *bus;
> +	struct device *dev;
> +
> +	for (bus = generic_match_buses[0]; bus; bus++) {
> +		dev = bus_find_device_by_name(bus, NULL, con->endpoint[ep]);
> +		if (dev)
> +			return dev;
> +	}
> +
> +	/*
> +	 * We only get called if a connection was found, tell the caller to

	                                          found; tell

> +	 * wait for the other device to show-up.

	                                show up.

> +	 */
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +/**
> + * device_find_connection - Find two devices connected together
> + * @dev: Device with the connection
> + * @con_id: Identifier for the connection
> + *
> + * Find a connection with unique identifier @con_id between @dev and an

                                                                    and

> + * other device. On success returns handle to the device that is connected

      another

> + * to @dev, with the reference count for the found device incremented. Returns
> + * NULL if no matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a
> + * connection was found but the other device has not been enumerated yet.
> + */
> +struct device *device_find_connection(struct device *dev, const char *con_id)
> +{
> +	return __device_find_connection(dev, con_id, generic_match, NULL);
> +}
> +EXPORT_SYMBOL_GPL(device_find_connection);



-- 
~Randy
