Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6BAECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F892086A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtKwS+cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F892086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeGWBqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 21:46:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45386 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbeGWBqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 21:46:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so10950669pgq.12;
        Sun, 22 Jul 2018 17:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qjs1gItmUnv5NKQR8/drVWfzvykoOH93wfPgbZ2pQA=;
        b=FtKwS+cby8er8NQ0As0lxn0qJbNKpgNWmSE287FwBSxlKKyupMdtu6tlNRE89YRsDb
         Jnc5AozZckFPuD/r7lQ6hsgVr3J/PDsw2nc88vxoklyC/TvwkaCyLqPR6sY+H3to+ydL
         OBu6f21DbhPxFVHJzxDqcUFI2GPouLPmfKnDinLIlTaWy8yTW4G1KppjQ+NMLrCHdppV
         o3l1UybAwy80/FUVA1Etb09lh1IOmooLc1EM7d8odoI8HBCXnz0E6bty2o9oTmQND3O5
         qUPulZSKlgLLheQiozYS4XhrkwK57pVRnUGGP/mg7mxO4nAKDXXwK14HYdsnJsprYgUG
         WU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qjs1gItmUnv5NKQR8/drVWfzvykoOH93wfPgbZ2pQA=;
        b=okeXNZbTZONNIrNZuSCPab0emxtZNdZgth80c1g8J/lK+vRzPcFbS7FN3YG+T8DYWk
         NxDXwDAyGT1y+vyojhJNQb9OTD/bSrtoIFkMDjqkye0pox1XTJPT+q9a9g4hFL9ZiX3c
         Bhf4ka1o6SKv1XdOVS2wuSeJ7ZIRGPHQZv71COshmDESY/PPuG1ZsPAKdlHctU8ICH5O
         2qzIg4++8A1VxmpMRe1Wd0xgl6GbQE2lB0KGv86Mh6mekOoWGVETjpb2UB9pzu+OCb4D
         crzwwNmRy+EI90MeOZ64KhWnnVjNBuGmWuuaJWsEtpBVWRDPlr8iamURIRRM/abFus97
         kdWg==
X-Gm-Message-State: AOUpUlGd9LHvEWtEUOa7ya9Zfnxnzxo5geYKAEFJUUk1yQH+kzDMTJAl
        PCINcUD/Lkll4GpXZcqFJlOPSN5P
X-Google-Smtp-Source: AAOMgpeftZVTg66xcXLu1nM7MozeXRRfbYdmrUF7cYPaSWg/OpZ6h3ts65sCWIZhHbkaka/mJrD+YA==
X-Received: by 2002:a62:3c4f:: with SMTP id j76-v6mr11117164pfa.119.1532306863969;
        Sun, 22 Jul 2018 17:47:43 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id e82-v6sm11646069pfk.87.2018.07.22.17.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 17:47:43 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 RESEND 0/6] KVM: X86: Implement Exit-less IPIs support 
Date:   Mon, 23 Jul 2018 08:47:33 +0800
Message-Id: <1532306859-31166-1-git-send-email-wanpengli@tencent.com>
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

