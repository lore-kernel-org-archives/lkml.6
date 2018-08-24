Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA72DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7181521477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g9CKrRwT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nZ6cszQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7181521477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeHXSUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:20:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53806 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeHXSUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:20:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 94245607B5; Fri, 24 Aug 2018 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535121946;
        bh=/b3E9kV9nTFJ37BkXehBorXy+ghOXTnWyOpvfVteP7g=;
        h=From:To:Cc:Subject:Date:From;
        b=g9CKrRwTAVMPheJsP6/7hl7R4HIIXfa3Ue5NoFk88zyyOXvN2HYm4RCEdkL4RMRqg
         QnmV7qqEuUPGFqTSpDpBq1z3Ifk6gqEzJh1ENockBZBFYzLbz91JSaHeDbr2YXzfW7
         IyS+37QKPsUOlHzz0Vxp0n68glhRtpZ84B4cZhyc=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 028E360600;
        Fri, 24 Aug 2018 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535121944;
        bh=/b3E9kV9nTFJ37BkXehBorXy+ghOXTnWyOpvfVteP7g=;
        h=From:To:Cc:Subject:Date:From;
        b=nZ6cszQ+M2jM1ZRKMNQCCGMow8woB7foNYmeLbBuISTK5mVFDValqxo+Ltuo6keCT
         +hy0jTH0Qqfylmqs2kbActvxJDUVSCPUQcFL/d5DpR+3K4pG1dZG0ODcjJwi/6irb8
         am7h04g+ntjG+zdtBJQRUENjXROAbw8+hsvlc/Yk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 028E360600
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [RFC PATCH v2 0/3] Register read/write tracing with dynamic debug and pstore
Date:   Fri, 24 Aug 2018 20:15:24 +0530
Message-Id: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds a new tracing facility for register reads and writes called
Register Trace Buffer(RTB).

We also add pstore support through which we can save all register read/write logs into a
persistent ram buffer that can be dumped after reboot.

It can be used to determine from where register was read/written before unclocked
access or some kind of bus hang or an unexpected reset caused by some buggy driver
which happens a lot during initial development stages.

In addition to this, we provide dynamic debug support to filter out unwanted logs
and limit trace to only specific files or directories since there can be aweful
lot of register events and we will be interested only in specific drivers or subsystems
which we will be working on. Last few RTB entries will give us the hint for debugging.
With dynamic debug, we are also reducing the overhead of tracing considerably.

Also as a bonus, this tracing can be extended to include IRQ, printk, context switch
and lot other things with proper hooks. It can be very helpful for real case debug scenarios.

Below is a simple example of identifying cause for bus hang in qcom mdp tested on db410c.
This hang was intentionally introduced just to show the usecase of RTB.
The module used can be found here: https://github.com/saiprakash-ranjan/Bus-Hang which does
an unclocked access and will reset db410c and later logs can be viewed through pstore.

Note: I just copied bus_hang.c to drivers/soc/qcom and built it.

1) Set bootargs with dyndbg parameter as below:

   # dyndbg="file drivers/soc/qcom/* +p"

2) Bus hang by reading below debugfs entry with bus_hang module.

   # cat /sys/kernel/debug/hang/bus_hang

3) After restart, we can find the cause in last entry i.e. (bus_hang_mdp+0x98/0xb0)

   # cat /sys/fs/pstore/rtb-ramoops-0
   [LOGK_WRITE] ts:1373101930  data:ffff00000cd065a4  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
   [LOGK_WRITE] ts:1373311878  data:ffff00000cd06608  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
   [LOGK_READ ] ts:18177142294  data:ffff00000ab85040 <ffff00000867cdc8>  bus_hang_mdp+0x98/0xb0

4) Offending register access found as below:

   # (gdb)
   # (gdb) list *(bus_hang_mdp+0x98)
   # 0xffff00000867cdc8 is in bus_hang_mdp (drivers/soc/qcom/bus_hang.c:10).
   # 5       static int bus_hang_mdp(void *data, u64 *val)
   # 6       {
   # 7               void *p = ioremap(0x01a01000, SZ_4K);
   # 8               unsigned int a;
   # 9
   # 10              a = __raw_readl((void *)((unsigned long)p + 0x40));  <----
   # 11
   # 12              *val = a;
   # 13
   # 14              return 0;
   # (gdb)

There will be a lot more real usecases where RTB can be used. Maybe we can test on other boards as well.

This trace module is based on RTB driver in CAF.
Link: https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/kernel/trace/msm_rtb.c

Patchwise one line description is given below:

Patch 1 provides the api called uncached_logk which is then called 
within dynamic_rtb for logging register accesses, i.e. (read/write{b,w,l,q})

Patch 2 adds the pstore support for displaying the logs after reset.

Patch 3 adds dynamic debug support to filter the register read/write{b,w,l,q} access.
Also this patch adds asm-generic/io-instrumented.h file for keeping instrumentation
away from arch code as suggested by Will Deacon.

v2:
 * Addressed Will's comment to keep instrumentation out of arch code and also
   remove duplicate code
 * Addressed Steven's comments regarding code cleanup
 * Fixed commit description to be more specific about register accesses i.e.,
   use read/write{b,l,w,q} instead of readl/writel since we will be tracing all

Sai Prakash Ranjan (3):
  tracing: Add support for logging data to uncached buffer
  pstore: Add register read/write{b,w,l,q} tracing support
  dynamic_debug: Add support for dynamic register trace

 .../bindings/reserved-memory/ramoops.txt      |   7 +-
 arch/arm64/include/asm/io.h                   |  26 ++--
 fs/pstore/Kconfig                             |  12 ++
 fs/pstore/Makefile                            |   1 +
 fs/pstore/inode.c                             |  71 ++++++++-
 fs/pstore/internal.h                          |   8 +
 fs/pstore/platform.c                          |   4 +
 fs/pstore/ram.c                               |  42 ++++-
 fs/pstore/rtb.c                               |  45 ++++++
 include/asm-generic/io-instrumented.h         |  32 ++++
 include/linux/dynamic_debug.h                 |  13 ++
 include/linux/pstore.h                        |   2 +
 include/linux/pstore_ram.h                    |   1 +
 include/linux/rtb.h                           |  31 ++++
 kernel/trace/Kconfig                          |   8 +
 kernel/trace/Makefile                         |   2 +
 kernel/trace/trace_rtb.c                      | 146 ++++++++++++++++++
 17 files changed, 430 insertions(+), 21 deletions(-)
 create mode 100644 fs/pstore/rtb.c
 create mode 100644 include/asm-generic/io-instrumented.h
 create mode 100644 include/linux/rtb.h
 create mode 100644 kernel/trace/trace_rtb.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

