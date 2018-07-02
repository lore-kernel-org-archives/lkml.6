Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0965C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E473242C9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+y5M+tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E473242C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965332AbeGBKOd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:14:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36727 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965036AbeGBKO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:14:28 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so7726523plp.3;
        Mon, 02 Jul 2018 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Rtpfg+se8dIxiMFgzatUyoy5RnqZSOwCyV08qQSNvI=;
        b=d+y5M+tcbwkam3bgq2dgfrrIz8TGDllBnRkA06danLLKLnINimCycBdA+uB0uzuoIq
         1sW0R1FnNEpJWrejSWcJKdfjhg69+7XhoA80/lkGRsLSOSq2Xt+jlcWpwGJVO++8Rlz4
         IzWoucIUkiDPyfx6fpqW8h0EoLgx/pMWbgR7GCR7KhHCiAm0LMDSkgWj5AMeQL92/gzg
         8m1m71t8fSAySBp09jLba1J0yR1XxonpgJylyOrd6lJkIACyy/Z53wQitAKhQUb31Jqk
         WA8BPRQkDNLA+qHzm2eGp2uGFl1PLzfEGnlGiNJZb8b9e1UySw9WrAmC5ZY91rpYLLU5
         NQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Rtpfg+se8dIxiMFgzatUyoy5RnqZSOwCyV08qQSNvI=;
        b=E4mC9BJJ4C5CncsP1v9ff2nC7aRPAfswiDldVxSJ2ys9rx9Vsc+QM3EI20wRL3t3uM
         jRrCX/QdIf05TRz40RKVtPtT6dWkxsja+3l8Wfx4Q2hTuktxZlZUjKcdqi75YtxtNV1J
         /7+ZzcwUP46OyymyaC/ZghOnXXcw2X91It5KZoC+krvK1doFYm+kktr3z4LWvdPPSfa9
         bEv7I+jVPrfDuWNB31sPCTHaC0+VM/PqEyRVNEhyUO0JA6JC4IYZwVmtrWjiV+BeLP/H
         tHX4j98QyxFncFFoJU2VS1ovGvEJ6yI1UXs8qL4IhP5EDlN6S1BbW/JH80fFdEIjYSfC
         bT7Q==
X-Gm-Message-State: APt69E15SXfL0BefG7bFQbJrsiD9+ZwBKLoDs45bPrjFqwcevu/qAvxO
        9wjJE0061Se2pZelMHz6r8+LjQ==
X-Google-Smtp-Source: ADUXVKJXvFnJT9HcCPD3e/GnH3OWAZPavizDZNn6827loip67UhcH+6AXFhoe+/QQVFy7gOC5kjeiQ==
X-Received: by 2002:a17:902:8f94:: with SMTP id z20-v6mr24928541plo.337.1530526467730;
        Mon, 02 Jul 2018 03:14:27 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id n68-v6sm29685665pfg.98.2018.07.02.03.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 03:14:27 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2 0/2] KVM: x86: Add PV IPIs support
Date:   Mon,  2 Jul 2018 18:14:20 +0800
Message-Id: <1530526462-920-1-git-send-email-wanpengli@tencent.com>
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
mode. 

Even if enable qemu interrupt remapping and PV TLB Shootdown, I can still 
observe ~14% performance boost by ebizzy benchmark for 64 vCPUs VM, the 
total msr-induced vmexits reduce ~70%.

The patchset implements the PV IPIs for vCPUs <= 128 VM, this is really 
common in cloud environment, after this patchset is applied, I can continue 
to add > 64 vCPUs VM support and that implementation has to introduce more 
complex logic.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>

v1 -> v2:
 * sparse apic id > 128, or any other errors, fallback to original apic hooks
 * have two bitmask arguments so that one hypercall handles 128 vCPUs 
 * fix KVM_FEATURE_PV_SEND_IPI doc
 * document hypercall
 * fix NMI selftest fails
 * fix build errors reported by 0day

Wanpeng Li (2):
  KVM: X86: Implement PV IPI in linux guest
  KVM: X86: Implement PV send IPI support

 Documentation/virtual/kvm/cpuid.txt      |  4 ++
 Documentation/virtual/kvm/hypercalls.txt |  6 ++
 arch/x86/include/uapi/asm/kvm_para.h     |  1 +
 arch/x86/kernel/kvm.c                    | 99 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c                     |  3 +-
 arch/x86/kvm/x86.c                       | 42 ++++++++++++++
 include/uapi/linux/kvm_para.h            |  1 +
 7 files changed, 155 insertions(+), 1 deletion(-)

-- 
2.7.4

