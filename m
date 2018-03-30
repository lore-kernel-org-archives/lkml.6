Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3097409-1522402232-2-10814386102610810484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522402232; b=mcKBNI5TD02Q3t1yzBnx6uNAbJw6OFfnYorgmYLhE4Md0luzDE
    ywj3AtAKMwiMwubBmMia95qZ5mrzpIIYegTFvS1r5DOtB2FR6BSFRr7QKwlyN+Dk
    s+opqsHQqS2UrZerl3PWgNdQIz0a9rV+dg3q0fMECBI2gyOun6BVJCFqjqPsm5px
    QcrdSAw/G0IKDqoNAmrvpusOOPx94/EFib31jnMSubjF3RJxAkhWxMNbnLq79bnu
    5XWuCGnOlHiFf2YMP4BM7LVLGN/aa1mOeFixi0vIl4ONo9zfVih4bSZmNphiUDX0
    79H188OLr8Mtt3JSVbpHjFbpkWwJQnzhng5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1522402232; bh=g/a4cfsM1
    UH22rsj6hnFohEIi5QK5lz9362uQGu72E8=; b=jEltKiz0vJPtCZtF2QjPqOlzf
    kRaFK0CtObNwszn+sqPhsQ16Hv5HxWG/oY7pxqXnsbXWJPTQCOQ88v7TgVW5wjXG
    nEBFEEcVWJ+3tQPlfAStwVGggLIV18KsTHwnWh1rX2cHbgjuiP6meLdbaF9e+D3s
    AQrrJ9Fb6ee9bJWIcc5m1jd9z8u3JCmW9RSD/z9sJJIka7Mcyx3nOpu4YOVKQxlc
    MuQsYAMZZNGitLkOVipLZDRJ6gkg7Ai9W7cmMc6utd0E3OUJDOfC7Ac5NVOlodhl
    zFCmmGjtrljyYpbbhTDfQzdsMnyWpRY6gTI8jb6pA16D5XDFpMCmtIcyyLriA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L2pG0xfB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=L2pG0xfB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVG8a9Q57h34prW12DFBQh1yn/dRCQqQ7jP8nuzO7F1t27mxQZMoWJwlOKWr4DDQciDNVtBKX+HS8mGN4gJq7JJy3stQlbf9uIwJqooHgiC26wBRRZo
    3A1a1L9K14YF3zsBHcstJogvhR5jWovPYCn8u4m1Wd3OzI/7OmFF671TE/ySirZUr+dCUt/EC5RUKjunOkbRMbCJcB6Y7EmrRGI0qrB1b76Gw1DRbYyS82sT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=p-nOP-kxAAAA:8 a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=2dK-GM5NKjdM7omtH-EA:9
    a=CjuIK1q_8ugA:10 a=XN2wCei03jY4uMu7D0Wg:22 a=rjTVMONInIDnV1a_A2c_:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbeC3JaU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 30 Mar 2018 05:30:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58800 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeC3JaS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 30 Mar 2018 05:30:18 -0400
X-Google-Smtp-Source: AIpwx4/7KC3+weeAU9VwlSLB5W75PBi9X+8L9UHLiOLPfonWhTNGh+eWbpJ0PaQip9s64d2Wriygdg==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2] PCI / PM: Always check PME wakeup capability for
 runtime wakeup support
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1748267.LlfkqdCPEG@aspire.rjw.lan>
Date: Fri, 30 Mar 2018 17:30:10 +0800
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <44B8B950-4C07-447E-9F12-AD60C536150F@canonical.com>
References: <20180319140910.26496-1-kai.heng.feng@canonical.com>
 <5DC805B1-51DA-4D0F-9A43-9D5FE549AB13@canonical.com>
 <1748267.LlfkqdCPEG@aspire.rjw.lan>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> On Monday, March 26, 2018 7:54:35 AM CEST Kai Heng Feng wrote:
>> Hi Bjorn, Rafael,
>>
>>> On Mar 19, 2018, at 10:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> wrote:
>>>
>>> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
>>> core: Drop run_wake flag from struct dev_pm_info").
>>>
>>> The device in question is not power managed by platform firmware,
>>> furthermore, it only supports PME# from D3cold:
>>> Capabilities: [78] Power Management version 3
>>>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>>>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>>
>>> Before commit de3ef1eb1cd0, the device never gets runtime suspended.
>>> After that commit, the device gets runtime suspended, so it does not
>>> respond to any PME#.
>>>
>>> usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
>>> device_can_wakeup() in pci_dev_run_wake() always returns true.
>>>
>>> So pci_dev_run_wake() needs to check PME wakeup capability as its first
>>> condition.
>>>
>>> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct
>>> dev_pm_info")
>>> Cc: stable@vger.kernel.org # 4.13+
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>>
>> Is there any improvement I can address?
>> Or do you have any concern about this patch?
>>
>> Kai-Heng
>>
>>> ---
>>> v2: Explicitly check dev->pme_support.
>>>
>>>  drivers/pci/pci.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index f6a4dd10d9b0..52821a21fc07 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -2125,16 +2125,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
>>>  {
>>>  	struct pci_bus *bus = dev->bus;
>>>
>>> -	if (device_can_wakeup(&dev->dev))
>>> -		return true;
>>> -
>>>  	if (!dev->pme_support)
>>>  		return false;
>>>
>>>  	/* PME-capable in principle, but not from the target power state */
>>> -	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
>>> +	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
>
> So why do you change 'false' to 'true' here?
>
> At least that change should be mentioned in the changelog too.

I'll update the reason in the change log.

Thanks.

>
>>> return false;
>>>
>>> +	if (device_can_wakeup(&dev->dev))
>>> +		return true;
>>> +
>>>  	while (bus->parent) {
>>>  		struct pci_dev *bridge = bus->self;
