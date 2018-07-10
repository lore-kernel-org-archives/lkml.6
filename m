Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49131C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F19208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F19208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbeGJSSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:18:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51618 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732354AbeGJSSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:18:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60DDE1BB0;
        Tue, 10 Jul 2018 11:01:29 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D42D63F589;
        Tue, 10 Jul 2018 11:01:27 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, christoffer.dall@arm.com,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        mark.rutland@arm.com, will.deacon@arm.com
Subject: [PATCH 0/2] arm64: spectre-v1 write fixes (CVE-2018-3693)
Date:   Tue, 10 Jul 2018 19:01:21 +0100
Message-Id: <20180710180123.56461-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches inhibit spectre-v1-write gadgets found in arch/arm64, using the
same mitigation applied to existing spectre-v1-read gadgets.

This issue is also known as CVE-2018-3693, or "bounds check bypass store".
More details can be found in the Arm Cache Speculation Side-channels
whitepaper, available from the Arm security updates site [1].

Thanks,
Mark.

[1] https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability

Mark Rutland (2):
  arm64: fix possible spectre-v1 write in ptrace_hbp_set_event()
  KVM: arm/arm64: vgic: fix possible spectre-v1 write in
    vgic_mmio_write_apr()

 arch/arm64/kernel/ptrace.c       | 19 +++++++++++--------
 virt/kvm/arm/vgic/vgic-mmio-v2.c |  3 +++
 2 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.11.0

