Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-507227-1525254109-2-6973759174404618967
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525254108; b=NnC9ShckStS+1s8hxK4Cyjt29wcKQOf45c5Lp3/J8jgFT6aKW4
    6BtKQagwDRnuUrR/Dp0VX7maH5MVZfbFu2Y2hAYcoMFljIAX7KulF8ti4rVhXH2V
    u/68xBOrrUITjBUMxD35mHDrWg5LDqPzFjO8lWHRJmSUNc354XD4wI5ow5smEn9C
    wV+LMu7+bqnaK4PFhG3SZ8rfjk8/BqVhRBwrmG8fn3Jlw5Jn1EVToldTy1Bjg9wM
    n5W+dnsMp5ydAn9yOr/60a8TfZQi5AvJK6NfaW0WlHuGayeRGByBhTwBgY4R8MCR
    X3a7rExyuvFPuNag5WmSWKyPGVC4mME4bH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525254108; bh=U8GmfkxYYHeMQjjHh0XwVQo6EvaL8enTqTzN0HcKbR
    8=; b=RBGeI1RKL4OCz8Dmx7NF0dezSAMjxECzW/B2BarizTHntaKrdhEKS2gl29
    WQ+jGWvN13KcCYI1AWGH9OC6E8RZR5j93VM1ONDJV+Zt+XhPPMxTlivOS2kq9LSe
    STyH6GCygxPUVpByDYcMQSMHmiIsXZC5EcWdCu0ek3F6vHLeyHV2agShyBevcKaL
    xaEPidLtKFwxsjRYwX5VPJfz9WwUtN2SRI9Qnlat8NX8EbaCpLaRYjYZ+/odLJKb
    W0CMbz+bV00gpsfsluVr4LKPc9uJa7nhTZOxcVM8jHxqzmiYhFr2PExRkMMZgVjC
    jJxbyFvdtTDNFn2UC5ze7hYAtlrw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=EiksASiA x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=cBI0y2eq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=EiksASiA x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=cBI0y2eq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEKBamIywpIt2OpkMVNwWeFm08xSe3Pc3AeemGbSsXlGHl6lM/9Z0B1eiVGKqnDJctDN37dSy3iCafaqA7ZE55VOdadQpn6MsQTm3rI7CLEIKiywmGmE
    iVuuuZdt52mIElUAjctcndmrUsX56R7kAjutdGmq+XPyB54GWV9FlTPAALcAt6+Y+M0xu3C8Eo8OGxG9NkbSLtuIRuNmZS+zWB38iWBZDRpOoIKzKBcS2c1Z
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=NufY4J3AAAAA:8 a=7CQSdrXTAAAA:8 a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8
    a=_ENdC2KUInGSnSt8ppAA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10
    a=NWVoK91CQyQA:10 a=TPcZfFuj8SYsoCJAFAiX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeEBJlo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 05:41:44 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:44044 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeEBJln (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 05:41:43 -0400
X-Google-Smtp-Source: AB8JxZqJrTTzn7hp06IWoX7dbN+emZXT/e9k3oIpr4IDt3m8haPCCeJgWyBdGtyKzrxqG4bFGbYVdZlc+l8TsqVScDw=
MIME-Version: 1.0
In-Reply-To: <20180502091851.vr64q7atvd2tovpy@localhost>
References: <20180502080631.sriwquzcky6t24c2@localhost> <CAKv+Gu_rgLs2CP4Lpx=CwgmCsEm01sbn9vPzZ4z4JqVaFBtC+g@mail.gmail.com>
 <20180502091851.vr64q7atvd2tovpy@localhost>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 2 May 2018 11:41:41 +0200
Message-ID: <CAKv+Gu_S62zT_RqymKW3jD_AAUuFNrQ=iBUu16Q2vQojs2P-Qg@mail.gmail.com>
Subject: Re: Regression due to "Workaround for uPD72020x USB3 chips"
To: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bockholdt Arne <a.bockholdt@precitec-optronik.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2 May 2018 at 11:18, Domenico Andreoli <domenico.andreoli@linux.com> wrote:
> On Wed, May 02, 2018 at 10:22:05AM +0200, Ard Biesheuvel wrote:
>> On 2 May 2018 at 10:06, Domenico Andreoli <domenico.andreoli@linux.com> wrote:
>> > Dear all,
>> >
>> >   my home machine stopped to boot starting from kernel version 4.12.7.
>> >
>> > The last message I read is about resetting some USB3 bus. It's 100%
>> > reproducible also with any recent kernel up to 4.17.0-rc3.
>> >
>> > I bisected down to the following commit:
>> >
>> > commit 0e1f0eaed6c20db41ff61e024b361ee3ec9d686c (tag: my_broken_xhci)
>> > Author: Marc Zyngier <marc.zyngier@arm.com>
>> > Date:   Tue Aug 1 20:11:08 2017 -0500
>> >
>> >     xhci: Reset Renesas uPD72020x USB controller for 32-bit DMA issue
>> >
>>
>> Hello Domenico,
>
> Sir..
>
>>
>> Long time no see :-)
>
> Instead I see you pretty much everywhere :P
>
>>
>> Please refer to the following thread
>>
>> https://marc.info/?l=linux-usb&m=151872295419486
>>
>> for some discussion on this topic, and a possible workaround.
>
> Interesting, thanks for the pointer!
>
> I'm happy to learn I've this nice piece of HW in my machine. It might
> have at least some other issue while trying to hibernate (there is a
> fair chance for it to abort the process because of some "business").
>
> I tried the usb/uPD720202-reset branch from Marc (with some massaging
> due to quirks now being >32) and my system boots again. I think it's
> more because of the PCI reset is removed, I am not affected by the
> original issue it was meant to fix.
>

Indeed. The majority of x86 machines never perform DMA above 4 GB in
UEFI, so the issue does not occur, although it could still affect a
kernel with IOMMU on kexec'ed from a kernel with IOMMU off.
