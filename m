Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3125086-1523604597-2-520466453089702544
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523604597; b=WCJdoGnzOzCUfAhjf872pKeHU1FmgSeZ4KdbT4FWEJ3tO9+hrT
    xlI9q7MjCxT9WYPjP+DyqoTmOB9uFqoxmstCmnYb5/D6BjogweHZ0BZ4YW5GuOuv
    nhePcvW5FwndrRxxZ0mBK+49EsuxdOwFURDawC7zUO8cZjfsh8A5DAavdC7X6/hC
    25omSbmzmDES1RnfY3D1Ugfyd4IgBMPys+AuU60T+bIJ0qUCy7ng7p8h0TsGCaIl
    U0/rYaqxXTbpawNmYgmJmOd6nSacQDueZt0NIwf6xwA/uicYwknGZktKOCW493iU
    ExuSYSaypEyH9Ut7yC20HuqrQvrODTfqHkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1523604597; bh=RDPxf8o7HW
    A5rhCEBJRkoex4TAqTOtYsCH74zRVPtO4=; b=gCfluBVwnMruRpI0/2miThHDSv
    pMbOktHC8da4dBFCL9TCAby5FQsfMcKEvoMXuYsD3wu5n6eRG7xSd3yAcOVwsmVb
    MlFcH9NfWDWWUyNL5oUMHlRaV+pxl0aXfPdG1OSl9m3JGf3h9PilEX//S5VE99CR
    Os9ukvthgyb7IzurQnvq3Feo3bG8xVnHpaFShY/pfBarKhdh7V8BWrXcjnfabOSx
    SvOKr8xDGxFYz3y0lbT/z40WE+ZDQZOGM+GQM3txiDfbCd/f9Snry3XScRCxQd4K
    2DFVZ+TG3wUD6M0YUGoV7WOYkFyFmHWOO7HX6ruaKjldfCGvyV8riJoz6q+A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNIsJMi2HBLZmxGElo9rixf85V8hNdHjHY91F6i675HZalxu2kK7RzRC6XMLkLkhDe3Ys4aoYTkDDcjJiAsDe4P3BPqvV98KD066l3f6SOjQcIWEUDuY
    Ue45+UzNbqyFI9mrx38OfUph3+Xu+RBGIaXqYe2YnqB1qTjMfgdjie8eJxj9IYtQv4bHjZn2lVN/b/docKLN/zMHIY8FxYHmrZPC6k5B2wwTPWHGGhMw5QsM
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=p0LdxNZvL-aoYi43L-QA:9
    a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbeDMH3y (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 03:29:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59048 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbeDMH3x (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Apr 2018 03:29:53 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kai Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Fri, 13 Apr 2018 09:29:56 +0200
Message-ID: <10732937.eAR6mAEfiz@aspire.rjw.lan>
In-Reply-To: <798A7C7A-A3DA-4C0E-A774-48042430EE1A@canonical.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com> <798A7C7A-A3DA-4C0E-A774-48042430EE1A@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
> Hi Bjorn and Rafael,
> 
> > On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> > wrote:
> >
> > USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> > core: Drop run_wake flag from struct dev_pm_info").
> >
> > The device in question is not power managed by platform firmware,
> > furthermore, it only supports PME# from D3cold:
> > Capabilities: [78] Power Management version 3
> >        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> >
> > Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> > After that commit, the device gets runtime suspended, so it does not
> > respond to any PME#.
> >
> > usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
> > device_can_wakeup() in pci_dev_run_wake() always returns true.
> >
> > So pci_dev_run_wake() needs to check PME wakeup capability as its first
> > condition.
> >
> > In addition, change wakeup flag passed to pci_target_state() from false
> > to true, because we want to find the deepest state that the device can
> > still generate PME#.
> >
> > Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
> > dev_pm_info")
> > Cc: stable@vger.kernel.org # 4.13+
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3: State the reason why the wakeup flag gets changed.
> >
> > v2: Explicitly check dev->pme_support.
> 
> If this patch is good enough, I am hoping it can get merged in v4.17.

OK

Bjorn, if you want to take this:

 Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Otherwise please let me know and I'll queue it up.


> >
> >  drivers/pci/pci.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index f6a4dd10d9b0..52821a21fc07 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2125,16 +2125,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
> >  {
> >  	struct pci_bus *bus = dev->bus;
> >
> > -	if (device_can_wakeup(&dev->dev))
> > -		return true;
> > -
> >  	if (!dev->pme_support)
> >  		return false;
> >
> >  	/* PME-capable in principle, but not from the target power state */
> > -	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
> > +	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
> >  		return false;
> >
> > +	if (device_can_wakeup(&dev->dev))
> > +		return true;
> > +
> >  	while (bus->parent) {
> >  		struct pci_dev *bridge = bus->self;
> >
> 
