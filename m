Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2640480-1521459780-4-3616511958925404213
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521459779; b=GVRrhQep2gWzK92BU/CwWnUaYMpLkwTGLMWGTE7KKRmeGKz
    asfr3h48y4C+rtirwVXvpvTmYutuNHNrBoItRayf9itYCZtqzKT//hXL4Ro8n3/Q
    NurKfngh2Xpm7x2mutOVFfiEMszrp5lLzy3lhy5lA9PDvnMO3P8GJp46lxL48JWE
    TvxU/rSrhOwcHzqNjsXLQaaPnuS0ewpe76JCOCtYyUQCxPd6Cqc9BRrjZj6J53I9
    wAJfF/aisQ8yTpmj/1g7g7J2wewPcr6/qVYEcwbJX+c6+yGIPDPcuhlgW3fxHGyw
    iK+iOPQ/cCUsq1qmAXhysWW7+3YcRLDhrtoOsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521459779; bh=mkIwpgVHfd8hi0vnSoTNqAsDJq
    Nvk4yXGvjg9al7HfA=; b=DapmubrCBnlqXXVLIcYXB0xW1LR7rsM3KY8ZDccwTQ
    nW2iY9L0Na8oQAC/RUr14GCyF1XQfnwzjP2jpHbcs59ryv2nA42wA1SMmrDjqYYc
    r6qNhlVIdsOBjQR13kyGTpZWzQmbBC1W4M1Dpx7dnTcRk5vYHVejsOte/nKJ7OE2
    1+bpXiJHySje9GWQLlgdQZevdU7Upl5Bx9sgxmiewYMWt6BgDW2K0Gt/ObQNq8cA
    7nwlcID8FEqH5UKFbZyNAohgt/dSiDHcJnF/ummaAgUE3+QVsxJQmkuTRqvyiKJ7
    11dFRXj2vVeeJ6YjOakuxvGplBmLI0lkddKUH4pKqfAw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddvleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttddttddtredvnecuhfhrohhmpefjvghikhhkihcumfhrohhgvghruhhsuceohhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdduledvrdehhedrhedvrdegfeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtheelgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddvleculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttddttddtredvnecuhfhrohhmpefjvghikhhkihcumfhrohhgvghruhhsuceohhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdduledvrdehhedrhedvrdegfeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepuddtheelgeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755451AbeCSLmo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 07:42:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:35340 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755299AbeCSLmn (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 19 Mar 2018 07:42:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="scan'208";a="39216826"
Date: Mon, 19 Mar 2018 13:42:37 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] usb: typec: Bus type for alternate modes
Message-ID: <20180319114237.GG11689@kuha.fi.intel.com>
References: <20180309151918.22048-1-heikki.krogerus@linux.intel.com>
 <20180309151918.22048-3-heikki.krogerus@linux.intel.com>
 <20180316213336.GA11002@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316213336.GA11002@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Guenter,

On Fri, Mar 16, 2018 at 02:33:36PM -0700, Guenter Roeck wrote:
> On Fri, Mar 09, 2018 at 06:19:17PM +0300, Heikki Krogerus wrote:
> > diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> > new file mode 100644
> > index 000000000000..92944aaf3d6a
> > --- /dev/null
> > +++ b/drivers/usb/typec/bus.c
> > @@ -0,0 +1,421 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/**
> > + * Bus for USB Type-C Alternate Modes
> > + *
> > + * Copyright (C) 2018 Intel Corporation
> > + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > + */
> > +
> > +#include "bus.h"
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Common API */
> > +
> > +/**
> > + * typec_altmode_notify - Communication between the OS and alternate mode driver
> > + * @adev: Handle to the alternate mode
> > + * @conf: Alternate mode specific configuration value
> > + * @data: Alternate mode specific data
> > + *
> > + * The primary purpose for this function is to allow the alternate mode drivers
> > + * to tell which pin configuration has been negotiated with the partner. That
> > + * information will then be used for example to configure the muxes.
> > + * Communication to the other direction is also possible, and low level device
> > + * drivers can also send notifications to the alternate mode drivers. The actual
> > + * communication will be specific for every SVID.
> > + */
> > +int typec_altmode_notify(struct typec_altmode *adev,
> > +			 unsigned long conf, void *data)
> > +{
> > +	struct altmode *altmode;
> > +	struct altmode *partner;
> > +	int ret;
> > +
> > +	/*
> > +	 * All SVID specific configuration values must start from
> > +	 * TYPEC_STATE_MODAL. The first values are reserved for the pin states
> > +	 * defined in USB Type-C specification: TYPEC_STATE_USB and
> > +	 * TYPEC_STATE_SAFE. We'll follow this rule even with modes that do not
> > +	 * require pin reconfiguration for the sake of simplicity.
> > +	 */
> > +	if (conf < TYPEC_STATE_MODAL)
> > +		return -EINVAL;
> > +
> > +	if (!adev)
> > +		return 0;
> > +
> > +	altmode = to_altmode(adev);
> > +
> > +	if (!altmode->partner)
> > +		return -ENODEV;
> > +
> > +	ret = typec_set_mode(typec_altmode2port(adev), (int)conf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	partner = altmode->partner;
> > +
> > +	blocking_notifier_call_chain(is_typec_port(adev->dev.parent) ?
> > +				     &altmode->nh : &partner->nh,
> > +				     conf, data);
> > +
> > +	if (partner->ops && partner->ops->notify)
> > +		return partner->ops->notify(&partner->adev, conf, data);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(typec_altmode_notify);
> > +
> > +/**
> > + * typec_altmode_enter - Enter Mode
> > + * @adev: The alternate mode
> > + *
> > + * The alternate mode drivers use this function to enter mode. The port drivers
> > + * use this to inform the alternate mode drivers that their mode has been
> > + * entered successfully.
> > + */
> > +int typec_altmode_enter(struct typec_altmode *adev)
> > +{
> > +	struct altmode *partner = to_altmode(adev)->partner;
> > +	struct typec_altmode *pdev = &partner->adev;
> > +	int ret;
> > +
> > +	if (is_typec_port(adev->dev.parent)) {
> > +		typec_altmode_update_active(pdev, pdev->mode, true);
> > +		sysfs_notify(&pdev->dev.kobj, NULL, "active");
> > +		goto enter_mode;
> > +	}
> > +
> > +	if (!pdev->active)
> > +		return -EPERM;
> > +
> > +	/* First moving to USB Safe State */
> > +	ret = typec_set_mode(typec_altmode2port(adev), TYPEC_STATE_SAFE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	blocking_notifier_call_chain(&partner->nh, TYPEC_STATE_SAFE, NULL);
> > +
> > +enter_mode:
> > +	/* Enter Mode command */
> > +	if (partner->ops && partner->ops->enter)
> > +		partner->ops->enter(pdev);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(typec_altmode_enter);
> > +
> > +/**
> > + * typec_altmode_enter - Exit Mode
> 
> typec_altmode_exit

Yes.

> > + * @adev: The alternate mode
> > + *
> > + * The alternate mode drivers use this function to exit mode. The port drivers
> > + * can also inform the alternate mode drivers with this function that the mode
> > + * was successfully exited.
> > + */
> > +int typec_altmode_exit(struct typec_altmode *adev)
> > +{
> > +	struct altmode *partner = to_altmode(adev)->partner;
> > +	struct typec_port *port = typec_altmode2port(adev);
> > +	struct typec_altmode *pdev = &partner->adev;
> > +	int ret;
> > +
> > +	/* In case of port, just calling the driver and exiting */
> > +	if (is_typec_port(adev->dev.parent)) {
> > +		typec_altmode_update_active(pdev, pdev->mode, false);
> > +		sysfs_notify(&pdev->dev.kobj, NULL, "active");
> > +
> > +		if (partner->ops && partner->ops->exit)
> > +			partner->ops->exit(pdev);
> > +		return 0;
> > +	}
> > +
> > +	/* Moving to USB Safe State */
> > +	ret = typec_set_mode(port, TYPEC_STATE_SAFE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	blocking_notifier_call_chain(&partner->nh, TYPEC_STATE_SAFE, NULL);
> > +
> > +	/* Exit Mode command */
> > +	if (partner->ops && partner->ops->exit)
> > +		partner->ops->exit(pdev);
> > +
> > +	/* Back to USB operation */
> > +	ret = typec_set_mode(port, TYPEC_STATE_USB);
> > +	if (ret)
> > +		return ret;
> > +
> > +	blocking_notifier_call_chain(&partner->nh, TYPEC_STATE_USB, NULL);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(typec_altmode_exit);
> > +
> > +/**
> > + * typec_altmode_attention - Attention command
> > + * @adev: The alternate mode
> > + * @vdo: VDO for the Attention command
> > + *
> > + * Notifies the partner of @adev about Attention command.
> > + */
> > +void typec_altmode_attention(struct typec_altmode *adev, const u32 vdo)
> > +{
> > +	struct altmode *partner = to_altmode(adev)->partner;
> > +
> > +	if (partner && partner->ops && partner->ops->attention)
> > +		partner->ops->attention(&partner->adev, vdo);
> > +}
> > +EXPORT_SYMBOL_GPL(typec_altmode_attention);
> > +
> > +/**
> > + * typec_altmode_vdm - Send Vendor Defined Messages (VDM) to the partner
> > + * @adev: Alternate mode handle
> > + * @header: VDM Header
> > + * @vdo: Array of Vendor Defined Data Objects
> > + * @count: Number of Data Objects
> > + *
> > + * The alternate mode drivers use this function for SVID specific communication
> > + * with the partner. The port drivers use it to deliver the Structured VDMs
> > + * received from the partners to the alternate mode drivers.
> > + */
> > +int typec_altmode_vdm(struct typec_altmode *adev,
> > +		      const u32 header, const u32 *vdo, int count)
> > +{
> > +	struct altmode *altmode;
> > +	struct altmode *partner;
> > +
> > +	if (!adev)
> > +		return 0;
> > +
> > +	altmode = to_altmode(adev);
> > +
> > +	if (!altmode->partner)
> > +		return -ENODEV;
> > +
> > +	partner = altmode->partner;
> > +
> > +	if (partner->ops && partner->ops->vdm)
> > +		return partner->ops->vdm(&partner->adev, header, vdo, count);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(typec_altmode_vdm);
> > +
> > +void typec_altmode_register_ops(struct typec_altmode *adev,
> > +				const struct typec_altmode_ops *ops)
> > +{
> > +	to_altmode(adev)->ops = ops;
> > +}
> > +EXPORT_SYMBOL_GPL(typec_altmode_register_ops);
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* API for the alternate mode drivers */
> > +
> > +/**
> > + * typec_altmode_get_plug - Find cable plug alternate mode
> > + * @adev: Handle to partner alternate mode
> > + * @index: Cable plug index
> > + *
> > + * Increment reference count for cable plug alternate mode device. Returns
> > + * handle to the cable plug alternate mode, or NULL if none is found.
> > + */
> > +struct typec_altmode *typec_altmode_get_plug(struct typec_altmode *adev,
> > +					     int index)
> > +{
> > +	struct altmode *port = to_altmode(adev)->partner;
> > +
> > +	if (port->plug[index]) {
> > +		get_device(&port->plug[index]->adev.dev);
> > +		return &port->plug[index]->adev;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(typec_altmode_get_plug);
> > +
> > +/**
> > + * typec_altmode_get_plug - Decrement cable plug alternate mode reference count
> 
> typec_altmode_put_plug

Yes.


Thanks,

-- 
heikki
