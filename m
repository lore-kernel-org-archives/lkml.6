Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3021914-1524574043-2-18266961814532309530
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524574042; b=Svz27RgOwHLuPQYy5ON9J0jBofQmo3DC/zIpn93g0bzayyIU7y
    2YjvQzFRQcbE0AIhi08C99BUiAq68UX6N+fEzjQ75fQSJuYUFS1tnOVAueWirikv
    FXdAvZn5nMm7z/48JuuWJN7g3lxaYdA4kzHkHkX5YhF4ttSYqDn7S/08bGgRJJ1/
    owBoEg3oCSGDlCsaVLpqQfaenzyvOL3jj1K9No3D5LxrU3uqrmrUS/fJzug4KaSG
    gmM7RKF1fleCsb5DYFCZvcqLPVMswovRAbi/QyBfZZAx4TWVfWqINqsFLo9ECh0g
    Xm946dTnxwiwpHkuvInTQW8v3zwq6Q2vYKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524574042; bh=LeA3alL3ZnYqRqQwUw2bgPCqwkgSHx
    zIS0QjD3Y0eAk=; b=mAgwonKGp6+O9GZr/ZugW2F6/JjCXETQBxJKusPX5piZ1X
    vu7Ek7xsdmrYrabfVCZKpkORv863HzahlirA1sP+zRPjind7pYGxkDZ/J08eUMEp
    iWb7OKKjCPZQLpy7xdbIPB0m/pvc3glGlRzf6o9Mry62mLkM6dorPW81KtYTJ28O
    knnUJCiuIa3MAWl+++gAFqSFqUue8IflYyGyqQgRUNSwplceAst/mxXD2vVqyGk5
    UVHk/FGKTZmvKTyDOIhIqInlFis+4wIGm4gWSTYQDyKWt5umuUYr6Io9+GuUHLW5
    PrryPBh4CFfRllCEI+IzUHI+O7XQxuGD2JuOsORg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDus2fB27oooDnMTcVs2bX9fEGKNC0vsiDuTYyC2X5SOKgOc3o1rp07deCQzZIAz5RAGtdKrBImZ1hKR3KkwT93zIT5Htg8Lt9+L1LMzldjBKu3vpZyf
    aiVMN1UOP8r1tIAZZZr112zqbSx9n5zSKw6ZzeliPH7PIVawetMfOKlQBraoQ6+x5Ma2mrMOHi/aIe80kVud9naiYOjbA5H3PK4N92AjDKcyrv1LTNjVNDLG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=8eAF7N-IxLA0nCDghUoA:9
    a=M2jAZWLrBn7CPHyj:21 a=lPTVjhLeC9vJCjLT:21 a=CjuIK1q_8ugA:10
    a=d24Ss_oZLtcA:10 a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933146AbeDXMrN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 08:47:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:3527 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933110AbeDXMqo (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 24 Apr 2018 08:46:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="49491238"
Date: Tue, 24 Apr 2018 15:46:39 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v8 4/6] power: supply: Add 'usb_type' property and
 supporting code
Message-ID: <20180424124639.GF25723@kuha.fi.intel.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
 <36488aeca4c870e24ddbcf8bc9d3064c9973413f.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36488aeca4c870e24ddbcf8bc9d3064c9973413f.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 03:10:59PM +0100, Adam Thomson wrote:
> This commit adds the 'usb_type' property to represent USB supplies
> which can report a number of different types based on a connection
> event.
> 
> Examples of this already exist in drivers whereby the existing 'type'
> property is updated, based on an event, to represent what was
> connected (e.g. USB, USB_DCP, USB_ACA, ...). Current implementations
> however don't show all supported connectable types, so this knowledge
> has to be exlicitly known for each driver that supports this.
> 
> The 'usb_type' property is intended to fill this void and show users
> all possible USB types supported by a driver. The property, when read,
> shows all available types for the driver, and the one currently chosen
> is highlighted/bracketed. It is expected that the 'type' property
> would then just show the top-level type 'USB', and this would be
> static.
> 
> Currently the 'usb_type' enum contains all of the USB variant types
> that exist for the 'type' enum at this time, and in addition has
> SDP and PPS types. The mirroring is intentional so as to not impact
> existing usage of the 'type' property.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  Documentation/ABI/testing/sysfs-class-power | 12 ++++++++
>  drivers/power/supply/power_supply_core.c    |  8 ++++-
>  drivers/power/supply/power_supply_sysfs.c   | 45 +++++++++++++++++++++++++++++
>  include/linux/power_supply.h                | 16 ++++++++++
>  4 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index e046566..5e23e22 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -409,6 +409,18 @@ Description:
>  		Access: Read
>  		Valid values: Represented in 1/10 Degrees Celsius
>  
> +What: 		/sys/class/power_supply/<supply_name>/usb_type
> +Date:		March 2018
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports what type of USB connection is currently active for
> +		the supply, for example it can show if USB-PD capable source
> +		is attached.
> +
> +		Access: Read-Only
> +		Valid values: "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
> +			      "PD_DRP", "PD_PPS", "BrickID"
> +
>  What: 		/sys/class/power_supply/<supply_name>/voltage_max
>  Date:		January 2008
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index a7984af..ecd68c2 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -843,7 +843,7 @@ static void psy_unregister_cooler(struct power_supply *psy)
>  {
>  	struct device *dev;
>  	struct power_supply *psy;
> -	int rc;
> +	int i, rc;
>  
>  	if (!parent)
>  		pr_warn("%s: Expected proper parent device for '%s'\n",
> @@ -852,6 +852,12 @@ static void psy_unregister_cooler(struct power_supply *psy)
>  	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
>  		return ERR_PTR(-EINVAL);
>  
> +	for (i = 0; i < desc->num_properties; ++i) {
> +		if ((desc->properties[i] == POWER_SUPPLY_PROP_USB_TYPE) &&
> +		    (!desc->usb_types || !desc->num_usb_types))
> +			return ERR_PTR(-EINVAL);
> +	}
> +
>  	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
>  	if (!psy)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 5204f11..1350068 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -46,6 +46,11 @@
>  	"USB_PD", "USB_PD_DRP", "BrickID"
>  };
>  
> +static const char * const power_supply_usb_type_text[] = {
> +	"Unknown", "SDP", "DCP", "CDP", "ACA", "C",
> +	"PD", "PD_DRP", "PD_PPS", "BrickID"
> +};
> +
>  static const char * const power_supply_status_text[] = {
>  	"Unknown", "Charging", "Discharging", "Not charging", "Full"
>  };
> @@ -73,6 +78,41 @@
>  	"Unknown", "System", "Device"
>  };
>  
> +static ssize_t power_supply_show_usb_type(struct device *dev,
> +					  enum power_supply_usb_type *usb_types,
> +					  ssize_t num_usb_types,
> +					  union power_supply_propval *value,
> +					  char *buf)
> +{
> +	enum power_supply_usb_type usb_type;
> +	ssize_t count = 0;
> +	bool match = false;
> +	int i;
> +
> +	for (i = 0; i < num_usb_types; ++i) {
> +		usb_type = usb_types[i];
> +
> +		if (value->intval == usb_type) {
> +			count += sprintf(buf + count, "[%s] ",
> +					 power_supply_usb_type_text[usb_type]);
> +			match = true;
> +		} else {
> +			count += sprintf(buf + count, "%s ",
> +					 power_supply_usb_type_text[usb_type]);
> +		}
> +	}
> +
> +	if (!match) {
> +		dev_warn(dev, "driver reporting unsupported connected type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (count)
> +		buf[count - 1] = '\n';
> +
> +	return count;
> +}
> +
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf) {
> @@ -115,6 +155,10 @@ static ssize_t power_supply_show_property(struct device *dev,
>  	else if (off == POWER_SUPPLY_PROP_TYPE)
>  		return sprintf(buf, "%s\n",
>  			       power_supply_type_text[value.intval]);
> +	else if (off == POWER_SUPPLY_PROP_USB_TYPE)
> +		return power_supply_show_usb_type(dev, psy->desc->usb_types,
> +						  psy->desc->num_usb_types,
> +						  &value, buf);
>  	else if (off == POWER_SUPPLY_PROP_SCOPE)
>  		return sprintf(buf, "%s\n",
>  			       power_supply_scope_text[value.intval]);
> @@ -241,6 +285,7 @@ static ssize_t power_supply_store_property(struct device *dev,
>  	POWER_SUPPLY_ATTR(time_to_full_now),
>  	POWER_SUPPLY_ATTR(time_to_full_avg),
>  	POWER_SUPPLY_ATTR(type),
> +	POWER_SUPPLY_ATTR(usb_type),
>  	POWER_SUPPLY_ATTR(scope),
>  	POWER_SUPPLY_ATTR(precharge_current),
>  	POWER_SUPPLY_ATTR(charge_term_current),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index f0139b4..0c9a572 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -145,6 +145,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
>  	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
>  	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
> +	POWER_SUPPLY_PROP_USB_TYPE,
>  	POWER_SUPPLY_PROP_SCOPE,
>  	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
>  	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> @@ -170,6 +171,19 @@ enum power_supply_type {
>  	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  };
>  
> +enum power_supply_usb_type {
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN = 0,
> +	POWER_SUPPLY_USB_TYPE_SDP,		/* Standard Downstream Port */
> +	POWER_SUPPLY_USB_TYPE_DCP,		/* Dedicated Charging Port */
> +	POWER_SUPPLY_USB_TYPE_CDP,		/* Charging Downstream Port */
> +	POWER_SUPPLY_USB_TYPE_ACA,		/* Accessory Charger Adapters */
> +	POWER_SUPPLY_USB_TYPE_C,		/* Type C Port */
> +	POWER_SUPPLY_USB_TYPE_PD,		/* Power Delivery Port */
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,		/* PD Dual Role Port */
> +	POWER_SUPPLY_USB_TYPE_PD_PPS,		/* PD Programmable Power Supply */
> +	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
> +};
> +
>  enum power_supply_notifier_events {
>  	PSY_EVENT_PROP_CHANGED,
>  };
> @@ -196,6 +210,8 @@ struct power_supply_config {
>  struct power_supply_desc {
>  	const char *name;
>  	enum power_supply_type type;
> +	enum power_supply_usb_type *usb_types;
> +	size_t num_usb_types;
>  	enum power_supply_property *properties;
>  	size_t num_properties;
>  
> -- 
> 1.9.1

-- 
heikki
