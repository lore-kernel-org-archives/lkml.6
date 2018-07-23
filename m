Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED9AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D2920858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtH9Ut25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D2920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbeGWHjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:39:41 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38151 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387838AbeGWHjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:39:41 -0400
Received: by mail-pl0-f67.google.com with SMTP id b1-v6so7832049pls.5;
        Sun, 22 Jul 2018 23:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Xdq+AVRyyZjGcUSZmKd58RZht+1qMiLLEbORSfvOXo=;
        b=TtH9Ut25PxBRCS/MjoJ5F/ZwmoN4etxKArBqupH0CgDUP8jod9lMe+/QeqiwIyd8Ta
         KMwaHU+YAOXWCzeX0B5Qruj/DL/tUoTdZviQBozxTauLKFEz/vhC9HRK5cshh54zTq1Y
         iad/4fXOC/oNYUPMgdunmZlYNVfOC88khExcfDGDuYOYqtx7/FVF2BSHQSgt+Td7lmjS
         QJ2Y7Kj15TwPAxegF96wXiEnvqlzZ+yXcsm2qlcGviKBZLMW94SiVhacyE140zy8mHPK
         Ho0PtIaY3x4P6epkLD/x1qSNEcXfn/kYUYq0uXxjIwlFH219LunwcTepjkJ5+WLfumxm
         bZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Xdq+AVRyyZjGcUSZmKd58RZht+1qMiLLEbORSfvOXo=;
        b=l8crHnPp3vpnHZityXOdtaymzjKiHJIM8vCnT2jZDMEw9NGhexP3QBS0jn7LLPJBi3
         0vYHZWaEOrjJjCovAA/QfQbF9S863yd5rzjpcMVcJiLmUPeAAadHIyrmMXGv3hNWJXEq
         7NBfl1wB4UoVPAOqRRzDrdh6Mu6LudIULFtmFhDo/lbXV7++2PYPp8TtsbWJjveSyXB5
         8Pqmk/JWPem2MZorOdcbWDip+d3SiOmvaDonT/divXNDdYqmh0hx1q03H+OsWmPtiVN7
         n1z23B561o2bnpgEnnfCs2P5Ga2jRezDPgd5xAIiVHvUZlAfVmSAOAkTLVVO1sGYCN67
         DS0w==
X-Gm-Message-State: AOUpUlHr0fkwG0F5RpAVZu7JV0/S60CHeL7cF86aHVUlIs8D9TeIMv+F
        BpEsOpKLvwBe/Oiz28ttqtHcQqy4
X-Google-Smtp-Source: AAOMgpfzTAhHzLSbjKEhCzxUooAMO94VUXzWBltqrDbYBTKYfNXeiHJA5F5OlKMU+JNuq7cYTDkn3w==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr11907791plo.100.1532328001440;
        Sun, 22 Jul 2018 23:40:01 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm8165598pgv.26.2018.07.22.23.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:40:00 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 0/6] KVM: X86: Implement Exit-less IPIs support
Date:   Mon, 23 Jul 2018 14:39:50 +0800
Message-Id: <1532327996-17619-1-git-send-email-wanpengli@tencent.com>
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
lets a guest send multicast IPIs, with at most 128 destinations per 
hypercall in 64-bit mode and 64 vCPUs per hypercall in 32-bit mode.

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

v4 -> v5:
 * update hypercall layout description
 * fix PV IPIs send hypercall loops

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
 Documentation/virtual/kvm/hypercalls.txt |  20 ++++++
 arch/x86/include/uapi/asm/kvm_para.h     |   1 +
 arch/x86/kernel/kvm.c                    | 111 +++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c                     |   3 +-
 arch/x86/kvm/x86.c                       |  43 ++++++++++++
 include/uapi/linux/kvm_para.h            |   1 +
 7 files changed, 182 insertions(+), 1 deletion(-)

-- 
2.7.4

