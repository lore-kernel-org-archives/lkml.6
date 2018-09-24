Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DF2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602DB206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2uo+60C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602DB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeIXMxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 08:53:54 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45269 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIXMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 08:53:54 -0400
Received: by mail-ua1-f68.google.com with SMTP id q7-v6so7862531uam.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 23:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jlkNB/16RtxQS6ZkHrGm+SWLuN1YXVftydnRBV7J5Oc=;
        b=K2uo+60CqsOiwEfOYIVRjeKJV7uDn9vcGrmdizBtofUilVVJv+0Gl4epRMEX0Dbqen
         XjJzC5Eet3yPtyUgLji6CpPDovZiwOoXfg4Pkosu+NXOl+Lfp287opqNrjuden3S4Roi
         NsOL+6lZNr/4J5n8W2cQSx6lPgn2UKrMOyU4F4m0JOh8/PR1XSoH4yz26hNAQ2D3z9Qt
         sy1+Nt4pCjigwAJ88T+gotkSbet5mcYhlCtVkBF5KDre/PHYFEmPKmsQ6XOGvA23Xd7i
         t8GnfAm5Ec5Mncp01RaRkP2ERCU4nmoigzEY74gVSqonR0/kLP7or27XUwAn+SfIkyzk
         l0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jlkNB/16RtxQS6ZkHrGm+SWLuN1YXVftydnRBV7J5Oc=;
        b=Y1o0CQh07Uiy4ddDGK/cgbPjl3ob99cAKmXH6ZOT49U9zCAeZR+bu36NG9sLL4BUMn
         g+evjvr2g4ECfvjJEVmK6htSExee+Dh8u5r5S/l+fFgU/lIDkiPYuj8QGR5jckfw8CEl
         7G2G5Mz6lT3GE05LzQGtE8MRsJhO7H/1V5izq49fcJOBaafL/FsxmCarZzAFKOxTLyxk
         MzFBuFzIG+CkTG3Am+ufQQsObaBawCToLKOni6Azne0NuaRfLOAtAweXvhyuAt2zfLGv
         OiS4AdxeyaWFWuE6kaaYY8IxsuvHjH1xK4dZSN5KwJGLbPlUyIS2fmeXQ4XS4ybs7FFa
         evfQ==
X-Gm-Message-State: ABuFfohRiHEvZd9+tApz+pRKnrMLpYYeQvsI4RiIrSIQwEPcD7Y8GvMm
        +U43WQRYt+/JIisNeVFDiVrQ6MmptoXjmC4IBooTAg==
X-Google-Smtp-Source: ACcGV60S7TAREUgr7cGbVIuLcAZfbpJtOdE2UolyONRJYFwPU0TZtrtg1VJ9IyyrW9uybz9l0GpUxG1i3G2G98YEbwE=
X-Received: by 2002:ab0:1861:: with SMTP id j33-v6mr2164425uag.119.1537771996659;
 Sun, 23 Sep 2018 23:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000565ab805768bf006@google.com> <125732064.15444205.1537718529926.JavaMail.zimbra@redhat.com>
 <CACT4Y+Z1G_QMG_PQu_ZwHsyhwyh_DBOG4mX9n=va08w3Z7j02Q@mail.gmail.com> <1040580049.15456466.1537740558279.JavaMail.zimbra@redhat.com>
In-Reply-To: <1040580049.15456466.1537740558279.JavaMail.zimbra@redhat.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 24 Sep 2018 08:53:04 +0200
Message-ID: <CAG_fn=WwmJONmipmqdZkNj8K0Z-ZRmEiCvG4qt_fHknGYQe5Cg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in memcmp (2)
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Dmitriy Vyukov <dvyukov@google.com>,
        syzbot+d3402c47f680ff24b29c@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, sunlw.fnst@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:09 AM Vladis Dronov <vdronov@redhat.com> wrote:
>
> Hello, Dmirty,
>
> Thank you for the reply. Can we please, discuss this further?
Hi Vladis,
> > You can see on dashboard that the last crash
> > for the second version (2) happened just few days ago. So this is a
> > different bug.
FWIW I've just double-checked that the reproducer provided by
syzkaller in the original message still triggers the report from the
original message in the latest KMSAN tree (which already contains the
__hw_addr_add_ex() fix from April).
> Well... yes and no. When I was looking at this bug (bug?id=3D088efeac32fd=
) I was looking
> at the report at "2018/05/09 18:55" (https://syzkaller.appspot.com/text?t=
ag=3DCrashReport&x=3D141b707b800000),
> since it was the only report with a reproducer. This was my error.
>
> The error and the call trace in this report are:
>
> >>>
> BUG: KMSAN: uninit-value in memcmp+0x119/0x180 lib/string.c:861
> CPU: 0 PID: 38 Comm: kworker/0:1 Not tainted 4.17.0-rc3+ #88
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> Workqueue: ipv6_addrconf addrconf_dad_work
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
>  kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
>  __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:683
>  memcmp+0x119/0x180 lib/string.c:861
>  __hw_addr_add_ex net/core/dev_addr_lists.c:61 [inline]
>  __dev_mc_add+0x1fc/0x900 net/core/dev_addr_lists.c:670
>  dev_mc_add+0x6d/0x80 net/core/dev_addr_lists.c:687
>  igmp6_group_added+0x2db/0xa00 net/ipv6/mcast.c:662
>  ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
>  addrconf_join_solict net/ipv6/addrconf.c:2103 [inline]
>  addrconf_dad_begin net/ipv6/addrconf.c:3853 [inline]
>  addrconf_dad_work+0x462/0x2a20 net/ipv6/addrconf.c:3979
>  process_one_work+0x12c6/0x1f60 kernel/workqueue.c:2145
>  worker_thread+0x113c/0x24f0 kernel/workqueue.c:2279
>  kthread+0x539/0x720 kernel/kthread.c:239
>  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:412
>
> Local variable description: ----buf@igmp6_group_added
> Variable was created at:
>  igmp6_group_added+0x4a/0xa00 net/ipv6/mcast.c:650
>  ipv6_dev_mc_inc+0xe9e/0x1130 net/ipv6/mcast.c:914
> <<<
>
> It is the same like in bug?id=3D3887c0d99aecb27d085180c5222d245d08a30806
> which, after some more test, made me believe these bugs are duplicate
> and are fixed by the same commit.
>
> But let's look at another report at "2018/09/12 21:00"
> (https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D14f99b71400000)
> at the bug (bug?id=3D088efeac32fd), the one you've mentioned as
> "the last crash for the second version (2) happened just few days ago".
>
> Its error and the call trace are completely different:
>
> >>>
> BUG: KMSAN: uninit-value in memcmp+0x11d/0x180 lib/string.c:863
> CPU: 0 PID: 6107 Comm: syz-executor4 Not tainted 4.19.0-rc3+ #45
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x14b/0x190 lib/dump_stack.c:113
>  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
>  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
>  memcmp+0x11d/0x180 lib/string.c:863
>  dev_uc_add_excl+0x165/0x7b0 net/core/dev_addr_lists.c:464
>  ndo_dflt_fdb_add net/core/rtnetlink.c:3463 [inline]
>  rtnl_fdb_add+0x1081/0x1270 net/core/rtnetlink.c:3558
>  rtnetlink_rcv_msg+0xa0b/0x1530 net/core/rtnetlink.c:4715
>  netlink_rcv_skb+0x36e/0x5f0 net/netlink/af_netlink.c:2454
>  rtnetlink_rcv+0x50/0x60 net/core/rtnetlink.c:4733
>  netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
>  netlink_unicast+0x1638/0x1720 net/netlink/af_netlink.c:1343
>  netlink_sendmsg+0x1205/0x1290 net/netlink/af_netlink.c:1908
>  sock_sendmsg_nosec net/socket.c:621 [inline]
>  sock_sendmsg net/socket.c:631 [inline]
> ...
> Uninit was created at:
> ...
>  slab_post_alloc_hook mm/slab.h:446 [inline]
>  slab_alloc_node mm/slub.c:2718 [inline]
>  __kmalloc_node_track_caller+0x9e7/0x1160 mm/slub.c:4351
>  __kmalloc_reserve net/core/skbuff.c:138 [inline]
>  __alloc_skb+0x2f5/0x9e0 net/core/skbuff.c:206
>  alloc_skb include/linux/skbuff.h:996 [inline]
>  netlink_alloc_large_skb net/netlink/af_netlink.c:1189 [inline]
>  netlink_sendmsg+0xb49/0x1290 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:621 [inline]
>  sock_sendmsg net/socket.c:631 [inline]
>  ___sys_sendmsg+0xe70/0x1290 net/socket.c:2114
> <<<
>
> This is a different bug. How come these 2 different reports for 2 differe=
nt
> bugs have ended in the same syzkaller report (bug?id=3D088efeac32fd) ?

I suspect this is because syzbot used the top stack frame as the
report signature.
There's a mechanism to ignore frames like memcmp() in the reports, not
sure why didn't it work in this case (maybe it just wasn't in place at
the time the report happened).
> One bug is fixed by the "net: fix uninit-value in __hw_addr_add_ex()" com=
mit,
> the second one is not, but they are still in the same syzkaller report.
>
> This was the reason of my confusion. I'm not sure how to fix this. If it =
is possible,
> probably we need to cancel/revoke "#syz fix: net: fix uninit-value in __h=
w_addr_add_ex()"
> for this syzkaller report (bug?id=3D088efeac32fd). And then "split" it in=
to 2 or
> more different reports, but I'm not sure if this is possible.
>
> Probably, syzkaller needs to look deeper into the KMSAN reports to differ=
entiate
> KMSAN errors happening because of different reasons.
>
> Best regards,
> Vladis Dronov | Red Hat, Inc. | Product Security Engineer
>
> ----- Original Message -----
> > From: "Dmitry Vyukov" <dvyukov@google.com>
> > To: "Vladis Dronov" <vdronov@redhat.com>
> > Cc: "syzbot" <syzbot+d3402c47f680ff24b29c@syzkaller.appspotmail.com>, "=
syzkaller-bugs"
> > <syzkaller-bugs@googlegroups.com>, "David Miller" <davem@davemloft.net>=
, "Eric Dumazet" <edumazet@google.com>,
> > "LKML" <linux-kernel@vger.kernel.org>, "netdev" <netdev@vger.kernel.org=
>, "sunlianwen" <sunlw.fnst@cn.fujitsu.com>
> > Sent: Sunday, September 23, 2018 6:22:36 PM
> > Subject: Re: KMSAN: uninit-value in memcmp (2)
> >
> > On Sun, Sep 23, 2018 at 6:02 PM, Vladis Dronov <vdronov@redhat.com> wro=
te:
> > > #syz fix: net: fix uninit-value in __hw_addr_add_ex()
> >
> > Hi Vladis,
> >
> > This can be fixed with "net: fix uninit-value in __hw_addr_add_ex()".
> > That commit landed in April, syzbot waited till the commit reached all
> > tested trees, and then closed the bug.
> > But the similar bug continued to happen, so syzbot created second
> > version of this bug (2). You can see on dashboard that the last crash
> > for the second version (2) happened just few days ago. So this is a
> > different bug.
> >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/1040580049.15456466.1537740558279.JavaMail.zimbra%40redhat=
.com.
> For more options, visit https://groups.google.com/d/optout.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
