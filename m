Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3949122-1521101845-2-5404772281837583590
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521101844; b=Vx9SAj/1bKfT7Qb6mtjdQFJ6Zij+4LcalcTBtiLE03IFNAP
    bsUa34iIVsABjBa/ULe/kbFgVmqVCBmF/VqGbyxfPOCzvQqFcyaKF/d5LNuFnh+U
    DTE/q3leytsl2AZVyknt7k9azDU1wXfqDLbxAE7828lBxtCJNKePVvettelZkWlf
    MvB5b8XAFvBj5mGlLmuf/LkF0a0eqC7acz/76XEipj6Qu5HabCgaVSh4ueSm/3sr
    MntEUbbyThcFD2wJpT/uw0HDuFeYnddDz4xRJX4CSk/FFIDxWQFon2CJnhE2RKui
    xS+InBZ8lAEa7qTL4AsPoVJmorZPSM7q4z7ndqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521101844; bh=xJmzkdBwKln9K6MK8KHh8SRHk6o/ZGexzfR8Gr+OS3g=; b=b
    +5TyBv7EHHLn/M0jMa67dKZT3/grgRlu5uG5rykwG62msqusL6PrNNupp8Km8gHG
    HqSQt+berXVEmUkyj3FbqM3fyOwXn2IMy0HMlOFnfjN/p7dRo47ibHdXcdW8NWXv
    8rrM6oZF8xbXDDGA8iFdjOeDk8M7FBSWjQd9MtV0ji0+oIwQq5UGJiRI9k8FrERa
    SzhX6Ac8j5IGFLVxP7JTFy/fMEt7oMy7VSC1I4WuTf/a0WrLl7ybZo1RWt8/dQUK
    yFFWb3NqFa/SFD26vG1OPsOt1mU+8fC7/JnAYswXlSP5+o+2U/4cqUTXYNGt6jj0
    lPC6UqHn1wfurnDRprlSA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=QVgSGNkC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=lo6Xu65x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=QVgSGNkC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=lo6Xu65x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeCOIQp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 04:16:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeCOIQl (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 04:16:41 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D02860390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v1 2/2] usb: dwc3: Add Qualcomm DWC3 glue driver
To: Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org>
 <1520937362-28777-2-git-send-email-mgautam@codeaurora.org>
 <878taw8c81.fsf@linux.intel.com>
 <5a65d202-bb94-0f73-f9aa-9055a1cddf76@codeaurora.org>
 <87woyfrqgr.fsf@linux.intel.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <78b262e9-5682-0a56-3589-b5736fec10bc@codeaurora.org>
Date: Thu, 15 Mar 2018 13:46:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87woyfrqgr.fsf@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,


On 3/14/2018 2:20 PM, Felipe Balbi wrote:
> Hi,
>
> Manu Gautam <mgautam@codeaurora.org> writes:
>
[snip]
>>>>  - Support to replace pip3 clock going to DWC3 with utmi clock
>>>>    for hardware configuration where SSPHY is not used with DWC3.
>>> Is that SW configurable? Really? In any case seems like this and SESSVLD
>>> valid should be handled using Hans' and Heikki's mux support.
>> Yes, with this we can use dwc3 without using SSPHY. Please point me to
>> those patches. There are only bunch of register writes in glue wrapper to
>> achieve the same.
> https://www.spinics.net/lists/linux-usb/msg160868.html

I looked at the patchset and thinking that adding mux for this may
not be of much help here. Qscratch is part of dwc3 wrapper
and uses same clock domain for its registers. Hence, I can't
have a separate mux driver for same. Will have to register
mux controller from this driver for these and use only in this driver
as I dont expect any other client for same. So, can I proceed with
existing logic?

>
>>>> +static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
>>>> +{
>>>> +	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
>>> nope! Glue shouldn't touch dwc3 at all.
>> Other than PHY handles, need this to fail runtime suspend if dwc3 hasn't
>> probed yet.
> Will that even happen? You should pm_runtime_forbid() by default,
> anyway and expect it to be enabled via sysfs later, no?

It happens if I enable runtime_pm from probe which is the case right now.
I will disable it from probe as you suggested.
In any case dwc3 uses pm_runtime_forbid and expects it to be enabled from sysfs,
so I dont get any benefit of enabling it from glue driver probe.

Other than this, I need to access 'dwc->xhci' to resume root hub on remote wakeup.
That I missed to mention earlier.

>
>>>> +	dwc3_qcom_suspend_hsphy(qcom);
>>>> +
>>>> +	if (dwc->usb2_generic_phy)
>>>> +		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>>>> +	if (dwc->usb3_generic_phy)
>>>> +		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
>>> core.c should do this.
>> Recommended sequence from h/w programming guide is that:
>> 1. PHY autosuspend must be left disabled - snps,dis_u2_susphy_quirk/dis_enblslpm_quirk
>> 2. During runtime-suspend (say on xhci bus_suspend) , PHY should be suspended
>>     using GUSB2PHYCFG register
> this is something that dwc3 core can do on its own suspend implementation.
>
>> 3. Wait until pwr_event_irq_stat in qscratch reflects PHY transition to L2.
> this is interesting part. Is this register accessible by the PHY driver?
> Seems like that would be the best place to stuff this...

This register is in controller wrapper which PHY driver can't access.
Also clock domain is different.

>
>> 3. USB2 PHY driver can suspend - enable wakeup events and turns off clocks etc.
> ... together with this.
>
>> 4. dwc3 glue driver can suspend.
>>
>> Since, pwr_event_irq stat can't be checked in core driver, I added this handling
>> in glue driver. Alternative approach I can think of is to let dwc3 core suspend
>> PHY using GUSBPHYCFG register on suspend,  add some delay before
>> suspending PHY. Glue driver can check for pwr_event_irq stat and throw a
>> warning if PHY not in L2.
> almost :-) core_suspend fiddles with GUSB2PHYCFG for suspend and calls
> phy_suspend() (or whatever the function is called heh), that will go to
> your phy driver's suspend callback, which checks pwr_event_irq_stat and
> then pm_runtime_put() to schedule ->runtime_suspend() so that can enable
> wakeups and switch off clocks.

Since phy driver can not access pwr_event_irq_stat, should I just use some delay
and assume PHY gets suspended?

>
>>>> +	irq = platform_get_irq_byname(pdev, "dp_hs_phy_irq");
>>>> +	if (irq > 0) {
>>>> +		irq_set_status_flags(irq, IRQ_NOAUTOEN);
>>> why do you need to set this flag?
>> These wakeup_irqs should be enabled only during suspend. With this flag I
>> don't need to disable irq immediately after requesting it.
> oh, okay. You may want to add a comment here :-)
Sure.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

