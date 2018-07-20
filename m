Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9681FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3B120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSoQQFqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3B120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbeGTRH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:07:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36965 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731746AbeGTRH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:07:28 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so5410487plc.4;
        Fri, 20 Jul 2018 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qjs1gItmUnv5NKQR8/drVWfzvykoOH93wfPgbZ2pQA=;
        b=YSoQQFqNu1NvLOZHKW9ceWbftM3K/rbqPrcJwiZLC+uehiMkqtrvzN0mLTriPFZ4/E
         EWjnYqQQD60dgVa5Qz9gyXDEfCQVO6nizxoP/Ig2Rs408NduHsG0gWCTvquNaXOxtobE
         JkF/E333cl5VBmZD56sPm+s0MPR3sJsVxpiSk4VIFtiaUOEYG7XVNmBnsq/ljmoiLlMJ
         HjxA1cTureAaMFqqNqdadwKxp9FOJdEyF2T/FjPoK6aLDWdke4JLbF9zwHweiz7z9x58
         TSGfu+gVulcc7VHkJtXOeO9RlVE1hNARYfU9H9HqOYk2txxJef0zn4ogm/T47+Olmepy
         Hw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qjs1gItmUnv5NKQR8/drVWfzvykoOH93wfPgbZ2pQA=;
        b=hhq4EUgvmdQGBKZkBSq2P2KV/YeOLlEkgwb7uGEccR5xHHGboz+h5ZeimBhOBtOM7t
         Pqjq19t3/SBdD14eCS/5YmM5SeZ35JCIxS9174ERZpXpRIp9iLlfvdGG2TMrS9/qwyp0
         FuXicJDhn5C2uV1vuwTFVXRO1YzepeWWL3dzKcle5ZLz08xwrk4MlCSLQ/AMUs+H8FvH
         RRBCsTtoWDNZCjPKfw5tsWLV3sD9amymoJiad8pgC4Qa3AOX6nPnzjllXmWezW6m6lwT
         1rdJpdTCQVbbmAPNfXiwqbHFFILyfzQjuLmWNQbsBO2nTtboCyCoIVz8UOCk8tl90whz
         jUuQ==
X-Gm-Message-State: AOUpUlFCacdc4Pn2irDvAur+rok2RjEyTDxoslrJiKo7ZTCESNiLoDUr
        RpCvXyfXyfEshsemWwDROPl1/m+E
X-Google-Smtp-Source: AAOMgpf6ojx1zf3jVmV8rTXQTze0SokJZXz8J4HRAqVSzojU4gHViHT8MZZu5hxfUFzyn3Ls+4jmdQ==
X-Received: by 2002:a17:902:7b97:: with SMTP id w23-v6mr2765786pll.66.1532103508810;
        Fri, 20 Jul 2018 09:18:28 -0700 (PDT)
Received: from localhost ([223.72.65.191])
        by smtp.gmail.com with ESMTPSA id 13-v6sm3274613pfw.131.2018.07.20.09.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:18:28 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 0/6] KVM: X86: Implement Exit-less IPIs support 
Date:   Sat, 21 Jul 2018 00:18:16 +0800
Message-Id: <1532103502-14855-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using hypercall to send IPIs by one vmexit instead of one by one for
xAPIC/x2APIC physical mode and one vmexit per-cluster for x2APIC cluster 
mode. Intel guest can enter x2apic cluster mode when interrupt remmaping 
is enabled in qemu, however, latest AMD EPYC still just supports xapic 
mode which can get great improvement by Exit-less IPIs. This patchset 
lets a guest which sends multicast IPIs at most can handle 128 vCPUs per 
hypercall on 64-bit machines and 64 vCPUs per hypercall on 32-bit machines.

Hardware: Xeon Skylake 2.5GHz, 2 sockets, 40 cores, 80 threads, the VM 
is 80 vCPUs, IPI microbenchmark(https://lkml.org/lkml/2017/12/19/141):

x2apic cluster mode, vanilla

 Dry-run:                         0,            2392199 ns
 Self-IPI:                  6907514,           15027589 ns
 Normal IPI:              223910476,          251301666 ns
 Broadcast IPI:                   0,         9282161150 ns
 Broadcast lock:                  0,         8812934104 ns

x2apic cluster mode, pv-ipi 

 Dry-run:                         0,            2449341 ns
 Self-IPI:                  6720360,           15028732 ns
 Normal IPI:              228643307,          255708477 ns
 Broadcast IPI:                   0,         7572293590 ns  => 22% performance boost 
 Broadcast lock:                  0,         8316124651 ns

x2apic physical mode, vanilla

 Dry-run:                         0,            3135933 ns
 Self-IPI:                  8572670,           17901757 ns
 Normal IPI:              226444334,          255421709 ns
 Broadcast IPI:                   0,        19845070887 ns
 Broadcast lock:                  0,        19827383656 ns

x2apic physical mode, pv-ipi

 Dry-run:                         0,            2446381 ns
 Self-IPI:                  6788217,           15021056 ns
 Normal IPI:              219454441,          249583458 ns
 Broadcast IPI:                   0,         7806540019 ns  => 154% performance boost 
 Broadcast lock:                  0,         9143618799 ns

v3 -> v4:
 * offset algorithm w/ __uint128_t to scale to higher APIC IDs
 * remove num_possible_cpus limit
 * pass op_64_bit to check bitmap size
 * better describe hypercall layout

v2 -> v3:
 * rename ipi_mask_done to irq_restore_exit, __send_ipi_mask return int 
   instead of bool 
 * fix build errors reported by 0day
 * split patches, nothing change 

v1 -> v2:
 * sparse apic id > 128, or any other errors, fallback to original apic hooks
 * have two bitmask arguments so that one hypercall handles 128 vCPUs 
 * fix KVM_FEATURE_PV_SEND_IPI doc
 * document hypercall
 * fix NMI selftest fails
 * fix build errors reported by 0day

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>


Wanpeng Li (6):
  KVM: X86: Add kvm hypervisor init time platform setup callback
  KVM: X86: Implement PV IPIs in linux guest
  KVM: X86: Fallback to original apic hooks when bad happens
  KVM: X86: Implement PV IPIs send hypercall
  KVM: X86: Add NMI support to PV IPIs
  KVM: X86: Expose PV_SEND_IPI CPUID feature bit to guest

 Documentation/virtual/kvm/cpuid.txt      |   4 ++
 Documentation/virtual/kvm/hypercalls.txt |  17 +++++
 arch/x86/include/uapi/asm/kvm_para.h     |   1 +
 arch/x86/kernel/kvm.c                    | 111 +++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c                     |   3 +-
 arch/x86/kvm/x86.c                       |  44 ++++++++++++
 include/uapi/linux/kvm_para.h            |   1 +
 7 files changed, 180 insertions(+), 1 deletion(-)

-- 
2.7.4

