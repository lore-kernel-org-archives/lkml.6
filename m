Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972292-1519811961-2-4146770419512806945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519811961; b=mzsXM/HeLDfn3OFiVk1Th3o5vHawrUGYiIaiPBQKHOqfrhj
    NhMAs+fKNJ3WYuWUxzuUlu+WStAbaGxMRSzkiQ2AnGZPQYtbinj0RHneCZB1+xx3
    QyjIQdSNLoFTNukE4qgt1sT/y4AuIv8Tp8aumxZqYBM3WQFJYXnP/0om56gCUmpp
    cJyXI48fsOd+CfcvewhB8HrvJgbsQnwhvCmuUXcBj0qhAWHViIvI7zVSrK+B5bXT
    qUVxufspeE9PhQza5GObc0GZWOanf6lZC7VlM8FJ7HzeUvCm2JPdA5AdOsHMCy9X
    lXDG3VXdlUNxEqCtwyIcesjWArv9ygTnc3yRr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519811961; bh=CB8zdaxwFh5e8vWr1wVxPoUDLyRXqmxvhoJfRQuRGnY=; b=W
    lohuPzM69XX9QAOs4Y/iIb6qYTSOdbWMTAGrQYNOlYjIbnld+dr9X5+p+vXJa0oE
    Ee+/ISAXClOPygFj+g6DrC9Fj8ACPL+jSYX52TdRCROTVVglJY5sGNMb7babkUu2
    RNYw1q3uhe/fqqq50+/1CeUO97iI8c0xDN7tSMkEbPVmA5tHJ8ySHEVNfGhgfg9U
    spuw2zePXzppCZQYiK1ASe+MMmeT9IFad+eFezHGcql0XrtzU9KYqb72DcY6vNYd
    6O02nlWbgD9SagCBih69Z7dFYO8bPb5CL383Y4T4gzAXjxBvGW1GLd05GCr0jMa6
    ZAL0nLlzP4qFe5mSvmlKg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=bn+nOpP0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=bn+nOpP0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeB1J7T (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 04:59:19 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:60781 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbeB1J7S (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 28 Feb 2018 04:59:18 -0500
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode
 during suspend/resume
To: Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
 <87sh9l5z4l.fsf@linux.intel.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com>
Date: Wed, 28 Feb 2018 11:59:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87sh9l5z4l.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Felipe,

On 28/02/18 09:53, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>> In the following test we get stuck by sleeping forever in _dwc3_set_mode()
>> after which dual-role switching doesn't work.
>>
>> On dra7-evm's dual-role port,
>> - Load g_zero gadget driver and enumerate to host
>> - suspend to mem
>> - disconnect USB cable to host and connect otg cable with Pen drive in it.
>> - resume system
>> - we sleep indefinitely in _dwc3_set_mode due to.
>>   dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
>> 	dwc3_gadget_stop()->wait_event_lock_irq()
>>
>> Let's clear the DWC3_EP_END_TRANSFER_PENDING flag on all endpoints
>> so we don't wait in dwc3_gadget_stop().
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/dwc3/gadget.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 2bda4eb..0a360da 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -3273,6 +3273,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>>  
>>  void dwc3_gadget_exit(struct dwc3 *dwc)
>>  {
>> +	int epnum;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&dwc->lock, flags);
>> +	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>> +		struct dwc3_ep  *dep = dwc->eps[epnum];
>> +
>> +		if (!dep)
>> +			continue;
>> +
>> +		dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
>> +	}
>> +	spin_unlock_irqrestore(&dwc->lock, flags);
>> +
>>  	usb_del_gadget_udc(&dwc->gadget);
>>  	dwc3_gadget_free_endpoints(dwc);
> 
> free endpoints is a better place for this. It's already going to free
> the memory anyway. Might as well clear all flags to 0 there.
> 

But it won't solve the deadlock issue. Since dwc3_gadget_free_endpoints()
is called after usb_del_gadget_udc() and the deadlock happens when

usb_del_gadget_udc()->udc_stop()->dwc3_gadget_stop()->wait_event_lock_irq()

and DWC3_EP_END_TRANSFER_PENDING flag is set.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
