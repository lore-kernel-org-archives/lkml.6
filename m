Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2611097-1519642483-2-4168895070966251217
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
    t=1519642482; b=Wf0KqTBc/H6j5lqVdHN1SgD31dvVVZ+VNgAGoF7vFlBaRqo
    oe2GvzntzBCopepBS2oRX/Kb2RMiCYGoF1PjnMIiUOij3zuXsnGAeFVjmHjxYqJQ
    uUpnfHHaiK0sotattEOKsoMRh6MzOkTXKcNYZB/rsU4yYiFOLxIQhnPRL+D1pkgv
    9whapIcOBT07bYuOfqiTbu50ajf/H/3pE0b+Xit8+bQnk4HKvTKGaUiiUdVBmlsP
    1jdCz84ApQ0y8LJAAMa2RlxbxwX7lQ+BBeflcWIRfwNKInogH9KQsClbY/dtc6hO
    I8faIGhR8O2NmJH5k5EvH58M10jd9uKgm7LO25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519642482; bh=wHRy678WchjhM82JyNYTEbAh4EeUyYa5iKBVxiN9fEQ=; b=m
    hExdp3hQAF1ZT+ASFLC9USX1V2Cwt1qOmsjxfmDSIokMq//7sXhLodrqVj1FJc4d
    NVHi6r1jgo72T6/73RkHTvQu1Pt+VPxn0Gu2Gfz0hI63obUGOxJmrg7hCb+VSh/I
    rzHW1FWl8PnlTvDqdfBq1zXB2c+vm2AtBwg+n0cyWUdP3dzMQ0IZ5jjt018XtgPQ
    tH5/oF0Dg2lmAoJaszkMnOuIBiAGpY1jsGFiq8uSuHY+cy3jVYYkFhhRN8LaIpSg
    VQtdc5T67JR1NJezR9YONdSuxRG5kGeLx3fiayvoDHi9GJGeYFN4FDqvqGwbH37Y
    CxjRxK/kcQnCEfr8CI5Iw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeBZKyl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 05:54:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752353AbeBZKyk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Feb 2018 05:54:40 -0500
Subject: Re: [RFC PATCH 2/2] serial: 8250_dw: support polling mode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <slaby@suse.com>,
        <p.zabel@pengutronix.de>, <heiko@sntech.de>,
        <ed.blake@sondrel.com>, <jhogan@kernel.org>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519324923-196857-3-git-send-email-john.garry@huawei.com>
 <1519407313.10722.127.camel@linux.intel.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <a97eeee3-07a0-5ca6-edc4-f5550ca4acbf@huawei.com>
Date: Mon, 26 Feb 2018 10:54:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1519407313.10722.127.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23/02/2018 17:35, Andy Shevchenko wrote:
> On Fri, 2018-02-23 at 02:42 +0800, John Garry wrote:
>> It would be useful to make this driver support some
>> 8250-compatible devices which have no interrupt line.
>>
>> For these, we allow for no interrupt, and will fallback on
>> polling mode.
>>
>> Note: the 8250 dt bindings state that "interrupts"
>> is a required property:
>> "interrupts : should contain uart interrupt."
>>
>> But the 8250_of.c driver can live without it. So
>> this patch is going this way also.
>
> It should be documented in the binding.

Agreed. I find the wording a bit ambigious in bindings/serial/8250.txt 
and snps-dw-apb-uart.txt:

Required properties:
[...]
- interrupts : should contain uart interrupt.

It uses the word "should", and not "must". Maybe "should" means "must"...

>
>>  	if (irq < 0) {
>> -		if (irq != -EPROBE_DEFER)
>> -			dev_err(dev, "cannot get irq\n");
>> -		return irq;
>> +		if (irq == -EPROBE_DEFER)
>> +			return irq;
>> +		dev_warn(dev, "cannot get irq, using polling
>> mode\n");
>> +		irq = 0;
>
> NO_IRQ _is_ 0. You need to do something like
>
> if (irq < 0) }
>  ... leave existing code ...
> }
>
> if (!irq)
>  dev_warn(, "Use polling mode\n");

OK

>

Thanks,
John


