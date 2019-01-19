Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6474CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F252177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfA2HG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:06:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:44929 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfA2HG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:06:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 23:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,536,1539673200"; 
   d="scan'208";a="129738090"
Received: from vmm.bj.intel.com ([10.240.192.123])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2019 23:06:24 -0800
From:   Luwei Kang <luwei.kang@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, songliubraving@fb.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, zsm@chromium.org,
        alexander.shishkin@linux.intel.com, konrad.wilk@oracle.com,
        ak@linux.intel.com, Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH 0/3] Inject a PMI for KVM Guest when ToPA buffer is filled
Date:   Sat, 19 Jan 2019 15:04:41 -0500
Message-Id: <1547928284-2915-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each intel processor trace table of physical addresses (ToPA) entry
has an INT bit. If this bit is set, the processor will signal a
performance-monitoring interrupt (PMI) when the corresponding trace
output region is filled. This patch set will inject a PMI for Intel
Processor Trace when ToPA buffer is filled.

Luwei Kang (3):
  perf/x86/intel/pt: Move pt structure to global header
  perf/x86/intel/pt: Inject PMI for KVM guest
  KVM: x86: Add support of clear Trace_ToPA_PMI status

 arch/x86/events/intel/pt.c       | 12 +++++++++++-
 arch/x86/events/intel/pt.h       | 38 -------------------------------------
 arch/x86/include/asm/intel_pt.h  | 41 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h  |  1 +
 arch/x86/include/asm/msr-index.h |  8 ++++++++
 arch/x86/kvm/vmx/pmu_intel.c     |  8 +++++++-
 arch/x86/kvm/x86.h               |  6 ++++++
 7 files changed, 74 insertions(+), 40 deletions(-)

-- 
1.8.3.1

