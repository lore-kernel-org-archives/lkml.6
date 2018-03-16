Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3921380-1521236043-2-3173590987243481413
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521236040; b=B8Z+UC0jDed1zDRCUWu70XBWW09vjNFH2AXRE9BBvQGXrrg
    1aGJfFnM7zsJKQZU0WHwDXhjA7QEGQQttQdUIFj9sjeTDa+NKgOCW1sowLDiK0mE
    slnrMx3y9E0FreAAmNijOeIaglaT3KdvQVoZnulMzNyJGbPgmfCJpMK6J3fWcCw8
    QgQriyyhYj44C4IMoIZWBeneS1FlqRBFXspT55vCX45xMdY7xNPNuGNGBbs/TwPQ
    eEoJKVkzYUY5D89X7zZRGNcnn2bPiFT3ASWCk+dGYgdj4/RBdBUHPvWBD9gxU2vt
    QeYkjHZ/t3GpRHhHo1xmmFGcI2P4al76eMcFqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521236040; bh=40J+Tyt
    QjbBYyYXUNxVHvqUifXtumVfqE6k26FYI4+Y=; b=fL/EQQbvOj60qpwaA0+duOE
    Z6L4l5gsEU9mm22rdOKkxDHkxc5akbHcrKwGSKmrZmcE15U4RNFo8P8EYbQvGpMU
    8pqciyycvj5ubstMXVOvaeAn46PtFglF6Fbf8zg57uAEdZDrSdAEenAWzd0SClII
    vTlqOtXmA4Bwrom6AKK6b+mg01wo5tFot9BySFOfgchUR9KzOunZ03HD2XQi7P/x
    TvkQpNRjZydSHikG/bJuC/T30EiqhLnKm5059lTXRZs4Yoxs3ctOOIv7RkeJB/Uj
    ecqguyXPlfiX6A63N1mQxi1oPH3pSreSPJ9VuDReP+msj/ynitIv4Ro2rddfhrQ=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cBAWaRQm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AY24xjRW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cBAWaRQm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AY24xjRW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeCPVdl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 17:33:41 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37146 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeCPVdj (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Mar 2018 17:33:39 -0400
X-Google-Smtp-Source: AG47ELszvFM6ZkxdfZKzLpMyJOdL5D49mTeo4yveOw1TzXMaNim6AcPXqsX/EPNbOJQUNdTsuP92UQ==
Date: Fri, 16 Mar 2018 14:33:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] usb: typec: Bus type for alternate modes
Message-ID: <20180316213336.GA11002@roeck-us.net>
References: <20180309151918.22048-1-heikki.krogerus@linux.intel.com>
 <20180309151918.22048-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180309151918.22048-3-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 06:19:17PM +0300, Heikki Krogerus wrote:
> Introducing a simple bus for the alternate modes. Bus allows
> binding drivers to the discovered alternate modes the
> partners support.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  Documentation/ABI/obsolete/sysfs-class-typec |  48 +++
>  Documentation/ABI/testing/sysfs-bus-typec    |  51 ++++
>  Documentation/ABI/testing/sysfs-class-typec  |  62 +---
>  Documentation/driver-api/usb/typec_bus.rst   | 143 +++++++++
>  drivers/usb/typec/Makefile                   |   2 +-
>  drivers/usb/typec/bus.c                      | 421 +++++++++++++++++++++++++++
>  drivers/usb/typec/bus.h                      |  37 +++
>  drivers/usb/typec/class.c                    | 325 +++++++++++++++++----
>  include/linux/mod_devicetable.h              |  15 +
>  include/linux/usb/typec.h                    |  16 +-
>  include/linux/usb/typec_altmode.h            | 136 +++++++++
>  scripts/mod/devicetable-offsets.c            |   4 +
>  scripts/mod/file2alias.c                     |  13 +
>  13 files changed, 1138 insertions(+), 135 deletions(-)
>  create mode 100644 Documentation/ABI/obsolete/sysfs-class-typec
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-typec
>  create mode 100644 Documentation/driver-api/usb/typec_bus.rst
>  create mode 100644 drivers/usb/typec/bus.c
>  create mode 100644 drivers/usb/typec/bus.h
>  create mode 100644 include/linux/usb/typec_altmode.h
> 
> diff --git a/Documentation/ABI/obsolete/sysfs-class-typec b/Documentation/ABI/obsolete/sysfs-class-typec
> new file mode 100644
> index 000000000000..32623514ee87
> --- /dev/null
> +++ b/Documentation/ABI/obsolete/sysfs-class-typec
> @@ -0,0 +1,48 @@
> +These files are deprecated and will be removed. The same files are available
> +under /sys/bus/typec (see Documentation/ABI/testing/sysfs-bus-typec).
> +
> +What:		/sys/class/typec/<port|partner|cable>/<dev>/svid
> +Date:		April 2017
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		The SVID (Standard or Vendor ID) assigned by USB-IF for this
> +		alternate mode.
> +
> +What:		/sys/class/typec/<port|partner|cable>/<dev>/mode<index>/
> +Date:		April 2017
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		Every supported mode will have its own directory. The name of
> +		a mode will be "mode<index>" (for example mode1), where <index>
> +		is the actual index to the mode VDO returned by Discover Modes
> +		USB power delivery command.
> +
> +What:		/sys/class/typec/<port|partner|cable>/<dev>/mode<index>/description
> +Date:		April 2017
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		Shows description of the mode. The description is optional for
> +		the drivers, just like with the Billboard Devices.
> +
> +What:		/sys/class/typec/<port|partner|cable>/<dev>/mode<index>/vdo
> +Date:		April 2017
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		Shows the VDO in hexadecimal returned by Discover Modes command
> +		for this mode.
> +
> +What:		/sys/class/typec/<port|partner|cable>/<dev>/mode<index>/active
> +Date:		April 2017
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		Shows if the mode is active or not. The attribute can be used
> +		for entering/exiting the mode with partners and cable plugs, and
> +		with the port alternate modes it can be used for disabling
> +		support for specific alternate modes. Entering/exiting modes is
> +		supported as synchronous operation so write(2) to the attribute
> +		does not return until the enter/exit mode operation has
> +		finished. The attribute is notified when the mode is
> +		entered/exited so poll(2) on the attribute wakes up.
> +		Entering/exiting a mode will also generate uevent KOBJ_CHANGE.
> +
> +		Valid values: yes, no
> diff --git a/Documentation/ABI/testing/sysfs-bus-typec b/Documentation/ABI/testing/sysfs-bus-typec
> new file mode 100644
> index 000000000000..ead63f97d9a2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-typec
> @@ -0,0 +1,51 @@
> +What:		/sys/bus/typec/devices/.../active
> +Date:		April 2018
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		Shows if the mode is active or not. The attribute can be used
> +		for entering/exiting the mode. Entering/exiting modes is
> +		supported as synchronous operation so write(2) to the attribute
> +		does not return until the enter/exit mode operation has
> +		finished. The attribute is notified when the mode is
> +		entered/exited so poll(2) on the attribute wakes up.
> +		Entering/exiting a mode will also generate uevent KOBJ_CHANGE.
> +
> +		Valid values are boolean.
> +
> +What:		/sys/bus/typec/devices/.../description
> +Date:		April 2018
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		Shows description of the mode. The description is optional for
> +		the drivers, just like with the Billboard Devices.
> +
> +What:		/sys/bus/typec/devices/.../mode
> +Date:		April 2018
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		The index number of the mode returned by Discover Modes USB
> +		Power Delivery command. Depending on the alternate mode, the
> +		mode index may be significant.
> +
> +		With some alternate modes (SVIDs), the mode index is assigned
> +		for specific functionality in the specification for that
> +		alternate mode.
> +
> +		With other alternate modes, the mode index values are not
> +		assigned, and can not be therefore used for identification. When
> +		the mode index is not assigned, identifying the alternate mode
> +		must be done with either mode VDO or the description.
> +
> +What:		/sys/bus/typec/devices/.../svid
> +Date:		April 2018
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		The Standard or Vendor ID (SVID) assigned by USB-IF for this
> +		alternate mode.
> +
> +What:		/sys/bus/typec/devices/.../vdo
> +Date:		April 2018
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		Shows the VDO in hexadecimal returned by Discover Modes command
> +		for this mode.
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 5be552e255e9..d7647b258c3c 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -222,70 +222,12 @@ Description:
>  		available. The value can be polled.
>  
>  
> -Alternate Mode devices.
> +USB Type-C port alternate mode devices.
>  
> -The alternate modes will have Standard or Vendor ID (SVID) assigned by USB-IF.
> -The ports, partners and cable plugs can have alternate modes. A supported SVID
> -will consist of a set of modes. Every SVID a port/partner/plug supports will
> -have a device created for it, and every supported mode for a supported SVID will
> -have its own directory under that device. Below <dev> refers to the device for
> -the alternate mode.
> -
> -What:		/sys/class/typec/<port|partner|cable>/<dev>/svid
> -Date:		April 2017
> -Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> -Description:
> -		The SVID (Standard or Vendor ID) assigned by USB-IF for this
> -		alternate mode.
> -
> -What:		/sys/class/typec/<port|partner|cable>/<dev>/mode<index>/
> -Date:		April 2017
> -Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> -Description:
> -		Every supported mode will have its own directory. The name of
> -		a mode will be "mode<index>" (for example mode1), where <index>
> -		is the actual index to the mode VDO returned by Discover Modes
> -		USB power delivery command.
> -
> -What:		/sys/class/typec/<port|partner|cable>/<dev>/mode<index>/description
> -Date:		April 2017
> -Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> -Description:
> -		Shows description of the mode. The description is optional for
> -		the drivers, just like with the Billboard Devices.
> -
> -What:		/sys/class/typec/<port|partner|cable>/<dev>/mode<index>/vdo
> -Date:		April 2017
> -Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> -Description:
> -		Shows the VDO in hexadecimal returned by Discover Modes command
> -		for this mode.
> -
> -What:		/sys/class/typec/<port|partner|cable>/<dev>/mode<index>/active
> -Date:		April 2017
> -Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> -Description:
> -		Shows if the mode is active or not. The attribute can be used
> -		for entering/exiting the mode with partners and cable plugs, and
> -		with the port alternate modes it can be used for disabling
> -		support for specific alternate modes. Entering/exiting modes is
> -		supported as synchronous operation so write(2) to the attribute
> -		does not return until the enter/exit mode operation has
> -		finished. The attribute is notified when the mode is
> -		entered/exited so poll(2) on the attribute wakes up.
> -		Entering/exiting a mode will also generate uevent KOBJ_CHANGE.
> -
> -		Valid values: yes, no
> -
> -What:		/sys/class/typec/<port>/<dev>/mode<index>/supported_roles
> +What:		/sys/class/typec/<port>/<alt mode>/supported_roles
>  Date:		April 2017
>  Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
>  		Space separated list of the supported roles.
>  
> -		This attribute is available for the devices describing the
> -		alternate modes a port supports, and it will not be exposed with
> -		the devices presenting the alternate modes the partners or cable
> -		plugs support.
> -
>  		Valid values: source, sink
> diff --git a/Documentation/driver-api/usb/typec_bus.rst b/Documentation/driver-api/usb/typec_bus.rst
> new file mode 100644
> index 000000000000..ef3c049a8a7f
> --- /dev/null
> +++ b/Documentation/driver-api/usb/typec_bus.rst
> @@ -0,0 +1,143 @@
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
> +
> +USB Type-C bus allows binding a driver to the discovered partner alternate
> +modes by using the SVID and the mode number.
> +
> +USB Type-C Connector Class provides a device for every alternate mode a port
> +supports, and separate device for every alternate mode the partner supports.
> +The drivers for the alternate modes are bind to the partner alternate mode
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
> +The alternate mode drivers need to register their operation vector in their
> +``->probe`` callback with :c:func:`typec_altmode_register_ops()`. They should
> +be registered before the mode is entered using :c:func:`typec_altmode_enter()`.
> +
> +``->vdm`` is the most important callback in the vector. It will be used to
> +deliver all the SVID specific commands from the partner to the alternate mode
> +driver, and vise versa in case of port drivers. The drivers send the SVID
> +specific commands to each other using :c:func:`typec_altmode_vmd()`.
> +
> +If the communication with the partner using the SVID specific commands results
> +in need to re-configure the pins on the connector, the alternate mode driver
> +needs to notify the bus using :c:func:`typec_altmode_notify()`. The driver
> +passes the negotiated SVID specific pin configuration value to the function as
> +parameter. The bus driver will then configure the mux behind the connector using
> +that value as the state value for the mux, and also call blocking notification
> +chain to notify the external drivers about the state of the connector that need
> +to know it.
> +
> +NOTE: The SVID specific pin configuration values must always start from
> +``TYPEC_STATE_MODAL``. USB Type-C specification defines two default states for
> +the connector: ``TYPEC_STATE_USB`` and ``TYPEC_STATE_SAFE``. USB Type-C
> +Specification also defines two Accessory modes, Audio and Debug:
> +``TYPEC_STATE_AUDIO`` and ``TYPEC_STATE_DEBUG`` These values are reserved by the
> +bus as the four first possible values for the state, and attempts to use them
> +from the alternate mode drivers will result in failure. When the alternate mode
> +is entered, the bus will put the connector into ``TYPEC_STATE_SAFE`` before
> +sending Enter or Exit Mode command as defined in USB Type-C Specification, and
> +also put the connector back to ``TYPEC_STATE_USB`` after the mode has been
> +exited.
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
> +only to the partner alternate mode devices. If the alternate mode supports, or
> +requires, a cable that responds to SOP Prime, and optionally SOP Double Prime
> +messages, the driver for that alternate mode must request handle to the cable
> +plug alternate modes using :c:func:`typec_altmode_get_plug()`, and taking over
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
> +   :functions: typec_altmode_register_ops typec_altmode_enter typec_altmode_exit typec_altmode_attention typec_altmode_vdm typec_altmode_notify
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
> diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> index 1f599a6c30cc..5466c62c8e97 100644
> --- a/drivers/usb/typec/Makefile
> +++ b/drivers/usb/typec/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TYPEC)		+= typec.o
> -typec-y				:= class.o mux.o
> +typec-y				:= class.o mux.o bus.o
>  obj-$(CONFIG_TYPEC_TCPM)	+= tcpm.o
>  obj-y				+= fusb302/
>  obj-$(CONFIG_TYPEC_WCOVE)	+= typec_wcove.o
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> new file mode 100644
> index 000000000000..92944aaf3d6a
> --- /dev/null
> +++ b/drivers/usb/typec/bus.c
> @@ -0,0 +1,421 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * Bus for USB Type-C Alternate Modes
> + *
> + * Copyright (C) 2018 Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + */
> +
> +#include "bus.h"
> +
> +/* -------------------------------------------------------------------------- */
> +/* Common API */
> +
> +/**
> + * typec_altmode_notify - Communication between the OS and alternate mode driver
> + * @adev: Handle to the alternate mode
> + * @conf: Alternate mode specific configuration value
> + * @data: Alternate mode specific data
> + *
> + * The primary purpose for this function is to allow the alternate mode drivers
> + * to tell which pin configuration has been negotiated with the partner. That
> + * information will then be used for example to configure the muxes.
> + * Communication to the other direction is also possible, and low level device
> + * drivers can also send notifications to the alternate mode drivers. The actual
> + * communication will be specific for every SVID.
> + */
> +int typec_altmode_notify(struct typec_altmode *adev,
> +			 unsigned long conf, void *data)
> +{
> +	struct altmode *altmode;
> +	struct altmode *partner;
> +	int ret;
> +
> +	/*
> +	 * All SVID specific configuration values must start from
> +	 * TYPEC_STATE_MODAL. The first values are reserved for the pin states
> +	 * defined in USB Type-C specification: TYPEC_STATE_USB and
> +	 * TYPEC_STATE_SAFE. We'll follow this rule even with modes that do not
> +	 * require pin reconfiguration for the sake of simplicity.
> +	 */
> +	if (conf < TYPEC_STATE_MODAL)
> +		return -EINVAL;
> +
> +	if (!adev)
> +		return 0;
> +
> +	altmode = to_altmode(adev);
> +
> +	if (!altmode->partner)
> +		return -ENODEV;
> +
> +	ret = typec_set_mode(typec_altmode2port(adev), (int)conf);
> +	if (ret)
> +		return ret;
> +
> +	partner = altmode->partner;
> +
> +	blocking_notifier_call_chain(is_typec_port(adev->dev.parent) ?
> +				     &altmode->nh : &partner->nh,
> +				     conf, data);
> +
> +	if (partner->ops && partner->ops->notify)
> +		return partner->ops->notify(&partner->adev, conf, data);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_notify);
> +
> +/**
> + * typec_altmode_enter - Enter Mode
> + * @adev: The alternate mode
> + *
> + * The alternate mode drivers use this function to enter mode. The port drivers
> + * use this to inform the alternate mode drivers that their mode has been
> + * entered successfully.
> + */
> +int typec_altmode_enter(struct typec_altmode *adev)
> +{
> +	struct altmode *partner = to_altmode(adev)->partner;
> +	struct typec_altmode *pdev = &partner->adev;
> +	int ret;
> +
> +	if (is_typec_port(adev->dev.parent)) {
> +		typec_altmode_update_active(pdev, pdev->mode, true);
> +		sysfs_notify(&pdev->dev.kobj, NULL, "active");
> +		goto enter_mode;
> +	}
> +
> +	if (!pdev->active)
> +		return -EPERM;
> +
> +	/* First moving to USB Safe State */
> +	ret = typec_set_mode(typec_altmode2port(adev), TYPEC_STATE_SAFE);
> +	if (ret)
> +		return ret;
> +
> +	blocking_notifier_call_chain(&partner->nh, TYPEC_STATE_SAFE, NULL);
> +
> +enter_mode:
> +	/* Enter Mode command */
> +	if (partner->ops && partner->ops->enter)
> +		partner->ops->enter(pdev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_enter);
> +
> +/**
> + * typec_altmode_enter - Exit Mode

typec_altmode_exit

> + * @adev: The alternate mode
> + *
> + * The alternate mode drivers use this function to exit mode. The port drivers
> + * can also inform the alternate mode drivers with this function that the mode
> + * was successfully exited.
> + */
> +int typec_altmode_exit(struct typec_altmode *adev)
> +{
> +	struct altmode *partner = to_altmode(adev)->partner;
> +	struct typec_port *port = typec_altmode2port(adev);
> +	struct typec_altmode *pdev = &partner->adev;
> +	int ret;
> +
> +	/* In case of port, just calling the driver and exiting */
> +	if (is_typec_port(adev->dev.parent)) {
> +		typec_altmode_update_active(pdev, pdev->mode, false);
> +		sysfs_notify(&pdev->dev.kobj, NULL, "active");
> +
> +		if (partner->ops && partner->ops->exit)
> +			partner->ops->exit(pdev);
> +		return 0;
> +	}
> +
> +	/* Moving to USB Safe State */
> +	ret = typec_set_mode(port, TYPEC_STATE_SAFE);
> +	if (ret)
> +		return ret;
> +
> +	blocking_notifier_call_chain(&partner->nh, TYPEC_STATE_SAFE, NULL);
> +
> +	/* Exit Mode command */
> +	if (partner->ops && partner->ops->exit)
> +		partner->ops->exit(pdev);
> +
> +	/* Back to USB operation */
> +	ret = typec_set_mode(port, TYPEC_STATE_USB);
> +	if (ret)
> +		return ret;
> +
> +	blocking_notifier_call_chain(&partner->nh, TYPEC_STATE_USB, NULL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_exit);
> +
> +/**
> + * typec_altmode_attention - Attention command
> + * @adev: The alternate mode
> + * @vdo: VDO for the Attention command
> + *
> + * Notifies the partner of @adev about Attention command.
> + */
> +void typec_altmode_attention(struct typec_altmode *adev, const u32 vdo)
> +{
> +	struct altmode *partner = to_altmode(adev)->partner;
> +
> +	if (partner && partner->ops && partner->ops->attention)
> +		partner->ops->attention(&partner->adev, vdo);
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_attention);
> +
> +/**
> + * typec_altmode_vdm - Send Vendor Defined Messages (VDM) to the partner
> + * @adev: Alternate mode handle
> + * @header: VDM Header
> + * @vdo: Array of Vendor Defined Data Objects
> + * @count: Number of Data Objects
> + *
> + * The alternate mode drivers use this function for SVID specific communication
> + * with the partner. The port drivers use it to deliver the Structured VDMs
> + * received from the partners to the alternate mode drivers.
> + */
> +int typec_altmode_vdm(struct typec_altmode *adev,
> +		      const u32 header, const u32 *vdo, int count)
> +{
> +	struct altmode *altmode;
> +	struct altmode *partner;
> +
> +	if (!adev)
> +		return 0;
> +
> +	altmode = to_altmode(adev);
> +
> +	if (!altmode->partner)
> +		return -ENODEV;
> +
> +	partner = altmode->partner;
> +
> +	if (partner->ops && partner->ops->vdm)
> +		return partner->ops->vdm(&partner->adev, header, vdo, count);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_vdm);
> +
> +void typec_altmode_register_ops(struct typec_altmode *adev,
> +				const struct typec_altmode_ops *ops)
> +{
> +	to_altmode(adev)->ops = ops;
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_register_ops);
> +
> +/* -------------------------------------------------------------------------- */
> +/* API for the alternate mode drivers */
> +
> +/**
> + * typec_altmode_get_plug - Find cable plug alternate mode
> + * @adev: Handle to partner alternate mode
> + * @index: Cable plug index
> + *
> + * Increment reference count for cable plug alternate mode device. Returns
> + * handle to the cable plug alternate mode, or NULL if none is found.
> + */
> +struct typec_altmode *typec_altmode_get_plug(struct typec_altmode *adev,
> +					     int index)
> +{
> +	struct altmode *port = to_altmode(adev)->partner;
> +
> +	if (port->plug[index]) {
> +		get_device(&port->plug[index]->adev.dev);
> +		return &port->plug[index]->adev;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_get_plug);
> +
> +/**
> + * typec_altmode_get_plug - Decrement cable plug alternate mode reference count

typec_altmode_put_plug

> + * @plug: Handle to the cable plug alternate mode
> + */
> +void typec_altmode_put_plug(struct typec_altmode *plug)
> +{
> +	if (plug)
> +		put_device(&plug->dev);
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_put_plug);
> +
> +int __typec_altmode_register_driver(struct typec_altmode_driver *drv,
> +				    struct module *module)
> +{
> +	if (!drv->probe)
> +		return -EINVAL;
> +
> +	drv->driver.owner = module;
> +	drv->driver.bus = &typec_bus;
> +
> +	return driver_register(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(__typec_altmode_register_driver);
> +
> +void typec_altmode_unregister_driver(struct typec_altmode_driver *drv)
> +{
> +	driver_unregister(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_unregister_driver);
> +
> +/* -------------------------------------------------------------------------- */
> +/* API for the port drivers */
> +
> +bool typec_altmode_ufp_capable(struct typec_altmode *adev)
> +{
> +	struct altmode *altmode = to_altmode(adev);
> +
> +	if (!is_typec_port(adev->dev.parent))
> +		return false;
> +
> +	return !(altmode->roles == TYPEC_PORT_DFP);
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_ufp_capable);
> +
> +bool typec_altmode_dfp_capable(struct typec_altmode *adev)
> +{
> +	struct altmode *altmode = to_altmode(adev);
> +
> +	if (!is_typec_port(adev->dev.parent))
> +		return false;
> +
> +	return !(altmode->roles == TYPEC_PORT_UFP);
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_dfp_capable);
> +
> +/**
> + * typec_match_altmode - Match SVID to an array of alternate modes
> + * @altmodes: Array of alternate modes
> + * @n: Number of elements in the array, or -1 for NULL termiated arrays
> + * @svid: Standard or Vendor ID to match with
> + *
> + * Return pointer to an alternate mode with SVID mathing @svid, or NULL when no
> + * match is found.
> + */
> +struct typec_altmode *typec_match_altmode(struct typec_altmode **altmodes,
> +					  size_t n, u16 svid, u8 mode)
> +{
> +	int i;
> +
> +	for (i = 0; i < n; i++) {
> +		if (!altmodes[i])
> +			break;
> +		if (altmodes[i]->svid == svid && altmodes[i]->mode == mode)
> +			return altmodes[i];
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(typec_match_altmode);
> +
> +/* -------------------------------------------------------------------------- */
> +
> +static ssize_t
> +description_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct typec_altmode *alt = to_typec_altmode(dev);
> +
> +	return sprintf(buf, "%s\n", alt->desc ? alt->desc : "");
> +}
> +static DEVICE_ATTR_RO(description);
> +
> +static struct attribute *typec_attrs[] = {
> +	&dev_attr_description.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(typec);
> +
> +static int typec_match(struct device *dev, struct device_driver *driver)
> +{
> +	struct typec_altmode_driver *drv = to_altmode_driver(driver);
> +	struct typec_altmode *altmode = to_typec_altmode(dev);
> +	const struct typec_device_id *id;
> +
> +	for (id = drv->id_table; id->svid; id++)
> +		if ((id->svid == altmode->svid) &&
> +		    (id->mode == TYPEC_ANY_MODE || id->mode == altmode->mode))
> +			return 1;
> +	return 0;
> +}
> +
> +static int typec_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct typec_altmode *altmode = to_typec_altmode(dev);
> +
> +	if (add_uevent_var(env, "SVID=%04X", altmode->svid))
> +		return -ENOMEM;
> +
> +	if (add_uevent_var(env, "MODE=%u", altmode->mode))
> +		return -ENOMEM;
> +
> +	return add_uevent_var(env, "MODALIAS=typec:id%04Xm%02X",
> +			      altmode->svid, altmode->mode);
> +}
> +
> +static int typec_altmode_create_links(struct altmode *alt)
> +{
> +	struct device *port_dev = &alt->partner->adev.dev;
> +	struct device *dev = &alt->adev.dev;
> +	int err;
> +
> +	err = sysfs_create_link(&dev->kobj, &port_dev->kobj, "port");
> +	if (err)
> +		return err;
> +
> +	err = sysfs_create_link(&port_dev->kobj, &dev->kobj, "partner");
> +	if (err)
> +		sysfs_remove_link(&dev->kobj, "port");
> +
> +	return err;
> +}
> +
> +static int typec_probe(struct device *dev)
> +{
> +	struct typec_altmode_driver *drv = to_altmode_driver(dev->driver);
> +	struct typec_altmode *adev = to_typec_altmode(dev);
> +	struct altmode *altmode = to_altmode(adev);
> +
> +	/* Fail if the port does not support the alternate mode */
> +	if (!altmode->partner)
> +		return -ENODEV;
> +
> +	if (typec_altmode_create_links(altmode))
> +		dev_warn(dev, "failed to create symlinks\n");
> +
> +	return drv->probe(adev, altmode->partner->adev.vdo);
> +}
> +
> +static int typec_remove(struct device *dev)
> +{
> +	struct typec_altmode_driver *drv = to_altmode_driver(dev->driver);
> +	struct typec_altmode *adev = to_typec_altmode(dev);
> +	struct altmode *altmode = to_altmode(adev);
> +
> +	if (!is_typec_port(adev->dev.parent)) {
> +		sysfs_remove_link(&altmode->partner->adev.dev.kobj, "partner");
> +		sysfs_remove_link(&adev->dev.kobj, "port");
> +	}
> +
> +	if (drv->remove)
> +		drv->remove(to_typec_altmode(dev));
> +
> +	if (adev->active)
> +		typec_altmode_exit(adev);
> +
> +	return 0;
> +}
> +
> +struct bus_type typec_bus = {
> +	.name = "typec",
> +	.dev_groups = typec_groups,
> +	.match = typec_match,
> +	.uevent = typec_uevent,
> +	.probe = typec_probe,
> +	.remove = typec_remove,
> +};
> diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
> new file mode 100644
> index 000000000000..38585363952f
> --- /dev/null
> +++ b/drivers/usb/typec/bus.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __USB_TYPEC_ALTMODE_H__
> +#define __USB_TYPEC_ALTMODE_H__
> +
> +#include <linux/usb/typec.h>
> +
> +struct bus_type;
> +
> +struct altmode {
> +	unsigned int			id;
> +	struct typec_altmode		adev;
> +
> +	enum typec_port_data		roles;
> +
> +	struct attribute		*attrs[5];
> +	char				group_name[6];
> +	struct attribute_group		group;
> +	const struct attribute_group	*groups[2];
> +
> +	struct altmode			*partner;
> +	struct altmode			*plug[2];
> +	const struct typec_altmode_ops	*ops;
> +
> +	struct blocking_notifier_head	nh;
> +};
> +
> +#define to_altmode(d) container_of(d, struct altmode, adev)
> +
> +extern struct bus_type typec_bus;
> +extern const struct device_type typec_altmode_dev_type;
> +extern const struct device_type typec_port_dev_type;
> +
> +#define is_typec_altmode(_dev_) (_dev_->type == &typec_altmode_dev_type)
> +#define is_typec_port(_dev_) (_dev_->type == &typec_port_dev_type)
> +
> +#endif /* __USB_TYPEC_ALTMODE_H__ */
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 26eeab1491b7..33fffb853994 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -6,6 +6,7 @@
>   * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>   */
>  
> +#include <linux/connection.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -13,25 +14,12 @@
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_mux.h>
>  
> -struct typec_altmode {
> -	struct device			dev;
> -	u16				svid;
> -	u8				mode;
> -
> -	u32				vdo;
> -	char				*desc;
> -	enum typec_port_type		roles;
> -	unsigned int			active:1;
> -
> -	struct attribute		*attrs[5];
> -	char				group_name[6];
> -	struct attribute_group		group;
> -	const struct attribute_group	*groups[2];
> -};
> +#include "bus.h"
>  
>  struct typec_plug {
>  	struct device			dev;
>  	enum typec_plug_index		index;
> +	struct ida			mode_ids;
>  };
>  
>  struct typec_cable {
> @@ -46,11 +34,13 @@ struct typec_partner {
>  	unsigned int			usb_pd:1;
>  	struct usb_pd_identity		*identity;
>  	enum typec_accessory		accessory;
> +	struct ida			mode_ids;
>  };
>  
>  struct typec_port {
>  	unsigned int			id;
>  	struct device			dev;
> +	struct ida			mode_ids;
>  
>  	int				prefer_role;
>  	enum typec_data_role		data_role;
> @@ -71,17 +61,14 @@ struct typec_port {
>  #define to_typec_plug(_dev_) container_of(_dev_, struct typec_plug, dev)
>  #define to_typec_cable(_dev_) container_of(_dev_, struct typec_cable, dev)
>  #define to_typec_partner(_dev_) container_of(_dev_, struct typec_partner, dev)
> -#define to_altmode(_dev_) container_of(_dev_, struct typec_altmode, dev)
>  
>  static const struct device_type typec_partner_dev_type;
>  static const struct device_type typec_cable_dev_type;
>  static const struct device_type typec_plug_dev_type;
> -static const struct device_type typec_port_dev_type;
>  
>  #define is_typec_partner(_dev_) (_dev_->type == &typec_partner_dev_type)
>  #define is_typec_cable(_dev_) (_dev_->type == &typec_cable_dev_type)
>  #define is_typec_plug(_dev_) (_dev_->type == &typec_plug_dev_type)
> -#define is_typec_port(_dev_) (_dev_->type == &typec_port_dev_type)
>  
>  static DEFINE_IDA(typec_index_ida);
>  static struct class *typec_class;
> @@ -163,27 +150,141 @@ static void typec_report_identity(struct device *dev)
>  /* ------------------------------------------------------------------------- */
>  /* Alternate Modes */
>  
> +static int altmode_match(struct device *dev, void *data)
> +{
> +	struct typec_altmode *adev = to_typec_altmode(dev);
> +	struct typec_device_id *id = data;
> +
> +	if (!is_typec_altmode(dev))
> +		return 0;
> +
> +	return ((adev->svid == id->svid) && (adev->mode == id->mode));
> +}
> +
> +static void typec_altmode_get_partner(struct altmode *altmode)
> +{
> +	struct typec_altmode *adev = &altmode->adev;
> +	struct typec_device_id id = { adev->svid, adev->mode, };
> +	struct typec_port *port = typec_altmode2port(adev);
> +	struct altmode *partner;
> +	struct device *dev;
> +
> +	dev = device_find_child(&port->dev, &id, altmode_match);
> +	if (!dev)
> +		return;
> +
> +	/* Bind the port alt mode to the partner/plug alt mode. */
> +	partner = to_altmode(to_typec_altmode(dev));
> +	altmode->partner = partner;
> +
> +	/* Bind the partner/plug alt mode to the port alt mode. */
> +	if (is_typec_plug(adev->dev.parent)) {
> +		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
> +
> +		partner->plug[plug->index] = altmode;
> +	} else {
> +		partner->partner = altmode;
> +	}
> +}
> +
> +static void typec_altmode_put_partner(struct altmode *altmode)
> +{
> +	struct altmode *partner = altmode->partner;
> +	struct typec_altmode *adev;
> +
> +	if (!partner)
> +		return;
> +
> +	adev = &partner->adev;
> +
> +	if (is_typec_plug(adev->dev.parent)) {
> +		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
> +
> +		partner->plug[plug->index] = NULL;
> +	} else {
> +		partner->partner = NULL;
> +	}
> +	put_device(&adev->dev);
> +}
> +
> +static int __typec_port_match(struct device *dev, const void *name)
> +{
> +	return !strcmp((const char *)name, dev_name(dev));
> +}
> +
> +static void *typec_port_match(struct devcon *con, int ep, void *data)
> +{
> +	return class_find_device(typec_class, NULL, con->endpoint[ep],
> +				 __typec_port_match);
> +}
> +
> +struct typec_altmode *
> +typec_altmode_register_notifier(struct device *dev, u16 svid, u8 mode,
> +				struct notifier_block *nb)
> +{
> +	struct typec_device_id id = { svid, mode, };
> +	struct device *altmode_dev;
> +	struct device *port_dev;
> +	struct altmode *altmode;
> +	int ret;
> +
> +	/* Find the port linked to the caller */
> +	port_dev = __device_find_connection(dev, NULL, NULL, typec_port_match);
> +	if (!port_dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	/* Find the altmode with matching svid */
> +	altmode_dev = device_find_child(port_dev, &id, altmode_match);
> +
> +	put_device(port_dev);
> +
> +	if (!altmode_dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	altmode = to_altmode(to_typec_altmode(altmode_dev));
> +
> +	/* Register notifier */
> +	ret = blocking_notifier_chain_register(&altmode->nh, nb);
> +	if (ret) {
> +		put_device(altmode_dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return &altmode->adev;
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_register_notifier);
> +
> +void typec_altmode_unregister_notifier(struct typec_altmode *adev,
> +				       struct notifier_block *nb)
> +{
> +	struct altmode *altmode = to_altmode(adev);
> +
> +	blocking_notifier_chain_unregister(&altmode->nh, nb);
> +	put_device(&adev->dev);
> +}
> +EXPORT_SYMBOL_GPL(typec_altmode_unregister_notifier);
> +
>  /**
>   * typec_altmode_update_active - Report Enter/Exit mode
> - * @alt: Handle to the alternate mode
> + * @adev: Handle to the alternate mode
>   * @mode: Mode index
>   * @active: True when the mode has been entered
>   *
>   * If a partner or cable plug executes Enter/Exit Mode command successfully, the
>   * drivers use this routine to report the updated state of the mode.
>   */
> -void typec_altmode_update_active(struct typec_altmode *alt, int mode,
> +void typec_altmode_update_active(struct typec_altmode *adev, int mode,
>  				 bool active)
>  {
>  	char dir[6];
>  
> -	if (alt->active == active)
> +	if (adev->active == active)
>  		return;
>  
> -	alt->active = active;
> +	adev->active = active;
>  	snprintf(dir, sizeof(dir), "mode%d", mode);
> -	sysfs_notify(&alt->dev.kobj, dir, "active");
> -	kobject_uevent(&alt->dev.kobj, KOBJ_CHANGE);
> +	sysfs_notify(&adev->dev.kobj, dir, "active");
> +	kobject_uevent(&adev->dev.kobj, KOBJ_CHANGE);
>  }
>  EXPORT_SYMBOL_GPL(typec_altmode_update_active);
>  
> @@ -210,7 +311,7 @@ EXPORT_SYMBOL_GPL(typec_altmode2port);
>  static ssize_t
>  vdo_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	struct typec_altmode *alt = to_altmode(dev);
> +	struct typec_altmode *alt = to_typec_altmode(dev);
>  
>  	return sprintf(buf, "0x%08x\n", alt->vdo);
>  }
> @@ -219,7 +320,7 @@ static DEVICE_ATTR_RO(vdo);
>  static ssize_t
>  description_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	struct typec_altmode *alt = to_altmode(dev);
> +	struct typec_altmode *alt = to_typec_altmode(dev);
>  
>  	return sprintf(buf, "%s\n", alt->desc ? alt->desc : "");
>  }
> @@ -228,28 +329,46 @@ static DEVICE_ATTR_RO(description);
>  static ssize_t
>  active_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	struct typec_altmode *alt = to_altmode(dev);
> +	struct typec_altmode *alt = to_typec_altmode(dev);
>  
>  	return sprintf(buf, "%s\n", alt->active ? "yes" : "no");
>  }
>  
> -static ssize_t
> -active_store(struct device *dev, struct device_attribute *attr,
> -			   const char *buf, size_t size)
> +static ssize_t active_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t size)
>  {
> -	struct typec_altmode *alt = to_altmode(dev);
> -	struct typec_port *port = typec_altmode2port(alt);
> -	bool activate;
> +	struct typec_altmode *adev = to_typec_altmode(dev);
> +	struct typec_port *port = typec_altmode2port(adev);
> +	struct altmode *altmode = to_altmode(adev);
> +	bool enter;
>  	int ret;
>  
>  	if (!port->cap->activate_mode)
>  		return -EOPNOTSUPP;
>  
> -	ret = kstrtobool(buf, &activate);
> +	ret = kstrtobool(buf, &enter);
>  	if (ret)
>  		return ret;
>  
> -	ret = port->cap->activate_mode(port->cap, alt->mode, activate);
> +	if (adev->active == enter)
> +		return size;
> +
> +	if (is_typec_port(adev->dev.parent)) {
> +		typec_altmode_update_active(adev, adev->mode, enter);
> +		sysfs_notify(&adev->dev.kobj, NULL, "active");
> +
> +		if (!altmode->partner)
> +			return size;
> +	} else {
> +		adev = &altmode->partner->adev;
> +
> +		if (!adev->active) {
> +			dev_warn(dev, "port has the mode disabled\n");
> +			return -EPERM;
> +		}
> +	}
> +
> +	ret = port->cap->activate_mode(adev, enter);
>  	if (ret)
>  		return ret;
>  
> @@ -261,7 +380,7 @@ static ssize_t
>  supported_roles_show(struct device *dev, struct device_attribute *attr,
>  		     char *buf)
>  {
> -	struct typec_altmode *alt = to_altmode(dev);
> +	struct altmode *alt = to_altmode(to_typec_altmode(dev));
>  	ssize_t ret;
>  
>  	switch (alt->roles) {
> @@ -280,29 +399,72 @@ supported_roles_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(supported_roles);
>  
> -static void typec_altmode_release(struct device *dev)
> +static ssize_t
> +mode_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	struct typec_altmode *alt = to_altmode(dev);
> +	struct typec_altmode *adev = to_typec_altmode(dev);
>  
> -	kfree(alt);
> +	return sprintf(buf, "%u\n", adev->mode);
>  }
> +static DEVICE_ATTR_RO(mode);
>  
> -static ssize_t svid_show(struct device *dev, struct device_attribute *attr,
> -			 char *buf)
> +static ssize_t
> +svid_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	struct typec_altmode *alt = to_altmode(dev);
> +	struct typec_altmode *adev = to_typec_altmode(dev);
>  
> -	return sprintf(buf, "%04x\n", alt->svid);
> +	return sprintf(buf, "%04x\n", adev->svid);
>  }
>  static DEVICE_ATTR_RO(svid);
>  
>  static struct attribute *typec_altmode_attrs[] = {
> +	&dev_attr_active.attr,
> +	&dev_attr_mode.attr,
>  	&dev_attr_svid.attr,
> +	&dev_attr_vdo.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(typec_altmode);
>  
> -static const struct device_type typec_altmode_dev_type = {
> +static int altmode_id_get(struct device *dev)
> +{
> +	struct ida *ids;
> +
> +	if (is_typec_partner(dev))
> +		ids = &to_typec_partner(dev)->mode_ids;
> +	else if (is_typec_plug(dev))
> +		ids = &to_typec_plug(dev)->mode_ids;
> +	else
> +		ids = &to_typec_port(dev)->mode_ids;
> +
> +	return ida_simple_get(ids, 0, 0, GFP_KERNEL);
> +}
> +
> +static void altmode_id_remove(struct device *dev, int id)
> +{
> +	struct ida *ids;
> +
> +	if (is_typec_partner(dev))
> +		ids = &to_typec_partner(dev)->mode_ids;
> +	else if (is_typec_plug(dev))
> +		ids = &to_typec_plug(dev)->mode_ids;
> +	else
> +		ids = &to_typec_port(dev)->mode_ids;
> +
> +	ida_simple_remove(ids, id);
> +}
> +
> +static void typec_altmode_release(struct device *dev)
> +{
> +	struct altmode *alt = to_altmode(to_typec_altmode(dev));
> +
> +	typec_altmode_put_partner(alt);
> +
> +	altmode_id_remove(alt->adev.dev.parent, alt->id);
> +	kfree(alt);
> +}
> +
> +const struct device_type typec_altmode_dev_type = {
>  	.name = "typec_alternate_mode",
>  	.groups = typec_altmode_groups,
>  	.release = typec_altmode_release,
> @@ -312,58 +474,72 @@ static struct typec_altmode *
>  typec_register_altmode(struct device *parent,
>  		       const struct typec_altmode_desc *desc)
>  {
> -	struct typec_altmode *alt;
> +	unsigned int id = altmode_id_get(parent);
> +	bool is_port = is_typec_port(parent);
> +	struct altmode *alt;
>  	int ret;
>  
>  	alt = kzalloc(sizeof(*alt), GFP_KERNEL);
>  	if (!alt)
>  		return ERR_PTR(-ENOMEM);
>  
> -	alt->svid = desc->svid;
> -	alt->mode = desc->mode;
> -	alt->vdo = desc->vdo;
> +	alt->adev.svid = desc->svid;
> +	alt->adev.mode = desc->mode;
> +	alt->adev.vdo = desc->vdo;
>  	alt->roles = desc->roles;
> +	alt->id = id;
>  
>  	alt->attrs[0] = &dev_attr_vdo.attr;
>  	alt->attrs[1] = &dev_attr_description.attr;
>  	alt->attrs[2] = &dev_attr_active.attr;
>  
> -	if (is_typec_port(parent))
> +	if (is_port) {
>  		alt->attrs[3] = &dev_attr_supported_roles.attr;
> +		alt->adev.active = true; /* Enabled by default */
> +	}
>  
>  	sprintf(alt->group_name, "mode%d", desc->mode);
>  	alt->group.name = alt->group_name;
>  	alt->group.attrs = alt->attrs;
>  	alt->groups[0] = &alt->group;
>  
> -	alt->dev.parent = parent;
> -	alt->dev.groups = alt->groups;
> -	alt->dev.type = &typec_altmode_dev_type;
> -	dev_set_name(&alt->dev, "%s-%04x:%u", dev_name(parent),
> -		     alt->svid, alt->mode);
> +	alt->adev.dev.parent = parent;
> +	alt->adev.dev.groups = alt->groups;
> +	alt->adev.dev.type = &typec_altmode_dev_type;
> +	dev_set_name(&alt->adev.dev, "%s.%u", dev_name(parent), id);
> +
> +	/* Link partners and plugs with the ports */
> +	if (is_port)
> +		BLOCKING_INIT_NOTIFIER_HEAD(&alt->nh);
> +	else
> +		typec_altmode_get_partner(alt);
>  
> -	ret = device_register(&alt->dev);
> +	/* The partners are bind to drivers */
> +	if (is_typec_partner(parent))
> +		alt->adev.dev.bus = &typec_bus;
> +
> +	ret = device_register(&alt->adev.dev);
>  	if (ret) {
>  		dev_err(parent, "failed to register alternate mode (%d)\n",
>  			ret);
> -		put_device(&alt->dev);
> +		put_device(&alt->adev.dev);
>  		return ERR_PTR(ret);
>  	}
>  
> -	return alt;
> +	return &alt->adev;
>  }
>  
>  /**
>   * typec_unregister_altmode - Unregister Alternate Mode
> - * @alt: The alternate mode to be unregistered
> + * @adev: The alternate mode to be unregistered
>   *
>   * Unregister device created with typec_partner_register_altmode(),
>   * typec_plug_register_altmode() or typec_port_register_altmode().
>   */
> -void typec_unregister_altmode(struct typec_altmode *alt)
> +void typec_unregister_altmode(struct typec_altmode *adev)
>  {
> -	if (!IS_ERR_OR_NULL(alt))
> -		device_unregister(&alt->dev);
> +	if (!IS_ERR_OR_NULL(adev))
> +		device_unregister(&adev->dev);
>  }
>  EXPORT_SYMBOL_GPL(typec_unregister_altmode);
>  
> @@ -401,6 +577,7 @@ static void typec_partner_release(struct device *dev)
>  {
>  	struct typec_partner *partner = to_typec_partner(dev);
>  
> +	ida_destroy(&partner->mode_ids);
>  	kfree(partner);
>  }
>  
> @@ -466,6 +643,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
>  	if (!partner)
>  		return ERR_PTR(-ENOMEM);
>  
> +	ida_init(&partner->mode_ids);
>  	partner->usb_pd = desc->usb_pd;
>  	partner->accessory = desc->accessory;
>  
> @@ -514,6 +692,7 @@ static void typec_plug_release(struct device *dev)
>  {
>  	struct typec_plug *plug = to_typec_plug(dev);
>  
> +	ida_destroy(&plug->mode_ids);
>  	kfree(plug);
>  }
>  
> @@ -566,6 +745,7 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
>  
>  	sprintf(name, "plug%d", desc->index);
>  
> +	ida_init(&plug->mode_ids);
>  	plug->index = desc->index;
>  	plug->dev.class = typec_class;
>  	plug->dev.parent = &cable->dev;
> @@ -1080,12 +1260,13 @@ static void typec_release(struct device *dev)
>  	struct typec_port *port = to_typec_port(dev);
>  
>  	ida_simple_remove(&typec_index_ida, port->id);
> +	ida_destroy(&port->mode_ids);
>  	typec_switch_put(port->sw);
>  	typec_mux_put(port->mux);
>  	kfree(port);
>  }
>  
> -static const struct device_type typec_port_dev_type = {
> +const struct device_type typec_port_dev_type = {
>  	.name = "typec_port",
>  	.groups = typec_groups,
>  	.uevent = typec_uevent,
> @@ -1238,6 +1419,8 @@ EXPORT_SYMBOL_GPL(typec_set_mode);
>   * typec_port_register_altmode - Register USB Type-C Port Alternate Mode
>   * @port: USB Type-C Port that supports the alternate mode
>   * @desc: Description of the alternate mode
> + * @ops: Port specific operations for the alternate mode
> + * @drvdata: Private pointer to driver specific info
>   *
>   * This routine is used to register an alternate mode that @port is capable of
>   * supporting.
> @@ -1322,10 +1505,12 @@ struct typec_port *typec_register_port(struct device *parent,
>  		break;
>  	}
>  
> +	ida_init(&port->mode_ids);
> +	mutex_init(&port->port_type_lock);
> +
>  	port->id = id;
>  	port->cap = cap;
>  	port->port_type = cap->type;
> -	mutex_init(&port->port_type_lock);
>  	port->prefer_role = cap->prefer_role;
>  
>  	port->dev.class = typec_class;
> @@ -1369,8 +1554,19 @@ EXPORT_SYMBOL_GPL(typec_unregister_port);
>  
>  static int __init typec_init(void)
>  {
> +	int ret;
> +
> +	ret = bus_register(&typec_bus);
> +	if (ret)
> +		return ret;
> +
>  	typec_class = class_create(THIS_MODULE, "typec");
> -	return PTR_ERR_OR_ZERO(typec_class);
> +	if (IS_ERR(typec_class)) {
> +		bus_unregister(&typec_bus);
> +		return PTR_ERR(typec_class);
> +	}
> +
> +	return 0;
>  }
>  subsys_initcall(typec_init);
>  
> @@ -1378,6 +1574,7 @@ static void __exit typec_exit(void)
>  {
>  	class_destroy(typec_class);
>  	ida_destroy(&typec_index_ida);
> +	bus_unregister(&typec_bus);
>  }
>  module_exit(typec_exit);
>  
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 48fb2b43c35a..17c1a912f524 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -733,4 +733,19 @@ struct tb_service_id {
>  #define TBSVC_MATCH_PROTOCOL_VERSION	0x0004
>  #define TBSVC_MATCH_PROTOCOL_REVISION	0x0008
>  
> +/* USB Type-C Alternate Modes */
> +
> +#define TYPEC_ANY_MODE	0x7
> +
> +/**
> + * struct typec_device_id - USB Type-C alternate mode identifiers
> + * @svid: Standard or Vendor ID
> + * @mode: Mode index
> + */
> +struct typec_device_id {
> +	__u16 svid;
> +	__u8 mode;
> +	kernel_ulong_t driver_data;
> +};
> +
>  #endif /* LINUX_MOD_DEVICETABLE_H */
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 278b6b42c7ea..a19aa3db4272 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -4,16 +4,13 @@
>  #define __LINUX_USB_TYPEC_H
>  
>  #include <linux/types.h>
> -
> -/* XXX: Once we have a header for USB Power Delivery, this belongs there */
> -#define ALTMODE_MAX_MODES	6
> +#include <linux/usb/typec_altmode.h>
>  
>  /* USB Type-C Specification releases */
>  #define USB_TYPEC_REV_1_0	0x100 /* 1.0 */
>  #define USB_TYPEC_REV_1_1	0x110 /* 1.1 */
>  #define USB_TYPEC_REV_1_2	0x120 /* 1.2 */
>  
> -struct typec_altmode;
>  struct typec_partner;
>  struct typec_cable;
>  struct typec_plug;
> @@ -107,7 +104,7 @@ struct typec_altmode_desc {
>  	u8			mode;
>  	u32			vdo;
>  	/* Only used with ports */
> -	enum typec_port_type	roles;
> +	enum typec_port_data	roles;
>  };
>  
>  struct typec_altmode
> @@ -118,7 +115,8 @@ struct typec_altmode
>  			     const struct typec_altmode_desc *desc);
>  struct typec_altmode
>  *typec_port_register_altmode(struct typec_port *port,
> -			     const struct typec_altmode_desc *desc);
> +			    const struct typec_altmode_desc *desc);
> +
>  void typec_unregister_altmode(struct typec_altmode *altmode);
>  
>  struct typec_port *typec_altmode2port(struct typec_altmode *alt);
> @@ -213,12 +211,10 @@ struct typec_capability {
>  				  enum typec_role);
>  	int		(*vconn_set)(const struct typec_capability *,
>  				     enum typec_role);
> -
> -	int		(*activate_mode)(const struct typec_capability *,
> -					 int mode, int activate);
>  	int		(*port_type_set)(const struct typec_capability *,
> -					enum typec_port_type);
> +					 enum typec_port_type);
>  
> +	int		(*activate_mode)(struct typec_altmode *alt, int active);
>  };
>  
>  /* Specific to try_role(). Indicates the user want's to clear the preference. */
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> new file mode 100644
> index 000000000000..bc765352a3c8
> --- /dev/null
> +++ b/include/linux/usb/typec_altmode.h
> @@ -0,0 +1,136 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __USB_TYPEC_ALTMODE_H
> +#define __USB_TYPEC_ALTMODE_H
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +
> +#define MODE_DISCOVERY_MAX	6
> +
> +/**
> + * struct typec_altmode - USB Type-C alternate mode device
> + * @dev: Driver model's view of this device
> + * @svid: Standard or Vendor ID (SVID) of the alternate mode
> + * @mode: Index of the Mode
> + * @vdo: VDO returned by Discover Modes USB PD command
> + * @desc: Optional human readable description of the mode
> + * @active: Tells has the mode been entered or not
> + */
> +struct typec_altmode {
> +	struct device		dev;
> +	u16			svid;
> +	int			mode;
> +	u32			vdo;
> +	char			*desc;
> +	bool			active;
> +} __packed;
> +
> +#define to_typec_altmode(d) container_of(d, struct typec_altmode, dev)
> +
> +static inline void typec_altmode_set_drvdata(struct typec_altmode *altmode,
> +					     void *data)
> +{
> +	dev_set_drvdata(&altmode->dev, data);
> +}
> +
> +static inline void *typec_altmode_get_drvdata(struct typec_altmode *altmode)
> +{
> +	return dev_get_drvdata(&altmode->dev);
> +}
> +
> +/**
> + * struct typec_altmode_ops - Alternate mode specific operations vector
> + * @enter: Operations to be executed with Enter Mode Command
> + * @exit: Operations to be executed with Exit Mode Command
> + * @attention: Callback for Attention Command
> + * @vdm: Callback for SVID specific commands
> + * @notify: Communication channel for platform and the alternate mode
> + */
> +struct typec_altmode_ops {
> +	void (*enter)(struct typec_altmode *altmode);
> +	void (*exit)(struct typec_altmode *altmode);
> +	void (*attention)(struct typec_altmode *altmode, const u32 vdo);
> +	int (*vdm)(struct typec_altmode *altmode, const u32 hdr,
> +		   const u32 *vdo, int cnt);
> +	int (*notify)(struct typec_altmode *altmode, unsigned long conf,
> +		      void *data);
> +};
> +
> +void typec_altmode_register_ops(struct typec_altmode *altmode,
> +				const struct typec_altmode_ops *ops);
> +
> +int typec_altmode_enter(struct typec_altmode *altmode);
> +int typec_altmode_exit(struct typec_altmode *altmode);
> +void typec_altmode_attention(struct typec_altmode *altmode, const u32 vdo);
> +int typec_altmode_vdm(struct typec_altmode *altmode,
> +		      const u32 header, const u32 *vdo, int count);
> +int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
> +			 void *data);
> +
> +/* Return values for type_altmode_vdm() */
> +#define VDM_DONE		0 /* Don't care */
> +#define VDM_OK			1 /* Suits me */
> +
> +/*
> + * These are the pin states (USB, Safe and Alt Mode) and accessory modes (Audio
> + * and Debug) defined in USB Type-C Specification. SVID specific pin states are
> + * expected to follow and start from the value TYPEC_STATE_MODAL.
> + *
> + * Port drivers should use TYPEC_STATE_AUDIO and TYPEC_STATE_DEBUG as the
> + * operation value for typec_set_mode() when accessory modes are in use.
> + *
> + * NOTE: typec_altmode_notify() does not accept values smaller then
> + * TYPEC_STATE_MODAL. USB Type-C bus will follow USB Type-C Specification with
> + * TYPEC_STATE_USB and TYPEC_STATE_SAFE.
> + */
> +enum {
> +	TYPEC_STATE_USB,	/* USB Operation */
> +	TYPEC_STATE_AUDIO,	/* Audio Accessory */
> +	TYPEC_STATE_DEBUG,	/* Debug Accessory */
> +	TYPEC_STATE_SAFE,	/* USB Safe State */
> +	TYPEC_STATE_MODAL,	/* Alternate Modes */
> +};
> +
> +#define TYPEC_MODAL_STATE(_state_)	((_state_) + TYPEC_STATE_MODAL)
> +
> +struct typec_altmode *typec_altmode_get_plug(struct typec_altmode *altmode,
> +					     int index);
> +void typec_altmode_put_plug(struct typec_altmode *plug);
> +
> +bool typec_altmode_ufp_capable(struct typec_altmode *altmode);
> +bool typec_altmode_dfp_capable(struct typec_altmode *altmode);
> +struct typec_altmode *typec_match_altmode(struct typec_altmode **altmodes,
> +					  size_t n, u16 svid, u8 mode);
> +
> +/**
> + * struct typec_altmode_driver - USB Type-C alternate mode device driver
> + * @id_table: Null terminated array of SVIDs
> + * @probe: Callback for device binding
> + * @remove: Callback for device unbinding
> + * @driver: Device driver model driver
> + *
> + * These drivers will be bind to the partner alternate mode devices. They will
> + * handle all SVID specific communication.
> + */
> +struct typec_altmode_driver {
> +	const struct typec_device_id *id_table;
> +	int (*probe)(struct typec_altmode *altmode, u32 port_vdo);
> +	void (*remove)(struct typec_altmode *altmode);
> +	struct device_driver driver;
> +};
> +
> +#define to_altmode_driver(d) container_of(d, struct typec_altmode_driver, \
> +					  driver)
> +
> +#define typec_altmode_register_driver(drv) \
> +		__typec_altmode_register_driver(drv, THIS_MODULE)
> +int __typec_altmode_register_driver(struct typec_altmode_driver *drv,
> +				    struct module *module);
> +void typec_altmode_unregister_driver(struct typec_altmode_driver *drv);
> +
> +#define module_typec_altmode_driver(__typec_altmode_driver) \
> +	module_driver(__typec_altmode_driver, typec_altmode_register_driver, \
> +		      typec_altmode_unregister_driver)
> +
> +#endif /* __USB_TYPEC_ALTMODE_H */
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> index 9fad6afe4c41..c48c7f56ae64 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -218,5 +218,9 @@ int main(void)
>  	DEVID_FIELD(tb_service_id, protocol_version);
>  	DEVID_FIELD(tb_service_id, protocol_revision);
>  
> +	DEVID(typec_device_id);
> +	DEVID_FIELD(typec_device_id, svid);
> +	DEVID_FIELD(typec_device_id, mode);
> +
>  	return 0;
>  }
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index b9beeaa4695b..a8afba836409 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1341,6 +1341,19 @@ static int do_tbsvc_entry(const char *filename, void *symval, char *alias)
>  }
>  ADD_TO_DEVTABLE("tbsvc", tb_service_id, do_tbsvc_entry);
>  
> +/* Looks like: typec:idNmN */
> +static int do_typec_entry(const char *filename, void *symval, char *alias)
> +{
> +	DEF_FIELD(symval, typec_device_id, svid);
> +	DEF_FIELD(symval, typec_device_id, mode);
> +
> +	sprintf(alias, "typec:id%04X", svid);
> +	ADD(alias, "m", mode != TYPEC_ANY_MODE, mode);
> +
> +	return 1;
> +}
> +ADD_TO_DEVTABLE("typec", typec_device_id, do_typec_entry);
> +
>  /* Does namelen bytes of name exactly match the symbol? */
>  static bool sym_is(const char *name, unsigned namelen, const char *symbol)
>  {
> -- 
> 2.16.1
> 
