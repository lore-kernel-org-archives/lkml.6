Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BB3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C612077C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C612077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeIBJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 05:06:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52017 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeIBJGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 05:06:42 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1fwKMw-0008MN-76; Sun, 02 Sep 2018 04:52:14 +0000
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000c178e305749daba4@google.com>
 <45dda774-fd57-3e60-fb67-ad855f2360c9@canonical.com>
 <CACT4Y+Za_M8yQ9j0aUDyZ2rrgJtNHuzeFf3dwmeL5kyb3T5UBQ@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <09def4f1-7dd8-ba41-139a-0c6f3be2db78@canonical.com>
Date:   Sat, 1 Sep 2018 21:52:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Za_M8yQ9j0aUDyZ2rrgJtNHuzeFf3dwmeL5kyb3T5UBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2018 09:33 PM, Dmitry Vyukov wrote:
> On Sat, Sep 1, 2018 at 11:18 AM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 08/29/2018 07:17 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>>> git tree:       net-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
>>>
>>
>> << snip >>
>>
>> Patch sent directly to syzbot for testing
> 
> Hi John,
> 
> What do you mean? syzbot has not received any test requests for this,
> and it would reply within half an hour or so. Where is that patch?
> 

Hrmmm strange I followed the web instruction and attached the patch to the
reply. The patch is below, its also available at

git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor 4.18-syzbot-secid

---

From 22dad84baabf4174f11f5e9b34a05529084fa29c Mon Sep 17 00:00:00 2001
From: John Johansen <john.johansen@canonical.com>
Date: Sat, 1 Sep 2018 01:57:52 -0700
Subject: [PATCH] apparmor: fix apparmor_secid_to_secctx incorrect debug
 triggering  WARN_ON

apparmor_secid_to_secctx() has a bad debug statement tripping on a
condition handle by the code.  When kconfig SECURITY_APPARMOR_DEBUG is
enabled the debug WARN_ON will trip when **secdata is NULL resulting
in the following trace.

------------[ cut here ]------------
AppArmor WARN apparmor_secid_to_secctx: ((!secdata)):
WARNING: CPU: 0 PID: 14826 at security/apparmor/secid.c:82 apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 14826 Comm: syz-executor1 Not tainted 4.19.0-rc1+ #193
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
 panic+0x238/0x4e7 kernel/panic.c:184
 __warn.cold.8+0x163/0x1ba kernel/panic.c:536
 report_bug+0x252/0x2d0 lib/bug.c:186
 fixup_bug arch/x86/kernel/traps.c:178 [inline]
 do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
 do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
 invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
Code: c7 c7 40 66 58 87 e8 6a 6d 0f fe 0f 0b e9 6c fe ff ff e8 3e aa 44 fe 48 c7 c6 80 67 58 87 48 c7 c7 a0 65 58 87 e8 4b 6d 0f fe <0f> 0b e9 3f fe ff ff 48 89 df e8 fc a7 83 fe e9 ed fe ff ff bb f4
RSP: 0018:ffff8801ba1bed10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8801ba1beed0 RCX: ffffc9000227e000
RDX: 0000000000018482 RSI: ffffffff8163ac01 RDI: 0000000000000001
RBP: ffff8801ba1bed30 R08: ffff8801b80ec080 R09: ffffed003b603eca
R10: ffffed003b603eca R11: ffff8801db01f657 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8801ba1beed0
 security_secid_to_secctx+0x63/0xc0 security/security.c:1314
 ctnetlink_secctx_size net/netfilter/nf_conntrack_netlink.c:621 [inline]
 ctnetlink_nlmsg_size net/netfilter/nf_conntrack_netlink.c:659 [inline]
 ctnetlink_conntrack_event+0x303/0x1470 net/netfilter/nf_conntrack_netlink.c:706
 nf_conntrack_eventmask_report+0x55f/0x930 net/netfilter/nf_conntrack_ecache.c:151
 nf_conntrack_event_report include/net/netfilter/nf_conntrack_ecache.h:112 [inline]
 nf_ct_delete+0x33c/0x5d0 net/netfilter/nf_conntrack_core.c:601
 nf_ct_iterate_cleanup+0x48c/0x5e0 net/netfilter/nf_conntrack_core.c:1892
 nf_ct_iterate_cleanup_net+0x23c/0x2d0 net/netfilter/nf_conntrack_core.c:1974
 ctnetlink_flush_conntrack net/netfilter/nf_conntrack_netlink.c:1226 [inline]
 ctnetlink_del_conntrack+0x66c/0x850 net/netfilter/nf_conntrack_netlink.c:1258
 nfnetlink_rcv_msg+0xd88/0x1070 net/netfilter/nfnetlink.c:228
 netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
 nfnetlink_rcv+0x1c0/0x4d0 net/netfilter/nfnetlink.c:560
 netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
 netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
 netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:621 [inline]
 sock_sendmsg+0xd5/0x120 net/socket.c:631
 ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
 __sys_sendmsg+0x11d/0x290 net/socket.c:2152
 __do_sys_sendmsg net/socket.c:2161 [inline]
 __se_sys_sendmsg net/socket.c:2159 [inline]
 __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
 do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7bc6e03c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7bc6e046d4 RCX: 0000000000457089
RDX: 0000000000000000 RSI: 0000000020d65000 RDI: 0000000000000003
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d4588 R14: 00000000004c8d5c R15: 0000000000000000
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

Fixes: c092921219d2 ("apparmor: add support for mapping secids and using secctxes")
Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/secid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index f2f22d00db18..4ccec1bcf6f5 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -79,7 +79,6 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	struct aa_label *label = aa_secid_to_label(secid);
 	int len;
 
-	AA_BUG(!secdata);
 	AA_BUG(!seclen);
 
 	if (!label)
-- 
2.17.1





