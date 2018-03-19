Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1782201-1521432043-2-7975065695753442850
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521432043; b=kRigp7cLwW2rgVVIQoMeh9VS/sVk/4oyZBHdSNvi6BMW6Qm
    Y8AQDN1jufac8SeHsdoB3ktAKs6qquIQuecEcsJkU+cgaDB1AXGanj9MlMU1luMJ
    igKvNB2tvahELj6p4DAdCWk2r8zeTNa8fQQNMKU1pD/Taj+z74WBPkkRx6pRuKQ5
    kFtgYpK4vQTUjwwNpRlKLIXWhhRMPAtBd8hCu3KsWD/zHegsSL8m/7AgZpEpbXye
    M2j8/uF9yqAijd6wc7H73RCqg+vGBkpq8XTJWK6K6Ip0bhl9GwD8wWl6Epei+8ap
    +sC1KU9HGQmm/gK0N+6enArlWi0ujfcsDBmhgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521432043; bh=m+5XxdzJZ9WuC7Q/tQ1ApC/+ayk1aXS9UjI+sw
    hI+So=; b=HOteJ/CocO7FhGotZ6eDqmEW3jJAJs4CZVDHRxd332aOxyB2pLfFeV
    tpoRGswfYBEuhuizzzxJANsNPuv5fbOo7FJljTESR0SxdCM99Uvjt1plHZk9M8Sk
    VfOFkHYC0DcoTkGhQ2N/rHKUNWKm9xjEh/ZgVSnG75Y0b54B9eEwGI3OvrYxFsuJ
    ojszn1Jozh24vbypnJfyR5CzkAxP82xAoJUfXRGSxtKWU5Qy0LNfivtgg2/BOdrF
    yVxAnOigTKVUqdo6haBDZ10D4oa1ENKkUH72BD6pC3gtrljECCxPXDDTDpr8q5EW
    jVewBgFR3s3rbyC7VN2ASVmxmfijLFGQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b=zhilRggr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tUT9myEe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=endlessm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b=zhilRggr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tUT9myEe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=endlessm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754923AbeCSEAk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 00:00:40 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:47035 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeCSEAi (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Mar 2018 00:00:38 -0400
X-Google-Smtp-Source: AG47ELs66FXL1F4f4auT7EnXoL+RfQ0dnPilKHQkpv6QtgJgLZeQvTQG6SYCDrj7e9WR0V0Ws3tmcV11e5BUTa9txxA=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g0DH03WYO3+7CZ2_mR+t3pJ6N9xnKL2OCOjGGRT9HiAw@mail.gmail.com>
References: <CAD8Lp45tvQP0aA=6zg+1j-_0jTxyyNxnrL=Gt0+0WrzeT6XS0Q@mail.gmail.com>
 <20180316082320.12636-1-drake@endlessm.com> <71f9b3cb-a66b-937a-8cfc-7b9127f6f5b9@linux.intel.com>
 <CAJZ5v0g0DH03WYO3+7CZ2_mR+t3pJ6N9xnKL2OCOjGGRT9HiAw@mail.gmail.com>
From: Daniel Drake <drake@endlessm.com>
Date: Mon, 19 Mar 2018 12:00:37 +0800
Message-ID: <CAD8Lp45iuZDVu++RB9ao8E9t6dBsehneXSSNebSwZdG=o02Zgg@mail.gmail.com>
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the
 system from suspend
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
        Chris Chiu <chiu@endlessm.com>,
        "Nyman, Mathias" <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:"
        <linux-usb@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 6:36 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Mar 16, 2018 at 10:06 AM, Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>> Adding Rafael directly to CC
>>
>> In short, if _S3D and _S3W are missing in DSDT then a PCI device
>> stays in D0 during suspend in Linux, but goes to D3 in Windows.
>>
>> USB wake doesn't work in Geminilake because of this.
>>
>> Should this be changed? reasoning below.
>
> It can be changed if that doesn't cause problems to happen.

I double checked that Windows 10 is going into S3 suspend and that USB
wakeup works fine on this platform - it works fine there.
Device manager for the XHCI controller clearly shows D3 being used for
S3 suspend: https://imgur.com/lF9U3V0

Current power state:
D0

Power capabilities:
00000089
PDCAP_D0_SUPPORTED
PDCAP_D3_SUPPORTED
PDCAP_WAKE_FROM_D3_SUPPORTED

Power state mappings:
S0 -> D0
S1 -> Unspecified
S2 -> Unspecified
S3 -> D3
S4 -> D3
S5 -> D3

The biggest risk of my proposed change is that we would now end up
putting a wakeup-enabled device into a too low power state where it
can no longer wake up the system. On the other hand, it solves this
issue affecting 2 different vendors, and may even result in some power
savings in general.

Perhaps we can consider the change for inclusion in Linux-4.17, giving
2-3 months of testing time.

I'll submit the patch shortly.

Thanks
Daniel
