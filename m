Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2046117-1524725926-2-13154445179453094908
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
    1524725925; b=Qxu0nYSuJalNGV40No6hxI/tDHZkrQNVgSu8Zhw4n7QpjuYgX9
    ciUqsQHG1s90IUwHuTzcgrwICC3D6ynzob5QYbGnMPkALf3qn6flbBK8qjPxTWuM
    RHmIkR+meIqau0OTxpS66o77/oytY0GZfhlEE9frgnQ9xbdSvNlC1+IWwhl7hHye
    feiGQaXefvfVJ9i2TI2ptz5zNTGIJciJFGuIWCW0gwwMvBwwyYRrTREqM3N6fmtH
    WOjQ1hBV1Ew26OQrlTe08BRq2aLmDnywNVX0cFphFlzGFE8ixurzD+yY1w4ia9Fv
    RH7uw+AznSpJFo5Ipy3WKI/tlvtuxEYX0hyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1524725925; bh=WYF4m6VXhw
    htjneCos2HatN9TOA6tp1GpjgQvMtmmQI=; b=aDegYjO610xlGsHmOgsVqiYf1l
    QQ0QHt0S6fNv6yTHgth3BrQeHriGA74sDWjplblsM6yT49aYsN5ZxWnVE++o2i2f
    WhBP5UKEoZHVRin5BZUpCT8Cw3vLwGe8p0U5Bo3HDNKmDE9YVhLbaukXEdDSQC25
    XHxWx3lOttERaLLMKtOBCdYCgWe5M7k9ZtsCglKbp5GllEDFPzctCkCt4rQwG4Ja
    Pn/fk4526EO6HPoPavLrNXE/I5+PLLoOK8xrvEZLszIb0g/TwUUGVHPmdpGy8Fe4
    f9MBDeTHkSw/ZrTGa6fwsnucEgku+ihUG3iXRCL5BNoPCvcS2JIGvsa1s6aw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfHpRICtm+4IzMZxviGfDDMQtP5IDnt8ti9wQqJiX4XF/qpBm2qXlRHKu6PxUT5WG6yLtd3H6XTD/z80A6D/OHFo2JQv+wEVghMH65wfNFAotSaPyXRZZ
    ri7XfDHkpjFVW0KE5VL1Dpt4N64tANRUUlg1KWnDvuw+1TPwI6b+tQxOKBE08lpX4JNnKT1kau6SCHYpT9I6Gx/9BFMF3H73uDfUq6yYcJBoz9jluyIoIWCm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=p-nOP-kxAAAA:8 a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=Rz-Wza_AFUVwgLTmuoEA:9 a=CjuIK1q_8ugA:10 a=XN2wCei03jY4uMu7D0Wg:22
    a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753504AbeDZG6o (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 02:58:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58737 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbeDZG6o (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 02:58:44 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Thu, 26 Apr 2018 08:58:32 +0200
Message-ID: <190600314.NA7iiQVSFY@aspire.rjw.lan>
In-Reply-To: <C07517A2-0AE5-4EE2-AB64-7F0767C988DF@canonical.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com> <10732937.eAR6mAEfiz@aspire.rjw.lan> <C07517A2-0AE5-4EE2-AB64-7F0767C988DF@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thursday, April 26, 2018 8:54:14 AM CEST Kai Heng Feng wrote:
> 
> > On Apr 13, 2018, at 3:29 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
> >> Hi Bjorn and Rafael,
> >>
> >>> On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>> wrote:
> >>>
> >>> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> >>> core: Drop run_wake flag from struct dev_pm_info").
> >>>
> >>> The device in question is not power managed by platform firmware,
> >>> furthermore, it only supports PME# from D3cold:
> >>> Capabilities: [78] Power Management version 3
> >>>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >>>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> >>>
> >>> Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> >>> After that commit, the device gets runtime suspended, so it does not
> >>> respond to any PME#.
> >>>
> >>> usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
> >>> device_can_wakeup() in pci_dev_run_wake() always returns true.
> >>>
> >>> So pci_dev_run_wake() needs to check PME wakeup capability as its first
> >>> condition.
> >>>
> >>> In addition, change wakeup flag passed to pci_target_state() from false
> >>> to true, because we want to find the deepest state that the device can
> >>> still generate PME#.
> >>>
> >>> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct
> >>> dev_pm_info")
> >>> Cc: stable@vger.kernel.org # 4.13+
> >>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>> ---
> >>> v3: State the reason why the wakeup flag gets changed.
> >>>
> >>> v2: Explicitly check dev->pme_support.
> >>
> >> If this patch is good enough, I am hoping it can get merged in v4.17.
> >
> > OK
> >
> > Bjorn, if you want to take this:
> >
> >  Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Otherwise please let me know and I'll queue it up.
> 
> Hi, Rafael,
> Can this patch be merged into your tree?

If Bjorn tells me to do that, then yes, it can.

Thanks,
Rafael
