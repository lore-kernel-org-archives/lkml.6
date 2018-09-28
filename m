Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8143C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97518214C3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97518214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeI1Tm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:42:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48107 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1Tm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:42:57 -0400
Received: from static-50-53-48-205.bvtn.or.frontiernet.net ([50.53.48.205] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1g5sfj-0007hL-7I; Fri, 28 Sep 2018 13:19:07 +0000
Subject: Re: KASAN: global-out-of-bounds Read in __aa_lookupn_ns
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+71b6643475f707f93fdc@syzkaller.appspotmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000a7487d0576c18693@google.com>
 <CACT4Y+YAbon-m=N-UcEVfGj8DxgRAySQz7qLYQWFxQZqv+3JhA@mail.gmail.com>
 <CACT4Y+ZP3bFBZ7Omjn7e78ibfCNAFriMpmPut5P38Ex_aGcJHQ@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <23948464-72d2-7d04-59b5-79606c24ed75@canonical.com>
Date:   Fri, 28 Sep 2018 06:19:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZP3bFBZ7Omjn7e78ibfCNAFriMpmPut5P38Ex_aGcJHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 01:39 AM, Dmitry Vyukov wrote:
> On Wed, Sep 26, 2018 at 12:06 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Wed, Sep 26, 2018 at 9:54 AM, syzbot
>> <syzbot+71b6643475f707f93fdc@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    02214bfc89c7 Merge tag 'media/v4.19-2' of git://git.kernel..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1456f8a1400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=71b6643475f707f93fdc
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> Again misattributed to net. This misattribution should now be fixed by:
>> https://github.com/google/syzkaller/commit/db716d6653d073b0abfb51186cd4ac2d5418c9c6
>> Adding security/apparmor/policy_ns.c maintainers explicitly.
> 
> This is the same as "KASAN: stack-out-of-bounds Read in __aa_lookupn_ns":
> https://syzkaller.appspot.com/bug?id=f0d603856d8b3cc9b8e09228f2f548c18ef907ac
> right?
> 

yes it looks like it is


>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+71b6643475f707f93fdc@syzkaller.appspotmail.com
>>>
>>>  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3038
>>>  __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
>>>  __do_sys_setsockopt net/socket.c:1913 [inline]
>>>  __se_sys_setsockopt net/socket.c:1910 [inline]
>>>  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
>>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>> ==================================================================
>>> BUG: KASAN: global-out-of-bounds in memcmp+0xe3/0x160 lib/string.c:861
>>> Read of size 1 at addr ffffffff88000008 by task syz-executor0/10914
>>>
>>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>> RIP: 0033:0x457579
>>> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>>> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>>> RSP: 002b:00007f4c14533c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
>>> RAX: ffffffffffffffda RBX: 00007f4c14533c90 RCX: 0000000000457579
>>> RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
>>> RBP: 000000000072bf00 R08: 0000000000000004 R09: 0000000000000000
>>> R10: 0000000020000080 R11: 0000000000000246 R12: 00007f4c145346d4
>>> R13: 00000000004c3ed9 R14: 00000000004d6260 R15: 0000000000000004
>>> CPU: 0 PID: 10914 Comm: syz-executor0 Not tainted 4.19.0-rc5+ #252
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> Call Trace:
>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>>  print_address_description.cold.8+0x58/0x1ff mm/kasan/report.c:256
>>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>>>  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
>>>  memcmp+0xe3/0x160 lib/string.c:861
>>>  strnstr+0x4b/0x70 lib/string.c:934
>>>  __aa_lookupn_ns+0xc1/0x570 security/apparmor/policy_ns.c:209
>>>  aa_lookupn_ns+0x88/0x1e0 security/apparmor/policy_ns.c:240
>>>  aa_fqlookupn_profile+0x1b9/0x1010 security/apparmor/policy.c:468
>>>  fqlookupn_profile+0x80/0xc0 security/apparmor/label.c:1844
>>>  aa_label_strn_parse+0xa3a/0x1230 security/apparmor/label.c:1908
>>>  aa_label_parse+0x42/0x50 security/apparmor/label.c:1943
>>>  aa_change_profile+0x513/0x3510 security/apparmor/domain.c:1362
>>>  apparmor_setprocattr+0xa8b/0x1150 security/apparmor/lsm.c:656
>>>  security_setprocattr+0x66/0xc0 security/security.c:1298
>>>  proc_pid_attr_write+0x301/0x540 fs/proc/base.c:2555
>>>  __vfs_write+0x119/0x9f0 fs/read_write.c:485
>>>  vfs_write+0x1fc/0x560 fs/read_write.c:549
>>>  ksys_write+0x101/0x260 fs/read_write.c:598
>>>  __do_sys_write fs/read_write.c:610 [inline]
>>>  __se_sys_write fs/read_write.c:607 [inline]
>>>  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>> RIP: 0033:0x457579
>>> Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>>> 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>>> RSP: 002b:00007f5a92ec2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457579
>>> RDX: 000000000000002c RSI: 00000000200000c0 RDI: 0000000000000004
>>> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5a92ec36d4
>>> R13: 00000000004c5454 R14: 00000000004d8c78 R15: 00000000ffffffff
>>>
>>> CPU: 1 PID: 10921 Comm: syz-executor3 Not tainted 4.19.0-rc5+ #252
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>>> Google 01/01/2011
>>> The buggy address belongs to the variable:
>>>  __start_rodata+0x8/0x1000
>>> Call Trace:
>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>>
>>> Memory state around the buggy address:
>>>  ffffffff87ffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>  ffffffff87ffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>  fail_dump lib/fault-inject.c:51 [inline]
>>>  should_fail.cold.4+0xa/0x17 lib/fault-inject.c:149
>>>>
>>>> ffffffff88000000: 00 fa fa fa fa fa fa fa 00 01 fa fa fa fa fa fa
>>>
>>>                       ^
>>>  ffffffff88000080: 00 00 00 07 fa fa fa fa 00 04 fa fa fa fa fa fa
>>>  ffffffff88000100: 05 fa fa fa fa fa fa fa 00 00 00 00 05 fa fa fa
>>> ==================================================================
>>>
>>>
>>> ---
>>> This bug is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this bug report. See:
>>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>>> syzbot.

