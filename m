Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93160C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA722089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="YXVHBzxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA722089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJPByo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:54:44 -0400
Received: from imap.thunk.org ([74.207.234.97]:44362 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbeJPByo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ylglzF5ZU/0mQKeogSlSykiCuRg2q5YAovdACNZsvto=; b=YXVHBzxrrMBkkmJ4SrHcQZSkMm
        293yXIfh/Kp6CbYb4BttafI8FLtTZ/bkzho+nEPWrjwlRGh1nvy6mkcTmgorRY+zdFsekAhLTmd4p
        gBKlFH461mSyzeh7oOZypt0oT0PFa4utiZ+y0AVb44b973XcbaiwuHunDmAHt5kZzdE0=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gC7Hy-0007um-4P; Mon, 15 Oct 2018 18:08:22 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 67B4E7A4986; Mon, 15 Oct 2018 14:08:21 -0400 (EDT)
Date:   Mon, 15 Oct 2018 14:08:21 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in ext4_invalidatepage
Message-ID: <20181015180821.GE8983@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000002753c60577b9f707@google.com>
 <CACT4Y+bdR3ch9q_FCND4YmqjunYBVbEk3n167DT0r0GqzVKL-g@mail.gmail.com>
 <20181009013425.GB3369@thunk.org>
 <CACT4Y+a08tYAgXKEiTO+A-RDrSNk-RdhDxvGCM6bAbk5bckH6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a08tYAgXKEiTO+A-RDrSNk-RdhDxvGCM6bAbk5bckH6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 03:22:42PM +0200, Dmitry Vyukov wrote:
> Now that you mention EXT4_IOC_SWAP_BOOT, I think I looked at the wrong
> program, there is a subsequent one that does ioctl(0x6611) where
> 0x6611 is in fact EXT4_IOC_SWAP_BOOT. So I think it's this one:
> 
> 05:23:28 executing program 5:
> r0 = creat(&(0x7f00000001c0)='./file0\x00', 0x0)
> socketpair$unix(0x1, 0x1, 0x0, &(0x7f0000000380)={0xffffffffffffffff,
> <r1=>0xffffffffffffffff})
> write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000240)={0x0, 0x18,
> 0xfa00, {0x0, &(0x7f0000000200)}}, 0x20)
> ioctl$PERF_EVENT_IOC_ENABLE(r1, 0x8912, 0x400200)
> ioctl$EXT4_IOC_SETFLAGS(r0, 0x6611, &(0x7f0000000000)=0x4000)

Ah, so is it a bug in Syzkaller that it is printing
ioctl$EXT4_IOC_SETFLAGS when 0x6611 is in fact EXT4_IOC_SWAP_BOOT,
right?

> I've tried to manually reply this program and the whole log too, but
> it does not reproduce. This may be related to the fact that filesystem
> accumulates too much global state, so probably first relevant part
> happened long time ago, and then second relevant part happened later
> and triggered the warning. But just re-doing the second part does not
> reproduce the bug.

It was probably some other process racing with EXT4_IOC_SWAP_BOOT.
The patch I referenced in my previous e-mail protects against
additional scenarios where someone might be trying to punch a whole
into a file that is being swapped into the bootloader ioctl.  This
particular ioctl isn't yet being used by anyone, so it had some other
issues as well, such as not interacting well with inline_data-enabled
file systems --- not that any bootloader would be small enough that it
would fit in an inline_data inode, but we're basically proofing the
code against a malicious (or buggy) root-privileged program... such as
syzbot.  :-)

						- Ted
