Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1288896-1520243168-2-17410126601919891004
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
    t=1520243168; b=vtWhaJKAyCktghngBeWYuEqiz9v6xzbvM4/VFAQYOfsq1xf
    wWOiO7CMBnMn824wqoeOjuwwetRIpabJFt3jwVdo8hDjcPXJVmHHXpJigttP9Pei
    B7/xsGGKomg4ZIGNgiaCOftSX9EaJxWSGdfX4lpYHsRAfZ9aaXRrNktU4c1PjsT0
    5ssPu2mD2MVNPN7kdFtthIYCIlnAvV9KdJUSp3Ze1YlNk4CAaMjgZSNlxTdRMRg9
    BpL6tUz+GP908zCpVqCAzUl50aKWEeNfwj6j3qGsSjqmoMMt8TfTAa8IQKQ/s4ZN
    +/jgphSWeOvYQmIJUuq2YKYNWnMPsHZYGCp0eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520243168; bh=zZli4Aufgx0SH/1Iy0QEmNWhEUJ+RnQm7YuZdUiQbDk=; b=p
    8h3bsV5idRtOu1IsUv8ZnG3eFV7ZiF846tPIrCG6530vZ1Ehxwan9VoG6YSBk2tC
    zigIgZBR/oGdmjRhh0WKbjcS9ZC8yWL3z+aqQ5lVV2HDo96T5cZvrjZ1QWCUR+oG
    yqCnq9xzWiJws59MmJEyOSeoCKNODS4tOIRIw+kSfPMEZhNs+1LcnQSXPnPGfSE9
    Zh+P4QmtahmIYKt31jJBW0QqyLB8hQ4EtVOYNysQYlpXj0v5QCquaRXg1Uq9809u
    AXRPHw2TYckZsKyDUHIjn0JEXepRQG2hiQuWzAUlZxVtCiIhY7t/coU5e0wMo1xu
    fi0ECCuhDETbDytFHTMzQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=sifdjx9G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=sifdjx9G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933237AbeCEJqD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 04:46:03 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:53267 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933048AbeCEJqC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 04:46:02 -0500
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode
 during suspend/resume
To: Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
 <87sh9l5z4l.fsf@linux.intel.com>
 <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com>
 <87po4i3o1v.fsf@linux.intel.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <a907787a-dea2-5f15-3d25-693680a42b71@ti.com>
Date: Mon, 5 Mar 2018 11:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87po4i3o1v.fsf@linux.intel.com>
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

On 05/03/18 10:49, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>>> Roger Quadros <rogerq@ti.com> writes:
>>>> In the following test we get stuck by sleeping forever in _dwc3_set_mode()
>>>> after which dual-role switching doesn't work.
>>>>
>>>> On dra7-evm's dual-role port,
>>>> - Load g_zero gadget driver and enumerate to host
>>>> - suspend to mem
>>>> - disconnect USB cable to host and connect otg cable with Pen drive in it.
>>>> - resume system
>>>> - we sleep indefinitely in _dwc3_set_mode due to.
>>>>   dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
>>>> 	dwc3_gadget_stop()->wait_event_lock_irq()
>>>>
>>>> Let's clear the DWC3_EP_END_TRANSFER_PENDING flag on all endpoints
>>>> so we don't wait in dwc3_gadget_stop().
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>>  drivers/usb/dwc3/gadget.c | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 2bda4eb..0a360da 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -3273,6 +3273,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>>>>  
>>>>  void dwc3_gadget_exit(struct dwc3 *dwc)
>>>>  {
>>>> +	int epnum;
>>>> +	unsigned long flags;
>>>> +
>>>> +	spin_lock_irqsave(&dwc->lock, flags);
>>>> +	for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>>>> +		struct dwc3_ep  *dep = dwc->eps[epnum];
>>>> +
>>>> +		if (!dep)
>>>> +			continue;
>>>> +
>>>> +		dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
>>>> +	}
>>>> +	spin_unlock_irqrestore(&dwc->lock, flags);
>>>> +
>>>>  	usb_del_gadget_udc(&dwc->gadget);
>>>>  	dwc3_gadget_free_endpoints(dwc);
>>>
>>> free endpoints is a better place for this. It's already going to free
>>> the memory anyway. Might as well clear all flags to 0 there.
>>>
>>
>> But it won't solve the deadlock issue. Since dwc3_gadget_free_endpoints()
>> is called after usb_del_gadget_udc() and the deadlock happens when
>>
>> usb_del_gadget_udc()->udc_stop()->dwc3_gadget_stop()->wait_event_lock_irq()
>>
>> and DWC3_EP_END_TRANSFER_PENDING flag is set.
> 
> indeed. Iterating twice over the entire endpoint list seems
> wasteful. Perhaps we just shouldn't wait when removing the UDC since
> that's essentially what this patch will do, right? If you clear the flag
> before calling ->udc_stop(), this means the loop in dwc3_gadget_stop()
> will do nothing. Might as well remove it.
> 

This means that we will never wait for DWC3_EP_END_TRANSFER_PENDING to clear
in dwc3_gadget_stop() like we used to. This is perfectly fine, right?

It makes sense to me as dwc3_gadget_stop() calls __dwc3_gadget_stop() which
masks all interrupts and nobody will ever clear that flag if it was set.

And there is no point in clearing the DWC3_EP_END_TRANSFER_PENDING flag
in dwc3_gadget_free_endpoints() since we're freeing the dwc3_ep memory there.

dwc3_gadget_init_endpoints() will start with a clean slate.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
