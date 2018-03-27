Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-88863-1522170422-2-9862820527589910066
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522170421; b=dYszI0fX7ZsMbfCkRQZAlrYu5v9BgstQKP3yF3Vox9qGNsC
    Y2KXXE3VQOv9EqcOGi4xoBcuRLjgdPJJsEJK2TRDERwtBK2TvlXtN2AeO13isIH6
    +2KryWfIBQ1+WV0kMyGI0KcUdcsW+8VU9MLtgMCjPLbIuzBO9tAAIFlTPba1ru0d
    x2YGK7v+4BIejuBwn4Fw9kJnDyfxtHq6RXkpQBgO8v1h7xi+Jdt3xnN8/7enPzMN
    0MS0051J8BW7mo8QjWHNM8TnuoXHWkrb5OxPKeJjILADq6V3y2ewjSVzIomZtaCV
    jkAKQWEflgq/1BA8ikOD67LI6AFKu2BDuY/5CYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=arctest;
    t=1522170421; bh=TlJBHAwmJ4sSYxAb9lkxemnjjzGjU/Cp6rAYnI+XM8M=; b=
    ig/pAkt+tXdgSPIN+iGlRCk2iA5HTxdzmf7IMJdiEgW0xbM0xYcyVJ6gSztywgNy
    tpK72xJK+77APjmFu/b/sE55vk4ZDcPPqz8GkibPs1pWkS/K2OqyD/yj8hz42MPx
    scxls9FJixr177r75PnK/naHo5QNbnHq7JsBUHnNoosbe+6yZ5sCjVkXh518YKyb
    qA8eBFWigQVmTj5zQZj6Kk5KwAq12altoMtRAKgzvrAZVtfevUmQb112FwDPs4hR
    dQndcwwzYKGuI+KLUemIg2wgW+5PwOng1D89Su3PQPmp/5o2R2RSliVeiBkKjVNQ
    /JZ6lvmGXRGI9w1wj7SkxQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDSVuNNU92fXPB3OASGwNdq4qoNCY10wu5QIlN9NpvaLdGvfmDHXi9+6T37Q3VzMkyQlVGpxKj3hDh+u/3AGJKOLD2bbrWSSZ4LbEfktkCxt4dARIO1i
    MTmZnsd4U0wgy2Wbh56Jw0WreyI3YI11AnE6GM3N80BO/8+QZJZFNtJ+Oy5B6d0zHfWOC4APevHcYJnpwPVme35DMf10jjzca4XVpjya6uExvR1ywDAbRP6W
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=xej0Vutpp0V8tlr98XAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbeC0RGw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 13:06:52 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58854 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1754424AbeC0RGu (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Mar 2018 13:06:50 -0400
Date: Tue, 27 Mar 2018 13:06:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Jonathan Liu <net147@gmail.com>
cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>, <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AMAN DEEP <aman.deep@samsung.com>, <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [v6] usb: ohci: Proper handling of ed_rm_list to handle race
 condition between usb_kill_urb() and finish_unlinks()
In-Reply-To: <CANwerB3QwzexOWCnFfxL+si7cVj2Gb0m_hak8QTmxTb8t8swsw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1803271243570.1397-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Mar 2018, Jonathan Liu wrote:

> > I am experiencing a USB function call hang from userspace with OCHI
> > (full speed USB device) after updating from Linux 4.14.15 to 4.14.24
> > and noticed this commit.
> >
> > Here is the Linux 4.14.24 kernel stack trace (extracted from SysRq+w
> > and amended with addr2line):
> > [<c05cbd64>] (__schedule) from [<c05cc148>] (schedule+0x50/0xb4)
> > kernel/sched/core.c:2792
> > [<c05cc148>] (schedule) from [<c042789c>]
> > (usb_kill_urb.part.3+0x78/0xa8) include/asm-generic/preempt.h:59
> > [<c042789c>] (usb_kill_urb.part.3) from [<c0433a3c>]
> > (usbdev_ioctl+0x1288/0x1cf0) drivers/usb/core/urb.c:690
> > [<c0433a3c>] (usbdev_ioctl) from [<c0217db8>]
> > (do_vfs_ioctl+0x9c/0x8ec) drivers/usb/core/devio.c:1835
> > [<c0217db8>] (do_vfs_ioctl) from [<c021863c>] (SyS_ioctl+0x34/0x5c)
> > fs/ioctl.c:47
> > [<c021863c>] (SyS_ioctl) from [<c0107820>] (ret_fast_syscall+0x0/0x54)
> > include/linux/file.h:39
> >
> > Afterwards the kernel is unresponsive to disconnect/connect of the
> > full speed USB device but I can connect/disconnect a high speed USB
> > device to the same port and communicate to it without problem since it
> > uses EHCI (OHCI is companion controller). If I try to connect the full
> > speed USB device again it is still unresponsive. The userspace
> > application is still hanging after all this.
> >
> > Could this commit be causing the issue?

It sounds like the URB gets cancelled but is never given back.  But 
although the commit you mentioned does affect this logic, I don't see 
the problem could arise.

> There does seem to be something wrong with this commit. I did some
> more testing with Linux 4.16.0-rc6 on sun7i-a20-olinuxino-lime.
> I connected a sun7i-a20-pcduino3b running Linux 4.15.12 that has OTG
> port with gadget zero kernel module (g_zero) loaded to the USB port
> and did some testing with usbtest from tools/usb/testusb.c in kernel
> repository.
> 
> I had to do the following change to avoid getting flooded with
> "usbtest 1-1:3.0: unlink retry" kernel messages after test 11 of
> testusb starts:
> --- a/drivers/usb/misc/usbtest.c
> +++ b/drivers/usb/misc/usbtest.c
> @@ -1473,7 +1473,7 @@ static int unlink1(struct usbtest_dev *dev, int
> pipe, int
>                 size, int async)
>                                  * resubmission, but since we're testing unlink
>                                  * paths, we can't.
>                                  */
> -                           ERROR(dev, "unlink retry\n");
> +                         /*ERROR(dev, "unlink retry\n");*/

That's a bizarre message in any case.  The condition under which it
gets printed is _not_ an error, just a race.  I would expect it to show
up every now and then just based on random chance.  But if it gets
printed over and over again then something is definitely wrong.

> If I revert the commit, I can run "./testusb -a" to completion without
> any issues with Linux 4.16.0-rc6 on sun7i-a20-olinuxino-lime.
> I don't get a kernel stall detected when testing on x86_64 but I do
> still get at least one "unlink retry" error message from kernel in
> dmesg which can be reproduced using "./testusb -a" or more frequently
> with "./testusb -a -t 11 -c 5000".

A few of those "unlink retry" messages during a test with 5000 
iterations does not mean anything is wrong; don't worry about it.

It would be great if you could debug this farther.  I'm not sure what
to suggest, however.  Clearly we need to know what's going on in
ohci-q.c's finish_unlinks() routine; unfortunately this routine
probably gets called thousands of times before the problem shows up.

Anyway, here's a patch you can try out on the sun7i-a20-olinuxino-lime.  
I have no idea whether it will help pinpoint the source of the problem.

Alan Stern



Index: usb-4.x/drivers/usb/host/ohci-hcd.c
===================================================================
--- usb-4.x.orig/drivers/usb/host/ohci-hcd.c
+++ usb-4.x/drivers/usb/host/ohci-hcd.c
@@ -327,14 +327,21 @@ static int ohci_urb_dequeue(struct usb_h
 		 * some upcoming INTR_SF to call finish_unlinks()
 		 */
 		urb_priv = urb->hcpriv;
-		if (urb_priv->ed->state == ED_OPER)
+		if (urb_priv->ed->state == ED_OPER) {
+			ohci_info(ohci, "start dequeue URB %p ed %p\n", urb,
+					urb_priv->ed);
 			start_ed_unlink(ohci, urb_priv->ed);
-
+		} else
+			ohci_info(ohci, "idle dequeue URB %p ed %p\n", urb,
+					urb_priv->ed);
 		if (ohci->rh_state != OHCI_RH_RUNNING) {
 			/* With HC dead, we can clean up right away */
 			ohci_work(ohci);
 		}
 	}
+	else
+		ohci_info(ohci, "failed dequeue URB %p\n", urb);
+
 	spin_unlock_irqrestore (&ohci->lock, flags);
 	return rc;
 }
Index: usb-4.x/drivers/usb/host/ohci-q.c
===================================================================
--- usb-4.x.orig/drivers/usb/host/ohci-q.c
+++ usb-4.x/drivers/usb/host/ohci-q.c
@@ -1022,6 +1022,7 @@ skip_ed:
 		*last = ed->ed_next;
 		ed->ed_next = NULL;
 		modified = 0;
+		ohci_info(ohci, "scanning unlinked ed %p\n", ed);
 
 		/* unlink urbs as requested, but rescan the list after
 		 * we call a completion since it might have unlinked
@@ -1072,6 +1073,8 @@ rescan_this:
 			/* if URB is done, clean up */
 			if (urb_priv->td_cnt >= urb_priv->length) {
 				modified = completed = 1;
+				ohci_info(ohci, "finish dequeue URB %p ed %p\n",
+						urb, ed);
 				finish_urb(ohci, urb, 0);
 			}
 		}

