Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-986160-1521540284-2-16272791070746368460
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
    t=1521540283; b=w316gMXM9DTNkCbDgkzREUagmhqGVYzTiOXqUez0MqV7kxj
    pBcwIuQf2dxY8P07EkO8LXjbQ5mssp4On3It1McSyg7QEfMxtrykFkx2DUXCqtNT
    T6M5i/JWzyNbsuJ6hnSwOGo+MniW2vmv9r+1RKpgSjvsOdxZZYO/t76DTG7l/F9Y
    LRPMfyQAHiC+G4/+3pjUjb3vVWx+i+J+3fYzeX9wtk2rj08a2XNEiJdC9I8DrNm8
    DviF1KoxUbEhWF1jpxhptFuWZXOgqjQWC1Luix3hZ/o+0IRUffkKhPeFOnfosrY3
    u22U4bRxdyv+1Isl0jY6KfXMWAhWotcaAdyUzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521540283; bh=0Rpxk1LUO3DmtkXRJ5hvLDSoDh
    Bq7Cop2ejJm4GICCQ=; b=Jt09psWQBnlEgEEgxp9HGq/etcQtg0ROXl9GjyQ5a/
    H7X0557RQo0rza8oMW9rPlTNPT41ozo4YDvSprnGBCyvCvI5M/isroh3HZ6o5+uq
    4PxhqC82MkB3BYeO0fxuQZH76fcr88JJi0k0TZg1clEd6kZXrgqU4ABQlb5AiIyV
    0nmHs1MHaq+1r6uNumhbm0bo0/wXspi32GN2WEbmJcl9baW31qoRZXMogkmJBeqx
    liNalTP52odSfShMDvWFBqtFQ4zdqUx0G6/pWrIffgcnLuQL4PhGz7VnvabjAEGd
    6r9B/fWlcKIYK5JpjWfI16fRAbvAipYUuXLV8Ml4vyiA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeCTKEU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 06:04:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:37072 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752717AbeCTKER (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 20 Mar 2018 06:04:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,334,1517904000";
   d="scan'208";a="39555626"
Date: Tue, 20 Mar 2018 12:04:12 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v8 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180320100412.GI11689@kuha.fi.intel.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
 <20180314131215.70833-2-heikki.krogerus@linux.intel.com>
 <20180320092004.GA21081@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320092004.GA21081@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 10:20:04AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 14, 2018 at 04:12:04PM +0300, Heikki Krogerus wrote:
> > Several frameworks - clk, gpio, phy, pmw, etc. - maintain
> > lookup tables for describing connections and provide custom
> > API for handling them. This introduces a single generic
> > lookup table and API for the connections.
> > 
> > The motivation for this commit is centralizing the
> > connection lookup, but the goal is to ultimately extract the
> > connection descriptions also from firmware by using the
> > fwnode_graph_* functions and other mechanisms that are
> > available.
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> > Changes in v8:
> > - No longer using rcu.
> 
> Ok, but then:
> 
> > +void *device_connection_find_match(struct device *dev, const char *con_id,
> > +			       void *data,
> > +			       void *(*match)(struct device_connection *con,
> > +					      int ep, void *data))
> > +{
> > +	const char *devname = dev_name(dev);
> > +	struct device_connection *con;
> > +	void *ret = NULL;
> > +	int ep;
> > +
> > +	if (!match)
> > +		return NULL;
> > +
> > +	mutex_lock(&devcon_lock);
> > +
> > +	list_for_each_entry_rcu(con, &devcon_list, list) {
> 
> _rcu calls everywhere :(
> 
> Did you send out the right version of this patch?
> 
> Also, further down you do:
> 
> > +#include <linux/platform_device.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/i2c.h>
> > +#include <linux/pci.h>
> 
> Eeek, #include in the middle of a file, not good.
> 
> > +
> > +static struct bus_type *generic_match_buses[] = {
> > +	&platform_bus_type,
> > +#ifdef CONFIG_PCI
> > +	&pci_bus_type,
> > +#endif
> > +#ifdef CONFIG_I2C
> > +	&i2c_bus_type,
> > +#endif
> > +#ifdef CONFIG_SPI_MASTER
> > +	&spi_bus_type,
> > +#endif
> > +	NULL,
> > +};
> 
> Can't you just declare the above as "extern" variables and not need the
> #include?  Yeah, checkpatch will complain, but it should be fine here as
> we really don't want the full .h files here (or need them.)

OK. I'll declare them as extern.

> > +void device_connection_remove(struct device_connection *con)
> > +{
> > +	mutex_lock(&devcon_lock);
> > +	list_del_rcu(&con->list);
> 
> See, rcu?

True. I'll send one more version.


Thanks,

-- 
heikki
