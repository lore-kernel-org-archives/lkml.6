Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E03C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB7D2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB7D2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeJOXHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:07:52 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55244 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726545AbeJOXHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:07:52 -0400
Received: (qmail 2184 invoked by uid 2102); 15 Oct 2018 11:22:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Oct 2018 11:22:09 -0400
Date:   Mon, 15 Oct 2018 11:22:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com>
cc:     Thinh.Nguyen@synopsys.com, <felipe.balbi@linux.intel.com>,
        <garsilva@embeddedor.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usb_submit_urb (3)
In-Reply-To: <00000000000050c44f05780f6bbe@google.com>
Message-ID: <Pine.LNX.4.44L0.1810151120060.1394-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9dcd936c5312 Merge tag 'for-4.19/dm-fixes-4' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=123b8da1400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
> dashboard link: https://syzkaller.appspot.com/bug?extid=24a30223a4b609bb802e
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13888991400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1476e5e6400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com
> 
> IPVS: ftp: loaded support on port[0] = 21
> ------------[ cut here ]------------
> usb usb7: BOGUS urb flags, 1 --> 0
> WARNING: CPU: 0 PID: 5828 at drivers/usb/core/urb.c:503  
> usb_submit_urb+0x717/0x14e0 drivers/usb/core/urb.c:502
> Kernel panic - not syncing: panic_on_warn set ...

This should have been fixed by commit 7a68d9fb8510 ("USB: usbdevfs: 
sanitize flags more").  Was that commit not present in the kernel you 
tested?

Alan Stern

