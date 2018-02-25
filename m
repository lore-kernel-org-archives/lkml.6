Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713019-1519586575-5-10109735531518028254
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
    t=1519586574; b=YmgkHUXWaHfVi3pZcMNEStzdIWzojE1NAgEpQeZW9BteuL1
    Re59Ln/5vPSrQ6VRfybuQ0lZBqUnPlq/XfFkcXtZLkSDwh4BGEqnEDCWFEEprOwT
    EfUGY9a8yWwT+fn5JBiRtvX3s2+Z7rNXbiDM/BpucSQKp5NnDeFoYSlC//e0nZjb
    6xKGGfz4FfF87OpLU3dOhbLJN55qcE4lhtdoaMxY/BqDufoZx8HRnXQ20gd+A1Cl
    NGBKKoLVInBcG0uIWsHmGChrn6XzAV5bx3gvB23u2UECv/IWi2dh2OHtja5fQqvI
    UEWHWhLtmbrFraq5TOjBvo/UyLVRAmEsP5XOdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519586574; bh=EvVKUmu9Uid6P47+spsSZ4SUFvoK4dGZUmFKetH/EdY=; b=q
    OdJ9rmcBUjaw6KOOy0XkLygiVDduczhFWcsahdVg1S4oKx1JZNuKL/G/MM0ivLuw
    jYwyTpiQOnqddGMcildQud9pcjlJcyFfMzE7QZr5ELCCS5mUaP7OQ5afvI6hbd/F
    U8OIybEY365x8nsYQGGYGytVBX3xatkopwcDMWvTHPPFpiSdFUHamWIPT0reCOAK
    NBOfzbAGzaRCaEV6V6dKoZvAiLRebqatWESFnN+ZpdTZG3Gcsc28bCCB02hjJp7i
    6RgnFNxReSBuW033PGT73+gxsefZoV3XZcEoyqgDHhLJvB82MGJdmL6Ds5PXzr/4
    Gaity56FjBdIgSUWOzzng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=AqVXUxlK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=AqVXUxlK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeBYTWo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 14:22:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeBYTWn (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 14:22:43 -0500
Subject: Re: [PATCH v2 03/12] usb: typec: API for controlling USB Type-C
 Multiplexers
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
 <20180225152510.10159-4-hdegoede@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3147a267-0f20-e3f4-deca-b81d7e60f412@infradead.org>
Date: Sun, 25 Feb 2018 11:22:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225152510.10159-4-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/25/2018 07:25 AM, Hans de Goede wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> ---
>  Documentation/driver-api/usb/typec.rst |  73 +++++++++++--
>  drivers/usb/typec/Makefile             |   1 +
>  drivers/usb/typec/{typec.c => class.c} |  70 ++++++++++++
>  drivers/usb/typec/mux.c                | 188 +++++++++++++++++++++++++++++++++
>  include/linux/usb/typec.h              |  14 +++
>  include/linux/usb/typec_mux.h          |  55 ++++++++++
>  6 files changed, 390 insertions(+), 11 deletions(-)
>  rename drivers/usb/typec/{typec.c => class.c} (95%)
>  create mode 100644 drivers/usb/typec/mux.c
>  create mode 100644 include/linux/usb/typec_mux.h
> 
> diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
> index 8a7249f2ff04..091e4def3a39 100644
> --- a/Documentation/driver-api/usb/typec.rst
> +++ b/Documentation/driver-api/usb/typec.rst
> +
> +Multiplexer/DeMultiplexer Switches
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +USB Type-C connectors may have one or more mux/demux switches behind them. Since
> +the plugs can be inserted right-side-up or upside-down, a switch is needed to
> +route the correct data pairs from the connector to the USB controllers. If
> +Alternate or Accessory Modes are supported, an other switch is needed that can

                                               another

> +route the pins on the connector to some other component besides USB. USB Type-C
> +Connector Class supplies an API for registering those switches.
> +
> +.. kernel-doc:: drivers/usb/typec/mux.c
> +   :functions: typec_switch_register typec_switch_unregister typec_mux_register typec_mux_unregister
> +
> +In most cases the same physical mux will handle both the orientation and mode.
> +However, as the port drivers will be responsible of the orientation, and the

                                                    for the orientation,

> +alternate mode drivers of the mode, the two are always separated into their own

                          for the mode,

> +logical components: "mux" for the mode and "switch" for the orientation.
> +
> +When a port is registered, USB Type-C Connector Class requests both the mux and
> +the switch for the port. The drivers can then use the following API for
> +controlling them:
> +
> +.. kernel-doc:: drivers/usb/typec/class.c
> +   :functions: typec_set_orientation typec_set_mode
> +
> +If the connector is dual-role capable, there may also be a switch for the data
> +role. USB Type-C Connector Class does not supply separate API for them. The
> +port drivers can use USB Role Class API with those.
> +
> +Illustration of the muxes behind a connector that supports an alternate mode:
> +
> +                     ------------------------
> +                     |       Connector      |
> +                     ------------------------
> +                            |         |
> +                     ------------------------
> +                      \     Orientation    /
> +                       --------------------
> +                                |
> +                       --------------------
> +                      /        Mode        \
> +                     ------------------------
> +                         /              \
> +      ------------------------        --------------------
> +      |       Alt Mode       |       /      USB Role      \
> +      ------------------------      ------------------------
> +                                         /            \
> +                     ------------------------      ------------------------
> +                     |       USB Host       |      |       USB Device     |
> +                     ------------------------      ------------------------

> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> new file mode 100644
> index 000000000000..3102238366ed
> --- /dev/null
> +++ b/drivers/usb/typec/mux.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * USB Type-C Multiplexer/DeMultiplexer Switch support
> + *
> + * Copyright (C) 2018 Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + *         Hans de Goede <hdegoede@redhat.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/connection.h>
> +#include <linux/usb/typec_mux.h>

Needs: <linux/mutex.h> <linux/list.h> ...

> +static DEFINE_MUTEX(switch_lock);
> +static DEFINE_MUTEX(mux_lock);
> +static LIST_HEAD(switch_list);
> +static LIST_HEAD(mux_list);
> +
> +static void *typec_switch_match(struct devcon *con, int ep, void *data)
> +{
> +	struct typec_switch *sw;
> +
> +	list_for_each_entry(sw, &switch_list, entry)
> +		if (!strcmp(con->endpoint[ep], dev_name(sw->dev)))
> +			return sw;
> +
> +	/*
> +	 * We only get called if a connection was found, tell the caller to
> +	 * wait for the switch to show-up.

	                          show up.

> +	 */
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +


> +static void *typec_mux_match(struct devcon *con, int ep, void *data)
> +{
> +	struct typec_mux *mux;
> +
> +	list_for_each_entry(mux, &mux_list, entry)
> +		if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
> +			return mux;
> +
> +	/*
> +	 * We only get called if a connection was found, tell the caller to
> +	 * wait for the switch to show-up.

	                          show up.

> +	 */
> +	return ERR_PTR(-EPROBE_DEFER);
> +}

> diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
> new file mode 100644
> index 000000000000..0ddaaa8b0ac1
> --- /dev/null
> +++ b/include/linux/usb/typec_mux.h
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef __USB_TYPEC_MUX
> +#define __USB_TYPEC_MUX
> +
> +#include <linux/list.h>
> +#include <linux/usb/typec.h>
> +
> +struct device;
> +
> +/**
> + * typec_switch - USB Type-C cable orientation switch

    * struct typec_switch - USB Type-C cable orientation switch

> + * @dev: Switch device
> + * @entry: List entry
> + * @set: Callback to the driver for setting the orientation
> + *
> + * USB Type-C pin flipper switch routing the correct data pairs from the
> + * connector to the USB controller depending on the orientation of the cable
> + * plug.
> + */
> +struct typec_switch {
> +	struct device *dev;
> +	struct list_head entry;
> +
> +	int (*set)(struct typec_switch *sw, enum typec_orientation orientation);
> +};
> +
> +/**
> + * typec_switch - USB Type-C connector pin mux

    * struct typec_mux - USB Type-C connector pin mux

> + * @dev: Mux device
> + * @entry: List entry
> + * @set: Callback to the driver for setting the state of the mux
> + *
> + * Pin Multiplexer/DeMultiplexer switch routing the USB Type-C connector pins to
> + * different components depending on the requested mode of operation. Used with
> + * Accessory/Alternate modes.
> + */
> +struct typec_mux {
> +	struct device *dev;
> +	struct list_head entry;
> +
> +	int (*set)(struct typec_mux *mux, int state);
> +};

ta.
-- 
~Randy
