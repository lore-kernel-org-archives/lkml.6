Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1313496-1527141795-2-446889681110220151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
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
    1527141795; b=Gvno0WA39K+j/+aS4LEaIRu0ivYM6/tuNrW8uolwRDeTu5YLi7
    2AKGgvhKLekKrnIorGxMednX/IEhGjpI8lSHXT/Q+JZu5k/qDAigJyZQtAkphzjG
    CjBdBcXIdK3pronojXyIPMbJhMXCuuK9dQwqmh5fqsIuNke6CgmnM2yXrs0pLdCQ
    /DAyvpPA3xWe6YxkFHkgMQYvhgclf6Aofg8Y5CfLMYOKs5DoPQgm7vslpv2kuHn3
    DD5c7GIfhQxmidVP1snU99QPK497L3G4yPzsQ76BJUtBJ57KnOXG8LOYAfA+PKAD
    znCsCGSTts2WqG6h7Fh8RTeeVVDIy+/G+cXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527141795; bh=+ThH85HI169dOlzJQkkXsCIItfxP+Y
    2th9KlWqIKikA=; b=LBhwhepPiDAaJzVlPo9aZEi89XzfByvBDjC5msfP8PJC8T
    Bya+fSgocc6eTqayRp87hnsJjGnemR1IxWBDtNc8D/1ef8C/78w5S1CbifuDsH3D
    7ps8HuOr85IBrtXlcIJeTi7dEUKtVtsxGFDQqpaLsfeh7DhaDWrnKGumFWkonDjs
    78DG482slPeO1shmwRoDv5uUgM4B92vgcSmEWNqJz3yBhcMW+cRHvb0gO+2q3che
    2lTA/vwr8bVQZ0mQfAqZmclUW+rQO0/9of1ypZlGEzTENxyaBQDv+dmfMUBsWUx2
    LjT9LPWZZrAOQzMgR6GIfvXK/eMIsdeh/sPtqqqw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfLBQ1FqUspwxg6V2HnsUH3RwR08SemTk8Z30WV7nBk0Rz3JhOO7OefGXW2YPBkLpOrog0AgRsEC+xiGoq0LQp6eVA+h0CaG36jivfcJNKdd81Q+i7eBa
    ZT6FY8y92sTq+dMBssbx/8tRbqumAcmHXmYsfHjM8Ha5j2NYHIqHHpo0GRcCYUFplk4UMvCBvZzFB40rFp0AyS69BVpwMqwU1ySH4746P2WV84aaIFmTNgfJ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=B6utNPlCFDGAz22yvO4A:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935582AbeEXGDI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 02:03:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:47626 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935515AbeEXGDG (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 24 May 2018 02:03:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,435,1520924400";
   d="scan'208";a="58043455"
Date: Thu, 24 May 2018 09:03:02 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: roles: intel_xhci: Always allow user control
Message-ID: <20180524060302.GA29600@kuha.fi.intel.com>
References: <20180523143758.66348-1-heikki.krogerus@linux.intel.com>
 <20180523143758.66348-2-heikki.krogerus@linux.intel.com>
 <0e4dd22d-8553-1d51-22a2-d6252e5c5dc5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e4dd22d-8553-1d51-22a2-d6252e5c5dc5@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 08:03:43PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 23-05-18 16:37, Heikki Krogerus wrote:
> > Trying to determine the USB port type with this mux is very
> > difficult. To simplify the situation, always allowing user
> > control, even if the port is USB Type-C port.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >   .../usb/roles/intel-xhci-usb-role-switch.c    | 21 +------------------
> >   1 file changed, 1 insertion(+), 20 deletions(-)
> > 
> > diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > index 30b07ea3a3c6..3f14153d753f 100644
> > --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> > @@ -39,20 +39,6 @@ struct intel_xhci_usb_data {
> >   	void __iomem *base;
> >   };
> > -struct intel_xhci_acpi_match {
> > -	const char *hid;
> > -	int hrv;
> > -};
> > -
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
> > @@ -139,6 +125,7 @@ static enum usb_role intel_xhci_usb_get_role(struct device *dev)
> >   static struct usb_role_switch_desc sw_desc = {
> >   	.set = intel_xhci_usb_set_role,
> >   	.get = intel_xhci_usb_get_role,
> > +	.allow_userspace_control = true,
> >   };
> >   static int intel_xhci_usb_probe(struct platform_device *pdev)
> 
> 
> I hate to be pedantic here, but the sw_desc can and should be made
> const now, with that fixed the entire series is:

Sure, I'll fix that.

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks Hans. I'll send the v3. I need to add one more fix to the
series.

I got a report where somebody hit the issue related to the runtime PM
we talked about a while back: If xHCI is suspended, we fail to program
the mux registers as they are part of xHCI MMIO, so I will add a patch
to this series where I enable runtime PM here to fix that problem.


Cheers,

-- 
heikki
