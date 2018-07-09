Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB8BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D17820896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="latlNVr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D17820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932583AbeGIKwn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:52:43 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36964 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754433AbeGIKwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:52:42 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so5866459plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=15JO0MRa8m6Ihc9b+7/f5Hd57mTt8g1xrdEpf0VQ89w=;
        b=latlNVr82lPs0G8WFuIJha5bFJ+LZ6YszkJ56tWusn6+GtvXUho695tpTEvnfbt97a
         /AHW2RY+/nZxUYSsE7xH4ttrs/lODJChUU/orySQOjYhOl7fRWpAM6xWZuApiF+fv0Dz
         YwdKT2ZaOXaiErE5z0b8t4WpZlr06jCHvsZk7kCgFDRdRc59TD1LQF1jcpjB+ueLvO2+
         bqwpf+BuAT/dn35vpGVrZ3+Ds9L2sACWaF3k5D2j7D41VesAJOshLPErRedJlKnQAaxI
         FqpoZ+pG718Wb6IyirSnLZ+5GfxTxLVn3r4/Y8/ZlKNZLhW6HKwFkzD2OftBI1COhlpX
         30GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=15JO0MRa8m6Ihc9b+7/f5Hd57mTt8g1xrdEpf0VQ89w=;
        b=FEBqogLyf4vHXXeVLgRsiR51m+QRvacVniiQ5oKyFGpPVT5m9gBX6wdr9TDnzfM1XK
         qqFOvpDrC66TQYYqg1drbtllL6RTLz3FIC4+51X4qJc+b2cSziSKiaqdVpTIAHqytW3K
         Z8OHHPJfG9uT7P6G4Ps2N9uZvfJi7OK0IL+b9JbdUnLOYcMrMT1JnXrL4gAHI5QOzryJ
         jIhWRsgUCopEEUp5auMy3YXWVZcm0ICTxrybo6YMIOuIOg7DlzcSi7PvH9fZDybB+W/c
         BC6ejWF11zsYsJ+zMzuWztYQpREyWc6ATE0Sml2Dy+rTT8c2RwiA+oo9Dqjk2J8WB6vj
         NTMg==
X-Gm-Message-State: APt69E3jnIN9rR2JEPK4RV40QtTUlgObr9WCdL5wWzAn5C230DL2FAd5
        +7kcAk5tMEM9DyhlmCI/OisrlVf20HMiWqn+Z46WFQ==
X-Google-Smtp-Source: AAOMgpd3kpYcSS+6X5QURPmu9JbMg3V5tMB+vkGEPFsjH5iYeAurLaBxU338GnA0C1bK2n45/aj5M7nUcLgtgbnRxH4=
X-Received: by 2002:a17:902:740b:: with SMTP id g11-v6mr14379809pll.85.1531133561570;
 Mon, 09 Jul 2018 03:52:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Mon, 9 Jul 2018 03:52:21
 -0700 (PDT)
In-Reply-To: <CACT4Y+a=8NOg+h6fBzpmVHiZ-vNUiG7SW4QgQvK3vD=KBqQ3_Q@mail.gmail.com>
References: <0000000000004a7da505708a9915@google.com> <20180709101558.63vkwppwcgzcv3dg@kshutemo-mobl1>
 <CACT4Y+a=8NOg+h6fBzpmVHiZ-vNUiG7SW4QgQvK3vD=KBqQ3_Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jul 2018 12:52:21 +0200
Message-ID: <CACT4Y+baBmOHwH6rUL3DjKhGk-JjBAvKOmnq65_4z6b96ohrBQ@mail.gmail.com>
Subject: Re: kernel BUG at mm/memory.c:LINE!
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     syzbot <syzbot+3f84280d52be9b7083cc@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        ldufour@linux.vnet.ibm.com, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 12:48 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Jul 9, 2018 at 12:15 PM, Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
>> On Sun, Jul 08, 2018 at 10:51:03PM -0700, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    b2d44d145d2a Merge tag '4.18-rc3-smb3fixes' of git://git.s..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=11d07748400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3f84280d52be9b7083cc
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+3f84280d52be9b7083cc@syzkaller.appspotmail.com
>>>
>>> next ffff8801ce5e7040 prev ffff8801d20eca50 mm ffff88019c1e13c0
>>> prot 27 anon_vma ffff88019680cdd8 vm_ops 0000000000000000
>>> pgoff 0 file ffff8801b2ec2d00 private_data 0000000000000000
>>> flags: 0xff(read|write|exec|shared|mayread|maywrite|mayexec|mayshare)
>>> ------------[ cut here ]------------
>>> kernel BUG at mm/memory.c:1422!
>>
>> Looks like vma_is_anonymous() false-positive.
>>
>> Any clues what file is it? I would guess some kind of socket, but it's not
>> clear from log which exactly.
>
>
> From the log it looks like it was this program (number 3 matches Comm:
> syz-executor3):
>
> 08:39:32 executing program 3:
> r0 = socket$nl_route(0x10, 0x3, 0x0)
> bind$netlink(r0, &(0x7f00000002c0)={0x10, 0x0, 0x0, 0x100000}, 0xc)
> getsockname(r0, &(0x7f0000000000)=@pppol2tpv3in6={0x0, 0x0, {0x0,
> <r1=>0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, {0x0, 0x0, 0x0,
> @loopback}}}, &(0x7f00000000c0)=0x3a)
> mmap(&(0x7f0000e00000/0x200000)=nil, 0x200000, 0x7fdff, 0x11, r1, 0x0)
> ioctl$FIBMAP(r0, 0x1, &(0x7f0000000100)=0x9)
> r2 = socket$inet6(0xa, 0x1000000000002, 0x0)
> ioctl(r2, 0x8912, &(0x7f00000001c0)="796d05ad441e829115ac7fd77200")
> r3 = syz_open_dev$vcsa(&(0x7f0000000140)='/dev/vcsa#\x00', 0x3, 0x2)
> ioctl$VHOST_SET_VRING_ENDIAN(r3, 0x4008af13, &(0x7f0000000180)={0x0, 0x8})
> sendto$inet(0xffffffffffffffff, &(0x7f0000a88f88), 0xffffffffffffff31,
> 0x0, &(0x7f0000e68000)={0x2, 0x0, @multicast2=0xe0000002},
> 0xfffffffffffffeb3)
> ftruncate(r1, 0x6)
> mmap(&(0x7f0000e00000/0x200000)=nil, 0x200000, 0x0, 0x11, r0, 0x0)
> setsockopt$SO_TIMESTAMPING(r1, 0x1, 0x25, &(0x7f0000000080)=0x804, 0x4)
>
> But take what happens here with a grain of salt, it can pretend that
> it's doing one thing, but actually do something different.
> So that r1 passed to ftruncate is something that getsockname returned
> somewhere in the middle of address. And since the socket is not
> actually ppp, it can be just some bytes in the middle of netlink
> address, that than happened to be small and match some existing fd...


This also happened only once so far:
https://syzkaller.appspot.com/bug?extid=3f84280d52be9b7083cc
and I can't reproduce it rerunning this program. So it's either a very
subtle race, or fd in the middle of netlink address magically matched
some fd once, or something else...
