Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A091C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5147124B6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PATa90JO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5147124B6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933171AbeGCGVh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:21:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35155 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932767AbeGCGVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:21:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so507679plt.2;
        Mon, 02 Jul 2018 23:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TTT6cWCe6OemaOp7SleMpq6DZlbLsZ1iRqZjGO3Vms=;
        b=PATa90JOnToVagqBX+zYE3hAZm/DKh6+pBhPmRfa5s5g5dgTarwpSj5j1S8vr16IFD
         DSGC22yK7AMAyJSfEO4aVhqEv8VCOkoduE0ndBe2LDXwRCJghVhAf+ZK/6jv37FLzPxG
         g0icY1cRkp4FXh4o92wvHUJIMHUD4L19QvhcL/2h14ktQhzhgF2QOWDbm0DjzaBkTOC4
         gbcnr6dLorb63k3fI/fZmxlE6EsRH4VEHBgY1U0VAM2q6RgQjkNoeH78xiXOrya1E5sA
         yZsmKjPUklkd1Qmo8u5NSisvTOg4D1chk+eX/U26M9w9ETMkRvO6oAaIBJjf3G8kZSwm
         j/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TTT6cWCe6OemaOp7SleMpq6DZlbLsZ1iRqZjGO3Vms=;
        b=ev3CDi2jHf+UqrINdwSFt9Djdj8rBoF+2H/vVmPMNfIVlMHK0raBtchQUw1pfoQYai
         EnCHdYDvfN4J6izdNgqqLxDsgvL/LVgOPrBH765eqCaAASyMcUxMlE+8Kf4v5a9gqgg2
         qTqGT2bx/QyCh6paSXXcKAY8FHe35Nc7b8C9It0WBC5njwTnR2JrKShU0f2YD186ZvXb
         3PHUCJ0KFeSIEJzUMlo2AiBflGlmMT1i+dDqK+rYdZfp61/7CDxdpNiHjl7KqNdxeD9h
         M2G4y9mNLrf13zNOBgxao4ERXWI5hfYhkCt8yc/lnq7waBUBS3dIFaLleCI2r1UdOjFC
         6bKA==
X-Gm-Message-State: APt69E2q1aK3me/Tj1Pti0Eo8goMtZXsZronJpH9SCzxMBkP+Qp4ORcV
        CaiGwLKLRBqBhfLWv5miFB5eQg==
X-Google-Smtp-Source: AAOMgpdi6OhWJJC6AOD2UXnYKSbXMIDFkOneacr9EwyMX0IKu13BUBxr9BXSS+IWUVxSA2MoGfPf8Q==
X-Received: by 2002:a17:902:b582:: with SMTP id a2-v6mr8482602pls.335.1530598895396;
        Mon, 02 Jul 2018 23:21:35 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id v89-v6sm1766427pfd.64.2018.07.02.23.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 23:21:34 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 0/6] KVM: X86: Implement PV IPIs support 
Date:   Tue,  3 Jul 2018 14:21:25 +0800
Message-Id: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
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
mode which can get great improvement by PV IPIs. This patchset supports 
PV IPIs for maximal 128 vCPUs VM, it is big enough for cloud environment 
currently, supporting more vCPUs needs to introduce more complex logic, 
in the future this might be extended if needed.

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
 Documentation/virtual/kvm/hypercalls.txt |   6 ++
 arch/x86/include/uapi/asm/kvm_para.h     |   1 +
 arch/x86/kernel/kvm.c                    | 101 +++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c                     |   3 +-
 arch/x86/kvm/x86.c                       |  42 +++++++++++++
 include/uapi/linux/kvm_para.h            |   1 +
 7 files changed, 157 insertions(+), 1 deletion(-)

-- 
2.7.4

