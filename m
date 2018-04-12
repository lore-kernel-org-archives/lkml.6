Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1364822-1523550696-2-13116894422267513780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523550696; b=PNgCSYLWK54FzvGIvSyuU/1mFOWjWG1MOqv5UsjAdHsxeH+FCt
    gOkAwdariOC9l6zWCHh8be8o8gxwwo7g+U0CaVa7jiw31/sfTv/fcS6x17nKvcUL
    /qfH7xWW2CboU2wWSzVZQ4iuS2fdo4Hh3DtK31uYwT/qMXwFbHW3mEVRlsm3QELx
    4YC5Bu2w5B7vIEuXVg0qkjDeVQH+m5Enb0sv6FTnpWATi6kosKU6bgG5uA83spWM
    ft8lq0cWJpwN76IFG+ZAV6q0e3p70VA3LVFRiYwxJMX+rNOC9W+kKQJPy4aW1rvo
    JVRePeTz2YpJj2vtwdP0/I7DCMCSItfUfj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:subject:to:references:cc:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523550696;
    bh=05UuHjq39d5uvkZN3h1Dc0LvVoTc9gjzhBJmI9nHxVY=; b=Z8v9HhWroI5b
    42G7pMGas4A00sRJPVXyMVvPVX1JtL22graYnRg9y6FGPjYw+YhfskkEbvjWlHZ4
    v128h2hP1upFY1pohe3I4mo/SYrK4FwEqtp7+rR7qxs3u0b3srogcpLbR8SVmJSI
    PnrgjNLFGZj7bNxtp42KzLhWuyFKdr/vJ4llMoa4WLJyRW1fd6xb9Jm3o4AnIznI
    4V0fwsYf0+9RU9MBEkgUXWq6HooU+ltqEbdewEdNiQ62g4NxZyMA3lwHPIWQvrq7
    aZ5aeOaie4Vt5u7WlnPJCJajR6Y4amDdonRo/NdJMTf+U6CHnKFP/2q6YLgZCZw4
    rwwR8Ew+Aw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfDvoDlOMFMvRbOPyxR9hko3fiNjae8rP2oEjrbX8vAyCypFs1mwCIuQDUPPZHITMxllYVspZYJd65mJn/KUhv9INB9LFzuBVOPOsVXk0OJEA4cUOaYGL
    Zq2tnMwXAuPaqbNTBBKugyidAFRJWiU9wSRfIu7PPzGT9uYHzF8atI5OdsGa9djTd13RLQjgEItS+2sOF3pO7ulnBEZGPm5CMNE1mIpBb12TYWkm3lJ48gdd
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=oLkrN1oqsHwA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=8dBIwtolQBhZ3dul6QQA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeDLQbe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 12:31:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40197 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752320AbeDLQbd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Apr 2018 12:31:33 -0400
From: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519381801.10722.103.camel@linux.intel.com>
 <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
 <1519407117.10722.124.camel@linux.intel.com>
 <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
 <1519638828.10722.153.camel@linux.intel.com>
 <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
 <1519644517.10722.179.camel@linux.intel.com>
 <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
 <1519647669.10722.184.camel@linux.intel.com>
 <1519648063.10722.185.camel@linux.intel.com>
 <22270a6a-44fb-d2ad-d6d3-3d301bdde26e@huawei.com>
 <1519657365.10722.187.camel@linux.intel.com>
 <98039a90-cbf2-6d76-bdb5-56c8e83f6470@huawei.com>
CC: <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <p.zabel@pengutronix.de>, <heiko@sntech.de>,
        <ed.blake@sondrel.com>, <jhogan@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Message-ID: <aad35699-393a-80dc-d088-f749cfa284c8@huawei.com>
Date: Thu, 12 Apr 2018 17:31:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <98039a90-cbf2-6d76-bdb5-56c8e83f6470@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26/02/2018 15:07, John Garry wrote:
> On 26/02/2018 15:02, Andy Shevchenko wrote:
>> On Mon, 2018-02-26 at 13:15 +0000, John Garry wrote:
>>> On 26/02/2018 12:27, Andy Shevchenko wrote:
>>>> On Mon, 2018-02-26 at 14:21 +0200, Andy Shevchenko wrote:
>>>>> On Mon, 2018-02-26 at 11:56 +0000, John Garry wrote:
>>>>
>>>>
>>>>>>    Device (LPC0.CON0) {
>>>>>>      Name (_HID, "HISI1031")
>>>>>>      // Name (_CID, "PNP0501") // cannot support PNP
>>>>
>>>>
>>>> One more question. What is the problem with this CID? Do you have a
>>>> race
>>>> condition in enumeration?
>>>>
>>>
>>> Hi Andy,
>>>
>>> Not sure if race condition exactly. I tried enabling this CID and a
>>> pnp
>>> device is created in pnpacpi_add_device_handler(), while we have
>>> already
>>> marked the corresponding acpi_device to skip enumeration in ACPI scan
>>> handler (by flagging it as a serial bus slave).
>>
>> Is that code already in upstream?
>
> No, not yet.
>
>>
>> If no, please, Cc next version to me and possible Mika.
>
> Of course. I should be sending it later today.
>

Hi Andy,

A while ago we discussed on this thread the possibility of adding 
generic 8250 IO space platform driver support for ACPI FW.

In this discussion I mentioned that we require specifically platform 
device support, and not PNP device support, as this is how we enumerate 
the devices in the host controller driver. I think you're familiar with 
this driver - here is the thread posting for reference: 
https://lkml.org/lkml/2018/3/6/230

I would say that there were 2 main takeaway points:
a. for 8250-compatible UART, we should use a PNP driver for ACPI FW
b. you prefered us to change the host driver to use an ACPI handler approach

For b., I was not keen as we already did try the handler in the ACPI 
core code, but this was not so welcome. Reasoning here: 
https://lkml.org/lkml/2018/2/14/532

I did also say that I would prefer not to change approach after a very 
long upstream effort, with no clear end in sight.

However do you have an idea on creating a PNP device in a.? That is, 
enumerate (create) a 8250 PNP device.

If you look at the least driver here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/hisi_lpc.c

We could have this working with a change in the ACPI probe code, like in 
this code snippet:

list_for_each_entry(child, &adev->children, node) {
	struct resource_entry *rentry;
	LIST_HEAD(resource_list);
         int rc;

         if (!acpi_is_pnp_device(child))
             continue;

         acpi_dev_get_resources(child, &resource_list, NULL, NULL);

         list_for_each_entry(rentry, &resource_list, node) {
             struct resource *res = rentry->res;

             if (res->flags | IORESOURCE_IO)
                 hisi_lpc_acpi_xlat_io_res(child, adev, res); /* bad */
         }
         rc = pnpacpi_add_device(child);
         if (rc)
             return rc;
}

Obviously this is not sound as we should not modify the child 
acpi_device resources.

Alternatively, as another approach, I could copy the relevant code 
pnpacpi_add_device() verbatim into this above code, and xlat the 
resource of the PNP device, but it's not good to copy the code like.

Any other ideas?

All the best,
John

>>
> All the best,
> John


