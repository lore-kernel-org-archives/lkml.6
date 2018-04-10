Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3054136-1523341780-2-11619715619450754342
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523341780; b=oqmi16zv1cbu+UGkEOrgsyh5tgWUTj2RZI8QVy5AU7d+cwCaei
    iZpxaiMffst8cUB2oGDnStmMOpA3IhEhXpuEfQ620PkWOWLmnD/YQVPhVXW/p830
    w+X3d7OxzJSbjJTq7yfDSM/I9WZdxlfZVAyLbMLI4Fk1wftoDepcanm7euJnQGBk
    VcOxGg5W+c2+cTKRO9c5j+YX3ufHGemgoIelgOce+wCT8hiiYeitg2DW17azACSx
    7I1CrtY/NTpdo6ghYxpLZaHFFyPhZxnJk43HCZOGAL/WTCORcojq9IYQBG52gln8
    sTS/sJy3XXLCvlY5o0oRix3rrktxT8o4r+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:content-type:content-transfer-encoding:mime-version
    :sender:list-id; s=fm2; t=1523341780; bh=2EfFTx2wVu5kW98VWrw+fva
    aIxksX6WusPP/GiHmahI=; b=nNBJ3XMrF1PdXGWkTkAGWRv6jlEBUIwyWNOwhsv
    LJkwEXxsXaPfEE+P3xgqIU1E6qp+oHNNI+d2tib6J/Nwf3rBfT3CrdYYhSjQQKJz
    kW9Ew9nQZr7cNwcwhOR9i529ckDNV43V7BNMVKPJhYzXkiV8LeXM9w9qxvybHfXs
    zXSAcjTVjEuGUa/kKFKsPVby+IwPyJIkDD57cf8BzjpDXKBGuVE0HoZjhkJu3fQ3
    oJSkKTtHB58+wddqKFpLRyBsJcj8Fm/1SXj43wDeKNSTgAJcVyDBdUCLTQ58rdFs
    LnQ5+9LDUv5nrMByuDVI0q9tjQmDnLTbENXr4GneD42PFYg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHv0VY7omrZ0S2iLC74hJlxp7n+klSUa4AyvQnCOzjpLaoAS3DKe5+aeb+8Fhi15iLzKabipNXEjR9Q4D+VBDg67EQnwjO1vktR19YnUg/0p5zi6y9w0
    KrGLAgnQLgVBuaXzSAeuLJHQDcb4Rb4f5LwmKuXmchy6CksEogz+CQOgx/yBYfCIY5Z608UNZ5At8Qb8IR0clz6iqqs2pQnj1yjFH7coh8GmsuOckDIxVOCV
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=NMaeLcIL3LwA:10 a=kj9zAlcOel0A:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=jIQo8A4GAAAA:8 a=VwQbUJbxAAAA:8
    a=ciVnQoJJoVIaF_P-oXsA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=Lf5xNeLK5dgiOs8hzIjU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeDJG30 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 10 Apr 2018 02:29:26 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51374 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDJG3Z (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 10 Apr 2018 02:29:25 -0400
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Felipe Balbi <balbi@kernel.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Roger Quadros <rogerq@ti.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Prevent indefinite sleep in
 _dwc3_set_mode during suspend/resume
Thread-Topic: [PATCH v2] usb: dwc3: Prevent indefinite sleep in
 _dwc3_set_mode during suspend/resume
Thread-Index: AQHTt7VttcDOmDIowUqzUI1Hi/JpmA==
Date: Tue, 10 Apr 2018 06:29:20 +0000
Message-ID: <410670D7E743164D87FA6160E7907A560113AE789A@am04wembxb.internal.synopsys.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
 <a04fafee-7992-ce8b-55a9-afd4c9935462@ti.com>
 <69517684-bd39-e945-0c9e-ccd52b8050d5@ti.com>
 <87y3isffog.fsf@linux.intel.com>
 <5ea0ad17-d538-72ec-ed59-004242c4cd26@ti.com>
 <410670D7E743164D87FA6160E7907A560113ABB478@am04wembxa.internal.synopsys.com>
 <87zi38438h.fsf@linux.intel.com>
 <410670D7E743164D87FA6160E7907A560113ABBA4B@am04wembxa.internal.synopsys.com>
 <87d100qwc5.fsf@linux.intel.com>
 <410670D7E743164D87FA6160E7907A560113ABC945@am04wembxa.internal.synopsys.com>
 <410670D7E743164D87FA6160E7907A560113ABCA0A@am04wembxa.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.63]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Filipe,

On 3/19/2018 5:53 PM, Minas Harutyunyan wrote:
> Hi,
> 
> On 3/19/2018 3:36 PM, Minas Harutyunyan wrote:
>> Hi,
>>
>> On 3/19/2018 12:55 PM, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:
>>>>>>>>> Thanks for picking this for -next.
>>>>>>>>> Is it better to have this in v4.16-rc fixes?
>>>>>>>>> and also stable? v4.12+
>>>>>>>>
>>>>>>>> Well, there was no "Fixes: foobar" or "Cc: stable" lines in the commit
>>>>>>>> log ;-)
>>>>>>>>
>>>>>>>> The best we can do now, is wait for -rc1 and manually send the commit to
>>>>>>>> stable.
>>>>>>>>
>>>>>>>
>>>>>>> That's fine. Thanks.
>>>>>>>
>>>>>>
>>>>>> Same issue seen in dwc3_gadget_ep_dequeue() function where also used
>>>>>> wait_event_lock_irq() - as result infinite loop.
>>>>>
>>>>> how did this happen? During rmmod dwc3? Or, perhaps, after you unloaded
>>>>> a gadget driver?
>>>>>
>>>> No, not during rmmod's.
>>>> We using our internal USB testing tool. Test case; ISOC OUT, transfer
>>>> size N frames. When host starts ISOC OUT traffic then the dwc3 based on
>>>> "Transfer not ready" event in frame F starts transfers staring from
>>>> frame F+4 (for bInterval=1) as result 4 requests, which already queued
>>>> on device side, remain incomplete. Function driver on some timeout
>>>> trying dequeue these 4 requests (without disabling EP) to complete test.
>>>> For IN ISOC's these requests completed on MISSED ISOC event, but for
>>>> ISOC OUT required call dequeue on some timeout.
>>>
>>> okay
>>>
>>>>>> Actually to fix this issue I updated condition of wait function
>>>>>> from:
>>>>>> !(dep->flags & DWC3_EP_END_TRANSFER_PENDING)
>>>>>> to:
>>>>>> !(dep->flags & DWC3_EP_END_TRANSFER_PENDING & DWC3_EP_ENABLED)
>>>>>
>>>>> you're not fixing anything. You're, essentially, removing the entire
>>>>> end transfer pending logic.
>>>> yes, you are right, but how to overcome this infinite loop? Replace
>>>> wait_event_lock_irq() by  wait_event_interruptible_lock_irq_timeout()?
>>>
>>> The best way here would be to figure why we're missing command complete
>>> IRQ in those cases. According to documentation, we *should* receive that
>>> interrupt, so why is it missing?
>>>
>>
>> Additional info on test. Core configuration is HS only mode, test speed
>> HS, core version v2.90a. Maybe it will help to understand cause of issue.
>> BTW, currently to pass above describe ISOC OUT test we just commented
>> wait_event_lock_irq() in dwc3_gadget_ep_dequeue() function and
>> successfully received request completion in function driver.
>> Thanks,
>> Minas
>>
> 
> One more info: while function driver call dequeue, host periodically
> send control read command to get status of test from function - test In
> Progress or Finished.
> Thanks,
> Minas
> 

Your last dwc3 patch series allow us to successfully dequeuing remaining 
requests without falling in to infinite loop.

Thank you,
Minas
