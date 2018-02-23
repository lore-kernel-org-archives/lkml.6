Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2756150-1519383758-2-2735711199421242027
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
    t=1519383758; b=Lc0FDoauhhMblXTKyjGVo5IYq76m4LWECJMLkwxOb783vq5
    kCQ8XH631uoctUFz54a4ksk93ImXpxG7m2o7Dyp3g/81Oj2tb3btPlLClrj/dcv/
    IW7LoZawYSKfAgW1t4CvsHk5vZnem0UphMlWNp/dh5XKjEBxZm+RnCSxKtnHdcs2
    bftkfBEuH0X3fv9jNAKMtjo5As2tkESx2tr1/X8BBLYi4/yndnMLTIvuDEo6sNmR
    Kq/9TcLO/WA+wN1elPRowRvwJPJJoU6XGuNRcc4u7G3uKn7YH9jAiVe7R9wWwMdS
    13Idw97ZLw24Ahkr2BW/LC9c7aiwfQRNzzoJAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519383758; bh=/pPY9ePtXZ5m/Gq3PcdlJwA1Dn+DbGEKA9ilGjmIJNc=; b=p
    5trqAigiDrrGgybSJngj8lAwd+S16RtJvuubFDAw6nPsrC7BvWwz6neIHn1abVFN
    wQQdSkmrZnvBJk9mte4Gh0UBGj0x7RBeCXXqZLN4MRfS1kQtr1kl2YDbaH3kDKoP
    i9ydv2dVgMv2CkCnyGhowuptg1uAHOIyzggiz83RUJjaDDlpOuJpymfTedCwcpnH
    5Z7uRGm2owAVS3V9rJfEvYHxRLv1MDzCSRFs6vnaMpktKohQx6U4O+pH7UKT2END
    iwCRh2YAFuVcx5xT3lnco9XUCk3soopGHwKt5bjG8axw5eCbKU3Qqya5xzMJ/Ada
    UGUHLWCNbNGXcK66T8jow==
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
        id S1751412AbeBWLCf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 06:02:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751407AbeBWLCd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Feb 2018 06:02:33 -0500
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <p.zabel@pengutronix.de>, <heiko@sntech.de>,
        <ed.blake@sondrel.com>, <jhogan@kernel.org>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519381801.10722.103.camel@linux.intel.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
Date: Fri, 23 Feb 2018 11:02:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1519381801.10722.103.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23/02/2018 10:30, Andy Shevchenko wrote:
> On Fri, 2018-02-23 at 02:42 +0800, John Garry wrote:
>> There is a requirement
>

Hi Andy,

> Where?
>

We require it for a development board for our hip06 platform. FWIW, 
here's a link to a board overview (does not mention UART particulars):
http://open-estuary.org/d03/

It uses the BMC virtual uart (16550A) over the LPC as the system UART. 
You know about the Hisi LPC support from here:
https://lkml.org/lkml/2018/2/19/460

>>  for supporting an 8250-compatible UART with
>> the following profile/features:
>> - platform device
>> - polling mode (i.e. no interrupt support)
>
>> - ACPI FW
>
> Elaborate this one, please.

So we need to define our own HID here, and cannot use PNP compatible CID 
(like PNP0501) as we cannot use the 8250 PNP driver.

This is related to the Hisi LPC ACPI support, where we would create an 
MFD (i.e. platform device) for the UART.

>
>> - IO port iotype
>> - 16550-compatible
>>
>> For OF, we have 8250_of.c, and for PNP device we have 8250_pnp.c
>> drivers. However there does not seem to any driver satisfying
>> the above requirements. So this RFC is to find opinion on
>> modifying the Synopsys DW 8250_dw.c driver to support these
>> generic features.
>
> Synopsys 8250 is a particular case of platform drivers. It doesn't
> satisfy "8250-compatible UART" requirement.
>

Right, but I wanted to try to use the generic parts of the driver to 
support this UART to save writing yet another driver.

>> With patch 2/2, we're relaxing the interrupt support requirement.
>> As I mentioned in the commit log, the 8250_of.c driver seems to
>> ignore the dt bindings, and I do the same.
>
>

Thanks,
John

