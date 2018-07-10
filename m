Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68691C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDF920877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDF920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932743AbeGJIz2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:55:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:44781 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeGJIz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:55:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 01:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,333,1526367600"; 
   d="scan'208";a="53258016"
Received: from dst.sh.intel.com ([10.239.48.156])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2018 01:55:07 -0700
From:   Jingqi Liu <jingqi.liu@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wei.w.wang@intel.com, Jingqi Liu <jingqi.liu@intel.com>
Subject: [PATCH 0/3] KVM: x86: expose a few new features into VM.
Date:   Tue, 10 Jul 2018 16:54:40 +0800
Message-Id: <1531212883-63173-1-git-send-email-jingqi.liu@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few new features including user wait (umwait, umonitor, tpause)
and direct stores (movdiri and movdir64b) will be available in
Intel Snow Ridge, and need to be exposed to guest VM.

The release document ref below link:
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

This series expose umonitor,umwait, tpause, movdiri and movdir64b
features to guest VM.

Jingqi Liu (3):
  KVM: x86: expose UMWAIT/UMONITOR/TPAUSE CPU features into VM.
  KVM: x86: expose MOVDIRI CPU feature into VM.
  KVM: x86: expose MOVDIR64B CPU feature into VM.

 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.3.1

