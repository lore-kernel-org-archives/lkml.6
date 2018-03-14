Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1542408-1521026184-2-3974674725937005723
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521026183; b=WU9XI1cyRVZEu6VS4hhuRfLVxLDu+iTr+hjYaFGtNFEeqRe
    SsxyC7EMtfDmaPvdaZh5hQmXDGnWx0ZpzMuNm4yMmb/28FB947DG59o/lEFPFQp6
    PKKPi2DmrT4VsjYzJRwEpAQ3VQdQ6fPbdIucRtD7ibXe6owajGi2jFm+bN8MiLd4
    T/qEeHFrqpVEfay8TW3mJpXNX8Emn+hW5trgPc+RBZUdHb2r9G96qiVXd5JgLWtE
    ryxG5aF6tn3XElc+H5wEVWAXNnEBjx+J+wuBYozFm6bqG0Ar4TbZugnIW/bRuR1+
    tOp4k64um1bS4vjhgPrHU63pYC1Yd96ZRjYgPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521026183; bh=uPL7EcWlXOpYpJc1O1v/w63Gfi
    6+2S8Q1h54TmqUpGY=; b=PPoC3d0vvd2jotHbN2ezrN1CAZVocIjM7fH5P2jd8m
    fHCGxpOoozTSHrfovLRutjz6No6CY+FJzoeuVfbf8uf/hpxerRseyxtZ7rP5dJJb
    Gkl7xgCqm1xWOIUd2BzwiTPPb3LGp2+b9QK0rCOI6YETS9zY4BN1I2a4ZPDU8dYh
    swdvLnuBL1RNBa8v/rV6mHF5V3ZkdmGGWsi2faZO5LHH5GqKqVRzPTlXYLB2nRUz
    Pij4mHOsjr+CNfs6oKOAlEJ9VLoYFYdyD9LoCdVZsIQ90rRCw4oTfJ7BitCt2QGW
    Tl6g03X/McsMF2RA6/qVwbGnDTe21cWerSDnW1AjJ0hw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeCNLQI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 07:16:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeCNLQH (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 07:16:07 -0400
Date: Wed, 14 Mar 2018 12:16:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v7 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180314111605.GA21241@kroah.com>
References: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
 <20180312143431.82396-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312143431.82396-2-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 05:34:20PM +0300, Heikki Krogerus wrote:
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
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Changes in v7:
> - API naming improvements suggested by Greg
> - Prototypes to device.h, also suggested by Greg
> - I removed the DEVCON() macro as it was not used yet and it needs to be
>   rewritten
> 
> Changes in v6:
> -Fix data and match arguments being swapped in __device_find_connection()
>  call in device_find_connection() (as noticed by Jun Li)
> 
> Changes in v5:
> -Add missing documentation for @list struct devcon member
> 
> Changes in v4:
> -Add Andy's Reviewed-by
> 
> Changes in v3:
> -Various spelling and gramar fixes in the docs pointed out by Randy Dunlap
> 
> Changes in v2:
> -Add a (struct devcon) cast to the DEVCON() macro
> ---
>  Documentation/driver-api/device_connection.rst |  43 ++++++++
>  drivers/base/Makefile                          |   3 +-
>  drivers/base/devcon.c                          | 141 +++++++++++++++++++++++++
>  include/linux/device.h                         |  22 ++++
>  4 files changed, 208 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/driver-api/device_connection.rst
>  create mode 100644 drivers/base/devcon.c
> 
> diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
> new file mode 100644
> index 000000000000..affbc5566ab0
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
> +Devices often have connections to other devices that are outside of the direct
> +child/parent relationship. A serial or network communication controller, which
> +could be a PCI device, may need to be able to get a reference to its PHY
> +component, which could be attached for example to the I2C bus. Some device
> +drivers need to be able to control the clocks or the GPIOs for their devices,
> +and so on.
> +
> +Device connections are generic descriptions of any type of connection between
> +two separate devices.
> +
> +Device connections alone do not create a dependency between the two devices.
> +They are only descriptions which are not tied to either of the devices directly.
> +A dependency between the two devices exists only if one of the two endpoint
> +devices requests a reference to the other. The descriptions themselves can be
> +defined in firmware (not yet supported) or they can be built-in.
> +
> +Usage
> +-----
> +
> +Device connections should exist before device ``->probe`` callback is called for
> +either endpoint device in the description. If the connections are defined in
> +firmware, this is not a problem. It should be considered if the connection
> +descriptions are "built-in", and need to be added separately.
> +
> +The connection description consists of the names of the two devices with the
> +connection, i.e. the endpoints, and unique identifier for the connection which
> +is needed if there are multiple connections between the two devices.
> +
> +After a description exists, the devices in it can request reference to the other
> +endpoint device, or they can request the description itself.
> +
> +API
> +---
> +
> +.. kernel-doc:: drivers/base/devcon.c
> +   : functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index e32a52490051..12a7f64d35a9 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -5,7 +5,8 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
>  			   driver.o class.o platform.o \
>  			   cpu.o firmware.o init.o map.o devres.o \
>  			   attribute_container.o transport_class.o \
> -			   topology.o container.o property.o cacheinfo.o
> +			   topology.o container.o property.o cacheinfo.o \
> +			   devcon.o
>  obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
>  obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
>  obj-y			+= power/
> diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
> new file mode 100644
> index 000000000000..e783c2c2ed1a
> --- /dev/null
> +++ b/drivers/base/devcon.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * Device connections
> + *
> + * Copyright (C) 2018 Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + */
> +
> +#include <linux/device.h>
> +
> +static DEFINE_MUTEX(devcon_lock);
> +static LIST_HEAD(devcon_list);
> +
> +/**
> + * device_connection_find_match - Find physical connection to a device
> + * @dev: Device with the connection
> + * @con_id: Identifier for the connection
> + * @data: Data for the match function
> + * @match: Function to check and convert the connection description
> + *
> + * Find a connection with unique identifier @con_id between @dev and another
> + * device. @match will be used to convert the connection description to data the
> + * caller is expecting to be returned.
> + */
> +void *device_connection_find_match(struct device *dev, const char *con_id,
> +			       void *data,
> +			       void *(*match)(struct device_connection *con,
> +					      int ep, void *data))
> +{
> +	const char *devname = dev_name(dev);
> +	struct device_connection *con;
> +	void *ret = NULL;
> +	int ep;
> +
> +	if (!match)
> +		return NULL;
> +
> +	rcu_read_lock();

Wait, why are you using rcu at all for this?  This is not a "heavy"
operation that you need to care about speed for, right?  Why get rcu
involved at all in this type of thing?

Yes, the links in the driver core seem to be using rcu, which I didn't
notice until right now, and I can't remember why or when that happened.
Let's not make this more complex than it has to be please.

Sorry I missed this the last review cycles.

greg k-h
