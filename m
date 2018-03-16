Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2885895-1521200632-2-14926598616056022690
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
    t=1521200631; b=BBLa8pQvYwSrLAZMD1mXk8o1mghFxcEyzRJYgTlJ4FtZMT3
    R4fg6Z+gqs4fKsJKeZusO64dfuaODS6vtPD3pAMrQneQMaNwOpceTqup0Q/lt+7l
    tLd6fh+Sar64LbrdH+keh2eJRgxgZgorFRmNIf//dBGPuPp68i3if53IV+W8+d37
    GwpR00xV3hpWf42V0+o07qFwzpfjVjFqWnuOIvnhDt6yq3hQkE8nDhfbZbS8gXAH
    ptkPIltGi8lkihaBO5FNR1G9OhlBWX8TSTXQJ0Pw8T12tmXiYW3dY49HO+ES3hHx
    rELfe7TMoA6ZIdCBKfBTagW8W0esE/RaVgBaFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:content-type:content-transfer-encoding:mime-version
    :sender:list-id; s=arctest; t=1521200631; bh=fZyeXV3zAByAupZlVLS
    BkJuhLiVwBUFdc1auzt1NiLk=; b=PwhlkSaCuvyhwBCTo0MQeVVpOYvEZAs04wW
    33S1KnWjYTtMb/DknYATQbyQ+m3DoWDnAaUvrtT0oBcXDqybVCeAzha5xMIVydP4
    gsv5iSrmrkWrqd7MEIaKNooXuG7DK4x8eXNkB8ELsg4bHtqIoxn8Ue+GSGFhTBAg
    9REgVIbb9AHxOgx9PhHBpfzFBmu9cjmohbYps4fxnDtTGm0TWrjbrvbvf1IIZw0j
    OaGdX22CVVW2xRgiygie4FzMlW43n/xAWrBeTmca/GqST/6ZKHIwpLNpxqH7maaM
    da/FzJjw5gE/oP+UmGu0NVbhWp/Va6mntOYFLwd4xOSgMZ5SfCA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeCPLnh convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 16 Mar 2018 07:43:37 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:60491 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeCPLng (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Mar 2018 07:43:36 -0400
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Prevent indefinite sleep in
 _dwc3_set_mode during suspend/resume
Thread-Topic: [PATCH v2] usb: dwc3: Prevent indefinite sleep in
 _dwc3_set_mode during suspend/resume
Thread-Index: AQHTt7VttcDOmDIowUqzUI1Hi/JpmA==
Date: Fri, 16 Mar 2018 11:43:32 +0000
Message-ID: <410670D7E743164D87FA6160E7907A560113ABB478@am04wembxa.internal.synopsys.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
 <a04fafee-7992-ce8b-55a9-afd4c9935462@ti.com>
 <69517684-bd39-e945-0c9e-ccd52b8050d5@ti.com>
 <87y3isffog.fsf@linux.intel.com>
 <5ea0ad17-d538-72ec-ed59-004242c4cd26@ti.com>
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

On 3/16/2018 3:03 PM, Roger Quadros wrote:
> On 16/03/18 13:00, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Roger Quadros <rogerq@ti.com> writes:
>>
>>> Hi Felipe,
>>>
>>> On 09/03/18 14:47, Roger Quadros wrote:
>>>> In the following test we get stuck by sleeping forever in _dwc3_set_mode()
>>>> after which dual-role switching doesn't work.
>>>>
>>>> On dra7-evm's dual-role port,
>>>> - Load g_zero gadget driver and enumerate to host
>>>> - suspend to mem
>>>> - disconnect USB cable to host and connect otg cable with Pen drive in it.
>>>> - resume system
>>>> - we sleep indefinitely in _dwc3_set_mode due to.
>>>>    dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
>>>> 	dwc3_gadget_stop()->wait_event_lock_irq()
>>>>
>>>> To fix this instead of waiting indefinitely with wait_event_lock_irq()
>>>> we use wait_event_interruptible_lock_irq_timeout() and print
>>>> and error message if there was a timeout.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>
>>> Thanks for picking this for -next.
>>> Is it better to have this in v4.16-rc fixes?
>>> and also stable? v4.12+
>>
>> Well, there was no "Fixes: foobar" or "Cc: stable" lines in the commit
>> log ;-)
>>
>> The best we can do now, is wait for -rc1 and manually send the commit to
>> stable.
>>
> 
> That's fine. Thanks.
> 

Same issue seen in dwc3_gadget_ep_dequeue() function where also used 
wait_event_lock_irq() - as result infinite loop.
Actually to fix this issue I updated condition of wait function
from:
!(dep->flags & DWC3_EP_END_TRANSFER_PENDING)
to:
!(dep->flags & DWC3_EP_END_TRANSFER_PENDING & DWC3_EP_ENABLED)
Not, sure that this fix is fully correct because I'm familiar with dwc3, 
but this fix allow us to go forward with request dequeue. I think, need 
deeper investigation of infinite loop to catch root cause of it, before 
accept any of fixes.

Thanks,
Minas
