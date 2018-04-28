Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1815275-1524913971-2-4874725942040727299
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524913971; b=HsLklHWUpX6Bkzbuy/Np/4BewWoqOkYM2jUgC7czvD+XL0zPtp
    2PP/ctH/Tc3xv1QNs/NS90DChvOXD5+9aKYvkvfZLtdnUwEuSbQRJGaHu3ypN6bZ
    MKiOKWA7n7/cnSxGOobwqmhB2dx9aOJpvO3dycgw0jzsaA4iI/TvAZrlVQEbi8Bl
    YXRJaKBH/t4nVAPsZbiyty4zd0Y2DN2b6xUE/+Ww2HnDYThhKgO5kpkuvWKyWLkz
    faOq69acp6BjFaUbNdh0i2+QWe9EdnTLcNsdVnF2TW+71v1k52KsV7FCWkEE5kOc
    dOtsvCaiWD+osJxCuMTf/APlA3Q6x3TuJhgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=in-reply-to:to:from:cc:subject:message-id
    :date:sender:list-id; s=fm2; t=1524913971; bh=Z0BlSIWHREF5oMAYZQ
    zEsWig6cFadEFiVR100lXQBe8=; b=KGUARRWaS0GJucVQPZCaXsIei4KwH7w9TE
    Ex2PmIKOo3jpM/oplbPfcdY2MebB3Sy55VGF0fSQLjOeHuqIZ75dVVN8Df4Si491
    WCwtY1kjrmo+q+9KFXOyQIi5SQuLNe+A/wG+oCXEXwnzVDXNTpgP9+2G/DlxPEIf
    d4dN3QWLZ91kiVc5w0Npkh7RuhrUoUGllTa5NgqEgAH/XcbhxAHkntnQ6RcBQxDE
    j3cV76PcipFKK4uNIwZ9rwmsScGmxEB0RdKZEuvmvygxnWGfqgpsKSlKnt1PGt0O
    zQG5Y0cNS8dFRJ0GTXZaYGwqe0608l/sDYBbiCzzjWgMVhs4YvDw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ellerman.id.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ellerman.id.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKiqVDdX0wxtKbtL/YaZwdpCVjSnOTZaQ4iiimUv+TEoSnechlRPo8U9cPouyGPnq9lP5lfjJcK99/tLr005N3n2OVXpvwXQItLsV33t4anLulI3c5F7
    ddwt+bK3B+uZJwIMixZEfnoAufvJadPh6Er/n0hz6xDRe/cGthj8qrCI2/gRr4XZytGzHh+V/1TzB8zC+QuGwXYD1quM6jjHiCjwCEd3B4diWLyUgUZkxwoE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=jzwyn7j8SzP9a3Bmv5kA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759828AbeD1LMr (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 07:12:47 -0400
Received: from ozlabs.org ([203.11.71.1]:46557 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759789AbeD1LMq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 07:12:46 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c0f7f5b6c69107ca92909512533e70258ee19188
In-Reply-To: <1524653971-4919-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-pm@vger.kernel.org, ppaidipe@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        stable@vger.kernel.org,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [V3] cpufreq: powernv: Fix the hardlockup by synchronus smp_call in timer interrupt
Message-Id: <40Y7SX0BHHz9s0x@ozlabs.org>
Date: Sat, 28 Apr 2018 21:12:43 +1000 (AEST)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-25 at 10:59:31 UTC, Shilpasri G Bhat wrote:
> gpstate_timer_handler() uses synchronous smp_call to set the pstate
> on the requested core. This causes the below hard lockup:
> 
> [c000003fe566b320] [c0000000001d5340] smp_call_function_single+0x110/0x180 (unreliable)
> [c000003fe566b390] [c0000000001d55e0] smp_call_function_any+0x180/0x250
> [c000003fe566b3f0] [c000000000acd3e8] gpstate_timer_handler+0x1e8/0x580
> [c000003fe566b4a0] [c0000000001b46b0] call_timer_fn+0x50/0x1c0
> [c000003fe566b520] [c0000000001b4958] expire_timers+0x138/0x1f0
> [c000003fe566b590] [c0000000001b4bf8] run_timer_softirq+0x1e8/0x270
> [c000003fe566b630] [c000000000d0d6c8] __do_softirq+0x158/0x3e4
> [c000003fe566b710] [c000000000114be8] irq_exit+0xe8/0x120
> [c000003fe566b730] [c000000000024d0c] timer_interrupt+0x9c/0xe0
> [c000003fe566b760] [c000000000009014] decrementer_common+0x114/0x120
> -- interrupt: 901 at doorbell_global_ipi+0x34/0x50
> LR = arch_send_call_function_ipi_mask+0x120/0x130
> [c000003fe566ba50] [c00000000004876c]
> arch_send_call_function_ipi_mask+0x4c/0x130
> [c000003fe566ba90] [c0000000001d59f0] smp_call_function_many+0x340/0x450
> [c000003fe566bb00] [c000000000075f18] pmdp_invalidate+0x98/0xe0
> [c000003fe566bb30] [c0000000003a1120] change_huge_pmd+0xe0/0x270
> [c000003fe566bba0] [c000000000349278] change_protection_range+0xb88/0xe40
> [c000003fe566bcf0] [c0000000003496c0] mprotect_fixup+0x140/0x340
> [c000003fe566bdb0] [c000000000349a74] SyS_mprotect+0x1b4/0x350
> [c000003fe566be30] [c00000000000b184] system_call+0x58/0x6c
> 
> One way to avoid this is removing the smp-call. We can ensure that the timer
> always runs on one of the policy-cpus. If the timer gets migrated to a
> cpu outside the policy then re-queue it back on the policy->cpus. This way
> we can get rid of the smp-call which was being used to set the pstate
> on the policy->cpus.
> 
> Fixes: 7bc54b652f13 (timers, cpufreq/powernv: Initialize the gpstate timer as pinned)
> Cc: <stable@vger.kernel.org>        [4.8+]
> Reported-by: Nicholas Piggin <npiggin@gmail.com>
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c0f7f5b6c69107ca92909512533e70

cheers
