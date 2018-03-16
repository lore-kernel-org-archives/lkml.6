Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2753674-1521198211-2-10121518872483881356
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
    t=1521198211; b=bVXouEdib7ywaJKDkPfelYmKAyTm9Beo8fexhTffsYhmqOk
    Xprhc1NFSNXC2wYtShLHAcMNLt69FroHor6hA/A+OR4IB7mPy9cNeIBzVM5uTztl
    McCzSYmlkrPJ0FWnC3j05f42GPS+t3qLLclggvjc61dgTynR2mrmFZK/tD/ia0r0
    B5fUywj1LqoiJCvBoyN5Evr6gSqSApRCRRZynpuDzUSrmPNNN/HCrEtYJFtVuEvf
    y+ibuZ7ty4kZsiD4qxjK5h+TdDPydfTWM3OA3ZI2aRFbx8Bh1rhRwcwshp4sIpA+
    mSflFybObPG0M2j1f/Nc5zUPt2rlfo+nv7uJA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521198211; bh=UIlKC9AwEkJaB/37Kzm3Viwb4bY6i68LzgKIIvAm6ms=; b=N
    f20+4wmiIVwVx5JJnlUQwZFGOpVUXfeodzjYKpkWuhP31Ukrblg/6H/nDW9+IhZb
    jCeq4luYPURLufWXavPp1Bfc6cP+w5yTVL3ADKuIokb3WBvSGab9jY3popp7dcTI
    ud57RK6noE+50BG97e4ucIYSADdE8I75Df69XZUeBF6W8PuWqAVkVDeQHyEgbFZK
    ekiYLFVxOWpSchi51vh2siSRi8U7NH/S4nNgzWfMtyoPfxx0q1Z6RlsDwQFGl4aI
    7tudj6kieeVT1DCj4AX1UUe7/qeZi5Ey+pNsAWlP2AOTiWy45pzGN/IYSBhPuaf2
    0f2OdRPOvrT8ajwBbfowg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=sCu3VEVD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=sCu3VEVD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbeCPLDR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 07:03:17 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:62380 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753819AbeCPLDQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Mar 2018 07:03:16 -0400
Subject: Re: [PATCH v2] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode
 during suspend/resume
To: Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com>
 <a04fafee-7992-ce8b-55a9-afd4c9935462@ti.com>
 <69517684-bd39-e945-0c9e-ccd52b8050d5@ti.com>
 <87y3isffog.fsf@linux.intel.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <5ea0ad17-d538-72ec-ed59-004242c4cd26@ti.com>
Date: Fri, 16 Mar 2018 13:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87y3isffog.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16/03/18 13:00, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
> 
>> Hi Felipe,
>>
>> On 09/03/18 14:47, Roger Quadros wrote:
>>> In the following test we get stuck by sleeping forever in _dwc3_set_mode()
>>> after which dual-role switching doesn't work.
>>>
>>> On dra7-evm's dual-role port,
>>> - Load g_zero gadget driver and enumerate to host
>>> - suspend to mem
>>> - disconnect USB cable to host and connect otg cable with Pen drive in it.
>>> - resume system
>>> - we sleep indefinitely in _dwc3_set_mode due to.
>>>   dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
>>> 	dwc3_gadget_stop()->wait_event_lock_irq()
>>>
>>> To fix this instead of waiting indefinitely with wait_event_lock_irq()
>>> we use wait_event_interruptible_lock_irq_timeout() and print
>>> and error message if there was a timeout.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>
>> Thanks for picking this for -next.
>> Is it better to have this in v4.16-rc fixes?
>> and also stable? v4.12+
> 
> Well, there was no "Fixes: foobar" or "Cc: stable" lines in the commit
> log ;-)
> 
> The best we can do now, is wait for -rc1 and manually send the commit to
> stable.
> 

That's fine. Thanks.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
