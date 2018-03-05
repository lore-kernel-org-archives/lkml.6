Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1402221-1520249130-2-9838671496331766389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520249129; b=kf1O1mY8SV6eb6FQnu5fVjWpv8mySFG11FBiFm9Eha9LSdD
    gTqYMwuSKG0mG98qljnmtIJ/eWKqNwECzs5/mcftNCu7F5bb1SI43IBrtOzbXfrc
    XETpGGERXHHGA9k42Q6HVnDWBzUi3wkI7xrowI6oAQlkWXpfkWLIdMoKAEDPq+XE
    OxO7nTjHu75lYOgzRlpT3pet1HxmGAD0Jeub+oWms75kaODK1ceNLe4tZoSgvV5K
    xK6voi21NMZFPkYg+PqaLn29hgSHXxxsJTeMFzzY3yKZm2MwIbFGkJAbIgIpvqZK
    UmGwzs213pPcc11U68ny1AndmMRLGCkwmhE6M5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520249129; bh=AbeUy7jLs83LPgaL+eG+bkUJrfqmwelWyhaPs/
    6JZoY=; b=hYSWqpeG+o9hs6NtO7YzKqpSj9J5vYyPqQe5LXI3x6RLSkPItPD6aA
    9nLVxOge5QKAavqFJGtJzQ36VEwVq5PLTpWvrvCCXUoSGd2fOacOuVFmOFRu3Plo
    3j0FjjMRect05HP1VAbFjVsIZ9cuP8AkZCm0MNanDwzVc8/kaPX9JsU98859m3a1
    j1LQoWUj6bAWQe/iB8UyGe/hi8pnvizWXY98ggLTlN1hIhV1JOBeMMfUwCNlELzL
    y/E0w/2aPih+pwk7poEBFzpyasQo84Z/c82kB68dpS/NF2JFkfEpa4MuG+mkhnF9
    hV4Eege2dUJYe7S7Gc6KOui1LJoBt2Fw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Q/9QOwAl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cfYagkd8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Q/9QOwAl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cfYagkd8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934191AbeCELZP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 06:25:15 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38471 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934176AbeCELZO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 06:25:14 -0500
X-Google-Smtp-Source: AG47ELsMfuHcC6WtYj4XZ6LNpbv2wkuYZlGzIJt37+9uZ5ulCEGH/qpVvHBd9oPWBy0a6bCVYwNod1JNhCKO+5cJXAU=
MIME-Version: 1.0
In-Reply-To: <8ec0485e-89af-568b-e34a-b0cd490817d0@ti.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
 <87sh9l5z4l.fsf@linux.intel.com> <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com>
 <87po4i3o1v.fsf@linux.intel.com> <a907787a-dea2-5f15-3d25-693680a42b71@ti.com>
 <CAMz4kuKOnAPckX1=nqVPyF7O5u-0YrekTfMddYwe0WC2-0AFDw@mail.gmail.com>
 <87k1uq3ho6.fsf@linux.intel.com> <8ec0485e-89af-568b-e34a-b0cd490817d0@ti.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 5 Mar 2018 19:25:13 +0800
Message-ID: <CAMz4kuJpBXY92zhG7s_VRkpcTHeLCE_vBLLSFVxLWjN2GQvyyw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode
 during suspend/resume
To: Roger Quadros <rogerq@ti.com>
Cc: Felipe Balbi <balbi@kernel.org>, USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5 March 2018 at 19:14, Roger Quadros <rogerq@ti.com> wrote:
> On 05/03/18 13:06, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Baolin Wang <baolin.wang@linaro.org> writes:
>>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>>> Roger Quadros <rogerq@ti.com> writes:
>>>>>>>> In the following test we get stuck by sleeping forever in _dwc3_set_mode()
>>>>>>>> after which dual-role switching doesn't work.
>>>>>>>>
>>>>>>>> On dra7-evm's dual-role port,
>>>>>>>> - Load g_zero gadget driver and enumerate to host
>>>>>>>> - suspend to mem
>>>>>>>> - disconnect USB cable to host and connect otg cable with Pen drive in it.
>>>>>>>> - resume system
>>>>>>>> - we sleep indefinitely in _dwc3_set_mode due to.
>>>>>>>>   dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
>>>>>>>>    dwc3_gadget_stop()->wait_event_lock_irq()
>>>>>>>>
>>>>>>>> Let's clear the DWC3_EP_END_TRANSFER_PENDING flag on all endpoints
>>>>>>>> so we don't wait in dwc3_gadget_stop().
>>>>>>>>
>>>>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>>>>> ---
>>>>>>>>  drivers/usb/dwc3/gadget.c | 14 ++++++++++++++
>>>>>>>>  1 file changed, 14 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>>>> index 2bda4eb..0a360da 100644
>>>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>>>> @@ -3273,6 +3273,20 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>>>>>>>>
>>>>>>>>  void dwc3_gadget_exit(struct dwc3 *dwc)
>>>>>>>>  {
>>>>>>>> +  int epnum;
>>>>>>>> +  unsigned long flags;
>>>>>>>> +
>>>>>>>> +  spin_lock_irqsave(&dwc->lock, flags);
>>>>>>>> +  for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>>>>>>>> +          struct dwc3_ep  *dep = dwc->eps[epnum];
>>>>>>>> +
>>>>>>>> +          if (!dep)
>>>>>>>> +                  continue;
>>>>>>>> +
>>>>>>>> +          dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
>>>>>>>> +  }
>>>>>>>> +  spin_unlock_irqrestore(&dwc->lock, flags);
>>>>>>>> +
>>>>>>>>    usb_del_gadget_udc(&dwc->gadget);
>>>>>>>>    dwc3_gadget_free_endpoints(dwc);
>>>>>>>
>>>>>>> free endpoints is a better place for this. It's already going to free
>>>>>>> the memory anyway. Might as well clear all flags to 0 there.
>>>>>>>
>>>>>>
>>>>>> But it won't solve the deadlock issue. Since dwc3_gadget_free_endpoints()
>>>>>> is called after usb_del_gadget_udc() and the deadlock happens when
>>>>>>
>>>>>> usb_del_gadget_udc()->udc_stop()->dwc3_gadget_stop()->wait_event_lock_irq()
>>>>>>
>>>>>> and DWC3_EP_END_TRANSFER_PENDING flag is set.
>>>>>
>>>>> indeed. Iterating twice over the entire endpoint list seems
>>>>> wasteful. Perhaps we just shouldn't wait when removing the UDC since
>>>>> that's essentially what this patch will do, right? If you clear the flag
>>>>> before calling ->udc_stop(), this means the loop in dwc3_gadget_stop()
>>>>> will do nothing. Might as well remove it.
>>>>>
>>>>
>>>> This means that we will never wait for DWC3_EP_END_TRANSFER_PENDING to clear
>>>> in dwc3_gadget_stop() like we used to. This is perfectly fine, right?
>>>>
>>>> It makes sense to me as dwc3_gadget_stop() calls __dwc3_gadget_stop() which
>>>> masks all interrupts and nobody will ever clear that flag if it was set.
>>>
>>> I don't think so. It can not mask the endpoint events, please check
>>> the events which will be masked in DEVTEN register. The reason why we
>>> should wait for DWC3_EP_END_TRANSFER_PENDING to clear is that,
>>> sometimes the DWC3_DEPEVT_EPCMDCMPLT event will be triggered later
>>> than 100us, but now we may have freed the gadget irq which will cause
>>> crash.
>>
>> We could mask command complete events as soon as ->udc_stop() is called,
>> right? Hmm, actually, __dwc3_gadget_stop() already clears DEVTEN
>> completely.
>
> But which bit in DEVTEN says Endpoint events are disabled?

When we set up the DWC3_DEPCMD_ENDTRANSFER command in
dwc3_stop_active_transfer(), we can do not set DWC3_DEPCMD_CMDIOC,
then there will no endpoint command complete interrupts I think.

cmd |= DWC3_DEPCMD_CMDIOC;

>
>>
>> /me goes check databook
>>
>> At least on revision 2.60a of the databook, bit 10 is reserved. I wonder
>> if that's the start of all the problems. Anybody has access to older and
>> newer databook revisions so we can cross-check?
>>
>
> I can access v2.40 and v3.10 books.
>
> bit 10 is reserved on both
>
> Differences in v2.4 vs v3.10 are:
>
> bit 8   reserved        vs      L1SUSPEN
> bit 13  reserved        vs      StopOnDisconnectEn
> bit 14  reserved        vs      L1WKUPEVTEN
>
> --
> cheers,
> -roger
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki



-- 
Baolin.wang
Best Regards
