Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-906599-1524475394-2-5442093148164517776
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524475394; b=JbRiu+pnfairJxviFx8L+WDdbLRvRWLCjQiWxXgBhPGDFTIMx/
    ysW9qC562G6+shJd1BxyiKvNvCX9vtmb+ybGbhbkWJ9YeaogbJ4eDkU8u/7t0qRK
    U5BG3wr/QWir6r1DgKLROw4AUyZPUNY6mRoJCv/a39cDQ314YTsD3ISOWbmEaMGZ
    ec1nNI8lsD2/UdPQ9TmOdmcnmSXsGsoRGYr782J1hAIWS7aqHQOJfJniDwyPmotS
    p4xTeB+M8V0ZNF1W7L8wkwCu2N2C8MYg+UwfdtDct1scat6DbNPqn/6NmpAH2phv
    ayWpBLREYpjxh7C7t6KQG/lw5Z9FuY8DKUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524475394;
    bh=7quZdaSD0fOg/CpZmY7RixCD0SNu5DtSIkN3jX0hkNY=; b=RH5eivsJwaVm
    4bNY6TOgMo5wlNYLOd6iPu/LSQmKoR1LMqoZFTEePjojaq9cd08BIpAZkM67uRtA
    9OxcOfn4oLQ1s1YANr6RrT7LXZdzr3p30hBjtbCsdyddW06d9sZqq0jeTph/l24C
    9K27A0ghR2SgcYQD5jVZleCZ5bTzM4OKKJj2dTlu1kMYu9rxkwMKNG4ho0WYX4l2
    B/icS0kx9zo15G6QtyUm/sizyYAfC0FGFG9Jxkg8RCNsMkRcQYqMewIa++SKsLYy
    nRfbvOCFMNPVQMlHd2hG2TyR7g2jBp+LHRb74IffgfjL0ClSmEZ/E5j0i6OSlS5/
    CwvEKk/q2w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK8Ad4aqAcd1ItN8hT3TaoCzxkATlZgjjpoPaKFGud64OWF0SeXHdVlZ3E+g2bHCLzRFYS2KM6g9AZ1o02N7FQZgBnnxv5cYfIe7SBKidN2fQFUoQbAH
    dedO7maL+RlUO/BL8ytT1UJV6QERoVzkfJ1UVnh+CeU8HBylkNJK2GSLHC6WumLzB6m/oy0VUXh2Hd+oXZF4JHUNx4ICUPvOHRl2jjyBVc0KTFL5ozER0CUA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=aD-pJVu_78AA:10 a=N659UExz7-8A:10
    a=Kd1tUaAdevIA:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=oVGVPBbhnh9iRtwKajYA:9
    a=pILNOxqGKmIA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbeDWJXL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:23:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754081AbeDWJXK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 05:23:10 -0400
Subject: Re: [PATCH] serial: 8250_of: Add IO space support
To: Greg KH <gregkh@linuxfoundation.org>
References: <1524152268-228631-1-git-send-email-john.garry@huawei.com>
 <20180423081402.GA19169@kroah.com>
CC: <jslaby@suse.com>, <joel@jms.id.au>, <p.zabel@pengutronix.de>,
        <arnd@arndb.de>, <fcooper@ti.com>,
        <sergei.shtylyov@cogentembedded.com>,
        <yamada.masahiro@socionext.com>, <khoroshilov@ispras.ru>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <af71a628-d9c8-bfbd-5772-8fced7c51b6b@huawei.com>
Date: Mon, 23 Apr 2018 10:22:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180423081402.GA19169@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.64]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23/04/2018 09:14, Greg KH wrote:
> On Thu, Apr 19, 2018 at 11:37:48PM +0800, John Garry wrote:
>> Currently the 8250_of driver only supports MEM IO type
>> accesses.
>>
>> Some development boards (Huawei D03, specifically) require
>> IO space access for 8250-compatible OF driver support, so
>> add it.
>>
>> The modification is quite simple: just set the port iotype
>> and associated flags depending on the device address
>> resource type.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>
> This no longer applies to my tree due to a patch that was sent before
> yours that conflicts in the same area.  Can you rebase it against my
> tty-testing branch and resend?
>

Hi Greg,

OK, I'll do that. I will also make this small improvement to this patch:

+	if ((resource.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO) {
+		port->iotype = UPIO_PORT;

	|
	V

+	if (resource_type(&resource) == IORESOURCE_IO) {
+		port->iotype = UPIO_PORT;

All the best,
John

> thanks,
>
> greg k-h
>
> .
>


