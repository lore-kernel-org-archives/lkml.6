Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2638020-1517464120-2-13047753785006608063
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517464119; b=CNjiOE37VhDHEeKGFL+IJTt4sk8HLkpBFbaLdt9ZXJx9vak
    UM1F3yHXmbr7RdN1e/5xJrayhDb8i9sPE8eBE9BOrBSZ9aCnurB9X2UuFI8NvCmv
    yh3bdlG/IOLyLTa+IcVrEnveU+KZQw3WlQGGjjn2soqJPJPCVFv794iYvsIOOEu/
    pjF4YLjdxisqlTf0BFb+nhW7QhN/I8kW4CKHuzwfnenWFXfBk6NcL1sOzagW5zwG
    X5ZMaWhArbamTCZh7yTkp4sMb7VacQEP60iJHXTQ5QDEXmF/izYGX2d4282WfYH8
    XWBujujhTJBZ6S2+6/8GFAvjvi8UGWMNeqcivyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517464119; bh=+uHWau19r4odmJO7gMjkoC6UiAqFRxQ5JJs8W7
    qXs3Y=; b=if4DrkxqKfbnQF4ZxnmT2zzdp0rolURAqJ3jKl06BVZl1m0u73ZwgP
    Lv8xUpZxakpt+hdpQMbiUq8wgvVma9QA/bUDNBGB/EcHi4GzPKpLh6rk3sRaeM6d
    ymFK1LLD7R/0eRS/E0ODDWdbspC1LJO9kA94ZBmvnAJx3k5uKntSHS9QTJNaaixv
    EKwTikwv1gviJ/2CX0n3N4gv71b1e7KRFEbkDEklb4Z3oTlzzmBZ8qdQgfxMQ6+N
    EwUek0D7xgIWUYtcM9ziDh7CA3naM+iySPzkJEVDr9unq6HyosbgSPF/q02QrrLV
    CJhV9US4AmCt+rFSKxPqEKNe8lGsf1qg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=windriver.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=windriver.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=windriver.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=windriver.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeBAFsh convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 1 Feb 2018 00:48:37 -0500
Received: from mail5.windriver.com ([192.103.53.11]:48644 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751602AbeBAFse (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 1 Feb 2018 00:48:34 -0500
From: "Yoshida, Shigeru" <Shigeru.Yoshida@windriver.com>
To: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC: "Bai, Haiqing" <Haiqing.Bai@windriver.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ohci-hcd: Fix race condition caused by
 ohci_urb_enqueue() and io_watchdog_func()
Thread-Topic: [PATCH] ohci-hcd: Fix race condition caused by
 ohci_urb_enqueue() and io_watchdog_func()
Thread-Index: AQHTmncRqxjtZV1slkO7r5QpQNTFa6OOqw2AgADm5YA=
Date: Thu, 1 Feb 2018 05:48:13 +0000
Message-ID: <20180201.144911.2171407625301691891.shigeru.yoshida@windriver.com>
References: <1517390197-32323-1-git-send-email-Haiqing.Bai@windriver.com>
        <Pine.LNX.4.44L0.1801311053240.1370-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1801311053240.1370-100000@iolanthe.rowland.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.224.232.213]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C18C3AF19F156F43B851A91BDEE2308C@local>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alan,

Thank you for your commenting.

On Wed, 31 Jan 2018 11:02:47 -0500, Alan Stern wrote:
>> To address above scenario, this patch introduces timer_running flag to
>> ohci_hcd structure.  Setting true to ohci->timer_running indicates
>> io_watchdog_func() is scheduled or is running.  ohci_urb_enqueue()
>> checks the flag when it schedules the watchdog (step 4 and 12 above),
>> so ohci->prev_frame_no is not overwritten while io_watchdog_func() is
>> running.
> 
> Instead of adding an extra flag variable, which has to be kept in sync 
> with the timer routine, how about defining a special sentinel value for 
> prev_frame_no?  For example:
> 
> #define IO_WATCHDOG_OFF		0xffffff00
> 
> Then whenever the timer isn't scheduled or running, set
> ohci->prev_frame_no to IO_WATCHDOG_OFF.  And instead of testing
> timer_pending(), compare prev_frame_no to this special value.
> 
> I think that approach will be slightly more robust.

It's reasonable since ohci->prev_frame_no is not used while the
watchdog timer is stopped.

I think we must choose an invalid frame number for the special
sentinel value, but I'm not sure which value is adequate for it.
Is 0xffffff00 an invalid frame number, otherwise how about simply
-1(0xffffffff)?

Thanks,
Shigeru