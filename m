Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2753674-1521198077-2-16565746588523014545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521198076; b=NwvulNyMyuBQqKQc78mwysLZF0uJEjo6poze6d6RtZ5FMOW
    PrUlp/dnSuOYBjLtGmGAd26rlNxK9q/uSZ9rhLduAoTLEVL/Dmen8tYpd1kDoX0s
    ltANQDTzh19g4TYuCDdL+L2sLLiaixnUuJJ0eU1x52W6stnX1wtwxbWp+tOOPZVX
    CbkdJtecZ+JxTBINgaEuNVy6jloeQNn1V+SstanQZBJ/MRQhtbL2W6mm4rNJZFdj
    j16JYuXnOw9WdtTrp0atgLMg1+6gURgrV+UQRZGVIZOBQjbB+s4tQR8uTU2cjvEW
    YH8hNAYlewrr0eOVT4rfEjRGKMoK1KTxdyuAA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1521198076; bh=Okp7YFwyCPjs2U4MQ7yBHHIThvQ+MBiy8dwc8Z
    OEnUY=; b=nmT0wrDGiQiFa8tNemOlV9TJGlCG91u/HMbj+7QUrBK+NG4Jc1jAr7
    pu3niAMJZlScjHgTEW9q3DgWN14GGGZ1dL+6UZ6UqkXrc/88m90PI3pJFODyHJGc
    PmBkopsYzVeco0PM/cCZbo/DJt31FAcswweQyimNmHtuAJpAdlhlm/+ykVTcJJds
    UmPjFVCMKMFbjvFrMdCzlYgTBXix1NmQFY/RP8AwuO+IeSq4nLuw04GuK7Uz4uZG
    yvz6uDjai7R5uyD1AsrJjYnMIstFOs3SfHpY9MxVeGM/parNm95gev0dQjPNdgHT
    Ov2sgyE0I1P05JngJvsYEyYo5loC/hsw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeCPLBE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 07:01:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:25320 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753019AbeCPLBD (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Mar 2018 07:01:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="34399146"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <69517684-bd39-e945-0c9e-ccd52b8050d5@ti.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <a04fafee-7992-ce8b-55a9-afd4c9935462@ti.com> <69517684-bd39-e945-0c9e-ccd52b8050d5@ti.com>
Date: Fri, 16 Mar 2018 13:00:47 +0200
Message-ID: <87y3isffog.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,

Roger Quadros <rogerq@ti.com> writes:

> Hi Felipe,
>
> On 09/03/18 14:47, Roger Quadros wrote:
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
>> To fix this instead of waiting indefinitely with wait_event_lock_irq()
>> we use wait_event_interruptible_lock_irq_timeout() and print
>> and error message if there was a timeout.
>> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>
> Thanks for picking this for -next.
> Is it better to have this in v4.16-rc fixes?
> and also stable? v4.12+

Well, there was no "Fixes: foobar" or "Cc: stable" lines in the commit
log ;-)

The best we can do now, is wait for -rc1 and manually send the commit to
stable.

-- 
balbi
