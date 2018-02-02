Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2700043-1517585123-2-3598151179374905291
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517585123; b=WpuntD/DA4xcj9uyRc7SbWlzX2wOzwbhRIYHsxL1RO1cW5k
    jrAvW/d92+5ULHycNw7ojGcYeN7Fv519DEVjsIOKjAky9T/GDS2Iwj173571F04a
    80Qvn3NIdfQf2zIgES61KXizavMecC19/juM+0qswSAxoG2/6t6ZFvRBpwXydVOH
    pZ91uotbhcp13YmVdpuIbtsfQpzys9OG1OxmrqWiPBrmodAYN/XZlvNQ0mYVIVw1
    SyEotR7xoc2vuHXLRVtRFqJLEDY7SczqL66DQKc/+JJiuVDiMOOObcyc5wNrQIOI
    3FTJQzGhigSWWjKzLaQPaibJArQ24T3mz23sF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=arctest;
    t=1517585123; bh=bdn00U/zvVXuGvAKDN0fTONHi977hhQycLMWdkN3Zeg=; b=
    u2ecjq+pYnjdQDSTCHLd9NnXG7MYg7ImToL2vrMzc0ia+IXY5zLQyMYxXg9KFr0k
    czFh4HwYbwVXtQL+PWdHQCofAC7vBt3f+pEZciVpfrf1gxylFEohwk2jXiPtG2RN
    8xHF4d5u1K+n4mL/b3tqu5quQC64kVGX4Epc6Vvs2WUHD3lJP1DRQIRtpx/bt6Nv
    9FM+8igLygYqvMDtoWiUt4lUDK6UKYwdACu5rlvk/npSPoB13figKkIdlRpONu5s
    ZL++uEnOAK9rmWC9jyLEBDHdJITYUx3XmRJBI/ryL2V+dt/DPptIMf+5poKVbxrF
    1PNY/DcLaX0BKskC/ghthg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeBBPZG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 10:25:06 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:41114 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751878AbeBBPZB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 2 Feb 2018 10:25:01 -0500
Date: Fri, 2 Feb 2018 10:25:00 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Haiqing Bai <Haiqing.Bai@windriver.com>
cc: gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Shigeru.Yoshida@windriver.com>
Subject: Re: [V2][PATCH] ohci-hcd: Fix race condition caused by ohci_urb_enqueue()
 and io_watchdog_func()
In-Reply-To: <1517550699-7879-1-git-send-email-Haiqing.Bai@windriver.com>
Message-ID: <Pine.LNX.4.44L0.1802021021090.1357-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Feb 2018, Haiqing Bai wrote:

> From: Shigeru Yoshida <shigeru.yoshida@windriver.com>
> 
> Running io_watchdog_func() while ohci_urb_enqueue() is running can
> cause a race condition where ohci->prev_frame_no is corrupted and the
> watchdog can mis-detect following error:
> 
>   ohci-platform 664a0800.usb: frame counter not updating; disabled
>   ohci-platform 664a0800.usb: HC died; cleaning up
> 
> Specifically, following scenario causes a race condition:
> 
>   1. ohci_urb_enqueue() calls spin_lock_irqsave(&ohci->lock, flags)
>      and enters the critical section
>   2. ohci_urb_enqueue() calls timer_pending(&ohci->io_watchdog) and it
>      returns false
>   3. ohci_urb_enqueue() sets ohci->prev_frame_no to a frame number
>      read by ohci_frame_no(ohci)
>   4. ohci_urb_enqueue() schedules io_watchdog_func() with mod_timer()
>   5. ohci_urb_enqueue() calls spin_unlock_irqrestore(&ohci->lock,
>      flags) and exits the critical section
>   6. Later, ohci_urb_enqueue() is called
>   7. ohci_urb_enqueue() calls spin_lock_irqsave(&ohci->lock, flags)
>      and enters the critical section
>   8. The timer scheduled on step 4 expires and io_watchdog_func() runs
>   9. io_watchdog_func() calls spin_lock_irqsave(&ohci->lock, flags)
>      and waits on it because ohci_urb_enqueue() is already in the
>      critical section on step 7
>  10. ohci_urb_enqueue() calls timer_pending(&ohci->io_watchdog) and it
>      returns false
>  11. ohci_urb_enqueue() sets ohci->prev_frame_no to new frame number
>      read by ohci_frame_no(ohci) because the frame number proceeded
>      between step 3 and 6
>  12. ohci_urb_enqueue() schedules io_watchdog_func() with mod_timer()
>  13. ohci_urb_enqueue() calls spin_unlock_irqrestore(&ohci->lock,
>      flags) and exits the critical section, then wake up
>      io_watchdog_func() which is waiting on step 9
>  14. io_watchdog_func() enters the critical section
>  15. io_watchdog_func() calls ohci_frame_no(ohci) and set frame_no
>      variable to the frame number
>  16. io_watchdog_func() compares frame_no and ohci->prev_frame_no
> 
> On step 16, because this calling of io_watchdog_func() is scheduled on
> step 4, the frame number set in ohci->prev_frame_no is expected to the
> number set on step 3.  However, ohci->prev_frame_no is overwritten on
> step 11.  Because step 16 is executed soon after step 11, the frame
> number might not proceed, so ohci->prev_frame_no must equals to
> frame_no.
> 
> To address above scenario, this patch introduces a special sentinel
> value IO_WATCHDOG_OFF and set this value to ohci->prev_frame_no when
> the watchdog is not pending or running.  When ohci_urb_enqueue()
> schedules the watchdog (step 4 and 12 above), it compares
> ohci->prev_frame_no to IO_WATCHDOG_OFF so that ohci->prev_frame_no is
> not overwritten while io_watchdog_func() is running.
> 
> v2: Instead of adding an extra flag variable, defining IO_WATCHDOG_OFF
>     as a special sentinel value for prev_frame_no.
> 
> Signed-off-by: Shigeru Yoshida <Shigeru.Yoshida@windriver.com>
> Signed-off-by: Haiqing Bai <Haiqing.Bai@windriver.com>

The "v2" explanation is supposed to go below the "---" tear line, but 
that doesn't matter much.  In any case,

Acked-by: Alan Stern <stern@rowland.harvard.edu>

You know, this could have been fixed a lot more easily if the core
kernel had a timer_pending_or_executing() routine.  I bet there are
other places in the kernel that suffer from the same bug and need the
same fix.

Alan Stern

