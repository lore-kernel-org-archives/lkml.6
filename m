Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4052609-1519563688-2-2569121321407332437
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519563687; b=bzzHOC3LwyinxSAAxs50BVelcWgWfD0Nq20lTmhNoK+fm6H
    rtXvBmVrGvxjh2GxSPlAqDpY2XruuB/4jbm6iJpAw1nUmurCfVmCM7yQVgal+1cE
    U6XFJir9jnJtxyoBri8nCTzs74Ag+NdaGIibXHEPsW7w21g0xVDJGe8yWrzHonaJ
    5ugucSPqkq/XlndwNsnb/W6KER7M+nJVhNFlDCYeGHg7hx5G1uJAupqm1RomKBAm
    DJDpvJO1IF2r6L6gtkhgLk0eflpilHO0cq+Irm0FiK1qbvXYon+XGp+jvh2h76Ng
    Wyr8fDGcxxuPAMGjibPQOEoa5HkvhPfjWXJ4cLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519563687; bh=QltXXO5/zRV/lfMvTjkpcsPOihE3SYXJC4kskxpB7OM=; b=E
    Ioy9QMqoYokYvdeJq1CLJ7Hlvpc7GiA6JvPRNJperT+2FDziUAHIR8DQ0jRXHAsZ
    rpUBFmkMOaDeicqRccbLCLnxs9KeSP6pSHFVQNmZk8Lk9Jmro9A5szXj08Wao0Hb
    LqTwo429p+e2fjCo6+vZUcxee7zr+X4pdv529oVJ+k74K6crlWiIIRdfJxtJewci
    wbhyBeyX6O701c2Gxtuo3N8iLrLxSKJTlLEZ3kTri8f5/xHbuXlII2jcotd1qrpC
    PKZC4N+m+RA3mK952/lZn168tyE/18YUOTFXC/cawh5H9LExkefhAiUYohoZi7DS
    wCOih4xd+4MsjxDfEGApQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gPh19LFy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gPh19LFy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeBYNBM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 08:01:12 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:40870 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeBYNBK (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 08:01:10 -0500
X-Google-Smtp-Source: AH8x224xKp3btfvGTMefj8oppOvDu4txnFSDAeyFWJtkq9gl+bWHOlXUU1tHgqO8BZhKNTlmnBANpw==
Subject: Re: [PATCH 08/12] xhci: Add Intel extended cap / otg phy mux handling
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-9-hdegoede@redhat.com>
 <CAHp75VdFXO+r25PPKEvTv61oNSReL9uqbF-ni8Z1YaxAzSze3Q@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <6244675b-715b-bf8a-9f35-212d6a37308b@redhat.com>
Date: Sun, 25 Feb 2018 14:01:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdFXO+r25PPKEvTv61oNSReL9uqbF-ni8Z1YaxAzSze3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 14:53, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The xHCI controller on various Intel SoCs has an extended cap mmio-range
>> which contains registers to control the muxing to the xHCI (host mode)
>> or the dwc3 (device mode) and vbus-detection for the otg usb-phy.
>>
>> Having a role-sw driver included in the xhci code (under drivers/usb/host)
>> is not desirable. So this commit adds a simple handler for this extended
>> capability, which creates a platform device with the caps mmio region as
>> resource, this allows us to write a separate platform role-sw driver for
>> the role-switch.
>>
>> Note this commit adds a call to the new xhci_ext_cap_init() function
>> to xhci_pci_probe(), it is added here because xhci_ext_cap_init() must
>> be called only once. If in the future we also want to handle ext-caps
>> on non pci xHCI HCDs from xhci_ext_cap_init() a call to it should also
>> be added to other bus probe paths.
> 
> SPDX?

Ack, fixed for v2.

>> +/*
>> + * XHCI extended capability handling
>> + *
>> + * Copyright (c) 2017 Hans de Goede <hdegoede@redhat.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
> 
>> +       pdev = platform_device_alloc("intel_xhci_usb_sw", PLATFORM_DEVID_NONE);
> 
> Perhaps,
> 
> #define USB_SW_DRV_NAME "..."

Ack, fixed for v2.

>> +       if (!pdev) {
>> +               xhci_err(xhci, "couldn't allocate intel_xhci_usb_sw pdev\n");
> 
> ...and re-use it everywhere here.
> 
> pdev -> platform device.
> 
>> +               return -ENOMEM;
>> +       }
>> +
>> +       res.start = hcd->rsrc_start + cap_offset;
>> +       res.end   = res.start + 0x3ff;
> 
> Is this magic always the same? Where its value comes from?
> At least define with comment.

Ack, I've added a USB_SW_RESOURCE_SIZE #define for this for v2.

>> +int xhci_ext_cap_init(struct xhci_hcd *xhci)
>> +{
>> +       void __iomem *base = &xhci->cap_regs->hc_capbase;
>> +       u32 cap_offset, val;
>> +       int ret;
>> +
>> +       cap_offset = xhci_find_next_ext_cap(base, 0, 0);
>> +
>> +       while (cap_offset) {
>> +               val = readl(base + cap_offset);
>> +
>> +               switch (XHCI_EXT_CAPS_ID(val)) {
>> +               case XHCI_EXT_CAPS_VENDOR_INTEL:
>> +                       if (xhci->quirks & XHCI_INTEL_USB_ROLE_SW) {
> 
>> +                               ret = xhci_create_intel_xhci_sw_pdev(
>> +                                                           xhci, cap_offset);
> 
> Can we leave xhci on previous line?

Fixed for v2.

>> +                               if (ret)
>> +                                       return ret;
>> +                       }
>> +                       break;
>> +               }
>> +               cap_offset = xhci_find_next_ext_cap(base, cap_offset, 0);
>> +       }
>> +
>> +       return 0;
>> +}
> 
> 

Regards,

Hans
