Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62216C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE8320700
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nMq1Ecnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfBWBHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:07:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54672 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBWBHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Pwu1GUqcGeOiii3EiHyOsEXk+VMsI8R65pbhSTX5E9o=; b=nMq1EcnjIy5PLL/BbkRdivoTsu
        faMZUzD+82XHF1wWZIc7STMKJxQ9sjSgE6GRPsQzvQC2G5VuYXdjJtwNq13ngZ2U8EpG+8KTaU0EJ
        PrkkU9kNYID+7QHFSPesAbs0PRWNKAPRk6hAijDR5qD1iA6AJQNa16oIn9Y+yS9R8WKhrRA9ea7F8
        yV79RTXTigFsVqc/mQPMfXVM2nq1Dj41+sZ+mpYDPdXcNIdmrO7Y8Gtqgqp/tFNYARLin4Q4i1geQ
        2993v0Fh3Wdhl4eZ+iHA88GOKJgo1C4JYChCGrM0UIzP2EtMhxxHci5YGNJfjxpC/HUz3LUbNXguC
        GQbUmOLg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxLmi-0000Vq-DL; Sat, 23 Feb 2019 01:07:20 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: UBSAN: Undefined behaviour in
 ../drivers/cpuidle/governors/menu.c:229:21
Message-ID: <01740a74-f663-9287-50c8-57d6e8f2bbba@infradead.org>
Date:   Fri, 22 Feb 2019 17:07:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is 5.0-rc7 on an old Toshiba Portege laptop.


================================================================================
[   51.898454] UBSAN: Undefined behaviour in ../drivers/cpuidle/governors/menu.c:229:21
[   51.898467] signed integer overflow:
[   51.898478] 3758096350 * 3758096350 cannot be represented in type 'long long int'
[   51.898496] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B   W         5.0.0-rc7mod #3
[   51.898507] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[   51.898519] Call Trace:
[   51.898533]  dump_stack+0x7b/0xb5
[   51.898544]  ubsan_epilogue+0xd/0x81
[   51.898553]  handle_overflow+0x198/0x1d7
[   51.898564]  ? __ubsan_handle_negate_overflow+0x195/0x195
[   51.898575]  ? tick_nohz_get_sleep_length+0x121/0x1d0
[   51.898588]  ? ipv6_icmp_error+0x755/0x7f0
[   51.898597]  ? tick_nohz_next_event+0x1b3/0x4a0
[   51.898607]  ? can_stop_idle_tick+0x260/0x260
[   51.898617]  ? __switch_to_asm+0x40/0x70
[   51.898628]  ? calibrate_delay+0x25/0x2341
[   51.898637]  ? __switch_to_asm+0x34/0x70
[   51.898646]  ? common_interrupt+0xa/0xf
[   51.898658]  __ubsan_handle_mul_overflow+0xe/0x1c
[   51.898669]  menu_select+0x13d0/0x1df0
[   51.898682]  ? menu_enable_device+0x170/0x170
[   51.898691]  ? sched_clock+0x9/0x10
[   51.898701]  ? kasan_check_write+0x14/0x20
[   51.898711]  ? rcu_dynticks_eqs_exit+0x2c/0x80
[   51.898722]  cpuidle_select+0x5a/0xa0
[   51.898732]  do_idle+0x2aa/0x3c0
[   51.898742]  ? arch_cpu_idle_exit+0x40/0x40
[   51.898751]  ? kasan_check_read+0x11/0x20
[   51.898761]  ? do_raw_spin_unlock+0x54/0x220
[   51.898773]  cpu_startup_entry+0x18/0x20
[   51.898782]  rest_init+0x165/0x1a0
[   51.898793]  arch_call_rest_init+0x9/0x11
[   51.898803]  start_kernel+0x697/0x6bd
[   51.898813]  ? mem_encrypt_init+0x6/0x6
[   51.898822]  ? load_ucode_intel_bsp+0x53/0x8a
[   51.898832]  ? init_intel_microcode+0x1a4/0x1a4
[   51.898844]  ? load_ucode_bsp+0x1e8/0x21c
[   51.898854]  x86_64_start_reservations+0x24/0x26
[   51.898865]  x86_64_start_kernel+0x74/0x77
[   51.898874]  secondary_startup_64+0xa4/0xb0
[   51.898887] ================================================================================


-- 
~Randy
