Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-66263-1520587188-2-994492144711869708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
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
    t=1520587187; b=Dh656XKfDTcoook4xcu+WKZe+ZWsp1meCj/Xx00gjclfzlw
    U7N2h3+lEeyRordA1S6yPyz8teU2JwL6fStTKQBfMw5SLlb7f8YwxM+eI1opHdJ7
    rTYp3QNwA31mcbNBD+C/N3R4Jg3mXxHCDkBIPxcVGGZAE2Ol5uNf9bDGLKED+WWT
    kXko3PgwyVP+9Ar+OrLGM6OtCxYWaoAaveunSNglOYFyGENz05NqGtlUnwhPG4Cf
    tzpEy7KECgrKxyE1TIMvXL5FASUUyUkRrZ/6Lhui45UCo9ClQU/Msuup0DjQvZp4
    imZ3PA8O/ukbtMbs83JWwkXPY032ePtLVkBKpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520587187; bh=Z+KqWTNhrshznB8zLUsBIl6l2V2Kp+yVAlhGp+V5Gto=; b=X
    epnpZxIbKaYPPiPlPvVnC9P93EZ7bXPEGy8RpEM3tYExGH4VXZsFiSyo40Docmqa
    EnLH+iUVydZmI7bANGKnqFkmS0sjSZKr6V81cjwiOpIWCnhSAhovVRAhPxvy2zl9
    JYZsWiIYWwhJXfEaQ6YOS+ghyacvvGyVHDMJT9uZtqbVcUTyq/nCoCI5GVH6LqkO
    ZJLWtthyUbzeJ10vGwuIuVi+Bl4Vd1PFIKcRZ4rch4EAKJvRpWKXm1yLx3VFDRqD
    ktYH8k68yheZt8yuN6H0/dbWbCeooAyTLqay16jrWsy3deV7TDIy5VffGRVwzdoC
    0IX5VsEK2XijAnrWTI+LQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=XuRgwnz2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=XuRgwnz2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbeCIJTn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 04:19:43 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:46695 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbeCIJTm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 04:19:42 -0500
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode
 during suspend/resume
To: Felipe Balbi <balbi@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>
CC: USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
 <87sh9l5z4l.fsf@linux.intel.com>
 <94cd6377-1327-2309-8d69-6ab0de2bdfd4@ti.com>
 <87po4i3o1v.fsf@linux.intel.com>
 <a907787a-dea2-5f15-3d25-693680a42b71@ti.com>
 <CAMz4kuKOnAPckX1=nqVPyF7O5u-0YrekTfMddYwe0WC2-0AFDw@mail.gmail.com>
 <87k1uq3ho6.fsf@linux.intel.com>
 <8ec0485e-89af-568b-e34a-b0cd490817d0@ti.com>
 <CAMz4kuJpBXY92zhG7s_VRkpcTHeLCE_vBLLSFVxLWjN2GQvyyw@mail.gmail.com>
 <87h8puwyn5.fsf@linux.intel.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <5bc56ef5-66b1-d40c-1639-e748fe18cdbd@ti.com>
Date: Fri, 9 Mar 2018 11:19:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87h8puwyn5.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/03/18 13:27, Felipe Balbi wrote:
> 
> Hi,
> 
> Baolin Wang <baolin.wang@linaro.org> writes:
>>>>>>>>>>  void dwc3_gadget_exit(struct dwc3 *dwc)
>>>>>>>>>>  {
>>>>>>>>>> +  int epnum;
>>>>>>>>>> +  unsigned long flags;
>>>>>>>>>> +
>>>>>>>>>> +  spin_lock_irqsave(&dwc->lock, flags);
>>>>>>>>>> +  for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>>>>>>>>>> +          struct dwc3_ep  *dep = dwc->eps[epnum];
>>>>>>>>>> +
>>>>>>>>>> +          if (!dep)
>>>>>>>>>> +                  continue;
>>>>>>>>>> +
>>>>>>>>>> +          dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
>>>>>>>>>> +  }
>>>>>>>>>> +  spin_unlock_irqrestore(&dwc->lock, flags);
>>>>>>>>>> +
>>>>>>>>>>    usb_del_gadget_udc(&dwc->gadget);
>>>>>>>>>>    dwc3_gadget_free_endpoints(dwc);
>>>>>>>>>
>>>>>>>>> free endpoints is a better place for this. It's already going to free
>>>>>>>>> the memory anyway. Might as well clear all flags to 0 there.
>>>>>>>>>
>>>>>>>>
>>>>>>>> But it won't solve the deadlock issue. Since dwc3_gadget_free_endpoints()
>>>>>>>> is called after usb_del_gadget_udc() and the deadlock happens when
>>>>>>>>
>>>>>>>> usb_del_gadget_udc()->udc_stop()->dwc3_gadget_stop()->wait_event_lock_irq()
>>>>>>>>
>>>>>>>> and DWC3_EP_END_TRANSFER_PENDING flag is set.
>>>>>>>
>>>>>>> indeed. Iterating twice over the entire endpoint list seems
>>>>>>> wasteful. Perhaps we just shouldn't wait when removing the UDC since
>>>>>>> that's essentially what this patch will do, right? If you clear the flag
>>>>>>> before calling ->udc_stop(), this means the loop in dwc3_gadget_stop()
>>>>>>> will do nothing. Might as well remove it.
>>>>>>>
>>>>>>
>>>>>> This means that we will never wait for DWC3_EP_END_TRANSFER_PENDING to clear
>>>>>> in dwc3_gadget_stop() like we used to. This is perfectly fine, right?
>>>>>>
>>>>>> It makes sense to me as dwc3_gadget_stop() calls __dwc3_gadget_stop() which
>>>>>> masks all interrupts and nobody will ever clear that flag if it was set.
>>>>>
>>>>> I don't think so. It can not mask the endpoint events, please check
>>>>> the events which will be masked in DEVTEN register. The reason why we
>>>>> should wait for DWC3_EP_END_TRANSFER_PENDING to clear is that,
>>>>> sometimes the DWC3_DEPEVT_EPCMDCMPLT event will be triggered later
>>>>> than 100us, but now we may have freed the gadget irq which will cause
>>>>> crash.
>>>>
>>>> We could mask command complete events as soon as ->udc_stop() is called,
>>>> right? Hmm, actually, __dwc3_gadget_stop() already clears DEVTEN
>>>> completely.
>>>
>>> But which bit in DEVTEN says Endpoint events are disabled?
>>
>> When we set up the DWC3_DEPCMD_ENDTRANSFER command in
>> dwc3_stop_active_transfer(), we can do not set DWC3_DEPCMD_CMDIOC,
>> then there will no endpoint command complete interrupts I think.
>>
>> cmd |= DWC3_DEPCMD_CMDIOC;
> 
> I remember some part of the databook mandating CMDIOC to be set. We
> could test it out without and see if anything blows up. I would,
> however, require a lengthy comment explaining that we're deviating from
> databook revision x.yya, section foobar because $reasons. :-)
> 

This is what the v3.10 databook says

"When issuing an End Transfer command, software must set the CmdIOC bit (field 8) so that an Endpoint
Command Complete event is generated after the transfer ends. This is necessary to synchronize the
conclusion of system bus traffic before the End Transfer command is completed."

with a note
"If GUCTL2[Rst_actbitlater] is set, Software can poll the completion of the End Transfer
command by polling the command active bit to be cleared to 0."

fyi.
Rst_actbitlater - "Enable clearing of the command active bit for the ENDXFER
command after the command execution is completed.
This bit is valid in device mode only."

So I'd prefer not to clear CMDIOC for all cases.

Could we some how just tackle the dwc3_gadget_exit case like I did in this patch?

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
