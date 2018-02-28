Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972292-1519811740-2-17697208593385290421
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
    t=1519811739; b=Al8kW1RfFZWEealRKntmj6F7avnygDsCMr4js6Ljq2JNHgx
    jto4529LqPziF7hcR38/ZVL9PnlFA8EACGDBW4jSAklvphJSXYENFAQjSGckaoJl
    ahBC4YoAQ0nAUvKvKJQw6sf1cUJf7hh0TJdq0mMM/yYi2XsKQw9bq4OQ6NuTesPp
    ZZLccBufbSAmfrXQbFbaN1dj9dr+KT6DIiE/a8DToAUsE0ZumPCmFeEfPRfApINA
    T7TktlJbZAishgmbn9qNamv1hYJ0uLJGDBflSZT6If3gKSWg5SgjqCpbpSLPCw1u
    RICeP+bGY5MFJZvuOSQLHMa8zxkqCKGZHxP4Xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519811739; bh=h69cp9zv9mHSRYSI/RiTm5q1M2nEMTUNeXp8t600Qmw=; b=Z
    Eep/NndjJ9FUvykUYDGYeoWGTJAqZYSahWpELJO/PZybMioR9Mtsi8M7wk1bPBQ0
    x9B1c6+LXLOzYt/lM+14EERq+h09gIb5FhvAfOoPAcHA66GD9dLBYlS3R/bYl74c
    t4rzg9TSZt4jolOatFvKdh14+nxLdeMZaeJ8auux1/lHWqZeChBCyFHrzIVoC9CX
    obS/DmkjLUdQy4WqYs6XKPC7WRy7dmXsGt89BkZz+Erm81oMeYjAXhqy8M60hnna
    TO22Ya2K/gYc9wOhsRR0ju+Kp6Db/4pLtVdFPYYLOLGU/zty1yGpU6KHNebWVXfA
    0qJWYUu1wN1CT5KJUKZEw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=UmpIZy1c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=UmpIZy1c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeB1JzY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 04:55:24 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:59259 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbeB1JzX (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 28 Feb 2018 04:55:23 -0500
Subject: Re: [PATCH] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode
 during suspend/resume
To: Baolin Wang <baolin.wang@linaro.org>
CC: Felipe Balbi <balbi@kernel.org>, USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
 <CAMz4kuLv6mOa5ijbEX-GoXyZ+=e8T_ZdpnVS7rbE7gmQo9RkGw@mail.gmail.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <eab78661-dee9-1ff3-0987-a47aed3ec8db@ti.com>
Date: Wed, 28 Feb 2018 11:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuLv6mOa5ijbEX-GoXyZ+=e8T_ZdpnVS7rbE7gmQo9RkGw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Baolin,

On 28/02/18 05:04, Baolin Wang wrote:
> Hi Roger,
> 
> On 27 February 2018 at 19:22, Roger Quadros <rogerq@ti.com> wrote:
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
>>         dwc3_gadget_stop()->wait_event_lock_irq()
>>
>> Let's clear the DWC3_EP_END_TRANSFER_PENDING flag on all endpoints
>> so we don't wait in dwc3_gadget_stop().
> 
> I am curious why the DWC3_DEPEVT_EPCMDCMPLT event was not triggered
> any more when you executed the DWC3_DEPCMD_ENDTRANSFER command?

In this particular case the USB gadget has been disconnected from the host so
we shouldn't be expecting any command completion events.

> 
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
>> +       int epnum;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&dwc->lock, flags);
>> +       for (epnum = 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>> +               struct dwc3_ep  *dep = dwc->eps[epnum];
>> +
>> +               if (!dep)
>> +                       continue;
>> +
>> +               dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
>> +       }
>> +       spin_unlock_irqrestore(&dwc->lock, flags);
>> +
>>         usb_del_gadget_udc(&dwc->gadget);
>>         dwc3_gadget_free_endpoints(dwc);
>>         dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
>> --
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
