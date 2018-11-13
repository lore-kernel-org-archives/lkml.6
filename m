Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF98AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DD1223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DD1223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeKNGhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:37:50 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55246 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726291AbeKNGht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:37:49 -0500
Received: (qmail 25148 invoked by uid 2102); 13 Nov 2018 15:37:59 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Nov 2018 15:37:59 -0500
Date:   Tue, 13 Nov 2018 15:37:59 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+7634edaea4d0b341c625@syzkaller.appspotmail.com>
cc:     Thinh.Nguyen@synopsys.com, <felipe.balbi@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <shuah@kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usb_submit_urb (4)
In-Reply-To: <000000000000214dc1057a74d206@google.com>
Message-ID: <Pine.LNX.4.44L0.1811131532270.1503-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, syzbot wrote:

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    e12e00e388de Merge tag 'kbuild-fixes-v4.20' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=100e4ef5400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f215f21f041a0d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=7634edaea4d0b341c625
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ce6fbd400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7634edaea4d0b341c625@syzkaller.appspotmail.com

I tried reproducing this bug on my own system, following the 
instructions at

https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md

The reproducer failed to run properly.  It produced the following 
output:


$ ./syz-execprog -cover=0 -threaded=1 -repeat=1 -procs=4 /tmp/repro.syz 
2018/11/13 15:29:32 parsed 1 programs
2018/11/13 15:29:32 executed programs: 0
2018/11/13 15:29:32 result: failed=false hanged=false err=executor 3: failed: tun: ioctl(TUNSETIFF) failed (errno 1)
loop failed (errno 0)


tun: ioctl(TUNSETIFF) failed (errno 1)
loop failed (errno 0)


The system is Fedora 28 running the 4.18.16-200.fc28.x86_64 kernel.  
What should I do to investigate further?

Alan Stern

