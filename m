Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELu0Gvbege6zOVH6mtz+XNTaZNTcVmD6nMO7eqFo+5zlhcon5FmdUYp4Vgv6hk/VfC8LvCaz
ARC-Seal: i=1; a=rsa-sha256; t=1521768225; cv=none;
        d=google.com; s=arc-20160816;
        b=KS0kulKhY809rMWCcow1jgl/pddFICvwJiT5mJImV3nlfikyS9y27TyWMVxprGqwZZ
         VxS4omel/DcNLTf6644964/9vRQbCWG0JMWGqrJKz1BroBj6NwhW5SeTr0hD+bEMBvhF
         xKpOxr5HNaK3MIN+FHOnKfvI5bPCB4bkDKeFpgd2Tr2ZKEs5JhUMGAdRken8N8mgbpOZ
         6vYKEqJm9DqHXhAGeDXIUC2ArV3qYGNJrTxmb/4KK6REmLWwI7m6PFnvjI5NPc2KdqGY
         +JHHTDFwTWMSO8yB/EGcMoAPFA2bHnMV7qmmPZ39CcxBCFo2I8CJPeF1hEUCwl0pBpfG
         WsOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=SzscdbHp9kqimRq3xo50fs5tQHzbO4qPfzmN38zUv4Y=;
        b=bBB/8/0HM2Zm8PB+WFSDcLPhaM1D1zA9dDSoBF9znpz7zXhyG94UqzXcl3Pami35sz
         wi+HlXBeGPA4779D3jygGD6ZHN5Rew4swtcitwYcsnhkIKO3uzT0lenmFU5YZh2XzzNq
         10wIQZWL2pUUrVoW4qEQQ4SaKtlojvzzJMmUMaFA2UG2SpSXM8M2oSDFuJHTYf0QGMcG
         Z1UbOSkAu/zEDbtGq071NYEELBqN7emNzYMAWtaU7J7oobz/dO9uxRoOUdey0ImGu2GV
         f1PAFOM6YGE0XXlyPwLjAFxxz9vVBXGqRtnmEcPvoShHyd/PeB//6thEtq9Upo3Dtj8I
         k5Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeCWBXp (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Mar 2018 21:23:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:18610 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbeCWBXo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Mar 2018 21:23:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,347,1517904000";
   d="scan'208";a="36087681"
Subject: Re: kernel_selftests.x86.mpx-mini-test_32.fail on skylake platform
To: Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
Cc: "Li, Philip" <philip.li@intel.com>,
        Chen Rong <rongx.a.chen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d36f0567-04a3-3e7f-4332-ce7518bfff60@intel.com>
 <3aa057ec-c0e7-8b18-2054-ec2a6aecaeb9@linux.intel.com>
From: Li Zhijian <zhijianx.li@intel.com>
Message-ID: <c238a4c5-e7a5-4dbb-c178-5bf127c75b9f@intel.com>
Date: Fri, 23 Mar 2018 09:23:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <3aa057ec-c0e7-8b18-2054-ec2a6aecaeb9@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594421573984612479?=
X-GMAIL-MSGID: =?utf-8?q?1595689638933414148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sorry to reply so late.

On 3/13/2018 1:34 AM, Dave Hansen wrote:
> On 03/08/2018 05:24 PM, Li Zhijian wrote:
>> 0Day robot tried to bisect the FBC, but it failed at last. But anyway
>> i want to let you know we had this issue.
> Can you please bisect this, manually if necessary?  Let me know if you
> need any help.


Try to bisect manually, but looks the 'git bisect' can not figure out the correct FBC.

First, the test has different behaviors at different commit. could you help to judge they are good or bad.
1) commit: 59c58ceb29d0f030eddb36a3a9dbadcc499786a6

XSAVE is supported by HW & OS
XSAVE processor supported state mask: 0x1f
XSAVE OS supported state mask: 0x1f
  BNDREGS: size: 64 user: 1 supervisor: 0 aligned: 0
   BNDCSR: size: 64 user: 1 supervisor: 0 aligned: 0

[  OK  ] Reached target Timers.
[  OK  ] Started Permit User Sessions.
[FAILED] Failed to start OpenBSD Secure Shell server.executing unmaptest
mpx dig (  1) complete, SUCCESS (       0 /    0)
unexpected trap 0! at 0x5663fbfa
si_addr (nil)
REG_ERR: 0
abort @ mpx-mini-test.c::450

  --------------

2) 74c8ce958dbf0b64f198becb5d8aa93afb967438
--------------
[    3.423346] BUG: unable to handle kernel paging request at ffffffffff577060
[    3.424283] IP: 0xf77cebe9
[    3.424594] PGD 1c0a067
[    3.424594] P4D 1c0a067
[    3.424853] PUD 1c0c067
[    3.425111] PMD 1c0d067
[    3.425391] PTE 800000002aa09161
[    3.425741]
[    3.426296] Oops: 0003 [#1] SMP
[    3.426622] CPU: 0 PID: 359 Comm: mpx-mini-test_3 Not tainted 4.11.0-rc2-00243-g74c8ce958dbf #37
[    3.427508] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
[    3.428533] task: ffff88003f46cb80 task.stack: ffffc90000738000
[    3.429129] RIP: 0023:0xf77cebe9
[    3.429456] RSP: 002b:00000000ffb3df10 EFLAGS: 00010246
[    3.429982] RAX: 0000000000000063 RBX: 00000000ffb3df10 RCX: 00000000f74bac98
[    3.430696] RDX: 00000000f74ba700 RSI: 00000000f77f5000 RDI: 0000000000000001
[    3.431442] RBP: 00000000ffb3e0c8 R08: 0000000000000000 R09: 0000000000000000
[    3.432153] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    3.432889] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    3.433723] FS:  0000000000000000(0000) GS:ffff88002aa00000(0000) knlGS:0000000000000000
[    3.434540] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[    3.435130] CR2: ffffffffff577060 CR3: 000000003f52b000 CR4: 00000000003406f0
[    3.435928] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.436653] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.437390] RIP: 0xf77cebe9 RSP: 00000000ffb3df10
[    3.437869] CR2: ffffffffff577060
[    3.438229] ---[ end trace dd63a5ceee1b0022 ]---
[    3.438698] Kernel panic - not syncing: Fatal exception
[    3.439316] Kernel Offset: disabled
[    3.439680] ---[ end Kernel panic - not syncing: Fatal exception
qemu-system-x86_64: terminating on signal 2
--------------

3) 8f3e474f3cea7b2470218a6ed6da47ff02147dce
------------
mpx dig (  2) complete, SUCCESS (    7914 / 4986)
[    2.733036] tsc: Refined TSC clocksource calibration: 3192.000 MHz
[    2.733876] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e02c4a121d, max_idle_ns: 440795236083 ns
mpx dig (  3) complete, SUCCESS (   11673 / 7372)
mpx dig (  4) complete, SUCCESS (   10703 / 6725)
mpx dig (  5) complete, SUCCESS (       0 /    0)
mpx dig (  6) complete, SUCCESS (     675 /  421)
mpx dig (  7) complete, SUCCESS (     324 /  205)
[    3.165773] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
mpx dig (  8) complete, SUCCESS (       0 /    0)
mpx dig (  9) complete, SUCCESS (       0 /    0)
mpx dig ( 10) complete, SUCCESS (       0 /    0)
mpx dig ( 11) complete, SUCCESS (       0 /    0)
mpx dig ( 12) complete, SUCCESS (       0 /    0)
mpx dig ( 13) complete, SUCCESS (       0 /    0)
mpx dig ( 14) complete, SUCCESS (       0 /    0)
mpx dig ( 15) complete, SUCCESS (       0 /    0)
mpx dig ( 16) complete, SUCCESS (       0 /    0)
mpx dig ( 17) complete, SUCCESS (       0 /    0)
iteration 1292 complete, OK so far
mpx dig ( 18) complete, SUCCESS (       0 /    0)
mpx dig ( 19) complete, SUCCESS (       0 /    0)
mpx dig ( 20) complete, SUCCESS (       0 /    0)
mpx dig ( 21) complete, SUCCESS (       0 /    0)
mpx dig ( 22) complete, SUCCESS (       0 /    0)
mpx dig ( 23) complete, SUCCESS (       0 /    0)
mpx dig ( 24) complete, SUCCESS (       0 /    0)
mpx dig ( 25) complete, SUCCESS (       0 /    0)
mpx dig ( 26) complete, SUCCESS (       0 /    0)
mpx dig ( 27) complete, SUCCESS (       0 /    0)
mpx dig ( 28) complete, SUCCESS (       0 /    0)
mpx dig ( 29) complete, SUCCESS (       0 /    0)
mpx dig ( 30) complete, SUCCESS (       0 /    0)
mpx dig ( 31) complete, SUCCESS (       0 /    0)
mpx dig ( 32) complete, SUCCESS (       0 /    0)
mpx dig ( 33) complete, SUCCESS (       0 /    0)
mpx dig ( 34) complete, SUCCESS (       0 /    0)
mpx dig ( 35) complete, SUCCESS (       0 /    0)
iteration 2844 complete, OK so far
done with malloc() fun
starting mpx bounds table test
ERROR: siginfo boundsdo  not match shadow boundsfor  register 0
7
------------

4) v4.12
------------
#BR status == 2, missing bounds table,kernel should have handled!!
XSAVE is supported by HW & OS
XSAVE processor supported state mask: 0x2ff
XSAVE OS supported state mask: 0x2ff
   BNDREGS: size: 64 user: 1 supervisor: 0 aligned: 0
    BNDCSR: size: 64 user: 1 supervisor: 0 aligned: 0
executing unmaptest
mpx dig (  1) complete, SUCCESS (       0 /    0)
------------


tried so many wasy to bisect it, find out 3 possible commits
# first bad commit: [771ceddaadd0a2b31603034b36dca50943ff6836] perf vendor events: Add mapping for KnightsMill PMU events
# first bad commit: [1b028f784e8c341e762c264f70dc0ca1418c8b7a] x86/mm: Introduce mmap_compat_base()for  32-bit mmap()
# first bad commit: [5ed386ec09a5d75bcf073967e55e895c2607a5c3] x86/mpx: Correctly report do_mpx_bt_fault() failures to user-space


Thanks
Zhijian

