Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF72DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B287B25610
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B287B25610
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754671AbeFYIld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:41:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:60641 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754563AbeFYIlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:41:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 01:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="66995679"
Received: from keunhyun-mobl1.amr.corp.intel.com (HELO [192.168.4.139]) ([10.255.29.56])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2018 01:41:28 -0700
To:     Andy Lutomirski <luto@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>,
        "Ye, Xiaolong" <xiaolong.ye@intel.com>,
        Li Zhijian <zhijianx.li@intel.com>
From:   Li Zhijian <zhijianx.li@intel.com>
Subject: test_syscall_vdso_32 [FAIL]
Message-ID: <0d78b5b4-710e-1b41-46e1-74003ca1381e@intel.com>
Date:   Mon, 25 Jun 2018 16:41:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Intel 0Day noticed that test_syscall_vdso_32 failed since 8bb2610bc4967f19672444a7b0407367f1540028(x86/entry/64/compat: Preserve r8-r11 in int $0x80)

2018-06-25 14:23:00 make run_tests -C x86
make: Entering directory '/usr/src/linux-selftests-x86_64-rhel-7.2-8bb2610bc4967f19672444a7b0407367f1540028/tools/testing/selftests/x86'
gcc -m32 -o /usr/src/linux-selftests-x86_64-rhel-7.2-8bb2610bc4967f19672444a7b0407367f1540028/tools/testing/selftests/x86/test_syscall_vdso_32 -O2 -g -std=gnu99 -pthread -Wall -no-pie -DCAN_BUILD_32 -DCAN_BUILD_64 test_syscall_vdso.c thunks_32.S -lrt -ldl -lm
TAP version 13
selftests: test_syscall_vdso_32
========================================
[RUN]	Executing 6-argument 32-bit syscall via VDSO
[WARN]	Flags before=0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
[WARN]	Flags  after=0000000000200606 id 0 00 d i 0 0 p 1
[WARN]	Flags change=00000000000008d1 0 00 o s z 0 a 0 0 c
[OK]	Arguments are preserved across syscall
[NOTE]	R11 has changed:0000000000200606 - assuming clobbered by SYSRET insn
[OK]	R8..R15 did not leak kernel data
[RUN]	Executing 6-argument 32-bit syscall via INT 80
[OK]	Arguments are preserved across syscall
[FAIL]	R8 has changed:0000000000000000
[FAIL]	R9 has changed:0000000000000000
[FAIL]	R10 has changed:0000000000000000
[FAIL]	R11 has changed:0000000000000000
[RUN]	Executing 6-argument 32-bit syscall via VDSO
[WARN]	Flags before=0000000000200ed7 id 0 00 o d i s z 0 a 0 p 1 c
[WARN]	Flags  after=0000000000200606 id 0 00 d i 0 0 p 1
[WARN]	Flags change=00000000000008d1 0 00 o s z 0 a 0 0 c
[OK]	Arguments are preserved across syscall
[NOTE]	R11 has changed:0000000000200606 - assuming clobbered by SYSRET insn
[OK]	R8..R15 did not leak kernel data
[RUN]	Executing 6-argument 32-bit syscall via INT 80
[OK]	Arguments are preserved across syscall
[FAIL]	R8 has changed:0000000000000000
[FAIL]	R9 has changed:0000000000000000
[FAIL]	R10 has changed:0000000000000000
[FAIL]	R11 has changed:0000000000000000
[RUN]	Running tests under ptrace
not ok 1..1 selftests:  test_syscall_vdso_32 [FAIL]
make: Leaving directory '/usr/src/linux-selftests-x86_64-rhel-7.2-8bb2610bc4967f19672444a7b0407367f1540028/tools/testing/selftests/x86'

This commit changed the testcase expected behavior, but looks it doesn't work as expected.
so want to consult whether 0Day missed something(special configurations) to this case ?

if more details are needed, please let me know.


Thanks

