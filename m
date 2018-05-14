Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616870-1526294575-2-7864108213699703873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526294574; b=Wea6d8xIDkwb9Asw7wDgFx4K79VAtUPEd1vbaV+yFEb7oasx+Z
    /iFiEZZ8gjLQuloB72UfChGTIphVG/ki/HqgT1mZ+EoDmimly2ra5DvElq9u9MUs
    Cp2Agfh82SvPr78kPIwicU3R/+wH2HUcNzXPdjk39KUDOsc2TP2A14HfFybjbx6z
    uCM4i/3N7p4TnROrmZMkjLE9DVUcble7tnt2NTUt9d94i1ZjCpt64IifqDukul8R
    1bejAKKxyK2HzObJyW0Sfr8QR21kMeN6oZpVJNOF4gax+6aHc1lg/eFHEGk4h0cn
    2zu0L5QNhkTuShmvfS78FxUcYUctIdQ6NR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526294574; bh=ndroQkMsJfbxaBBEXh/Wn9BGO96Uv9
    NW+h/LuFMoEUA=; b=AxPDJwHcC/V5SDkz4XwJYiBX3T8+lRyLMVGftoWzOh/8KH
    ACigo48csjy80CvNDPR0pfbyOPyR+KnPhRnMHyPs0GL7KbsJmBka3NhZPrhtNz9e
    Pgjtxv0WEHTkjR/igbauBStfRtR8A97vaWxaLoay1AG8eHVuMGlCUXS9mBmx2eqN
    nr7lTZDQQv7dxqBiJLmAPZO5mNxonf5JSzOHsgDPn/PaORbY+7yHnArLG2jFSvhp
    jDnAYBxQBtotM7nijWK1VbrsBDK8u1+ic2j8f7oAnS8wBZfW1k0sB9n+dAAc3slD
    VftNqLw1pXlRo+N2YPNCpiGmhf6r0dIN4Wwv0UEw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE/rlXtSW8usNXIQs0yK8x2IKUzO+s/3rCBneNJBmqIdlfzGjzLriIYn4w+62yYYn4hGAStQI5MABf+A7eGOn3YfLKH4j4sGK1bvMrDlqlyDE0VURLjf
    WfES/UDsDSvJe7JZjwysFbBooryORP+w72Y+wY7V2KCcqYgeGWl3n441nt9ElscVxYST1OyDRRIHmIzDdfKfa+GUDkVEc4dzHMIUr5MQqNYXf6fMN+VPXj6R
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Eoh472Lwl9tlTL_o2kYA:9
    a=gKeDeizPH2wjtHkS:21 a=D4A5EtING5JqbB5h:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeENKml (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 06:42:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:30943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbeENKmj (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 14 May 2018 06:42:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="54982999"
Date: Mon, 14 May 2018 13:42:34 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 3/5] usb: typec: Bus type for alternate modes
Message-ID: <20180514104234.GC21435@kuha.fi.intel.com>
References: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
 <20180511131838.62064-4-heikki.krogerus@linux.intel.com>
 <7a23768d-9a50-b9ba-bc76-d3168eee930e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a23768d-9a50-b9ba-bc76-d3168eee930e@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 12, 2018 at 06:25:09PM -0700, Randy Dunlap wrote:
> On 05/11/2018 06:18 AM, Heikki Krogerus wrote:
> > Introducing a simple bus for the alternate modes. Bus allows
> > binding drivers to the discovered alternate modes the
> > partners support.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  Documentation/ABI/obsolete/sysfs-class-typec |  48 +++
> >  Documentation/ABI/testing/sysfs-bus-typec    |  51 +++
> >  Documentation/ABI/testing/sysfs-class-typec  |  62 +--
> >  Documentation/driver-api/usb/typec_bus.rst   | 136 ++++++
> >  drivers/usb/typec/Makefile                   |   2 +-
> >  drivers/usb/typec/bus.c                      | 423 +++++++++++++++++++
> >  drivers/usb/typec/bus.h                      |  38 ++
> >  drivers/usb/typec/class.c                    | 364 ++++++++++++----
> >  include/linux/mod_devicetable.h              |  15 +
> >  include/linux/usb/typec.h                    |  14 +-
> >  include/linux/usb/typec_altmode.h            | 142 +++++++
> >  scripts/mod/devicetable-offsets.c            |   4 +
> >  scripts/mod/file2alias.c                     |  13 +
> >  13 files changed, 1168 insertions(+), 144 deletions(-)
> >  create mode 100644 Documentation/ABI/obsolete/sysfs-class-typec
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-typec
> >  create mode 100644 Documentation/driver-api/usb/typec_bus.rst
> >  create mode 100644 drivers/usb/typec/bus.c
> >  create mode 100644 drivers/usb/typec/bus.h
> >  create mode 100644 include/linux/usb/typec_altmode.h
> 
> Hi,
> I have a few doc corrections for you.

Thanks, I'll fix all of them as you proposed.

> > diff --git a/Documentation/driver-api/usb/typec_bus.rst b/Documentation/driver-api/usb/typec_bus.rst
> > new file mode 100644
> > index 000000000000..4184e0925567
> > --- /dev/null
> > +++ b/Documentation/driver-api/usb/typec_bus.rst
> > @@ -0,0 +1,136 @@
> > +
> > +API for USB Type-C Alternate Mode drivers
> > +=========================================
> > +
> > +Introduction
> > +------------
> > +
> > +Alternate modes require communication with the partner using Vendor Defined
> > +Messages (VDM) as defined in USB Type-C and USB Power Delivery Specifications.
> > +The communication is SVID (Standard or Vendor ID) specific, i.e. specific for
> > +every alternate mode, so every alternate mode will need custom driver.
> 
>                                                            a custom driver.
> 
> > +
> > +USB Type-C bus allows binding a driver to the discovered partner alternate
> > +modes by using the SVID and the mode number.
> > +
> > +USB Type-C Connector Class provides a device for every alternate mode a port
> > +supports, and separate device for every alternate mode the partner supports.
> > +The drivers for the alternate modes are bind to the partner alternate mode
> 
>                                        are bound
> or just:                               bind
> 
> > +devices, and the port alternate mode devices must be handled by the port
> > +drivers.
> > +
> > +When a new partner alternate mode device is registered, it is linked to the
> > +alternate mode device of the port that the partner is attached to, that has
> > +matching SVID and mode. Communication between the port driver and alternate mode
> > +driver will happen using the same API.
> > +
> > +The port alternate mode devices are used as a proxy between the partner and the
> > +alternate mode drivers, so the port drivers are only expected to pass the SVID
> > +specific commands from the alternate mode drivers to the partner, and from the
> > +partners to the alternate mode drivers. No direct SVID specific communication is
> > +needed from the port drivers, but the port drivers need to provide the operation
> > +callbacks for the port alternate mode devices, just like the alternate mode
> > +drivers need to provide them for the partner alternate mode devices.
> > +
> > +Usage:
> > +------
> > +
> > +General
> > +~~~~~~~
> > +
> > +By default, the alternate mode drivers are responsible for entering the mode.
> > +It is also possible to leave the decision about entering the mode to the user
> > +space (See Documentation/ABI/testing/sysfs-class-typec). Port drivers should not
> > +enter any modes on their own.
> > +
> > +``->vdm`` is the most important callback in the vector. It will be used to
> > +deliver all the SVID specific commands from the partner to the alternate mode
> > +driver, and vise versa in case of port drivers. The drivers send the SVID
> 
>                vice versa
> 
> > +specific commands to each other using :c:func:`typec_altmode_vmd()`.
> > +
> > +If the communication with the partner using the SVID specific commands results
> > +in need to re-configure the pins on the connector, the alternate mode driver
> 
>               reconfigure
> 
> > +needs to notify the bus using :c:func:`typec_altmode_notify()`. The driver
> > +passes the negotiated SVID specific pin configuration value to the function as
> > +parameter. The bus driver will then configure the mux behind the connector using
> > +that value as the state value for the mux, and also call blocking notification
> > +chain to notify the external drivers about the state of the connector that need
> > +to know it.
> > +
> > +NOTE: The SVID specific pin configuration values must always start from
> > +``TYPEC_STATE_MODAL``. USB Type-C specification defines two default states for
> > +the connector: ``TYPEC_STATE_USB`` and ``TYPEC_STATE_SAFE``. These values are
> > +reserved by the bus as the first possible values for the state. When the
> > +alternate mode is entered, the bus will put the connector into
> > +``TYPEC_STATE_SAFE`` before sending Enter or Exit Mode command as defined in USB
> > +Type-C Specification, and also put the connector back to ``TYPEC_STATE_USB``
> > +after the mode has been exited.
> > +
> > +An example of working definitions for SVID specific pin configurations would
> > +look like this:
> > +
> > +enum {
> > +	ALTMODEX_CONF_A = TYPEC_STATE_MODAL,
> > +	ALTMODEX_CONF_B,
> > +	...
> > +};
> > +
> > +Helper macro ``TYPEC_MODAL_STATE()`` can also be used:
> > +
> > +#define ALTMODEX_CONF_A = TYPEC_MODAL_STATE(0);
> > +#define ALTMODEX_CONF_B = TYPEC_MODAL_STATE(1);
> > +
> > +Notification chain
> > +~~~~~~~~~~~~~~~~~~
> > +
> > +The drivers for the components that the alternate modes are designed for need to
> > +get details regarding the results of the negotiation with the partner, and the
> > +pin configuration of the connector. In case of DisplayPort alternate mode for
> > +example, the GPU drivers will need to know those details. In case of
> > +Thunderbolt alternate mode, the thunderbolt drivers will need to know them, and
> > +so on.
> > +
> > +The notification chain is designed for this purpose. The drivers can register
> > +notifiers with :c:func:`typec_altmode_register_notifier()`.
> > +
> > +Cable plug alternate modes
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The alternate mode drivers are not bind to cable plug alternate mode devices,
> 
>                               are not bound
> 
> > +only to the partner alternate mode devices. If the alternate mode supports, or
> > +requires, a cable that responds to SOP Prime, and optionally SOP Double Prime
> > +messages, the driver for that alternate mode must request handle to the cable
> > +plug alternate modes using :c:func:`typec_altmode_get_plug()`, and taking over
> 
>                                                                   and take over
> 
> > +their control.
> > +
> > +Driver API
> > +----------
> > +
> > +Alternate mode driver registering/unregistering
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. kernel-doc:: drivers/usb/typec/bus.c
> > +   :functions: typec_altmode_register_driver typec_altmode_unregister_driver
> > +
> > +Alternate mode driver operations
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. kernel-doc:: drivers/usb/typec/bus.c
> > +   :functions: typec_altmode_enter typec_altmode_exit typec_altmode_attention typec_altmode_vdm typec_altmode_notify
> > +
> > +API for the port drivers
> > +~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. kernel-doc:: drivers/usb/typec/bus.c
> > +   :functions: typec_match_altmode
> > +
> > +Cable Plug operations
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +.. kernel-doc:: drivers/usb/typec/bus.c
> > +   :functions: typec_altmode_get_plug typec_altmode_put_plug
> > +
> > +Notifications
> > +~~~~~~~~~~~~~
> > +.. kernel-doc:: drivers/usb/typec/class.c
> > +   :functions: typec_altmode_register_notifier typec_altmode_unregister_notifier


Thanks,

-- 
heikki
