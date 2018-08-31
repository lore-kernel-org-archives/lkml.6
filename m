Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6235BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B0D2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B0D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeHaUJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:09:59 -0400
Received: from upbd19pa09.eemsg.mail.mil ([214.24.27.84]:64836 "EHLO
        UPBD19PA09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeHaUJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:09:59 -0400
X-EEMSG-check-008: 135797673|UPBD19PA09_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPBD19PA09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Aug 2018 16:01:43 +0000
X-IronPort-AV: E=Sophos;i="5.53,312,1531785600"; 
   d="scan'208";a="15417412"
IronPort-PHdr: =?us-ascii?q?9a23=3Af8IbHxCO268Ww3dWG6F9UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP39oM6wAkXT6L1XgUPTWs2DsrQY07WQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDiwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zaYN0aWH?=
 =?us-ascii?q?FBXt5PWCNdHoOyYYwPD+8bMuZZqYn2ul8CoBS6CAWpAu7gxCVIhnvr1qMk1e?=
 =?us-ascii?q?ovHxzN0Ag5E98PtXjZqsj+OqUPXuCv1KTG0CvNb/1W1zn+5obHfB8urvOQUr?=
 =?us-ascii?q?x/asfR1UsiGhnZglmMp4HoPTWY3fkNvWiB6OpgUPqihXM7qw5vujivxtkjio?=
 =?us-ascii?q?/UjYwIz1DL7yF5wIIrKty4VUV2ZsWkH4ZLtyyBK4t3Qt8tQ2FvuCogzL0Goo?=
 =?us-ascii?q?S0cDIFyJQg2R7ScvqKeJWG7BLkUeaeOzZ4hHR9dbKwhhay7UigyvDnWcWuzF?=
 =?us-ascii?q?lKqS9FnsHDtnAK0Bzf8MeHSv9l8ki7wTaPzxvT6vlDIUAoj6bUN5khwrs2m5?=
 =?us-ascii?q?EOskrDBjf7lFj5gaKZbEkp+vWk5/75brjpuJOQLZJ4hwfjOao0gMO/G/43Mg?=
 =?us-ascii?q?0WUmie/uSzyaPs8FXiQLVPkv02iq7ZsI3GJcgDpq62HQtV0oE75hajFTimyt?=
 =?us-ascii?q?UYnWQcLF5feRKHiYbpO1bVIP/mEfizmUiskTd3yPDGOb3tGJPNIWTYkLj9Z7?=
 =?us-ascii?q?p97k9cyA4rwdBe4ZJbFK0BLeruVkL+u9HUFB80PxGuz+r5B9hxyJkSVX+XDq?=
 =?us-ascii?q?+cKqzSsFuI5uw1I+mLYY8YoC39JOU+5/P1kX84mUMSfamu3ZcNbnC4Be5pL1?=
 =?us-ascii?q?+WYXrrnNcNCX0KsRYmTOz2lF2CViZeaGusX6M8+zE7C4WmDZnYS4Cih7yB2y?=
 =?us-ascii?q?i7HplIaWxcFl+MFnLofZ2eW/gQcCKSPtNhkjscWLi6S44g1AqhtAjmy7ZgMO?=
 =?us-ascii?q?bY5zEUuY/i2dRo6eDfiQo9+SB0Asmez22CVWV5kX4WSDI4x69yoVdwykyD0K?=
 =?us-ascii?q?l5gPxXD9hT5/dXXQcgL5LT1fR6C8jpWgLZedeJVFOmTc+nATE1VN4+39gOY0?=
 =?us-ascii?q?NlEdW4kh/DxzaqA6MSl7GTGJw18qLc33ntKMZ+0HbLz7UugEMgQstIM22mh7?=
 =?us-ascii?q?Jw+BLXB4LTj0qZkKOqf7wG3CHR7GeD0XaOvEZAXQ5yVqXFXXYfalHUrdT+5k?=
 =?us-ascii?q?PNVbmuCa85PQtH0sONNrFFatvujVVARffsJM7RY2arl2isAhaIw6uGbJD2dG?=
 =?us-ascii?q?UFwCXdFE8EnhgR/XaDMgg+HD2ho2PFDDF1E1LgeUbs/vd/qH+hSU801Q6KZV?=
 =?us-ascii?q?V717Wp4h4VmeCcS/QL07IAuSchrSh0HVmk09LVFdWAvQxhc7tYYd4m/ldH2n?=
 =?us-ascii?q?zWtxZnMpyjMa9inFgefBpzv0/00BV3EIpAm9AwrHw21ApyNb6Y0FRZejOc3J?=
 =?us-ascii?q?DwPKDXK2br8BC0daHZxkze0MyX+qcT6PU0slDjvAa0GUo/93VozcJY02WT5p?=
 =?us-ascii?q?rUFgoeS5HxXVgt9xh8ub7aZjMx54TO1X1jKaO0qCPN28o1BOs5zRatZ8xfP7?=
 =?us-ascii?q?2eFA/9DcIXHMiuJ/Yum1itbhMEOvpe+7IzP8Ojb/GGwrKkPP58nDK6imRK+J?=
 =?us-ascii?q?t900KN9ip/UOHI25IFzO+C3geeTDj8kVihstvslIBLYjESGWW/ySz6C45efK?=
 =?us-ascii?q?1yepsLCX+1I8Gt2tp+gJvtUWZC9FG/H1MGxNOpeR2KYlzlxwJQyEAXrGe/mS?=
 =?us-ascii?q?Si0jx0lyglrq+Y3CzJ2eTtagALNXJMRGln3h/QJt2YitEGRlngURk0lxy7rR?=
 =?us-ascii?q?L22blGp6NhB2bURkhMcm79KGQ0FuOrp6iIZNIHvIg5oy9QTKfmOAjDFOem+x?=
 =?us-ascii?q?FCjnO7FjpSyWsxKhmxq4f6lhh+hXjbJW5rt2LeZcR5xBOZ79vZE7oZwisGRS?=
 =?us-ascii?q?J7khHcD167Odii9NHSnJDG9qi8UGKnEJ9UcSDt1o6GnCCy42psABa2m7a4nd?=
 =?us-ascii?q?i0PxI91HrAy9RyVSjO5C35a43v2rXyZflrZWF0FVT87Ix8AYg4nYwu0sJDkU?=
 =?us-ascii?q?MGj4mYqCJU2Vz4Ns9WjOejM3c=3D?=
X-IPAS-Result: =?us-ascii?q?A2CnAABAZYlb/wHyM5BaEwEBBAEBAQEBAQEBAQEBAQcBA?=
 =?us-ascii?q?QEBAYMkgQ9tEiiDcogRX4wgBoEICCWIYohyhFiBJANTMIQBRgKDTTQYAQIBA?=
 =?us-ascii?q?QEBAQECAWwcDII1JIJeAQEBAQIBIxVBEAsOCgICJgICVwYBDAYCAQGCXD8Bg?=
 =?us-ascii?q?XQFCA+jM4EuhC0BPYUUBYELiSh5gQeBEicMgl+DGwICGIRIglcCiBuFFz+NZ?=
 =?us-ascii?q?QmGNIk/BheBQIQ3iGIrinyJfzg0gSErCAIYCCEPgycfggYXg0WBaIkGIzABC?=
 =?us-ascii?q?Q4BAY4OAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 31 Aug 2018 16:01:42 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7VG1auJ007248;
        Fri, 31 Aug 2018 12:01:38 -0400
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, john.johansen@canonical.com
Cc:     James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Paul Moore <paul@paul-moore.com>
References: <000000000000c178e305749daba4@google.com>
 <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
Date:   Fri, 31 Aug 2018 12:03:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 10:21 PM, Dmitry Vyukov wrote:
> On Wed, Aug 29, 2018 at 7:17 PM, syzbot
> <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>> dashboard link: https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
> 
> Hi John, Tyler,
> 
> I've switched syzbot from selinux to apparmor as we discussed on lss:
> https://github.com/google/syzkaller/commit/2c6cb254ae6c06f61e3aba21bb89ffb05b5db946

Sorry, does this mean that you are no longer testing selinux via syzbot? 
  That seems unfortunate.  SELinux is default-enabled and used in 
Fedora, RHEL and all derivatives (e.g. CentOS), and mandatory in Android 
(and seemingly getting some use in ChromeOS now as well, at least for 
the Android container and possibly wider), so it seems unwise to drop it 
from your testing altogether.  I was under the impression that you were 
just going to add apparmor to your testing matrix, not drop selinux 
altogether.

> 
> As expedited fix for this as possible would be nice to get, because we
> are currently getting 1 machine crash/minute on this bug:
> https://syzkaller.appspot.com/bug?extid=ab1882df6ecbb06d59be
> 
> 
>> ------------[ cut here ]------------
>> AppArmor WARN apparmor_secid_to_secctx: ((!secdata)):
>> WARNING: CPU: 0 PID: 14826 at security/apparmor/secid.c:82
>> apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
>> Kernel panic - not syncing: panic_on_warn set ...
>>
>> CPU: 0 PID: 14826 Comm: syz-executor1 Not tainted 4.19.0-rc1+ #193
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>>   panic+0x238/0x4e7 kernel/panic.c:184
>>   __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>>   report_bug+0x252/0x2d0 lib/bug.c:186
>>   fixup_bug arch/x86/kernel/traps.c:178 [inline]
>>   do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>>   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
>> RIP: 0010:apparmor_secid_to_secctx+0x2b5/0x2f0 security/apparmor/secid.c:82
>> Code: c7 c7 40 66 58 87 e8 6a 6d 0f fe 0f 0b e9 6c fe ff ff e8 3e aa 44 fe
>> 48 c7 c6 80 67 58 87 48 c7 c7 a0 65 58 87 e8 4b 6d 0f fe <0f> 0b e9 3f fe ff
>> ff 48 89 df e8 fc a7 83 fe e9 ed fe ff ff bb f4
>> RSP: 0018:ffff8801ba1bed10 EFLAGS: 00010286
>> RAX: 0000000000000000 RBX: ffff8801ba1beed0 RCX: ffffc9000227e000
>> RDX: 0000000000018482 RSI: ffffffff8163ac01 RDI: 0000000000000001
>> RBP: ffff8801ba1bed30 R08: ffff8801b80ec080 R09: ffffed003b603eca
>> R10: ffffed003b603eca R11: ffff8801db01f657 R12: 0000000000000001
>> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8801ba1beed0
>>   security_secid_to_secctx+0x63/0xc0 security/security.c:1314
>>   ctnetlink_secctx_size net/netfilter/nf_conntrack_netlink.c:621 [inline]
>>   ctnetlink_nlmsg_size net/netfilter/nf_conntrack_netlink.c:659 [inline]
>>   ctnetlink_conntrack_event+0x303/0x1470
>> net/netfilter/nf_conntrack_netlink.c:706
>>   nf_conntrack_eventmask_report+0x55f/0x930
>> net/netfilter/nf_conntrack_ecache.c:151
>>   nf_conntrack_event_report include/net/netfilter/nf_conntrack_ecache.h:112
>> [inline]
>>   nf_ct_delete+0x33c/0x5d0 net/netfilter/nf_conntrack_core.c:601
>>   nf_ct_iterate_cleanup+0x48c/0x5e0 net/netfilter/nf_conntrack_core.c:1892
>>   nf_ct_iterate_cleanup_net+0x23c/0x2d0
>> net/netfilter/nf_conntrack_core.c:1974
>>   ctnetlink_flush_conntrack net/netfilter/nf_conntrack_netlink.c:1226
>> [inline]
>>   ctnetlink_del_conntrack+0x66c/0x850
>> net/netfilter/nf_conntrack_netlink.c:1258
>>   nfnetlink_rcv_msg+0xd88/0x1070 net/netfilter/nfnetlink.c:228
>>   netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2454
>>   nfnetlink_rcv+0x1c0/0x4d0 net/netfilter/nfnetlink.c:560
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1317 [inline]
>>   netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1343
>>   netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1908
>>   sock_sendmsg_nosec net/socket.c:621 [inline]
>>   sock_sendmsg+0xd5/0x120 net/socket.c:631
>>   ___sys_sendmsg+0x7fd/0x930 net/socket.c:2114
>>   __sys_sendmsg+0x11d/0x290 net/socket.c:2152
>>   __do_sys_sendmsg net/socket.c:2161 [inline]
>>   __se_sys_sendmsg net/socket.c:2159 [inline]
>>   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2159
>>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x457089
>> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007f7bc6e03c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 00007f7bc6e046d4 RCX: 0000000000457089
>> RDX: 0000000000000000 RSI: 0000000020d65000 RDI: 0000000000000003
>> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
>> R13: 00000000004d4588 R14: 00000000004c8d5c R15: 0000000000000000
>> Dumping ftrace buffer:
>>     (ftrace buffer empty)
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.

