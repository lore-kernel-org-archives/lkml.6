Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA5EC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7002077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LJq4QKQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7002077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJOBvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:51:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51336 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeJOBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cwH9X4WoCQWp/CqYXVhESxdBKMV3Ligvf5H34JLJcK8=; b=LJq4QKQ2XjNb0q18jkL3oOOVyw
        jCBNSAAf8ZKQR0II8NexYQLwj3RsBm/Jrn+tuFLmZDBqRsFJX5F2Aeq0v1dBV6eDX1YSqC3hfekWL
        2djgNx6MIXB+yvSwBlus5Nqu4LGnL1MsaSLfrUP+RHX5buZvo9m2OsWr4kBfzIWYUGWP45LElKkKm
        /xwy7nsRJzQKJS8IOAdmf5DAWID1lGuykqQpYqXXtWa3ehlavz+Wk3Rb1k+BoCvxZ3lFiDkIHrYU7
        SYdu2BMT4v54dcDaB/saumpqig7dqR97jT05jJAZWzq8IYuHJ1Q91nGBrNPaEtdL4+7xyCBI72cVS
        IftohWqw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBkpQ-0002ko-Pp; Sun, 14 Oct 2018 18:09:26 +0000
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Krzysztof Halasa <khc@pm.waw.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: net/wan: hostess_sv11 + z85230 problems
Message-ID: <1468d110-4f92-da7a-21b5-36afcec3c94e@infradead.org>
Date:   Sun, 14 Oct 2018 11:09:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 4.19-rc7, on i386, with NO wan/hdlc/hostess/z85230 hardware:

modprobe hostess_sv11 + autoload of z85230 give:


[ 3162.494393] calling  hdlc_module_init+0x0/0x1000 [hdlc] @ 4024
[ 3162.495528] hdlc: HDLC support module revision 1.22
[ 3162.496877] initcall hdlc_module_init+0x0/0x1000 [hdlc] returned 0 after 1312 usecs
[ 3162.500840] calling  z85230_init_driver+0x0/0x1000 [z85230] @ 4024
[ 3162.502877] Generic Z85C30/Z85230 interface driver v0.02
[ 3162.503895] initcall z85230_init_driver+0x0/0x1000 [z85230] returned 0 after 987 usecs
[ 3162.506869] calling  init_module+0x0/0x270 [hostess_sv11] @ 4024
[ 3162.508065] INFO: trying to register non-static key.
[ 3162.508986] the code is fine but needs lockdep annotation.
[ 3162.509026] turning off the locking correctness validator.
[ 3162.509026] CPU: 1 PID: 4024 Comm: modprobe Not tainted 4.19.0-rc7 #2
[ 3162.511877] Hardware name: Dell Inc. Inspiron 1318                   /0C236D, BIOS A04 01/15/2009
[ 3162.511877] Call Trace:
[ 3162.511877]  <IRQ>
[ 3162.511877]  dump_stack+0x58/0x7d
[ 3162.511877]  register_lock_class+0x4a3/0x4b0
[ 3162.511877]  ? native_sched_clock+0x2f/0x110
[ 3162.511877]  __lock_acquire.isra.26+0x46/0x770
[ 3162.511877]  ? sched_clock+0x8/0x10
[ 3162.511877]  lock_acquire+0x5c/0x80
[ 3162.511877]  ? z8530_interrupt+0x35/0x180 [z85230]
[ 3162.511877]  _raw_spin_lock+0x28/0x70
[ 3162.511877]  ? z8530_interrupt+0x35/0x180 [z85230]
[ 3162.511877]  z8530_interrupt+0x35/0x180 [z85230]
[ 3162.511877]  __handle_irq_event_percpu+0x35/0xe0
[ 3162.511877]  handle_irq_event_percpu+0x26/0x70
[ 3162.511877]  handle_irq_event+0x29/0x42
[ 3162.511877]  handle_fasteoi_irq+0x9b/0x170
[ 3162.511877]  ? handle_simple_irq+0x90/0x90
[ 3162.511877]  handle_irq+0xc3/0xee
[ 3162.511877]  </IRQ>
[ 3162.511877]  do_IRQ+0x51/0xe0
[ 3162.511877]  common_interrupt+0xe7/0xec
[ 3162.511877] EIP: _raw_spin_unlock_irqrestore+0x24/0x50
[ 3162.511877] Code: 5b 5d c3 8d 76 00 55 89 e5 56 89 c6 83 c0 10 53 8b 4d 04 89 d3 ba 01 00 00 00 e8 17 14 9a ff 89 f0 e8 e0 4d 9a ff 89 d8 50 9d <66> 66 66 90 b8 01 00 00 00 e8 ee 89 97 ff 64 a1 ec 07 74 c7 85 c0
[ 3162.511877] EAX: 00000246 EBX: 00000246 ECX: 00000002 EDX: 00000058
[ 3162.511877] ESI: f400d8e4 EDI: 00000000 EBP: efbf9d74 ESP: efbf9d6c
[ 3162.511877] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000246
[ 3162.511877]  __setup_irq+0x2f0/0x620
[ 3162.511877]  request_threaded_irq+0xcd/0x170
[ 3162.511877]  init_module+0xb0/0x270 [hostess_sv11]
[ 3162.511877]  ? hostess_queue_xmit+0x20/0x20 [hostess_sv11]
[ 3162.511877]  do_one_initcall+0x3e/0x15a
[ 3162.511877]  ? __slab_alloc.isra.71.constprop.76+0x3a/0x50
[ 3162.511877]  ? do_init_module+0x17/0x1d0
[ 3162.511877]  ? kmem_cache_alloc+0x13f/0x190
[ 3162.511877]  ? do_init_module+0x17/0x1d0
[ 3162.511877]  do_init_module+0x46/0x1d0
[ 3162.511877]  load_module+0x131f/0x14f0
[ 3162.511877]  sys_finit_module+0x81/0xd0
[ 3162.511877]  do_fast_syscall_32+0x89/0x1f0
[ 3162.511877]  entry_SYSENTER_32+0x6b/0xbe
[ 3162.511877] EIP: 0xb7facd11
[ 3162.511877] Code: f6 ff ff 55 89 e5 8b 55 08 8b 80 5c cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 1c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[ 3162.511877] EAX: ffffffda EBX: 00000005 ECX: 0048834e EDX: 00000000
[ 3162.511877] ESI: 004a5870 EDI: 004a3470 EBP: 00000000 ESP: bfb9c32c
[ 3162.511877] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
[ 3162.883280] systemd-journald[1693]: Sent WATCHDOG=1 notification.
[ 3162.511877] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3163.549994] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3164.034994] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3164.522999] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3165.007005] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3165.494999] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3165.978998] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3166.466999] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3166.951999] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3167.440000] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3167.924000] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3168.408002] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3168.895999] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3169.380000] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3169.868001] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3170.351999] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3170.836001] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3171.324988] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3171.810991] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3172.296991] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3172.781991] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3173.268002] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3173.753994] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3174.240002] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3174.725990] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3175.211999] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3175.697002] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3176.183999] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3176.668989] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3177.153986] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3177.640002] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3178.125993] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3178.612002] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3179.097993] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3179.584002] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3180.069994] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3180.556001] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3181.041986] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3181.528001] z85230: (null): interrupt jammed - abort(0xFF)!
[ 3182.013986] z85230: (null): interrupt jammed - abort(0xFF)!



then manual poweroff.

-- 
~Randy
