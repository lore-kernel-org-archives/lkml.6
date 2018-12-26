Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19848C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE71421720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbeLZIMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:12:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:64132 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeLZIMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:12:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 00:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,400,1539673200"; 
   d="scan'208";a="104759656"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.239.13.104])
  by orsmga008.jf.intel.com with ESMTP; 26 Dec 2018 00:12:35 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>
Subject: [PATCH v1 0/8] This patch-set is to enable kvm Guest OS CET support.
Date:   Wed, 26 Dec 2018 16:15:24 +0800
Message-Id: <20181226081532.30698-1-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control-flow Enforcement Technology (CET) provides protection against
return/jump-oriented programming (ROP) attacks. To make kvm Guest OS
own the capability, this patch-set is required. It enables CET related
CPUID report, xsaves/xrstors, vmx entry configuration etc for Guest OS.

PATCH 1/3/4: Enable CET support in VMCS.
PATCH 2    : Define CR4.CET master enable bit.
PATCH 5    : Enable xsave components for CET in XSS.
PATCH 6/7/8: Report CET feature support in CPUID.
 
Yang Weijiang (8):
  kvm:vmx  Introduce CET related VMCS field definitions.
  kvm:  Define CR4.CET[bit 23] (master enable bit) for guest OS.
  kvm:vmx  Enable loading CET state bit while guest CR4.CET is being
    set.
  kvm:vmx  Pass through host CET related MSRs to Guest.
  kvm:x86  Enable MSR_IA32_XSS bit 11 and 12 for CET xsaves/xrstors.
  kvm:cpuid  Add CPUID support for CET xsaves component query.
  kvm:cpuid  Fix xsaves area size calculation for CPUID.(EAX=0xD,ECX=1).
  kvm:cpuid  Report CET SHSTK and IBT support in CPUID.(EAX=0x7,ECX=0).

 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/include/asm/vmx.h      |  8 +++++++
 arch/x86/kvm/cpuid.c            | 23 +++++++++++++-------
 arch/x86/kvm/vmx.c              | 37 ++++++++++++++++++++++++++++++---
 4 files changed, 60 insertions(+), 11 deletions(-)

-- 
2.17.1

