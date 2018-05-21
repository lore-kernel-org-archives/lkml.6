Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-797182-1526911104-2-12324733849454396045
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526911103; b=hSNGMGs46+mClF681PIBhCVaIcyablv1Qx0yD/xnLzfQID5rsA
    8XmtkiX72/4dXO91Prz8K8DSRagvz/RyNVgcv6X9iKbSH3H+l0116yTwAqAG84K0
    yeq6XlEeYlePan+wZeoOlnl7CsuwTvrAyE12zENuB1CFlj0qCPJMKduMGAzwzawI
    2iedc6FDoycfcrUz9DPMTapIs3dWvMS6QumjLepVE2MKPRcnh8irca6vjnBfmEcp
    GoLBvpTH9chsKmTe+rxss721azv9BS7miueQ2wrMxtYE4D5cZXGG7ygPF3t5fGP4
    WqBs96sASG2kwaleN+IdVBHxILYic52YY6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1526911103; bh=dYdJKu88ZB
    s5HvnBILXV8JsOGg/x6Ku9yimi7CLDD5Y=; b=g3TLvO23cWWvUasFZNhhN5+Dsf
    Uv6LJ0NbBb/uepd7pBdJUDfz+0CCUcrGhWduzdqehMMIQ9cXV02UrFomiJeKBgMB
    zzY5K2inqp2i8C1mqd442w5hFr/VuAUOfrAEg1o0E45NIeXaL395nwmOQ0DWN6O8
    IUiYZHV7K0a6JshSnUorYEP4xlOmgxFf1vo3dHZNaDpM0p+AuNz2Sm0WBiBla2sJ
    467x2vhrdamuhHn7VA9mm+iTIDHaO6gp0ld63oNVzJdshFpEqjAEiczW2wZ7x+zi
    NnqMKfNV6pqGUJjY10aVXNMeWfDZuz1eoyFZt90w3/HDW+me1P5nfbCO5jwg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCaeFitXOsMOvF4HvehamiMv4gE37ZiuryOBOhSxSBfNDrjcsXNMYCrdtNBRbP0elh15EmV8AjBAghumW8jY+F3jcDW9JtHXgh9Aj2WtU2Tybia6Hy29
    NgegocTOQGp8OzPlTZDGHYhzWlvX5fFX69mKm6i943l/bm5ITjnvX2InoDqMR0rEAN6Ic2NGfh+NJbJppfwJ9G4uakhr4qT8cSXn9I/bpQYNNLxEtN9qglRO
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=X3a0BiUdAAAA:8 a=VwQbUJbxAAAA:8 a=ggyOUzcTkJy56NUY4KcA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeEUN6V convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 21 May 2018 09:58:21 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.145]:61701 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751178AbeEUN6U (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 21 May 2018 09:58:20 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRWlGSWpSXmKPExsUSt3OpsW7lBaZ
  ogw97VSyaF69ns+havZPF4vKuOWwWi5a1Mls8WXiGyYHVY97JQI/9c9ewe+z83sDu8XmTXABL
  FGtmXlJ+RQJrxtx9Z9gL7vBVfLl2k6mBcRZPFyMXh5DAUkaJy782sXYxcnKwCVhITD7xgA3EF
  hHIkpi8dTkTSBGzQAeTxIxN3WBFwgI+Ejffv2GEKPKVWPblM1SDlcSKu2uZQWwWAVWJm3+mgd
  XwCgRI9E4+yQ5iCwnkSKze2sgCYnMKmEscP/gALM4oICvxpXE1WC+zgLjErSfzmUBsCQEBiSV
  7zjND2KISLx//Y4Ww5SW2f/vNDmHbS7y+9w5oJgeQrS/R11gMETaUWDXtAAuEbS7x8+EzqPE6
  Egt2f2KDsLUlli18zQxxpqDEyZlPWCYwis9CcsUsJC2zkLTMQtKygJFlFaNGcWpRWWqRrpGhX
  lJRZnpGSW5iZo6uoYGpXm5qcXFiempOYlKxXnJ+7iZGYITWMzAw7mC8O9nvEKMkB5OSKO+/Qq
  ZoIb6k/JTKjMTijPii0pzU4kOMMhwcShK8288D5QSLUtNTK9Iyc4CpAiYtwcGjJML7HSTNW1y
  QmFucmQ6ROsWoKCXOuw0kIQCSyCjNg2uDpadLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5
  94BM4cnMK4Gb/gpoMRPQ4o5D/6OAFpckIqSkGhhLkjpfin6TC3ksXMex6lx3dU+c2Ry1RzbSf
  32TD4tmm+ou7llvGr4w8uZx5Sk7f5xQzlVj2NX3XYmR21668eSpDez/QhycLkq5CNnKsd+Mvv
  cl7dx+v9w0j7s+e8JCvsvEz16RaXeoQ2u58eLnWqkPPHZGTbyTr5Ki7u+rato6J8kwM927SYm
  lOCPRUIu5qDgRAGX72btKAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-14.tower-178.messagelabs.com!1526911097!115407545!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC: Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH] typec: tcpm: Provide of_node pointer as part of psy_cfg
Thread-Topic: [PATCH] typec: tcpm: Provide of_node pointer as part of psy_cfg
Thread-Index: AQHT7S8N3gxz/LUPbUW6fTotsuqmzaQ6IcgAgAAZMQA=
Date: Mon, 21 May 2018 13:58:16 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1EE0EE@SW-EX-MBX01.diasemi.com>
References: <20180516160046.18FCF3FAD3@swsrvapps-01.diasemi.com>
 <20180521132016.GC10677@kuha.fi.intel.com>
In-Reply-To: <20180521132016.GC10677@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.43]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 21/05/2018 11:59:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Heikki,

On 21 May 2018 14:20, Heikki Krogerus wrote:

> On Wed, May 16, 2018 at 05:00:46PM +0100, Adam Thomson wrote:
> > For supply registration, provide of_node pointer of the port device,
> > via the power_supply_config structure, to allow other psy drivers
> > to add us as a supplier using the 'power-supplies' DT property.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > ---
> >  drivers/usb/typec/tcpm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > index 72996cc..e7c0b95 100644
> > --- a/drivers/usb/typec/tcpm.c
> > +++ b/drivers/usb/typec/tcpm.c
> > @@ -4500,6 +4500,7 @@ static int devm_tcpm_psy_register(struct tcpm_port
> *port)
> >  	char *psy_name;
> >
> >  	psy_cfg.drv_data = port;
> > +	psy_cfg.of_node = port->dev->of_node;
> >  	psy_name = devm_kzalloc(port->dev, psy_name_len, GFP_KERNEL);
> >  	if (!psy_name)
> >  		return -ENOMEM;
> 
> Would it be possible to use fwnode here instead? It would mean that
> you add a member for it to the struct power_supply_config, and handle
> it separately in power_supply_core.c. You could just convert it to
> of_node there for now.
> 
> That is just a request, I'm fine with this, but it would prepare this
> driver for all types of platforms, so less patching would be needed
> once we add ACPI support to the power_supply_core.c.

Would the following commit from Hans, already present in power_supply_core.c,
not fit the bill:

[58a36bb06891ee779074db6ef84e98347c634d38]
power: supply: core: Add support for supplied-from device-property

Or was that just meant as a stop gap for something more?

I have no problems adding something further, but I don't have a means to verify
anything ACPI based, beyond a simple build test, so would ideally want someone
to verify that path through the code.
