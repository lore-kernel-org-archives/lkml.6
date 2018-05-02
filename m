Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-257651-1525243988-2-2013936617071721210
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
    1525243987; b=JPEPEI7zATUdRnJlCmt43s7FrkYvqBoCWGayU4UFQG5NzFKnYY
    sKYAe0dDPcAnuXKIYo34PdcNuWDfuDuU6/KuswkZD3BcyUgr99KIsFVdFmB5vjhz
    SP89tcl6HaoN4Zx7qnNvCEMbteEFSo9ZZz0iXhVa+MKODTORnxp0IaazUD0gr3Xo
    RHVuq45J9y1hXNn677bAh7R9J6LUsUh/mqr1ZMJJsgj280IO6xPW5qH6hpSWTXz2
    aQi4yOTZOpdZaVGlJiYLTZ9SOjqNS0t9eCJ5MSchy8/cPLoGSkWdYw7VkNoC4ZuW
    JTbgjXP4CQIa15ssLj5jj5Ay5/orWUBHepZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525243987; bh=QuTY5jSbhR3J2DeO0vWtNjVegU7wtn
    jRRfvWtLrqVgM=; b=cqm9sMlxaL8Xik3lbhjkPnpNPTsRIeodxmimp4W96ROfoa
    ugar85MfHQBR08pFP59uYPmqFjc91v1QIg98d5/qJ/XN+KHaTsz6gfG6XKek2vEf
    Sy9bpOjFibybPrf2XgUseiHCcexymMGNnVIo6OYNgrwMrr5r1PxnzPYFykEIYPyz
    jA059BqE4ak5qlb0e5akJIeoYDPRbdpRXNmk4FsoEZr5gQbXR5We7DDMOGVUMmmK
    bHoWEwWmmndrzHUS3LUQK90PHOfWNL7TNWNsZeCU1wm3NkmKBiijnIBW5tc6l9QI
    /L67FFPm5U52qcrzKSiemQsvFhGhacWnkZjdfpcw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfG2+p4HZzMh6hzhyDMfGTZC8Dhkw4lA18sTk3oE7q4aFWoTfquu17P90whdLTRFfJJ7pB8cyLWWvy6wdmZtbQuEIq/1IvB9GyCMwk1mnoJSk8FvTbfJZ
    9NeJ9YEUOnQqgBI0kVCz3m3LLH6icUmiO6g1a9KHBFKhA1Pk8Owg8FYkSTbEkt9ShuA+cEgf03e0IOQ7Nt8Oi0lDuMkRVFNSUE7FGIccNAX/Lorw55QfInry
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=QNJw_f0IIQwzQNCnCDgA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeEBGww (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 02:52:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:35466 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbeEBGww (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 2 May 2018 02:52:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="51659014"
Date: Wed, 2 May 2018 09:52:48 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 4/4] usb: roles: intel_xhci: Always allow user control
Message-ID: <20180502065248.GC12870@kuha.fi.intel.com>
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
 <20180430124158.45269-5-heikki.krogerus@linux.intel.com>
 <9a0b6af4-8d49-8193-2fcd-a956c3f852ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0b6af4-8d49-8193-2fcd-a956c3f852ed@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 11:57:55AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 30-04-18 14:41, Heikki Krogerus wrote:
> > Trying to determine the USB port type with this mux is very
> > difficult. To simplify the situation, always allowing user
> > control, even if the port is USB Type-C port.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com> > ---
> >   drivers/usb/roles/intel-xhci-usb-role-switch.c | 15 +--------------
> >   1 file changed, 1 insertion(+), 14 deletions(-)
> > 
> > diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > index 28102127b9d5..6482eee6fd45 100644
> > --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > @@ -43,15 +43,6 @@ struct intel_xhci_acpi_match {
> >   	int hrv;
> >   };
> > -/*
> > - * ACPI IDs for PMICs which do not support separate data and power role
> > - * detection (USB ACA detection for micro USB OTG), we allow userspace to
> > - * change the role manually on these.
> > - */
> > -static const struct intel_xhci_acpi_match allow_userspace_ctrl_ids[] = {
> > -	{ "INT33F4",  3 }, /* X-Powers AXP288 PMIC */
> > -};
> > -
> >   static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
> >   {
> >   	struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
> > @@ -137,7 +128,6 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
> >   	struct device *dev = &pdev->dev;
> >   	struct intel_xhci_usb_data *data;
> >   	struct resource *res;
> > -	int i;
> >   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >   	if (!data)
> > @@ -150,10 +140,7 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
> >   	if (!data->base)
> >   		return -ENOMEM;
> > -	for (i = 0; i < ARRAY_SIZE(allow_userspace_ctrl_ids); i++)
> > -		if (acpi_dev_present(allow_userspace_ctrl_ids[i].hid, "1",
> > -				     allow_userspace_ctrl_ids[i].hrv))
> > -			sw_desc.allow_userspace_control = true;
> > +	sw_desc.allow_userspace_control = true;
> 
> It would be better to add:
> 
> 	.allow_userspace_control = true,
> 
> To the initialization of the struct and also make the struct const since
> we are now no longer changing it and usb_role_switch_register() accepts
> it being const.

Makes sense.

> With that changed:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks,

-- 
heikki
