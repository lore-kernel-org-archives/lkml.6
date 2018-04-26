Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2646822-1524750951-2-16325978698504355707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524750951; b=TvcdxhgfDB4onabB7BaOiTD5j9tdePnreI5OKEpyORTC/9T/hQ
    h7DKf3EgqfEeqKUx8O3mBdStCumYiUAyS4U5D9Z4BYEbHUenKXRzCMrRxjo9cvkT
    fPEwx/unVluFgGrewWcyBdyQ2HOf6zl4lWx3c7TMJPxpNuM8lsu6oUDfK1tx9eza
    wnm4nxVAWjIvVMPMjkOLm0ZIzTXjQCjrRSPXF6C2R2IyhiCJRutnzjUSmYl8RK2H
    rjDf0NBjSzJ9OWld9qDod1amGZVemtn2B9LiQY36HLl02KKCSpfJfsEVWb+x+AB9
    oDcN0cLZX8g9BqmdajrCM0ISldzwfSLUX2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524750951; bh=jHeWYgwBP9GrcgviBeIIfHSP8zMqx6
    ZYNfEh5y45K3c=; b=Os9LaXrUsUnVndCf71u6qx/UZKrjAueR2iw6hNrENf4T7O
    OriGHtPNUcuinCyqPWIAWBDc7GrlyNacqyGTUFaYOz1lIxR8e7Y76I+rrufW/IX+
    FJJcbPZpD3qGvKW8nsoQMzCeYu9+rq46LbnV+XOa0+0PdjBjOs72d+3PgaqtaSir
    hbIl8y9yKtTUS5+UbusVH80W+MnwDmenxVVH1pkpiZ2W+BdKGsLjRJXsvCOqE6Vd
    DBbbLXU2QEoSwhMra8KofgLiDwGC179P89gYjBu4bkgN8QVkmk15TzG49zntGBk+
    F9E7MHcchs6lLASMxeanYq6HVTV1POL1s2jCWW5Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCHCFg065cwHZ4NhOqbObDpVPDKsL/VrBpCGgqkXs2pTXA4qOrd3bbepwJiR1rWCLrj0U0jhfLH3BhDx9WHWeRqdla5Nq41LCowQGbQWiuPTyHZE8GAO
    vLzuCJAJ/WYQBO7oUjBtSypuyiYHYd7UUCRsQX2bFV6VriMSt4R733Wl1jTaSR0HKE1MEisMH/P4a3y8C4y51cFCuNAnBbXY/vIyw7bXXpcb9JCBfB2gdYp8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8
    a=JZH0MAl6W73PehkM-JkA:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755894AbeDZNzs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 09:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755873AbeDZNzr (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 09:55:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55C020779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Thu, 26 Apr 2018 08:55:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for
 runtime wakeup support
Message-ID: <20180426135545.GB225403@bhelgaas-glaptop.roam.corp.google.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com>
 <798A7C7A-A3DA-4C0E-A774-48042430EE1A@canonical.com>
 <10732937.eAR6mAEfiz@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10732937.eAR6mAEfiz@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 13, 2018 at 09:29:56AM +0200, Rafael J. Wysocki wrote:
> On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
> > Hi Bjorn and Rafael,
> > 
> > > On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> > > wrote:
> > >
> > > USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> > > core: Drop run_wake flag from struct dev_pm_info").
> > >
> > > The device in question is not power managed by platform firmware,
> > > furthermore, it only supports PME# from D3cold:
> > > Capabilities: [78] Power Management version 3
> > >        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> > >        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > >
> > > Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> > > After that commit, the device gets runtime suspended, so it does not
> > > respond to any PME#.

Apologies for my lack of PM expertise.  I don't think the device would
*respond* to PME#, would it?  I would think the device would
potentially *generate* a PME#.

And I guess since this device can generate PME# only from D3cold, the
implication is that runtime suspending the device may put it into D1,
D2, or D3hot, but not D3cold?  Is that an axiom of the runtime suspend
design?

> > > usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
> > > device_can_wakeup() in pci_dev_run_wake() always returns true.

I think "mandatorily" means "always" or "unconditionally", right?

> > > So pci_dev_run_wake() needs to check PME wakeup capability as its first
> > > condition.
> > >
> > > In addition, change wakeup flag passed to pci_target_state() from false
> > > to true, because we want to find the deepest state that the device can
> > > still generate PME#.

Is this a separate bug fix?  I don't understand how it fits in here
because the wakeup flag means "Whether or not wakeup functionality
will be enabled for the device", and you're not changing anything
about whether wakeup functionality will be enabled.

> > > Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
> > > dev_pm_info")
> > > Cc: stable@vger.kernel.org # 4.13+
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > v3: State the reason why the wakeup flag gets changed.
> > >
> > > v2: Explicitly check dev->pme_support.
> > 
> > If this patch is good enough, I am hoping it can get merged in v4.17.
> 
> OK
> 
> Bjorn, if you want to take this:
> 
>  Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Otherwise please let me know and I'll queue it up.

de3ef1eb1cd0 went through your tree, so I think this fix should go
through your tree, too.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Not directly related to this patch, but I think these comments in
pci_target_state() are slightly misleading:

   * Call the platform to choose the target state of the device
   * and enable wake-up from this state if supported.

   * Find the deepest state from which the device can generate
   * wake-up events, make it the target state and enable device
   * to generate PME#.

AFAICT, pci_target_state() does not actually "enable wake-up from this
state" or "enable device to generate PME#".

> > >  drivers/pci/pci.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index f6a4dd10d9b0..52821a21fc07 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2125,16 +2125,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
> > >  {
> > >  	struct pci_bus *bus = dev->bus;
> > >
> > > -	if (device_can_wakeup(&dev->dev))
> > > -		return true;
> > > -
> > >  	if (!dev->pme_support)
> > >  		return false;
> > >
> > >  	/* PME-capable in principle, but not from the target power state */
> > > -	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
> > > +	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
> > >  		return false;
> > >
> > > +	if (device_can_wakeup(&dev->dev))
> > > +		return true;
> > > +
> > >  	while (bus->parent) {
> > >  		struct pci_dev *bridge = bus->self;
> > >
> > 
> 
> 
