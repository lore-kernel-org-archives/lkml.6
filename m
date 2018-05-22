Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2247758-1526982459-2-601856922858876971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526982459; b=TGwG9+7onHpoQP2C68KcDf+5/CUPFOlY19UPMOOvA7ZxheiuQ0
    nsQ4eLdVqefyEFqW+o7b4cX/qWtB0bESVtckimVnvlQhZxbbKqTsj88k2BL0sZOr
    HFv1wCeDCb5NBSzym98smP0TVCE3sqTwbmMHXO+CMKrGV55nnJ5K0CnL6/m/sTq2
    wY5QQ5W3cZ2UBQD886ZIsB1cMKJif9fnK0MWU7HFRzUuQ1bP683x7kWRL1/5YwsR
    a2v9DwYWWoYLk/A2MBm1glN1MyB1HY8eW7GNm+aFUyFtkfiN9iWs85LFNQVS6l/g
    MAlHdwnp7KDKEzawYX52CoxhDASWHOvtyQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526982459; bh=TpxT85c0zKf2KfN2WTYk3HBbRM46Tc
    3nUpXV7EeZ6v0=; b=YkBh87+eQxGsaIlFPfKWxJNcJe73RI8j0+JorClPzm69sv
    qorOQ/je8yaDyN5XxxsEIzatXXwga2xwD9Q5PdJrHxsem+ZIpzpvVzfauRLzSSnF
    IrnrSXQRjTHcAZvZj0NUIXoUA0NrilH0DwPq4CetfdE6g235jz/OLav5PwbmbtE0
    7kvGeEnsreniUnzh0OYe87flGyiJbMoM+04CzilVBD1oVNx/RTxUkbndc6q0uITc
    6phiVNW7UFaFNyh7ZkGHHTrnWZj1yB74qVcyopiie0gYCDVbBSRrXcSbXBE9iVQA
    gvx12AoPEfaDUfON6FQRhBBDgENOXQPG3sHOkLcQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
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
X-CM-Envelope: MS4wfI5jPOIp/jX885aXj1/qrfJ37fDrswOc32A4A3zOomkbm3E6NE7oSxYaT/P1p60YAepMCQ1Uz6wIQvnQaBZznqaR+NVOxnCtB6U2dlFUw76OZ8LMIayr
    mdsHN8O/stE2wSe3uogiX2B3nFvUhO/b7GZyvA5cOrloX88afhHD9Qkjq8jQkZD3AThZhzpJCczmLH6FYRXUAoihUVTmrVgMLCKwDHwMLNqc6kFlfpJBqOZ2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=X3a0BiUdAAAA:8 a=VwQbUJbxAAAA:8 a=FoZAHQPpUm1dTUqHq-kA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeEVJrZ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 05:47:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:18846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbeEVJrY (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 22 May 2018 05:47:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="57407421"
Date: Tue, 22 May 2018 12:47:19 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH] typec: tcpm: Provide of_node pointer as part of psy_cfg
Message-ID: <20180522094719.GH10677@kuha.fi.intel.com>
References: <20180516160046.18FCF3FAD3@swsrvapps-01.diasemi.com>
 <20180521132016.GC10677@kuha.fi.intel.com>
 <2E89032DDAA8B9408CB92943514A0337014C1EE0EE@SW-EX-MBX01.diasemi.com>
 <20180521145534.GD10677@kuha.fi.intel.com>
 <2E89032DDAA8B9408CB92943514A0337014C1EE1C1@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1EE1C1@SW-EX-MBX01.diasemi.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 03:34:53PM +0000, Adam Thomson wrote:
> On 21 May 2018 15:56, Heikki Krogerus wrote:
> 
> > On Mon, May 21, 2018 at 01:58:16PM +0000, Adam Thomson wrote:
> > > Hi Heikki,
> > >
> > > On 21 May 2018 14:20, Heikki Krogerus wrote:
> > >
> > > > On Wed, May 16, 2018 at 05:00:46PM +0100, Adam Thomson wrote:
> > > > > For supply registration, provide of_node pointer of the port device,
> > > > > via the power_supply_config structure, to allow other psy drivers
> > > > > to add us as a supplier using the 'power-supplies' DT property.
> > > > >
> > > > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > > > ---
> > > > >  drivers/usb/typec/tcpm.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > > > > index 72996cc..e7c0b95 100644
> > > > > --- a/drivers/usb/typec/tcpm.c
> > > > > +++ b/drivers/usb/typec/tcpm.c
> > > > > @@ -4500,6 +4500,7 @@ static int devm_tcpm_psy_register(struct tcpm_port
> > > > *port)
> > > > >  	char *psy_name;
> > > > >
> > > > >  	psy_cfg.drv_data = port;
> > > > > +	psy_cfg.of_node = port->dev->of_node;
> > > > >  	psy_name = devm_kzalloc(port->dev, psy_name_len, GFP_KERNEL);
> > > > >  	if (!psy_name)
> > > > >  		return -ENOMEM;
> > > >
> > > > Would it be possible to use fwnode here instead? It would mean that
> > > > you add a member for it to the struct power_supply_config, and handle
> > > > it separately in power_supply_core.c. You could just convert it to
> > > > of_node there for now.
> > > >
> > > > That is just a request, I'm fine with this, but it would prepare this
> > > > driver for all types of platforms, so less patching would be needed
> > > > once we add ACPI support to the power_supply_core.c.
> > >
> > > Would the following commit from Hans, already present in power_supply_core.c,
> > > not fit the bill:
> > >
> > > [58a36bb06891ee779074db6ef84e98347c634d38]
> > > power: supply: core: Add support for supplied-from device-property
> > >
> > > Or was that just meant as a stop gap for something more?
> > 
> > I think the main idea with that patch was that it allows us to take
> > advantage of build-in device properties, but I think we could actually
> > improve also it if we had the fwnode handle assigned to the psy. We
> > would not have to assume the parent has those device properties then.
> > 
> > But ACPI actually defines a specific object called _PCL (power
> > consumer list) for power source objects that we should one day check
> > in power_supply_core.c. That's what I meant by ACPI support.
> 
> Ok, fair enough. Makes sense to me. Thanks for clarifying.
> 
> > > I have no problems adding something further, but I don't have a means to verify
> > > anything ACPI based, beyond a simple build test, so would ideally want someone
> > > to verify that path through the code.
> > 
> > This is not really about ACPI. By using fwnode handle instead of
> > of_node, we would continue to keep tcpm.c agnostic about the type of
> > hw description.
> > 
> > So I don't expect any ACPI support to be added to the
> > power_supply_code.c at this point. You can use to_of_node(cfg->fwnode)
> > in __power_supply_register() for now:
> > 
> >         psy->of_node = cfg->of_node;
> >         if (cfg->fwnode)
> >                 psy->of_node = to_of_node(cfg->fwnode);
> 
> OK, no problem. Will take a look and add that in.

Thanks Adam!

-- 
heikki
