Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3097409-1522400451-2-11228001857276781353
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522400450; b=GN4Q7SbSIwGvFli8Wj7CXmzB9rQIpTwAjwXfhM2R0O2M+/wKPb
    pApgRXZNFHDQDQgWsBx/toRfFzA25L2RUtpyPXT2TSVtbfAlaiNWHaWKD5wjRb1E
    QC5WDkJrP/wQDUWz1xHH5HCBJxvXQmzk1DSaHJNwbhss/c294MvAd+44E05BW+cJ
    wGsExd4RNf+awMvpa/qchbbY/+2XSP25CEZVUSs2RWNiFoXvWroMfoct5uFB8z38
    FXGtdWsl6URHwiRZhgWyOrtN6hnNI9DvV/rGEoVWqRa7YrktSmlojOOooscXQEbi
    Eqy6ibtkkqiZp/2GE3ueuWMf1jEL12i4Ss7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1522400450; bh=9/VBmMuh4P
    uJA3PTvgFTqVwRPtVsEnZn80eP5lNqmgM=; b=tQ9/4H+IxeoOCBU1tTSCnQiMLk
    nAmr+JkL0s4k4P2esxINS0NQQNrPi6qjG6lQYaNlvmbBeUwe5McQ3gLf/O9ufw2K
    nf1dyzGgSZy08jdlm08lmUwX87glmnzXxSTU+70dRgWNJsVDKK4KgxFQvuO47D1e
    Cz3pDZWku3iT9o0ZQXgy3h3/l1fKP733sMKYsjbS3oc920frIapYm8BXNsp83Ncf
    r6aJPmioP0F9hLN9OgCcuUw8fTnQCGGfTfcCUDaD4QioQmHkE1sZM5RRB95N0Ol9
    SDhaG27zghtu1teK51HRQI7OAKzWikrCES1jFUNNVebR5Lrlrvmm/v4hZYcg==
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
X-CM-Envelope: MS4wfLbczfcwAw/m7J52FFjNhLPNFazDjPzYBBYNmuSb0cS2VUf3ZjObEN2PITsgxpiwgRdmGsGqJOcS1zXVJYh6O/LYtkvbZCBQc6zHD0m5iJnbAeR+Li4+
    oXCkBOjVAwvlAJjPpJd9Z6tmd6peI0IUvKdfRGYEiu6n+1zWjIFZhG95UCztn8m+aBdyn+MLDrr1Ed9O9Jjnuoc95S9lx02fpLN2GC1MKSN78P9uSJbneB6k
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=p0LdxNZvL-aoYi43L-QA:9 a=CjuIK1q_8ugA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbeC3JAh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 05:00:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55371 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbeC3JAf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Mar 2018 05:00:35 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Fri, 30 Mar 2018 11:00:51 +0200
Message-ID: <1748267.LlfkqdCPEG@aspire.rjw.lan>
In-Reply-To: <5DC805B1-51DA-4D0F-9A43-9D5FE549AB13@canonical.com>
References: <20180319140910.26496-1-kai.heng.feng@canonical.com> <5DC805B1-51DA-4D0F-9A43-9D5FE549AB13@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Monday, March 26, 2018 7:54:35 AM CEST Kai Heng Feng wrote:
> Hi Bjorn, Rafael,
> 
> > On Mar 19, 2018, at 10:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
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
> > Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
> > dev_pm_info")
> > Cc: stable@vger.kernel.org # 4.13+
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> 
> Is there any improvement I can address?
> Or do you have any concern about this patch?
> 
> Kai-Heng
> 
> > ---
> > v2: Explicitly check dev->pme_support.
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

So why do you change 'false' to 'true' here?

At least that change should be mentioned in the changelog too.

> >  		return false;
> >
> > +	if (device_can_wakeup(&dev->dev))
> > +		return true;
> > +
> >  	while (bus->parent) {
> >  		struct pci_dev *bridge = bus->self;
> >
> 
