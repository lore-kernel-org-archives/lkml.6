Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2684841-1524753415-2-15158098613314657865
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
    1524753414; b=RdV4m0g3tB5TJ/hKdAL8neUjJBMnNYhZ3KkZ5SDbHZOz1aW4Pz
    899Q8MaPNEZMAFWIUdrULkF2MJroYR0c/p0i6x8u/735KDoNWymm2+GuVGsPq71B
    sEqGSSAjfziKV2/2jctAJOdudz8Lutmr9k2fkQlyOiIWp+2sKPdh/0UtS/J7ZGG4
    VqjkHruAwTkwv9iAjj7GxMp4g1jtFhYkxB+MGRBLecQ9iXglo0WNOsYCW/MoTj4e
    YX/h7zfPJVUGfWFYsC5gq+raNI7fxUpDV/uwxEzz9IFodUgV0H0/Xwl3pr+p+AyI
    KoYDR5LKEeCfK6Zww+ZC50neVmOusBk8QmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1524753414; bh=beFJ752rDI
    Zc5U6TrsAsJvWey/6CDUgLM2eyP7T5Nec=; b=fyEbnvDZNB4TpvAfUHSA4FgID7
    iELWHuvDVtf+joU0LxSxuY54MDTwxe02MVPe3PV83flMMfvBxNBN6LNdaGdLUo8s
    BKhS8nBp0i2FKfJsVEaPbA9JnJm7UBQCSkdMLd567aghfF2UNp+1+xRs3rg0a6WQ
    kHez9+8bWpYekWNjtfxxefAsUe1XfVoUtDxatydP/g9AZvzR/avFzMyfCJdt+a6J
    exyx5Ya1XPzT/jsNL8b1co/SYKZNs+wm8taYCEBo3uDX9SLBz/VsrcvPQ6jrgsyo
    S/rEljUAKiYFTu5nEMk5DJmOsH7YeMhgM2TMHwPam22shlkPpNRHVnaynFng==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfPspMEyEXnUX6m2Z3Sj9btvipd9wPIbjrUuoRxpnXg+yQlIex9w3MSkAMMgPljo2mHfboWmzFxMGIppGZfQcvA5duDxKm2HfUpl65TnwyfgyGhzWnSna
    RtwhS7YBVlVdht7/xzBj5s5SoWE8hRBUSqZqH6vbWHD5f1YaYY+/2bVCr9bR9joCxXUp4w4E6EMMmVqiBiEhpvxNEePIOa8C06DM5W5HVTsOTHivxC3RjhS/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=1XWaLZrsAAAA:8
    a=B4B1fWvliSaH0tsNWC4A:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756496AbeDZOgk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 10:36:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50944 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756422AbeDZOgj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 10:36:39 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Thu, 26 Apr 2018 16:36:26 +0200
Message-ID: <1772514.uJjIhrptf1@aspire.rjw.lan>
In-Reply-To: <20180426135545.GB225403@bhelgaas-glaptop.roam.corp.google.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com> <10732937.eAR6mAEfiz@aspire.rjw.lan> <20180426135545.GB225403@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thursday, April 26, 2018 3:55:45 PM CEST Bjorn Helgaas wrote:
> On Fri, Apr 13, 2018 at 09:29:56AM +0200, Rafael J. Wysocki wrote:
> > On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
> > > Hi Bjorn and Rafael,
> > > 
> > > > On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> > > > wrote:
> > > >
> > > > USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> > > > core: Drop run_wake flag from struct dev_pm_info").
> > > >
> > > > The device in question is not power managed by platform firmware,
> > > > furthermore, it only supports PME# from D3cold:
> > > > Capabilities: [78] Power Management version 3
> > > >        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> > > >        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > > >
> > > > Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> > > > After that commit, the device gets runtime suspended, so it does not
> > > > respond to any PME#.
> 
> Apologies for my lack of PM expertise.  I don't think the device would
> *respond* to PME#, would it?  I would think the device would
> potentially *generate* a PME#.

Right.

> And I guess since this device can generate PME# only from D3cold, the
> implication is that runtime suspending the device may put it into D1,
> D2, or D3hot, but not D3cold?  Is that an axiom of the runtime suspend
> design?

No, it isn't.

Runtime PM is expected to only put devices into D-states from where they
can generate PME.

Before the problematic change it would just hold the device in question in D0,
but after that change the device will be suspended (in which case it will end
up in D3hot which is incorrect).

> > > > usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
> > > > device_can_wakeup() in pci_dev_run_wake() always returns true.
> 
> I think "mandatorily" means "always" or "unconditionally", right?
> 
> > > > So pci_dev_run_wake() needs to check PME wakeup capability as its first
> > > > condition.
> > > >
> > > > In addition, change wakeup flag passed to pci_target_state() from false
> > > > to true, because we want to find the deepest state that the device can
> > > > still generate PME#.
> 
> Is this a separate bug fix?  I don't understand how it fits in here
> because the wakeup flag means "Whether or not wakeup functionality
> will be enabled for the device", and you're not changing anything
> about whether wakeup functionality will be enabled.

For runtime PM the "wakeup" argument of pci_target_state() should always be
"true", so technically this may be regarded as a separate issue, but this
change is needed as a functional fix for the device in question along with
the reordering.

Since technically there is a state from which the device can signal PME,
device_can_wakeup() returns "true" for it, but this isn't sufficient for
pci_dev_run_wake() to return "true" (because that state is D3cold and
the platform cannot power-manage the device, so the device cannot be put
into D3cold directly).  That's the first thing that needs to be changed.

On top of that, we need to look for a state from which the device can
generate PME.

> > > > Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
> > > > dev_pm_info")
> > > > Cc: stable@vger.kernel.org # 4.13+
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > > v3: State the reason why the wakeup flag gets changed.
> > > >
> > > > v2: Explicitly check dev->pme_support.
> > > 
> > > If this patch is good enough, I am hoping it can get merged in v4.17.
> > 
> > OK
> > 
> > Bjorn, if you want to take this:
> > 
> >  Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Otherwise please let me know and I'll queue it up.
> 
> de3ef1eb1cd0 went through your tree, so I think this fix should go
> through your tree, too.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

OK

> Not directly related to this patch, but I think these comments in
> pci_target_state() are slightly misleading:
> 
>    * Call the platform to choose the target state of the device
>    * and enable wake-up from this state if supported.
> 
>    * Find the deepest state from which the device can generate
>    * wake-up events, make it the target state and enable device
>    * to generate PME#.
> 
> AFAICT, pci_target_state() does not actually "enable wake-up from this
> state" or "enable device to generate PME#".

Right, the comments appear to be stale, I'll send a patch to update them.

Thanks,
Rafael
