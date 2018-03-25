Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073896-1521943439-2-5374011037701721828
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521943438; b=sHu6c6uhIxbWIwdAFfEfEfcb5TfWoSvguvT0ph3e2wOlHSf
    FdOWyuR1JvOrsNB8Gr3rfOpJJafwmRlP+WiFzNw9qEAAz7+U82EdMLPnIcJh6K2d
    D/p9I2UCWPOd7CuymwBaUzd0oJzNn8lz+JqQvxyy2zvAgU7OoCTzihE1s8pfEdYd
    5lySTyj2FkKeLUIq6slQTZuTyGNvKJWyTcNr8yxEcSV+ny+C1koxB/4Qw2SI8Dhl
    iOVxDa4CXYdzGZu1gj+fAR2YO02StMKSn/7droBuuXw8y7h9fbLfXCa8Buobnxv6
    cn0RHQ3LPBFypQWeULDf2OJyiqdjESRZk+d1Zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521943438; bh=GN+EWIa2dGFeSWapMIhXp4zTwS6C+9lnjEPCPS
    FRLq4=; b=q8/NZg3EZvW1kmpubDzcIk1y23l5J6AsUq6Ior/BhbIk7Z01bGyT/m
    kNs/EqsoEZSlcSDrZPV/Jaa7HpbnuBn5UF0pfV/6gBdKg6mSuc8tGVkzkIb8aSgR
    WlG7JMlSfIKfqW+xgPDSAy9QsCNFrweDDSqYvAO69Vie/kgOfFHvq/4j6cQHVfYH
    VTD8389NxfgL5/pnVqa8eop9KN1JFPGbo+D42gzd3u88kMO8kNtAgGuNw0sX7WXZ
    jFqG713nUqEOTmt7doJb47kENNp3I1VGhx8eLKmpWO9TMRvQgK/hVAAQ+FYy2aCK
    Xez7GgPLMKTNOWT/jO8Z5uGBRaw+NZzw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ch708tfU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jb+Nsg39;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ch708tfU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jb+Nsg39;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeCYCDn (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 22:03:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39687 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeCYCDl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Mar 2018 22:03:41 -0400
X-Google-Smtp-Source: AG47ELv2QeqSPmoO2yIFQw+5bgMqOrkMy1yIYnVOIXmtgIx3zb60jPF62KcjqX2aRzNIid4/RU4q2nhImbPnEGPziWA=
MIME-Version: 1.0
In-Reply-To: <CANwerB1BBnQhGoCrna48dtwb36iqC1UcsYJ-1Xnk6K0ce2OiGg@mail.gmail.com>
References: <20180208035501.10711-1-jeffy.chen@rock-chips.com> <CANwerB1BBnQhGoCrna48dtwb36iqC1UcsYJ-1Xnk6K0ce2OiGg@mail.gmail.com>
From: Jonathan Liu <net147@gmail.com>
Date: Sun, 25 Mar 2018 13:03:39 +1100
Message-ID: <CANwerB0JF7bxh-p3iWOju3aqGij4B+Bntqcc4v8BTyP59r2=rQ@mail.gmail.com>
Subject: Re: [v6] usb: ohci: Proper handling of ed_rm_list to handle race
 condition between usb_kill_urb() and finish_unlinks()
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        briannorris@chromium.org, stern@rowland.harvard.edu,
        mka@chromium.org, dianders@chromium.org,
        AMAN DEEP <aman.deep@samsung.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 25 March 2018 at 12:21, Jonathan Liu <net147@gmail.com> wrote:
> Hi,
>
> On 8 February 2018 at 14:55, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> From: AMAN DEEP <aman.deep@samsung.com>
>>
>> There is a race condition between finish_unlinks->finish_urb() function
>> and usb_kill_urb() in ohci controller case. The finish_urb calls
>> spin_unlock(&ohci->lock) before usb_hcd_giveback_urb() function call,
>> then if during this time, usb_kill_urb is called for another endpoint,
>> then new ed will be added to ed_rm_list at beginning for unlink, and
>> ed_rm_list will point to newly added.
>>
>> When finish_urb() is completed in finish_unlinks() and ed->td_list
>> becomes empty as in below code (in finish_unlinks() function):
>>
>>         if (list_empty(&ed->td_list)) {
>>                 *last = ed->ed_next;
>>                 ed->ed_next = NULL;
>>         } else if (ohci->rh_state == OHCI_RH_RUNNING) {
>>                 *last = ed->ed_next;
>>                 ed->ed_next = NULL;
>>                 ed_schedule(ohci, ed);
>>         }
>>
>> The *last = ed->ed_next will make ed_rm_list to point to ed->ed_next
>> and previously added ed by usb_kill_urb will be left unreferenced by
>> ed_rm_list. This causes usb_kill_urb() hang forever waiting for
>> finish_unlink to remove added ed from ed_rm_list.
>>
>> The main reason for hang in this race condtion is addition and removal
>> of ed from ed_rm_list in the beginning during usb_kill_urb and later
>> last* is modified in finish_unlinks().
>>
>> As suggested by Alan Stern, the solution for proper handling of
>> ohci->ed_rm_list is to remove ed from the ed_rm_list before finishing
>> any URBs. Then at the end, we can add ed back to the list if necessary.
>>
>> This properly handle the updated ohci->ed_rm_list in usb_kill_urb().
>>
>> Fixes:977dcfdc6031("USB:OHCI:don't lose track of EDs when a controller dies")
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> CC: <stable@vger.kernel.org>
>> Signed-off-by: Aman Deep <aman.deep@samsung.com>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v6:
>> This is a resend of Aman Deep's v5 patch [0], which solved the hang we
>> hit [1]. (Thanks Aman :)
>>
>> The v5 has some format issues, so i slightly adjust the commit message.
>>
>> [0] https://www.spinics.net/lists/linux-usb/msg129010.html
>> [1] https://bugs.chromium.org/p/chromium/issues/detail?id=803749
>>
>>  drivers/usb/host/ohci-q.c | 17 ++++++++++-------
>>  1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
>> index b2ec8c399363..4ccb85a67bb3 100644
>> --- a/drivers/usb/host/ohci-q.c
>> +++ b/drivers/usb/host/ohci-q.c
>> @@ -1019,6 +1019,8 @@ static void finish_unlinks(struct ohci_hcd *ohci)
>>                  * have modified this list.  normally it's just prepending
>>                  * entries (which we'd ignore), but paranoia won't hurt.
>>                  */
>> +               *last = ed->ed_next;
>> +               ed->ed_next = NULL;
>>                 modified = 0;
>>
>>                 /* unlink urbs as requested, but rescan the list after
>> @@ -1077,21 +1079,22 @@ static void finish_unlinks(struct ohci_hcd *ohci)
>>                         goto rescan_this;
>>
>>                 /*
>> -                * If no TDs are queued, take ED off the ed_rm_list.
>> +                * If no TDs are queued, ED is now idle.
>>                  * Otherwise, if the HC is running, reschedule.
>> -                * If not, leave it on the list for further dequeues.
>> +                * If the HC isn't running, add ED back to the
>> +                * start of the list for later processing.
>>                  */
>>                 if (list_empty(&ed->td_list)) {
>> -                       *last = ed->ed_next;
>> -                       ed->ed_next = NULL;
>>                         ed->state = ED_IDLE;
>>                         list_del(&ed->in_use_list);
>>                 } else if (ohci->rh_state == OHCI_RH_RUNNING) {
>> -                       *last = ed->ed_next;
>> -                       ed->ed_next = NULL;
>>                         ed_schedule(ohci, ed);
>>                 } else {
>> -                       last = &ed->ed_next;
>> +                       ed->ed_next = ohci->ed_rm_list;
>> +                       ohci->ed_rm_list = ed;
>> +                       /* Don't loop on the same ED */
>> +                       if (last == &ohci->ed_rm_list)
>> +                               last = &ed->ed_next;
>>                 }
>>
>>                 if (modified)
>
> I am experiencing a USB function call hang from userspace with OCHI
> (full speed USB device) after updating from Linux 4.14.15 to 4.14.24
> and noticed this commit.
>
> Here is the Linux 4.14.24 kernel stack trace (extracted from SysRq+w
> and amended with addr2line):
> [<c05cbd64>] (__schedule) from [<c05cc148>] (schedule+0x50/0xb4)
> kernel/sched/core.c:2792
> [<c05cc148>] (schedule) from [<c042789c>]
> (usb_kill_urb.part.3+0x78/0xa8) include/asm-generic/preempt.h:59
> [<c042789c>] (usb_kill_urb.part.3) from [<c0433a3c>]
> (usbdev_ioctl+0x1288/0x1cf0) drivers/usb/core/urb.c:690
> [<c0433a3c>] (usbdev_ioctl) from [<c0217db8>]
> (do_vfs_ioctl+0x9c/0x8ec) drivers/usb/core/devio.c:1835
> [<c0217db8>] (do_vfs_ioctl) from [<c021863c>] (SyS_ioctl+0x34/0x5c)
> fs/ioctl.c:47
> [<c021863c>] (SyS_ioctl) from [<c0107820>] (ret_fast_syscall+0x0/0x54)
> include/linux/file.h:39
>
> Afterwards the kernel is unresponsive to disconnect/connect of the
> full speed USB device but I can connect/disconnect a high speed USB
> device to the same port and communicate to it without problem since it
> uses EHCI (OHCI is companion controller). If I try to connect the full
> speed USB device again it is still unresponsive. The userspace
> application is still hanging after all this.
>
> Could this commit be causing the issue?

Note that I have been running with OHCI_QUIRK_QEMU added to
ochi->flags in ohci_init of drivers/usb/host/ohci-hcd.c for both
4.14.15 and 4.14.24 kernels due to a race condition that was later
addressed by https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=v4.14.23&id=85c3d26bd754160f6be90d8b078d70a1b35820e7,
so io_watchdog_func of drivers/usb/host/ohci-hcd.c is not being run.

Thanks.

Regards,
Jonathan
