Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1876232-1524719666-2-10752294584050529292
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524719665; b=UFkqWqi5JmyMJTrhqJFKCaORjwv8x8DWnzNPDfvMp6PpxC7DX6
    qoV5VcobB68LU/EkgqOfg/kbUpdyUthFkDtdbZCmJGDageHqU6MKDeVgMDcPtSX5
    4PxuHrjfAvLWxYQTdSyGjHXdBkRWA9XxeIrsFitjC8psQv6QJ4lbXNPfPzVJoAWj
    Z7LplZbZmsorFEN431RgLQnTYTU1mh6k2b4zO/EJ3vAYnIIs+TeXCfuxOPsqhGUU
    PJAHCg/5OgTqHRGibQOgM4c5ZZ1mm4U+u9jfD8ph7qszAFFl5CXnEeAhjF54ZxtF
    fEgQVyFGL830pBl70gketrxzSPIOvvLmia8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524719665; bh=sVFYgs5eQiDrYrhrvK3gQDhrsg1nJt
    g9tY2zY8JIZus=; b=nO7KppB/yVQkKZTJZa1prv+hUTiid+rxOoYL8Uac2T5ASW
    /jD5ZjGJLEIPJ5c+SXjaU0DcScnjo08Da9CMAHNUZ0G7/J1Bdsnrg+0BOVbzXQbU
    21/Ofq5lsxxxhX+QHPs+eUCO/fhanZQWQ9ScaStneRIqDbHOpzlCDTxU1Be0n6ro
    opxpwmQN0q2qqvUFqm/GIP0S76Prs233T50XBN8NKKjgw40ZMZaNjKtNLpMIpbiO
    mK9YuWPLrowhRzB4XwhboSWjJeKCWFzyGos9MpgHqEdUqLQLbFOZR10RPk1bbFSj
    N44WRHNU3WxiC+no8RKbH3/B/+Y5rD7T/6xMr24g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kvduoo03 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BaWnGRQQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kvduoo03 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BaWnGRQQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGNrD8rmORIPmSW2Xd4Ck0C0XfBuOui9epQ9T2wLVBhPYnax/mn6gFpmM4ABW1Ng82d9mpRhmlKDFLdRh2hs61jPDpjg+IKVRbkw/AsYgi9HEFp1mF3D
    p/cTVS5xksKGx4IfL+IAnj87w/leoxXt7S6wJuUGqVZsNSnCbPnRk/8jZXJBn/vfB4bhCjRWIf/QhcCV13JnOWdlq/XRRGf3jtTB9XMUlE7VIgyH0xKOdJYb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
    a=jzwyn7j8SzP9a3Bmv5kA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeDZFOY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 01:14:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34668 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeDZFOW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 01:14:22 -0400
X-Google-Smtp-Source: AB8JxZof/VvVnXaiA7coQbg/hQMlb9nrHLEIk1Qzab39k8pojaLvt3VQhaZu+2CuHd3Rih3epFFf8A==
Date: Thu, 26 Apr 2018 10:44:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, npiggin@gmail.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ppaidipe@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH V3] cpufreq: powernv: Fix the hardlockup by synchronus
 smp_call in timer interrupt
Message-ID: <20180426051418.vpwugncvivub43ej@vireshk-i7>
References: <1524653971-4919-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524653971-4919-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 25-04-18, 16:29, Shilpasri G Bhat wrote:
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
> ---
> Changes from V2:
> - Remove the check for active policy while requeing the migrated timer
> Changes from V1:
> - Remove smp_call in the pstate handler.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
