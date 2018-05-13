Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179414-1526174733-5-107014082465862177
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526174732; b=A8Fdc82iyI3/ZevGttV9cAB/ir47inAvQaV1HkThj4dpr+pFAw
    LIbwkzTRSfTptcdYqrrEfPK4A9zcfhcnolx6ZK5kUl6KkCnPmeEI1K5FJ2/DvZtk
    DjQZE4SQPt0gSDPMhxnW0lmP9sCN5tLbwPsK2Qn2f96jziL8mHm3Mq1l8R+xjkEa
    nddebwxCJ2boUnOAjROW4V+ltOtpWFkSom0UznE/au3I26kRcnNUjo3qEmKn43BH
    yw+SloOOSoJ/VjuQBfAR130qXv1Ro8up11xqFI89mBOthPqUtZgl3NnuCpAui3F2
    cvlOBicisNXI+wLUVh1u+s6BEP/E6ABEPyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526174732;
    bh=Z3OLG4QgkVoU91Z4s8Yi6E6boDSsNAlDwwPxDjjrpOI=; b=QE+Au9pO/qJR
    sFa39sLXfjlIs4sIWXIStPmE4k4baMrJkO9KM3yEHwgUu9fWjozcR2FMWu5ToR/y
    uGOkvMK+tvAF1kf4Nmmq/565kl1hYq0XHoLwOnnBfCYn2U8cyhFrezBBx9qkJkNp
    H7T7V7W6VPi1xZ0eXvVnvqzZjcJ5lGQGz5jNq3mM8Z/afjmDZyFEVSL6DKrGkgzO
    ip50/bkmDAJ0eHE/bQHEB75+QQv1NJEa62IZ2IGK6+BXL+4zfHhhIgRyIYEBhQuz
    MU3AX/3rGD6EBdzQQxZX25ulO9Rc1sqvSX+pVXDy8tlQm4w2yBdTymSB7hpLc0Zu
    OOlk+iQUWw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=nBUK1s65
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=nBUK1s65
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLnDb0d7XWNfSSaZlGIDgK6u1CcuxvTGN/nVxEIY46nrKQNSpZwSUv7UB47jZ+TwEGfVitfj79L2LBWUgf44mur8iXNGbMCXRzyL+1Ji8M1ptYebMFeb
    a3sCmi8sKUrLXB2NB62VfJE4u0t7vKxFTjmVa03AeA74L5FEgzUZ0M4q2NJH/gM7UiwIC0DPSxsFhrVlmCh+SWW28utcPuU3T5/Kj2PkXgNdD0e9f02pVu8j
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=NRKe_1xrOPX5vAT3Q1kA:9
    a=r5gdZekVQIY0R5oS:21 a=QVfl_dC7T3ilr1cm:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbeEMBZO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 12 May 2018 21:25:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeEMBZN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 12 May 2018 21:25:13 -0400
Subject: Re: [RFC PATCH v3 3/5] usb: typec: Bus type for alternate modes
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jun Li <jun.li@nxp.com>, Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
 <20180511131838.62064-4-heikki.krogerus@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7a23768d-9a50-b9ba-bc76-d3168eee930e@infradead.org>
Date: Sat, 12 May 2018 18:25:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511131838.62064-4-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/11/2018 06:18 AM, Heikki Krogerus wrote:
> Introducing a simple bus for the alternate modes. Bus allows
> binding drivers to the discovered alternate modes the
> partners support.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  Documentation/ABI/obsolete/sysfs-class-typec |  48 +++
>  Documentation/ABI/testing/sysfs-bus-typec    |  51 +++
>  Documentation/ABI/testing/sysfs-class-typec  |  62 +--
>  Documentation/driver-api/usb/typec_bus.rst   | 136 ++++++
>  drivers/usb/typec/Makefile                   |   2 +-
>  drivers/usb/typec/bus.c                      | 423 +++++++++++++++++++
>  drivers/usb/typec/bus.h                      |  38 ++
>  drivers/usb/typec/class.c                    | 364 ++++++++++++----
>  include/linux/mod_devicetable.h              |  15 +
>  include/linux/usb/typec.h                    |  14 +-
>  include/linux/usb/typec_altmode.h            | 142 +++++++
>  scripts/mod/devicetable-offsets.c            |   4 +
>  scripts/mod/file2alias.c                     |  13 +
>  13 files changed, 1168 insertions(+), 144 deletions(-)
>  create mode 100644 Documentation/ABI/obsolete/sysfs-class-typec
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-typec
>  create mode 100644 Documentation/driver-api/usb/typec_bus.rst
>  create mode 100644 drivers/usb/typec/bus.c
>  create mode 100644 drivers/usb/typec/bus.h
>  create mode 100644 include/linux/usb/typec_altmode.h

Hi,
I have a few doc corrections for you.

> diff --git a/Documentation/driver-api/usb/typec_bus.rst b/Documentation/driver-api/usb/typec_bus.rst
> new file mode 100644
> index 000000000000..4184e0925567
> --- /dev/null
> +++ b/Documentation/driver-api/usb/typec_bus.rst
> @@ -0,0 +1,136 @@
> +
> +API for USB Type-C Alternate Mode drivers
> +=========================================
> +
> +Introduction
> +------------
> +
> +Alternate modes require communication with the partner using Vendor Defined
> +Messages (VDM) as defined in USB Type-C and USB Power Delivery Specifications.
> +The communication is SVID (Standard or Vendor ID) specific, i.e. specific for
> +every alternate mode, so every alternate mode will need custom driver.

                                                           a custom driver.

> +
> +USB Type-C bus allows binding a driver to the discovered partner alternate
> +modes by using the SVID and the mode number.
> +
> +USB Type-C Connector Class provides a device for every alternate mode a port
> +supports, and separate device for every alternate mode the partner supports.
> +The drivers for the alternate modes are bind to the partner alternate mode

                                       are bound
or just:                               bind

> +devices, and the port alternate mode devices must be handled by the port
> +drivers.
> +
> +When a new partner alternate mode device is registered, it is linked to the
> +alternate mode device of the port that the partner is attached to, that has
> +matching SVID and mode. Communication between the port driver and alternate mode
> +driver will happen using the same API.
> +
> +The port alternate mode devices are used as a proxy between the partner and the
> +alternate mode drivers, so the port drivers are only expected to pass the SVID
> +specific commands from the alternate mode drivers to the partner, and from the
> +partners to the alternate mode drivers. No direct SVID specific communication is
> +needed from the port drivers, but the port drivers need to provide the operation
> +callbacks for the port alternate mode devices, just like the alternate mode
> +drivers need to provide them for the partner alternate mode devices.
> +
> +Usage:
> +------
> +
> +General
> +~~~~~~~
> +
> +By default, the alternate mode drivers are responsible for entering the mode.
> +It is also possible to leave the decision about entering the mode to the user
> +space (See Documentation/ABI/testing/sysfs-class-typec). Port drivers should not
> +enter any modes on their own.
> +
> +``->vdm`` is the most important callback in the vector. It will be used to
> +deliver all the SVID specific commands from the partner to the alternate mode
> +driver, and vise versa in case of port drivers. The drivers send the SVID

               vice versa

> +specific commands to each other using :c:func:`typec_altmode_vmd()`.
> +
> +If the communication with the partner using the SVID specific commands results
> +in need to re-configure the pins on the connector, the alternate mode driver

              reconfigure

> +needs to notify the bus using :c:func:`typec_altmode_notify()`. The driver
> +passes the negotiated SVID specific pin configuration value to the function as
> +parameter. The bus driver will then configure the mux behind the connector using
> +that value as the state value for the mux, and also call blocking notification
> +chain to notify the external drivers about the state of the connector that need
> +to know it.
> +
> +NOTE: The SVID specific pin configuration values must always start from
> +``TYPEC_STATE_MODAL``. USB Type-C specification defines two default states for
> +the connector: ``TYPEC_STATE_USB`` and ``TYPEC_STATE_SAFE``. These values are
> +reserved by the bus as the first possible values for the state. When the
> +alternate mode is entered, the bus will put the connector into
> +``TYPEC_STATE_SAFE`` before sending Enter or Exit Mode command as defined in USB
> +Type-C Specification, and also put the connector back to ``TYPEC_STATE_USB``
> +after the mode has been exited.
> +
> +An example of working definitions for SVID specific pin configurations would
> +look like this:
> +
> +enum {
> +	ALTMODEX_CONF_A = TYPEC_STATE_MODAL,
> +	ALTMODEX_CONF_B,
> +	...
> +};
> +
> +Helper macro ``TYPEC_MODAL_STATE()`` can also be used:
> +
> +#define ALTMODEX_CONF_A = TYPEC_MODAL_STATE(0);
> +#define ALTMODEX_CONF_B = TYPEC_MODAL_STATE(1);
> +
> +Notification chain
> +~~~~~~~~~~~~~~~~~~
> +
> +The drivers for the components that the alternate modes are designed for need to
> +get details regarding the results of the negotiation with the partner, and the
> +pin configuration of the connector. In case of DisplayPort alternate mode for
> +example, the GPU drivers will need to know those details. In case of
> +Thunderbolt alternate mode, the thunderbolt drivers will need to know them, and
> +so on.
> +
> +The notification chain is designed for this purpose. The drivers can register
> +notifiers with :c:func:`typec_altmode_register_notifier()`.
> +
> +Cable plug alternate modes
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The alternate mode drivers are not bind to cable plug alternate mode devices,

                              are not bound

> +only to the partner alternate mode devices. If the alternate mode supports, or
> +requires, a cable that responds to SOP Prime, and optionally SOP Double Prime
> +messages, the driver for that alternate mode must request handle to the cable
> +plug alternate modes using :c:func:`typec_altmode_get_plug()`, and taking over

                                                                  and take over

> +their control.
> +
> +Driver API
> +----------
> +
> +Alternate mode driver registering/unregistering
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: drivers/usb/typec/bus.c
> +   :functions: typec_altmode_register_driver typec_altmode_unregister_driver
> +
> +Alternate mode driver operations
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: drivers/usb/typec/bus.c
> +   :functions: typec_altmode_enter typec_altmode_exit typec_altmode_attention typec_altmode_vdm typec_altmode_notify
> +
> +API for the port drivers
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: drivers/usb/typec/bus.c
> +   :functions: typec_match_altmode
> +
> +Cable Plug operations
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: drivers/usb/typec/bus.c
> +   :functions: typec_altmode_get_plug typec_altmode_put_plug
> +
> +Notifications
> +~~~~~~~~~~~~~
> +.. kernel-doc:: drivers/usb/typec/class.c
> +   :functions: typec_altmode_register_notifier typec_altmode_unregister_notifier


HTH.
-- 
~Randy
