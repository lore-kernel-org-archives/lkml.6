Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2432626-1519637656-2-15236263444622267282
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
    t=1519637655; b=DdYoPJBMtkaGwHzBu1kkOYAhi+GzL4fQZQ3VrdojasTwGP0
    7Aee7Quurnyw/5IQchZapwJ8gAXFUFdf/qWLbE4hU9DXsM0XmZ/3a9kQEe42aPLq
    8Hwvvuv2NP9xGZHmKXwUCXb0Kp9qvBb9KwpPOzVXh54yRgI3+3VuY/4TwhNIlnny
    nkxKf+k7DW7e6mUkkH8BXwG+9XTRo2rkuklAub9VMiQMGkXQ075/Tx+VTfE1fv82
    6HVgmyD1wE9kvVEDyfa9lcxSEErC2QZ0GUByyluM1NcccgIbJpBq7DT/GMfBrfCv
    OQydTKCeeliFPLD1RoIRBWiW5PG4h2ZXlowVCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519637655; bh=A/2okSQjszUooOQcPA1Hyv5AF+9VIQrkxJqDAo4OFt8=; b=P
    oSLg3FI9OAkGMZLNBCIL83ExEYXUztbkM35IFWxNPdxLXC/AH29SCZz4cA0MjAY5
    WEnBe1agVXtSaz3fcTxvB+zaph6tcRiwj7nExeS2e0/N/fkQmGmvXRq/xQMEojnf
    s5q4U2xtx0O/Izs2+mUlkQedl5R1EO/w7HaW9VOHY9NB70RzLCHkT+I1eGz2MQYJ
    NwIRQzhqO/yhPmKTK+VXW4+nJ+bs36g8qebjBMC/jrpe3Msgdn3TCiVJo+8QWXaj
    gAbRDEDnbtamCYNp2o8NkpQlyRcaVmx7FkEx/jkiKR4PE4/y1ml9hDxjbquRavZg
    0ZISlseK4LQGJcTpMqg8A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeBZJeN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 04:34:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33565 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751022AbeBZJeN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Feb 2018 04:34:13 -0500
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <p.zabel@pengutronix.de>, <heiko@sntech.de>,
        <ed.blake@sondrel.com>, <jhogan@kernel.org>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519381801.10722.103.camel@linux.intel.com>
 <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
 <1519407117.10722.124.camel@linux.intel.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
Date: Mon, 26 Feb 2018 09:33:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1519407117.10722.124.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23/02/2018 17:31, Andy Shevchenko wrote:
> On Fri, 2018-02-23 at 11:02 +0000, John Garry wrote:
>> On 23/02/2018 10:30, Andy Shevchenko wrote:
>>> On Fri, 2018-02-23 at 02:42 +0800, John Garry wrote:
>>>> There is a requirement
>>
>>> Where?
>>

Hi Andy,

>> We require it for a development board for our hip06 platform.
>
> Okay, and this particular platform uses Synopsys IP?

As I see this uart is really a virtual 8250, so HW details like apb 
clocks and the like are hidden, so may not be relevant.

However I will check with the BMC team to know the specific details.

>
>>>>  for supporting an 8250-compatible UART with
>>>> the following profile/features:
>>>> - platform device
>>>> - polling mode (i.e. no interrupt support)
>>>> - ACPI FW
>>>
>>> Elaborate this one, please.
>>
>> So we need to define our own HID here, and cannot use PNP compatible
>> CID
>> (like PNP0501) as we cannot use the 8250 PNP driver.
>
> Why not? What are the impediments?
>

To support the host controller for this device, we will create an MFD, 
i.e. platform device, per slave device.

>> This is related to the Hisi LPC ACPI support, where we would create
>> an
>> MFD (i.e. platform device) for the UART.
>
> Why you can't do properly in ACPI?
>
>>>> - IO port iotype
>>>> - 16550-compatible
>>>>
>>>> For OF, we have 8250_of.c, and for PNP device we have 8250_pnp.c
>>>> drivers. However there does not seem to any driver satisfying
>>>> the above requirements. So this RFC is to find opinion on
>>>> modifying the Synopsys DW 8250_dw.c driver to support these
>>>> generic features.
>>>
>>> Synopsys 8250 is a particular case of platform drivers. It doesn't
>>> satisfy "8250-compatible UART" requirement.
>
>> Right, but I wanted to try to use the generic parts of the driver to
>> support this UART to save writing yet another driver.
>
> It's still odd. Why this one, why not 8250_foo_bar to touch instead?
>

Agreed, it's odd. I choose as 8250_dw.c as it has ACPI support already. 
And I recognise the hw from popularity. No stronger reasons than that.

Thanks,
John


