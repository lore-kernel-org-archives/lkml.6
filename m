Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831E0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 05:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174EA20843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 05:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k49SjijQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174EA20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeIBJU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 05:20:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33043 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeIBJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 05:20:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id b92-v6so2157801plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 22:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oa98aW0+TGamEELt/EO6JS65YllfrNEMdltxmmIVYiM=;
        b=k49SjijQLRQs1mCJexlbfPuZYFK+aLB1pxI+Ph3UDLE+lPW3MaOAIHYBhC0ACwSADA
         pD1djzNRU8mYDKLDfydvp2T33QrJzZuNvMDZWPsB/MyJnwvvIi261Akx0MRYUsmBi2II
         ePlRfqHi1PoQ1MCGueUEg0Y+pVrUNd0A7gF3XVCqk1/XpdWCcMW/Wiq6cLBc/xUnTIlX
         y02hRBWWk6UinLGpgDfNYW8IP+3NLNXufGzgzEPPZ1HO3iPgblaPsxWRSUXhmtkZ+n9M
         8XG+lbrVUHyK/OixUpg/TeDXz/15DG4C/nslGOzNaFkeXzdTwsZBUiCJq5PdEGiCpTQe
         gPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oa98aW0+TGamEELt/EO6JS65YllfrNEMdltxmmIVYiM=;
        b=MBCvToEUCd2Vj6O4ax4+T0fL+UsaNlAfctA9Tp4geMFaBGYJp2f0kDGWzEMYyQSOY2
         zHstUKhJ4p3jp2DrtUWyA5RCgcisr1V6tg0kI1gJZPfjr1LSUQjEnTBwfYRI1shhbej1
         WkI07UhwdgLyVzI9smQIf4UAYgk23f33tRhbPUvXkRtIKD5Ovv2v/5zaB4KVoFw4MCFw
         6M5rbtSA0ihlGCyDSE0Z6INK0J7z6O7m8rI3EU8rafoUoJsft+tuSnfcw2EoPwA14zfc
         /S8fDaXJxerkyvtFCkPYVs5f7xN6to/t7SpQ4GvTLJ3HkrzsVGNx5Lkz4bmsR9qaIhwE
         Q6Ng==
X-Gm-Message-State: APzg51BXT8B54I1q52WuNwMEkY7emzqv7B5qv4tMvCPukeOz9P68+xp/
        nomOHwA8TfdKlj9XcmcJZDGPvYkTt556Wi8ESXKUDA==
X-Google-Smtp-Source: ANB0Vdai2q1WC3+c33cO6Vu4E3ScE/MOxVKLUgmpDM5KlkTnnvAca0Z8koka5EeGg1PEsW0DtdklO6Ef/2RSO386zZI=
X-Received: by 2002:a17:902:6f10:: with SMTP id w16-v6mr22241255plk.216.1535864759908;
 Sat, 01 Sep 2018 22:05:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Sat, 1 Sep 2018 22:05:39
 -0700 (PDT)
In-Reply-To: <000000000000f02b570574dc59d5@google.com>
References: <CACT4Y+YfaqRg3NYANmCv0xDs8L9=U565AG5iJ8+MhkuNL-1xow@mail.gmail.com>
 <000000000000f02b570574dc59d5@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 2 Sep 2018 07:05:39 +0200
Message-ID: <CACT4Y+Y-wWVPYU0auia=u+XM9AS+JTxf1n8JfGLF-KTCBvNGvw@mail.gmail.com>
Subject: Re: Re: WARNING in apparmor_secid_to_secctx
To:     syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 7:03 AM, syzbot
<syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
>> On Sun, Sep 2, 2018 at 6:52 AM, John Johansen
>> <john.johansen@canonical.com> wrote:
>>>
>>> On 09/01/2018 09:33 PM, Dmitry Vyukov wrote:
>>>>
>>>> On Sat, Sep 1, 2018 at 11:18 AM, John Johansen
>>>> <john.johansen@canonical.com> wrote:
>>>>>
>>>>> On 08/29/2018 07:17 PM, syzbot wrote:
>>>>>>
>>>>>> Hello,
>
>
>>>>>> syzbot found the following crash on:
>
>
>>>>>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>>>>>> git tree:       net-next
>>>>>> console output:
>>>>>> https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>>>>>> kernel config:
>>>>>> https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>>>>>> dashboard link:
>>>>>> https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
>
>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>
>
>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the
>>>>>> commit:
>>>>>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
>
>
>
>>>>> << snip >>
>
>
>>>>> Patch sent directly to syzbot for testing
>
>
>>>> Hi John,
>
>
>>>> What do you mean? syzbot has not received any test requests for this,
>>>> and it would reply within half an hour or so. Where is that patch?
>
>
>
>>> Hrmmm strange I followed the web instruction and attached the patch to
>>> the
>>> reply. The patch is below, its also available at
>
>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
>>> 4.18-syzbot-secid
>
>
>> Humm.. Maybe you did not send it to syzbot?  The command should be just:
>
>
>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
>
>
> "git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor" does not
> look like a valid git repo address.
>
>
>> 4.18-syzbot-secid

I guess the repo is:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor.git
4.18-syzbot-secid


>>> ---
>
>
>>>  From 22dad84baabf4174f11f5e9b34a05529084fa29c Mon Sep 17 00:00:00 2001
>>> From: John Johansen <john.johansen@canonical.com>
>>> Date: Sat, 1 Sep 2018 01:57:52 -0700
>>> Subject: [PATCH] apparmor: fix apparmor_secid_to_secctx incorrect debug
>>>   triggering  WARN_ON
>
>
>>> apparmor_secid_to_secctx() has a bad debug statement tripping on a
>>> condition handle by the code.  When kconfig SECURITY_APPARMOR_DEBUG is
>>> enabled the debug WARN_ON will trip when **secdata is NULL resulting
>>> in the following trace.
>
>
>>> ------------[ cut here ]------------
>>> AppArmor WARN apparmor_secid_to_secctx: ((!secdata)):
>>> WARNING: CPU: 0 PID: 14826 at security/apparmor/secid.c:82
>>> apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
>>> Kernel panic - not syncing: panic_on_warn set ...
>
>
>>> CPU: 0 PID: 14826 Comm: syz-executor1 Not tainted 4.19.0-rc1+ #193
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> Call Trace:
>>>   __dump_stack lib/dump_stack.c:77 [inline]
>>>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>>>   panic+0x238/0x4e7 kernel/panic.c:184
>>>   __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>>>   report_bug+0x252/0x2d0 lib/bug.c:186
>>>   fixup_bug arch/x86/kernel/traps.c:178 [inline]
>>>   do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>>>   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>>>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
>>> RIP: 0010:apparmor_secid_to_secctx+0x2b5/0x2f0
>>> security/apparmor/secid.c:82
>>> Code: c7 c7 40 66 58 87 e8 6a 6d 0f fe 0f 0b e9 6c fe ff ff e8 3e aa 44
>>> fe 48 c7 c6 80 67 58 87 48 c7 c7 a0 65 58 87 e8 4b 6d 0f fe <0f> 0b e9 3f fe
>>> ff ff 48 89 df e8 fc a7 83 fe e9 ed fe ff ff bb f4
>>> RSP: 0018:ffff8801ba1bed10 EFLAGS: 00010286
>>> RAX: 0000000000000000 RBX: ffff8801ba1beed0 RCX: ffffc9000227e000
>>> RDX: 0000000000018482 RSI: ffffffff8163ac01 RDI: 0000000000000001
>>> RBP: ffff8801ba1bed30 R08: ffff8801b80ec080 R09: ffffed003b603eca
>>> R10: ffffed003b603eca R11: ffff8801db01f657 R12: 0000000000000001
>>> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8801ba1beed0
>>>   security_secid_to_secctx+0x63/0xc0 security/security.c:1314
>>>   ctnetlink_secctx_size net/netfilter/nf_conntrack_netlink.c:621 [inline]
>>>   ctnetlink_nlmsg_size net/netfilter/nf_conntrack_netlink.c:659 [inline]
>>>   ctnetlink_conntrack_event+0x303/0x1470
>>> net/netfilter/nf_conntrack_netlink.c:706
>>>   nf_conntrack_eventmask_report+0x55f/0x930
>>> net/netfilter/nf_conntrack_ecache.c:151
>>>   nf_conntrack_event_report
>>> include/net/netfilter/nf_conntrack_ecache.h:112 [inline]
>>>   nf_ct_delete+0x33c/0x5d0 net/netfilter/nf_conntrack_core.c:601
>>>   nf_ct_iterate_cleanup+0x48c/0x5e0
>>> net/netfilter/nf_conntrack_core.c:1892
>>>   nf_ct_iterate_cleanup_net+0x23c/0x2d0
>>> net/netfilter/nf_conntrack_core.c:1974
>>>   ctnetlink_flush_conntrack net/netfilter/nf_conntrack_netlink.c:1226
>>> [inline]
>>>   ctnetlink_del_conntrack+0x66c/0x850
>>> net/netfilter/nf_conntrack_netlink.c:1258
>>>   nfnetlink_rcv_msg+0xd88/0x1070 net/netfilter/nfnetlink.c:228
>>>   netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
>>>   nfnetlink_rcv+0x1c0/0x4d0 net/netfilter/nfnetlink.c:560
>>>   netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
>>>   netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
>>>   netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
>>>   sock_sendmsg_nosec net/socket.c:621 [inline]
>>>   sock_sendmsg+0xd5/0x120 net/socket.c:631
>>>   ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
>>>   __sys_sendmsg+0x11d/0x290 net/socket.c:2152
>>>   __do_sys_sendmsg net/socket.c:2161 [inline]
>>>   __se_sys_sendmsg net/socket.c:2159 [inline]
>>>   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
>>>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>> RIP: 0033:0x457089
>>> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89
>>> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
>>> ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>>> RSP: 002b:00007f7bc6e03c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>>> RAX: ffffffffffffffda RBX: 00007f7bc6e046d4 RCX: 0000000000457089
>>> RDX: 0000000000000000 RSI: 0000000020d65000 RDI: 0000000000000003
>>> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
>>> R13: 00000000004d4588 R14: 00000000004c8d5c R15: 0000000000000000
>>> Dumping ftrace buffer:
>>>     (ftrace buffer empty)
>>> Kernel Offset: disabled
>>> Rebooting in 86400 seconds..
>
>
>>> Fixes: c092921219d2 ("apparmor: add support for mapping secids and using
>>> secctxes")
>>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
>>> Signed-off-by: John Johansen <john.johansen@canonical.com>
>>> ---
>>>   security/apparmor/secid.c | 1 -
>>>   1 file changed, 1 deletion(-)
>
>
>>> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
>>> index f2f22d00db18..4ccec1bcf6f5 100644
>>> --- a/security/apparmor/secid.c
>>> +++ b/security/apparmor/secid.c
>>> @@ -79,7 +79,6 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata,
>>> u32 *seclen)
>>>          struct aa_label *label = aa_secid_to_label(secid);
>>>          int len;
>
>
>>> -       AA_BUG(!secdata);
>>>          AA_BUG(!seclen);
>
>
>>>          if (!label)
>>> --
>>> 2.17.1
>
>
>
>
>
>
>>> --
>>> You received this message because you are subscribed to the Google Groups
>>> "syzkaller-bugs" group.
>>> To unsubscribe from this group and stop receiving emails from it, send an
>>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>>> To view this discussion on the web visit
>>> https://groups.google.com/d/msgid/syzkaller-bugs/09def4f1-7dd8-ba41-139a-0c6f3be2db78%40canonical.com.
>>> For more options, visit https://groups.google.com/d/optout.
