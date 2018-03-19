Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2953273-1521467697-2-15203500164451796013
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521467697; b=e3xc29MuQvw0GUVrt3O9WEjcDVSUS1fKqGIdTvXOcRXmQ3c
    hItZeFocslktK/MLIZIZ5JfS5ON+J5+r86fKdncZXbyyXGcwXMPvjZubibGJR3lU
    rnlgN2AyOWzkMZFdLzjgk8MD039ePPKBAm5QAlvF+yggi8h5XdCxyqFQ8TNzRjCj
    bdgIUY8YOeLypXc02qTIxswvC2MH/D8GXVfPPoaw5135DGkoYqoA1JW3Jl/Tphoq
    ZVLJs/XAKOvvfso/OlUHrINUpw49mpUDniLvec8zOwq+jUJltVIEzeVXYSrGPsKj
    cAiunib4zkjCx5zMQSvI4MslYuVjsBMf4FTefkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:content-type:content-transfer-encoding:mime-version
    :sender:list-id; s=arctest; t=1521467697; bh=gJ311SfyIYMcC2SgYLC
    u6K+ZH9yvQ2Oc9w6YcjAWbeU=; b=ofUy6J5XIhZfCwiotsFM4ZdvSHGlD/O/1V8
    bLCVAq6SRUkJphvgHBRYUt+Y2uklETpXKQNln1VOkv9q2PtsSWbE+YUdsCrzNc8J
    vdMdC8wITJBX/AINu95Vff6pQmOYnMlgNhJm4DupZNixwSE+hJ7rxiRzI+rXgxM7
    fga1C+rq9Cxgx3Bo6N/3MV0Crmal1Z17kSVgAUh2gwn9d7TKrAatM1i4CMGlmbzo
    WaiCVD2I8iloaAfAxLYDsad++hsYd0Pjh3vkoSRWddb/9m2RCfLDkrSjVJb0MmbW
    ZlnsEM2zk1FkwAu5ERElSeUnST4YObOZA7LvXje3GRN5FkPyoTg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdehheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhhitgfggghsphejsehtjfertddttddvnecuhfhrohhmpefoihhnrghsucfjrghruhhthihunhihrghnuceoofhinhgrshdrjfgrrhhuthihuhhnhigrnhesshihnhhophhshihsrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtrdduudeirdejtddriedvpdhfvgektdemmeejlegtfeemheehfhdvmedufhdvtdemhegsfhegnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdhushgsqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeivdelheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdehheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhhitgfggghsphejsehtjfertddttddvnecuhfhrohhmpefoihhnrghsucfjrghruhhthihunhihrghnuceoofhinhgrshdrjfgrrhhuthihuhhnhigrnhesshihnhhophhshihsrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtrdduudeirdejtddriedvpdhfvgektdemmeejlegtfeemheehfhdvmedufhdvtdemhegsfhegnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdhushgsqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeivdelheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933400AbeCSNxw convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 19 Mar 2018 09:53:52 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:39865 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeCSNxv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Mar 2018 09:53:51 -0400
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
Date: Mon, 19 Mar 2018 13:53:48 +0000
Message-ID: <410670D7E743164D87FA6160E7907A560113ABCA0A@am04wembxa.internal.synopsys.com>
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
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.62]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 3/19/2018 3:36 PM, Minas Harutyunyan wrote:
> Hi,
> 
> On 3/19/2018 12:55 PM, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:
>>>>>>>> Thanks for picking this for -next.
>>>>>>>> Is it better to have this in v4.16-rc fixes?
>>>>>>>> and also stable? v4.12+
>>>>>>>
>>>>>>> Well, there was no "Fixes: foobar" or "Cc: stable" lines in the commit
>>>>>>> log ;-)
>>>>>>>
>>>>>>> The best we can do now, is wait for -rc1 and manually send the commit to
>>>>>>> stable.
>>>>>>>
>>>>>>
>>>>>> That's fine. Thanks.
>>>>>>
>>>>>
>>>>> Same issue seen in dwc3_gadget_ep_dequeue() function where also used
>>>>> wait_event_lock_irq() - as result infinite loop.
>>>>
>>>> how did this happen? During rmmod dwc3? Or, perhaps, after you unloaded
>>>> a gadget driver?
>>>>
>>> No, not during rmmod's.
>>> We using our internal USB testing tool. Test case; ISOC OUT, transfer
>>> size N frames. When host starts ISOC OUT traffic then the dwc3 based on
>>> "Transfer not ready" event in frame F starts transfers staring from
>>> frame F+4 (for bInterval=1) as result 4 requests, which already queued
>>> on device side, remain incomplete. Function driver on some timeout
>>> trying dequeue these 4 requests (without disabling EP) to complete test.
>>> For IN ISOC's these requests completed on MISSED ISOC event, but for
>>> ISOC OUT required call dequeue on some timeout.
>>
>> okay
>>
>>>>> Actually to fix this issue I updated condition of wait function
>>>>> from:
>>>>> !(dep->flags & DWC3_EP_END_TRANSFER_PENDING)
>>>>> to:
>>>>> !(dep->flags & DWC3_EP_END_TRANSFER_PENDING & DWC3_EP_ENABLED)
>>>>
>>>> you're not fixing anything. You're, essentially, removing the entire
>>>> end transfer pending logic.
>>> yes, you are right, but how to overcome this infinite loop? Replace
>>> wait_event_lock_irq() by  wait_event_interruptible_lock_irq_timeout()?
>>
>> The best way here would be to figure why we're missing command complete
>> IRQ in those cases. According to documentation, we *should* receive that
>> interrupt, so why is it missing?
>>
> 
> Additional info on test. Core configuration is HS only mode, test speed
> HS, core version v2.90a. Maybe it will help to understand cause of issue.
> BTW, currently to pass above describe ISOC OUT test we just commented
> wait_event_lock_irq() in dwc3_gadget_ep_dequeue() function and
> successfully received request completion in function driver.
> Thanks,
> Minas
> 

One more info: while function driver call dequeue, host periodically 
send control read command to get status of test from function - test In 
Progress or Finished.
Thanks,
Minas
