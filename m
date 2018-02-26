Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2556621-1519641983-2-18216757851593958759
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519641982; b=JuRYUDWPUkP/QR7Nr4p5M0zZrdL3NAw43++9/bWk1u7Ii0J
    7E+G06uEZCG5chlAMc3iToYj8cY3M/8vrz3PFB+I6oi0jeHcvbzu6CL8lbwiaUpm
    PEVWrsuTbXptdcDZkZIUNRoCkWDdEROG01mgzxPB4sHvme02SRKwoH1zaRNMZBuM
    XWEp1w1FaZe4GcTUTVY8vINn9RM7lEoeGdDHArkIGBBl0U89qNpOG9uhQUzRoJuU
    bqxn5kVMoJqoSE8ghmxj25t2P5+6ESx+UoCzZEAxJ+DPJBfzaFMGJQuTdVUQWfg3
    gUwIiHGH2wHbdpi25+GpzdbK3NApOyDcgg40osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519641982; bh=cGHUiMVKLTWFNPeN5fZdaSFtkM6R0eZoBdnjrjAgcEw=; b=b
    VO+kSG77cY0iosgY7xqKRHvh4dnYg3ETE4c2m5hGl4sZm0sXzO2aCbEXquwTi6GJ
    y29mksef1mh/ADAhk+s4SK3ZeSY4S6r6jF55NNNyrHVd6IsayGY3NlGMWKHJD5Az
    oac33yTJTrnzywsJCYVexiW4Vzi7slUaTth5Qwo6YYuE2SYeU+EeM/ug8+lYCySl
    9IA1jAJBb20JNVU+dojwIP0d47t6icATZaFM88JxJ2EmVCX4F8zkXfEcWcWMWP+6
    TxBjNYABcBRnc8cE+7E74CiTzQYCLYPeF4kjup4rQdy6cJ7QiBayISAS2aj37nL7
    Eb9MxuSIQE8trs7/8+qwQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeBZKqT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 05:46:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751609AbeBZKqT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Feb 2018 05:46:19 -0500
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <p.zabel@pengutronix.de>, <heiko@sntech.de>,
        <ed.blake@sondrel.com>, <jhogan@kernel.org>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519381801.10722.103.camel@linux.intel.com>
 <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
 <1519407117.10722.124.camel@linux.intel.com>
 <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
 <1519638828.10722.153.camel@linux.intel.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
Date: Mon, 26 Feb 2018 10:45:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1519638828.10722.153.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi Andy,

>>>> We require it for a development board for our hip06 platform.
>>>
>>> Okay, and this particular platform uses Synopsys IP?
>>
>> As I see this uart is really a virtual 8250, so HW details like apb
>> clocks and the like are hidden, so may not be relevant.
>
> Good to know.
>
>> However I will check with the BMC team to know the specific details.
>
>>>>>>  for supporting an 8250-compatible UART with
>>>>>> the following profile/features:
>>>>>> - platform device
>>>>>> - polling mode (i.e. no interrupt support)
>>>>>> - ACPI FW
>>>>>
>>>>> Elaborate this one, please.
>>>>
>>>> So we need to define our own HID here, and cannot use PNP
>>>> compatible
>>>> CID
>>>> (like PNP0501) as we cannot use the 8250 PNP driver.
>>>
>>> Why not? What are the impediments?
>>>
>>
>> To support the host controller for this device, we will create an
>> MFD,
>> i.e. platform device, per slave device.
>
> There is no answer here...
>
>>>> This is related to the Hisi LPC ACPI support, where we would
>>>> create
>>>> an
>>>> MFD (i.e. platform device) for the UART.
>>>
>>> Why you can't do properly in ACPI?
>
> No answer here either.
>
> Sorry, but with this level of communication it's no go for the series.
>

Sorry if my answers did not tell you want you want to know.

My point was that the 8250_pnp driver would be used for a pnp_device, 
but we are creating a platform device for this UART slave so would 
require a platform device driver, that which 8250_dw.c is. But I will 
check on pnp device support.

Much appreciated,
John




