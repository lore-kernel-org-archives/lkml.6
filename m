Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAEDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7594E21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzwk4UBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7594E21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeI0RiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:38:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35228 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeI0RiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:38:20 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so1684342iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tkh7nY6akc+95ZO51CmQNpAWt8Xwk5UD8FY9Bh7EOD8=;
        b=jzwk4UBxy6dzeibeHsEoqGyrtz7UzFKBvH1vwBcchG7uGdkD9NR7lF7rKindRhjKJU
         r4AmLfcbNzqqR4ksgbGJ1MRLNV9R3oDPgy2u819fbFmAC9ttXpbcy74hRt/bjHcQe7je
         LDSs3WAousmzn2Gj06Cc+qMbCnNQqMgocPPzEK7mV/bbcl+RjKsCE3m71I2O/hIjiTXy
         LFU1234x25sE6pS6A4ta0JInYuTsypCk2r9X8BVTdNLWqrChgK6haQSE9qeLJw3+IWu1
         oZE2rm8uPw0DqygbNNaRQ6pwL5U0UWl3SYdMgGxUfY621l9LR/bQg2TgYShMWRwzUaCK
         t+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tkh7nY6akc+95ZO51CmQNpAWt8Xwk5UD8FY9Bh7EOD8=;
        b=LwOHZ5IIeNtBCewioVgz57fg0MfWwlyoL0vdVlnSoQif+5/lbMfBqKBAoRPZU0kEjl
         QU99fqtl0TLHs1YepF9rk5qMvOqqb+C5bWCCy/pOYQnXCd1iCJ0BE/+GlraH3uM7vPEK
         7G+tXFWKs7Kp//L23GVoiCzywheqmVL/Qit24PaHjmpW5zTtuwQnwzS3xVNvX9pjI7GO
         Sd04q9rp/TI+W4ZivI8J/j+VqWzExAIsMbP8AtIycVi1rzTS00+LzyCXco4LO4LbLL5M
         O3lldVwVFy1io8kOJZjvhq5zem3AgFzLUbwKzMVtM9UfUBht5IlLysM0AQZDmGF4wb8x
         V31w==
X-Gm-Message-State: ABuFfojiOVcqDGrUwQsWUOEDmm9/uV6HVQQmld4usqyZVqE1qlepIaFb
        usZrui0j40D35sypwzFbFKhE8Zl6xiGY0ctL7tyShQ==
X-Google-Smtp-Source: ACcGV61O2GSmgRVyzbTM8kfiKlYtYFss+WOZGwDGnetUHCuiu+jgHIcJ6tKKqU6hKfECajqgMTSr78iMxQXYKvZNI7M=
X-Received: by 2002:a6b:f316:: with SMTP id m22-v6mr7837948ioh.271.1538047231262;
 Thu, 27 Sep 2018 04:20:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 04:20:10
 -0700 (PDT)
In-Reply-To: <1439650590.16502818.1538047050900.JavaMail.zimbra@redhat.com>
References: <000000000000565ab805768bf006@google.com> <125732064.15444205.1537718529926.JavaMail.zimbra@redhat.com>
 <CACT4Y+Z1G_QMG_PQu_ZwHsyhwyh_DBOG4mX9n=va08w3Z7j02Q@mail.gmail.com>
 <1040580049.15456466.1537740558279.JavaMail.zimbra@redhat.com>
 <CAG_fn=WwmJONmipmqdZkNj8K0Z-ZRmEiCvG4qt_fHknGYQe5Cg@mail.gmail.com>
 <CACT4Y+a8_4=dmZavdmZjPOraqYAtjBB228TjurbwLKSgJ9+J7Q@mail.gmail.com> <1439650590.16502818.1538047050900.JavaMail.zimbra@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Sep 2018 13:20:10 +0200
Message-ID: <CACT4Y+Ze=zywPgYODHUj0N5cDQsAmhYCe77u_KmMZYDrR763Vw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in memcmp (2)
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     syzbot <syzbot+d3402c47f680ff24b29c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 1:17 PM, Vladis Dronov <vdronov@redhat.com> wrote:
> Hello, Dmirty,
>
> Thank you for the explanation of how syzkaller/syzbot works in this and
> other emails. I understand that is it a complicated task to determine
> and categorize bugs based on just crash dump and messages, and syzkaller
> does a great job of doing so.

Thanks.

>> Re __hw_addr_add_ex bug, as Alex noted the crash was detected _after_
>> the fixing commit went in. So it's something new and different and
>> can't be fixed by the older commit.
>
> Indeed, you're right, there is another issue with tun/tap devices which
> leads to this bug. I've posted a patch (https://lkml.org/lkml/2018/9/26/416)
> to fix it.
>
> I hope I did not do much damage, reporting previous fix as a fix for this bug,
> as syzkaller will probably create another "KMSAN: uninit-value in <...>"
> report.

No, it did not do any damage.
This is in fact already re-reported as "KMSAN: uninit-value in __dev_mc_add":
https://syzkaller.appspot.com/bug?id=0766d38c656abeace60621896d705743aeefed51

> ----- Original Message -----
>> From: "Dmitry Vyukov" <dvyukov@google.com>
>> To: "Alexander Potapenko" <glider@google.com>
>> Cc: "Vladis Dronov" <vdronov@redhat.com>, "syzbot" <syzbot+d3402c47f680ff24b29c@syzkaller.appspotmail.com>,
>> "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>, "David Miller" <davem@davemloft.net>, "Eric Dumazet"
>> <edumazet@google.com>, "LKML" <linux-kernel@vger.kernel.org>, "Networking" <netdev@vger.kernel.org>, "sunlianwen"
>> <sunlw.fnst@cn.fujitsu.com>
>> Sent: Monday, September 24, 2018 11:39:08 AM
>> Subject: Re: KMSAN: uninit-value in memcmp (2)
>>
>> On Mon, Sep 24, 2018 at 8:53 AM, Alexander Potapenko <glider@google.com>
>> wrote:
>> > On Mon, Sep 24, 2018 at 12:09 AM Vladis Dronov <vdronov@redhat.com> wrote:
>> >>
>> >> Hello, Dmirty,
>> >>
>> >> Thank you for the reply. Can we please, discuss this further?
>> > Hi Vladis,
>> >> > You can see on dashboard that the last crash
>> >> > for the second version (2) happened just few days ago. So this is a
>> >> > different bug.
>> > FWIW I've just double-checked that the reproducer provided by
>> > syzkaller in the original message still triggers the report from the
>> > original message in the latest KMSAN tree (which already contains the
>> > __hw_addr_add_ex() fix from April).
>> >> Well... yes and no. When I was looking at this bug (bug?id=088efeac32fd) I
>> >> was looking
>> >> at the report at "2018/05/09 18:55"
>> >> (https://syzkaller.appspot.com/text?tag=CrashReport&x=141b707b800000),
>> >> since it was the only report with a reproducer. This was my error.
>> >>
>> >> The error and the call trace in this report are:
>> >>
>> >> >>>
>> >> BUG: KMSAN: uninit-value in memcmp+0x119/0x180 lib/string.c:861
>> >> CPU: 0 PID: 38 Comm: kworker/0:1 Not tainted 4.17.0-rc3+ #88
>> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> >> Google 01/01/2011
>> >> Workqueue: ipv6_addrconf addrconf_dad_work
>> >> Call Trace:
>> >>  __dump_stack lib/dump_stack.c:77 [inline]
>> >>  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
>> >>  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>> >>  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
>> >>  memcmp+0x119/0x180 lib/string.c:861
>> >>  __hw_addr_add_ex net/core/dev_addr_lists.c:61 [inline]
>> >>  __dev_mc_add+0x1fc/0x900 net/core/dev_addr_lists.c:670
>> >>  dev_mc_add+0x6d/0x80 net/core/dev_addr_lists.c:687
>> >>  igmp6_group_added+0x2db/0xa00 net/ipv6/mcast.c:662
>> >>  ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
>> >>  addrconf_join_solict net/ipv6/addrconf.c:2103 [inline]
>> >>  addrconf_dad_begin net/ipv6/addrconf.c:3853 [inline]
>> >>  addrconf_dad_work+0x462/0x2a20 net/ipv6/addrconf.c:3979
>> >>  process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2145
>> >>  worker_thread+0x113c/0x24f0 kernel/workqueue.c:2279
>> >>  kthread+0x539/0x720 kernel/kthread.c:239
>> >>  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:412
>> >>
>> >> Local variable description: ----buf@igmp6_group_added
>> >> Variable was created at:
>> >>  igmp6_group_added+0x4a/0xa00 net/ipv6/mcast.c:650
>> >>  ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
>> >> <<<
>> >>
>> >> It is the same like in bug?id=3887c0d99aecb27d085180c5222d245d08a30806
>> >> which, after some more test, made me believe these bugs are duplicate
>> >> and are fixed by the same commit.
>> >>
>> >> But let's look at another report at "2018/09/12 21:00"
>> >> (https://syzkaller.appspot.com/text?tag=CrashReport&x=14f99b71400000)
>> >> at the bug (bug?id=088efeac32fd), the one you've mentioned as
>> >> "the last crash for the second version (2) happened just few days ago".
>> >>
>> >> Its error and the call trace are completely different:
>> >>
>> >> >>>
>> >> BUG: KMSAN: uninit-value in memcmp+0x11d/0x180 lib/string.c:863
>> >> CPU: 0 PID: 6107 Comm: syz-executor4 Not tainted 4.19.0-rc3+ #45
>> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> >> Google 01/01/2011
>> >> Call Trace:
>> >>  __dump_stack lib/dump_stack.c:77 [inline]
>> >>  dump_stack+0x14b/0x190 lib/dump_stack.c:113
>> >>  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
>> >>  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
>> >>  memcmp+0x11d/0x180 lib/string.c:863
>> >>  dev_uc_add_excl+0x165/0x7b0 net/core/dev_addr_lists.c:464
>> >>  ndo_dflt_fdb_add net/core/rtnetlink.c:3463 [inline]
>> >>  rtnl_fdb_add+0x1081/0x1270 net/core/rtnetlink.c:3558
>> >>  rtnetlink_rcv_msg+0xa0b/0x1530 net/core/rtnetlink.c:4715
>> >>  netlink_rcv_skb+0x36e/0x5f0 net/netlink/af_netlink.c:2454
>> >>  rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:4733
>> >>  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
>> >>  netlink_unicast+0x1638/0x1720 net/netlink/af_netlink.c:1343
>> >>  netlink_sendmsg+0x1205/0x1290 net/netlink/af_netlink.c:1908
>> >>  sock_sendmsg_nosec net/socket.c:621 [inline]
>> >>  sock_sendmsg net/socket.c:631 [inline]
>> >> ...
>> >> Uninit was created at:
>> >> ...
>> >>  slab_post_alloc_hook mm/slab.h:446 [inline]
>> >>  slab_alloc_node mm/slub.c:2718 [inline]
>> >>  __kmalloc_node_track_caller+0x9e7/0x1160 mm/slub.c:4351
>> >>  __kmalloc_reserve net/core/skbuff.c:138 [inline]
>> >>  __alloc_skb+0x2f5/0x9e0 net/core/skbuff.c:206
>> >>  alloc_skb include/linux/skbuff.h:996 [inline]
>> >>  netlink_alloc_large_skb net/netlink/af_netlink.c:1189 [inline]
>> >>  netlink_sendmsg+0xb49/0x1290 net/netlink/af_netlink.c:1883
>> >>  sock_sendmsg_nosec net/socket.c:621 [inline]
>> >>  sock_sendmsg net/socket.c:631 [inline]
>> >>  ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
>> >> <<<
>> >>
>> >> This is a different bug. How come these 2 different reports for 2
>> >> different
>> >> bugs have ended in the same syzkaller report (bug?id=088efeac32fd) ?
>> >
>> > I suspect this is because syzbot used the top stack frame as the
>> > report signature.
>> > There's a mechanism to ignore frames like memcmp() in the reports, not
>> > sure why didn't it work in this case (maybe it just wasn't in place at
>> > the time the report happened).
>> >> One bug is fixed by the "net: fix uninit-value in __hw_addr_add_ex()"
>> >> commit,
>> >> the second one is not, but they are still in the same syzkaller report.
>> >>
>> >> This was the reason of my confusion. I'm not sure how to fix this. If it
>> >> is possible,
>> >> probably we need to cancel/revoke "#syz fix: net: fix uninit-value in
>> >> __hw_addr_add_ex()"
>> >> for this syzkaller report (bug?id=088efeac32fd). And then "split" it into
>> >> 2 or
>> >> more different reports, but I'm not sure if this is possible.
>> >>
>> >> Probably, syzkaller needs to look deeper into the KMSAN reports to
>> >> differentiate
>> >> KMSAN errors happening because of different reasons.
>> >>
>> >> > On Sun, Sep 23, 2018 at 6:02 PM, Vladis Dronov <vdronov@redhat.com>
>> >> > wrote:
>> >> > > #syz fix: net: fix uninit-value in __hw_addr_add_ex()
>> >> >
>> >> > Hi Vladis,
>> >> >
>> >> > This can be fixed with "net: fix uninit-value in __hw_addr_add_ex()".
>> >> > That commit landed in April, syzbot waited till the commit reached all
>> >> > tested trees, and then closed the bug.
>> >> > But the similar bug continued to happen, so syzbot created second
>> >> > version of this bug (2). You can see on dashboard that the last crash
>> >> > for the second version (2) happened just few days ago. So this is a
>> >> > different bug.
>>
>>
>> Precisely discriminating bugs (root causes) bases on crash text is
>> generally undecidable problem, even for humans. We even can have
>> literally equal crash texts, which are still different bugs. And we
>> can have significantly differently looking crash texts, which are
>> actually caused by the same root cause. syzbot extracts some
>> "identity" string for each crash and than uses that string to
>> discriminate crashes and sort them into bins. This identity string is
>> what you see in email subject and bug title on dashboard. This method
>> can have both false positives and false negatives, but works
>> reasonably well in most cases and looks like the best practical
>> option.
>>
>> For this exact instance (memcmp) we actually improved the analysis
>> logic recently:
>> https://github.com/google/syzkaller/commit/0e29942f77715486995d996f80f82742812d75a2#diff-abe1515f011fad2659ff218f9eea9ae1
>> But this crash was analyzed and reported before the change. So if this
>> crash happens again it should be reported as "in __hw_addr_add_ex"
>> now.
>>
>> Re __hw_addr_add_ex bug, as Alex noted the crash was detected _after_
>> the fixing commit went in. So it's something new and different and
>> can't be fixed by the older commit.
>>
>> There are no general, single guideline as to what to do when several
>> different bugs glued together into a single bug. Fixing at least one
>> of them (any) in the context of the bug is good, fixing both is good
>> too. When/if a bug is closed, new occurrences of similar crashes (the
>> same identity string) will lead to creation of a new bug. So if we fix
>> only one and close the bug, eventually the second one will lead to a
>> new bug (won't be lost), now dedicated to this second crash.
>>
>> Now syzbot thinks that this bug is fixed/closed:
>> https://syzkaller.appspot.com/bug?extid=d3402c47f680ff24b29c
>> There is specifically no "undo" functionality, because it's inherently
>> racy with creation of a new version of this bugs by new crashes. So if
>> of these crashes will happen again, syzbot will open new bugs (now
>> with better discriminated titles). We can wait for that. Or we can
>> submit new fixes without waiting for new syzbot bugs (adding
>> Reported-by to new commits referencing this bug should not do any
>> harm).
>>
>> Hope this clarifies things a bit.
>>
>> Thanks
