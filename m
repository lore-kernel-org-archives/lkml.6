Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2046117-1524725667-2-765014156867207157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524725666; b=MEp1j3ZxgEPep5WVPmK4wqkhy0uG6D+UgNdLIL7QsrH6xt2ZSF
    6fjiYwjubtGeyouqI3ulSXlVOusNW2Zkr5wrINg3bUSLScHH4rueiW2peaGHrH9A
    IApUih9z6CX4REBaH5WSl0N+P9SULRdKf2ILU/wKsF73wFLT/iZSFKaAlyyp/NaR
    BWvGGhby8RwmBXHQgp0tYvLImxJoAw9/NshfRb3Hz/zsEDrcPksNtn1/zD+t2bsY
    qYyoE+HHBeEw4GG7pYZLleEOFq97cMJhU9AWd71EnU4SVOwo48t8F8jYBlO8xy83
    97GBeaFRGia1104Lh3cbkXUQEb2fkxyEgmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1524725666; bh=+dZmZAqcY
    Q45LkC0qrgni6ul9o0NYD7EfBCx04abjx8=; b=hsMYyUSBs4lCFqmXHQ104WZCQ
    2SSO8Yc292xxBfHab6YLkQ5u2pRa1n/+5hVmi+FCNkzGXuyQfOxO0OruxoCcVBzB
    Rn1/hsC/WKAtnjyBzCSUv9xrGn2oQnV8ZllvpvTl1ELsOtz+ifb/wM6BjtsOdHW6
    7iRXRagsfPB5VUW+O2kPB3gYo7AxGsACEoFcwQtiyX4+Jje/o4L/P/NZQdqMDAFv
    mvW4JxeVIfT6M2sX/VrG2Oizs4uFbUVDUSD7ZvtR4WCcWmF7uSAi4P+jx1KxWSgy
    TvthY66e9GyEJpvzVcAIDLioWlrRMXNeYNG72kpNt3DQQy3yCvNl9ijy7WnKQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p8ycrPqA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p8ycrPqA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHgJqYJfe4EQ2QQazeianMbUcwny3keg3cdLZPr0oK4lBACI26Z6EHDJNHrWRFtZ9RQeSWCjGQuRewERKAlwfgl9WNc2KpxoEV4PuNVjCYFVNcRkeKEH
    zMGbn/9HIV/6bx34ZvTUpI2UoMEzPnJ+GmPJKOKXN4JD48jpptDEZKgb5J8yHm2e5z7JR+PP78be0/peimS9fp1psHCF0wxU3xDHhJdm6y0PheD4EK62KB4I
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=p-nOP-kxAAAA:8 a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
    a=2dK-GM5NKjdM7omtH-EA:9 a=CjuIK1q_8ugA:10 a=XN2wCei03jY4uMu7D0Wg:22
    a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753876AbeDZGyX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 02:54:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58338 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753325AbeDZGyV (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 02:54:21 -0400
X-Google-Smtp-Source: AIpwx48T1iBRYsGhwIVlG1I4Zx4ppD46ehDhhgoZj0GSWCHobbljtXfFEwhaPNUsdiROUnzEIaySeg==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v3] PCI / PM: Always check PME wakeup capability for
 runtime wakeup support
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <10732937.eAR6mAEfiz@aspire.rjw.lan>
Date: Thu, 26 Apr 2018 14:54:14 +0800
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <C07517A2-0AE5-4EE2-AB64-7F0767C988DF@canonical.com>
References: <20180331164022.24220-1-kai.heng.feng@canonical.com>
 <798A7C7A-A3DA-4C0E-A774-48042430EE1A@canonical.com>
 <10732937.eAR6mAEfiz@aspire.rjw.lan>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On Apr 13, 2018, at 3:29 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, April 13, 2018 8:58:11 AM CEST Kai Heng Feng wrote:
>> Hi Bjorn and Rafael,
>>
>>> On Apr 1, 2018, at 12:40 AM, Kai-Heng Feng <kai.heng.feng@canonical.com>
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
>>> In addition, change wakeup flag passed to pci_target_state() from false
>>> to true, because we want to find the deepest state that the device can
>>> still generate PME#.
>>>
>>> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct
>>> dev_pm_info")
>>> Cc: stable@vger.kernel.org # 4.13+
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>> v3: State the reason why the wakeup flag gets changed.
>>>
>>> v2: Explicitly check dev->pme_support.
>>
>> If this patch is good enough, I am hoping it can get merged in v4.17.
>
> OK
>
> Bjorn, if you want to take this:
>
>  Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Otherwise please let me know and I'll queue it up.

Hi, Rafael,
Can this patch be merged into your tree?

Kai-Heng

>
>
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
>>>  		return false;
>>>
>>> +	if (device_can_wakeup(&dev->dev))
>>> +		return true;
>>> +
>>>  	while (bus->parent) {
>>>  		struct pci_dev *bridge = bus->self;
