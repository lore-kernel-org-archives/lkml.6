Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2978043-1521203133-2-130604677411891250
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
    t=1521203132; b=j3oQY63Kf5Y+Rc7qA6XU3Rcr7gaPD5MTuhAMrVgMELdq9hY
    o49mtbGi86IJJ4udpcc9fsi7mdLKAuuOqFT87u5VTxNgvSoOQvWAbjAMgO47ZJQ8
    CkGl2bBzGFpi27GN3OUFT1HeRAyTn55ZhSIsXuxu56LymmkSq9R4i3j8xZw1nCrZ
    ueNrQDmyNlF3Mx8asBO+Ed+o/CzbScfO2dWDj4/bez8gYBbXMlesAjEgUM8QZGJx
    jV33u+gEf/Pz3frFS3+vWuGVr5pqOgwh7ak7YZbYgYsfpCqBxHYqcPH90jxghvoD
    eo12L9IoW7nS9ZXSwJhogww1znf85KKNWcW6ehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1521203132; bh=gEI4E8HaRjk16vuq0y5ckMaKLwM+eEzS63cJRK
    gsteU=; b=qEimcLkr9sTscDIwitOEgsyJH8vTWwwmt75BYz7n6UdIxDE/UNIWj9
    RlN6HAyqrI8ZTsBT7Bnuigip2E6YTB0wTX9s+75OFGxGJ0+yNDJtPYVdo2x+rKoU
    3Zdoz1wHkTUqcvV86Wl3MrgML9uxVphbF/mH2KAYD869IDQvupjMzMBFnSIx6rd4
    YOGZKO965ocVqVl2Na68DKqe0E9AkVJjdo8cN+OcKjiSpHFASqucArPzqcrjCmlQ
    4ErWnPahKN90Th81rBqEOYm7LwiZg7qznJKer/0NkQfO8ORwZim/7Cs1vxzpoKSG
    oE2biATQ30OrVWlw7I1gANuWT6DZwtoQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S1751586AbeCPMZS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 08:25:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:22215 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbeCPMZS (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Mar 2018 08:25:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="25047096"
From: Felipe Balbi <balbi@kernel.org>
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Roger Quadros <rogerq@ti.com>
Cc: "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Prevent indefinite sleep in _dwc3_set_mode during suspend/resume
In-Reply-To: <410670D7E743164D87FA6160E7907A560113ABB478@am04wembxa.internal.synopsys.com>
References: <1519730526-22274-1-git-send-email-rogerq@ti.com> <a04fafee-7992-ce8b-55a9-afd4c9935462@ti.com> <69517684-bd39-e945-0c9e-ccd52b8050d5@ti.com> <87y3isffog.fsf@linux.intel.com> <5ea0ad17-d538-72ec-ed59-004242c4cd26@ti.com> <410670D7E743164D87FA6160E7907A560113ABB478@am04wembxa.internal.synopsys.com>
Date: Fri, 16 Mar 2018 14:25:02 +0200
Message-ID: <87zi38438h.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:
>>>> On 09/03/18 14:47, Roger Quadros wrote:
>>>>> In the following test we get stuck by sleeping forever in _dwc3_set_mode()
>>>>> after which dual-role switching doesn't work.
>>>>>
>>>>> On dra7-evm's dual-role port,
>>>>> - Load g_zero gadget driver and enumerate to host
>>>>> - suspend to mem
>>>>> - disconnect USB cable to host and connect otg cable with Pen drive in it.
>>>>> - resume system
>>>>> - we sleep indefinitely in _dwc3_set_mode due to.
>>>>>    dwc3_gadget_exit()->usb_del_gadget_udc()->udc_stop()->
>>>>> 	dwc3_gadget_stop()->wait_event_lock_irq()
>>>>>
>>>>> To fix this instead of waiting indefinitely with wait_event_lock_irq()
>>>>> we use wait_event_interruptible_lock_irq_timeout() and print
>>>>> and error message if there was a timeout.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>
>>>> Thanks for picking this for -next.
>>>> Is it better to have this in v4.16-rc fixes?
>>>> and also stable? v4.12+
>>>
>>> Well, there was no "Fixes: foobar" or "Cc: stable" lines in the commit
>>> log ;-)
>>>
>>> The best we can do now, is wait for -rc1 and manually send the commit to
>>> stable.
>>>
>> 
>> That's fine. Thanks.
>> 
>
> Same issue seen in dwc3_gadget_ep_dequeue() function where also used 
> wait_event_lock_irq() - as result infinite loop.

how did this happen? During rmmod dwc3? Or, perhaps, after you unloaded
a gadget driver?

> Actually to fix this issue I updated condition of wait function
> from:
> !(dep->flags & DWC3_EP_END_TRANSFER_PENDING)
> to:
> !(dep->flags & DWC3_EP_END_TRANSFER_PENDING & DWC3_EP_ENABLED)

you're not fixing anything. You're, essentially, removing the entire
end transfer pending logic. The whole idea of this is that we can
disable the endpoint and wait for the End Transfer interrupt. When you
add a check for the endpoint being enabled, then that code will never
run and, thus, never wait for the End Transfer IRQ.

If you manage to find a more reliable way of reproducing this, then make
sure to capture dwc3 tracepoints (see the documentation for details) and
let's start trying to figure out what's going on.

cheers

-- 
balbi
