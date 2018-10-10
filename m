Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279F6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA1E21527
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RBIJVdwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA1E21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJJUXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:23:38 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55553 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJJUXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:23:38 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so7827450itd.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ycSNX1mI1lyDDWYJWzgrRx2cDOWLY8ewqscdO5YFelo=;
        b=RBIJVdwMJe0dfth89rw6HwcULyzEIih9VMRonfyFv2+QuuDE7ijlZtG2G1lNNb3/dB
         ta3T65d8zymGSsQ7T2PcIn7TBKoQiavR1oZ35UapfDncSXN/uHtjxI1TJkKwfYIEVisM
         PTgHkoffYvVY78SPC7h5eenx6NgR/0e4jebCoOPcGrHe78Xulsebzi35JAY37IOKN8e6
         dQEMYztUkdEIt93EwsiMTqGZG/Te9kV7mC0DsxaykwGV+8vXl9PaJqnk9VudpF+Jf1Z/
         Trfyzl061eqdFt8cVvxKq5axcl0vhHImVke+kduPLhnXcDx2Pm5w65ZbS9t7OsLfM+cV
         xOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ycSNX1mI1lyDDWYJWzgrRx2cDOWLY8ewqscdO5YFelo=;
        b=pMmzgJnpd7kI90uMy4vkpvie6XYEMeeXbRuZgWCBTYQWqHxp30aWlB29Q1ZfBvIzgg
         R109rew3PpmF+CIA7R3EPL0wCfM8jwsnXLuGLSOXXfVPrl/f5NTSLexA1TqW3VYCewOC
         4mMBV+vIRFzLtuaQ+nD9XSyN4dQJ9/rkzpR5tZctxTfDaZi+0ZCl8sZEdUnMyVrxwxyv
         qOLYNS6NNrYAZTzQCGPsMT16nsCzGEmjk8vUdBEYOH9EaRk/y2GvTz0Puv9x7EzmTQwq
         i9/FNup0bmeTriqQ+9ediEu2N/nQ/VMLE/l3LW0Yb2mjoGsrgekkhIZzxVS6X564Enq5
         fBYQ==
X-Gm-Message-State: ABuFfoivDpGmj2sSnEMwk1YeIkvHHh4e4l8UURp5wFhOaGHw5MFuK08P
        pJ81wmEfFuFTW2ZXuHOIhwLs67NvzBR8ZPCJEGV4GA==
X-Google-Smtp-Source: ACcGV60CQ1d99cFLxKkGHfTaHfi3Wy3+cwQqVYNjW3ondSGcU6LXAg/tHLwAiM4gPmrXjGKMW3AOiRbLGI6S0lKDntg=
X-Received: by 2002:a24:940f:: with SMTP id j15-v6mr676755ite.12.1539176491702;
 Wed, 10 Oct 2018 06:01:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 06:01:11
 -0700 (PDT)
In-Reply-To: <20181009113000.GC4105@mtr-leonro.mtl.com>
References: <000000000000b3d5610577b9e12c@google.com> <CACT4Y+bfqk8Fczw4dJHhVzM63YhYNSovEE-KygZ1XmgUQVGCWQ@mail.gmail.com>
 <20181008194513.GC27639@ziepe.ca> <20181009113000.GC4105@mtr-leonro.mtl.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 15:01:11 +0200
Message-ID: <CACT4Y+ZH946wZ5UxZp=zmRF7eJxOtAB5z6aBSAOuowWhHh3Fgw@mail.gmail.com>
Subject: Re: WARNING in __put_task_struct (2)
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        syzbot <syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com>,
        dledford@redhat.com, swise@opengridcomputing.com,
        markb@mellanox.com, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, guro@fb.com,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Marcos Souza <marcos.souza.org@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 1:30 PM, Leon Romanovsky <leon@kernel.org> wrote:
> On Mon, Oct 08, 2018 at 01:45:13PM -0600, Jason Gunthorpe wrote:
>> On Mon, Oct 08, 2018 at 06:15:22PM +0200, Dmitry Vyukov wrote:
>> > On Mon, Oct 8, 2018 at 6:12 PM, syzbot
>> > <syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com> wrote:
>> > > Hello,
>> > >
>> > > syzbot found the following crash on:
>> > >
>> > > HEAD commit:    ae16eea39a86 Add linux-next specific files for 20181008
>> > > git tree:       linux-next
>> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12e7c6a1400000
>> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=42525ce985d1a955
>> > > dashboard link: https://syzkaller.appspot.com/bug?extid=1ed9dfaa984c88cf0ef8
>> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> > >
>> > > Unfortunately, I don't have any reproducer for this crash yet.
>> > >
>> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > > Reported-by: syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com
>> >
>> >
>> > This was triggered by the following program, all is rdma-related, so
>> > +rdma maintainers.
>> >
>> > 10:27:26 executing program 5:
>> > r0 = openat$rdma_cm(0xffffffffffffff9c,
>> > &(0x7f0000000380)='/dev/infiniband/rdma_cm\x00', 0x2, 0x0)
>> > write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000080)={0x0, 0x18,
>> > 0xfa00, {0x0, &(0x7f0000000040)={<r1=>0xffffffffffffffff}, 0x13f}},
>> > 0x12d)
>> > write$RDMA_USER_CM_CMD_RESOLVE_IP(r0, &(0x7f0000000200)={0x3, 0x40,
>> > 0xfa00, {{0xa, 0x4e21}, {0xa, 0x0, 0x0, @mcast1}, r1}}, 0x48)
>> > write$RDMA_USER_CM_CMD_CREATE_ID(r0, &(0x7f0000000340)={0x0, 0x18,
>> > 0xfa00, {0x0, &(0x7f0000000300)={<r2=>0xffffffffffffffff}, 0x13f}},
>> > 0x20)
>> > write$RDMA_USER_CM_CMD_SET_OPTION(r0, &(0x7f00000002c0)={0xe, 0x18,
>> > 0xfa00, @id_afonly={&(0x7f0000000000)=0x1, r1, 0x0, 0x2, 0x4}}, 0x20)
>> > write$RDMA_USER_CM_CMD_RESOLVE_IP(r0, &(0x7f0000000100)={0x3, 0x40,
>> > 0xfa00, {{0x2, 0x4e21}, {0xa, 0x0, 0x0, @local}, r2}}, 0x1ff)
>> > write$RDMA_USER_CM_CMD_DESTROY_ID(r0, &(0x7f0000000180)={0x1, 0x10,
>> > 0xfa00, {&(0x7f00000000c0), r2}}, 0x18)
>>
>> This might be fixed in Linux-next now by this commit:
>>
>> Author: Leon Romanovsky <leonro@mellanox.com>
>> Date:   Tue Oct 2 11:48:03 2018 +0300
>>
>>     RDMA/restrack: Release task struct which was hold by CM_ID object
>
> Jason,
>
> I afraid that the opposite it more accurate.
>
> This issue was introduced by that commit and According to linux-next
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/tag/?h=next-20181008
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?h=next-20181008&id=ae16eea39a86735f4ed0b5a6e9fe43c6cedb13b3
> The RDMA tree has commit ed7a01fd3fd77f40b4ef2562b966a5decd8928d2,
> which is exactly the one you cited above.
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-next&id=ed7a01fd3fd77f40b4ef2562b966a5decd8928d2
>
> Any ideas how?

I marked another bug as dup of this because it looks like the same root cause:
https://syzkaller.appspot.com/bug?id=e1854417677586ce3d00f498f19816cb4fd15676
And that dup bug has a C reproducer.
