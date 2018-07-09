Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CAFC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADA320862
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHG1AByw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADA320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932738AbeGIKtA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:49:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37389 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932278AbeGIKs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:48:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id x10-v6so3543656pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OT04yH2qEg1j621DFQ2q9cpd8AMBcSliWeyq91D/mSo=;
        b=HHG1ABywnUD1CBRjf872WgJuRvADEzXxQcI6zdRHDyYPc4mwpDi0dwF9jQHfiGl+GG
         tjZlxzZMn8NKM8gvzZCKeyt47MWOGETEVqtEpX6vis5OJZh2f5IdFVNRyWEDH3BNVV+P
         dEZXrKp5UlCXODDzHjCfLQAW+EqOKJWJ2BtJgygPtqPTTY8OAdnni6CFEfTcqb5R6iZz
         h7zMcRp3QgiVcf40ErnavSm/z/g/1W+SNMm1P9xSl45L0LLuLCwwLlvj0CNgKiiNbG1m
         sFdPo8dzNmQZyokxlj58ah0wVPXgbGB5RlGda6vmxdWy00h3Seq60hioyfgB5A9EJsox
         bqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OT04yH2qEg1j621DFQ2q9cpd8AMBcSliWeyq91D/mSo=;
        b=U0qYxLnPd0ji027TKYKbxTypiOKMqw7OBob81MWhQh5BrtA9HhB9/8ooNykQ1L4aHM
         OsGKZEWBHyiowiMwkhWJ6nPWz2agh4fhDt8hsFysAlZRe2BHDfXqzEykcYLgQtaTqU5m
         OeuNeQ4RcLdQAuqepgeVoWM4jQ8Hde5s6BURIVcFG2xPC7vea9rTpAWfaeO5pL7WA0A4
         B6aHVzLm56xKMSyIb4NVZa0uZudeIl4qcR20+ZX8ZRGmUCZ7iix+h0USQ9Ne4D6G0T2p
         vZSIzMOGXUSbXC9nAFPFj4op5xqCmr+vouPsk1dYGuB7kb3qSX5jijDcLqikGl1czn6J
         rB2Q==
X-Gm-Message-State: APt69E35kQ0sJ9mCztFW+dffZ1t1IFrEkt5eYobuVlffSO0JLk0E4TlG
        rU+bi1cs5pzH9CqK7vnEZDUK6X9Lsy8kOhDsfawbLw==
X-Google-Smtp-Source: AAOMgpdfX2pjiGyrPOkRaJawz2x/a+8hceCyGLdXN50j5u6X9N2HP1lNu9eCTR27ZGC4g1cAm2B294JhhCiQk9Ttu5s=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr18124410pgu.96.1531133337886;
 Mon, 09 Jul 2018 03:48:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Mon, 9 Jul 2018 03:48:37
 -0700 (PDT)
In-Reply-To: <20180709101558.63vkwppwcgzcv3dg@kshutemo-mobl1>
References: <0000000000004a7da505708a9915@google.com> <20180709101558.63vkwppwcgzcv3dg@kshutemo-mobl1>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jul 2018 12:48:37 +0200
Message-ID: <CACT4Y+a=8NOg+h6fBzpmVHiZ-vNUiG7SW4QgQvK3vD=KBqQ3_Q@mail.gmail.com>
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

On Mon, Jul 9, 2018 at 12:15 PM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Sun, Jul 08, 2018 at 10:51:03PM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    b2d44d145d2a Merge tag '4.18-rc3-smb3fixes' of git://git.s..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11d07748400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3f84280d52be9b7083cc
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+3f84280d52be9b7083cc@syzkaller.appspotmail.com
>>
>> next ffff8801ce5e7040 prev ffff8801d20eca50 mm ffff88019c1e13c0
>> prot 27 anon_vma ffff88019680cdd8 vm_ops 0000000000000000
>> pgoff 0 file ffff8801b2ec2d00 private_data 0000000000000000
>> flags: 0xff(read|write|exec|shared|mayread|maywrite|mayexec|mayshare)
>> ------------[ cut here ]------------
>> kernel BUG at mm/memory.c:1422!
>
> Looks like vma_is_anonymous() false-positive.
>
> Any clues what file is it? I would guess some kind of socket, but it's not
> clear from log which exactly.


From the log it looks like it was this program (number 3 matches Comm:
syz-executor3):

08:39:32 executing program 3:
r0 = socket$nl_route(0x10, 0x3, 0x0)
bind$netlink(r0, &(0x7f00000002c0)={0x10, 0x0, 0x0, 0x100000}, 0xc)
getsockname(r0, &(0x7f0000000000)=@pppol2tpv3in6={0x0, 0x0, {0x0,
<r1=>0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, {0x0, 0x0, 0x0,
@loopback}}}, &(0x7f00000000c0)=0x3a)
mmap(&(0x7f0000e00000/0x200000)=nil, 0x200000, 0x7fdff, 0x11, r1, 0x0)
ioctl$FIBMAP(r0, 0x1, &(0x7f0000000100)=0x9)
r2 = socket$inet6(0xa, 0x1000000000002, 0x0)
ioctl(r2, 0x8912, &(0x7f00000001c0)="796d05ad441e829115ac7fd77200")
r3 = syz_open_dev$vcsa(&(0x7f0000000140)='/dev/vcsa#\x00', 0x3, 0x2)
ioctl$VHOST_SET_VRING_ENDIAN(r3, 0x4008af13, &(0x7f0000000180)={0x0, 0x8})
sendto$inet(0xffffffffffffffff, &(0x7f0000a88f88), 0xffffffffffffff31,
0x0, &(0x7f0000e68000)={0x2, 0x0, @multicast2=0xe0000002},
0xfffffffffffffeb3)
ftruncate(r1, 0x6)
mmap(&(0x7f0000e00000/0x200000)=nil, 0x200000, 0x0, 0x11, r0, 0x0)
setsockopt$SO_TIMESTAMPING(r1, 0x1, 0x25, &(0x7f0000000080)=0x804, 0x4)

But take what happens here with a grain of salt, it can pretend that
it's doing one thing, but actually do something different.
So that r1 passed to ftruncate is something that getsockname returned
somewhere in the middle of address. And since the socket is not
actually ppp, it can be just some bytes in the middle of netlink
address, that than happened to be small and match some existing fd...
