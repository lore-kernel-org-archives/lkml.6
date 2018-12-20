Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86A5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCBC218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389663AbeLTUxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:53:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:6560 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387666AbeLTUxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:53:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 12:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,378,1539673200"; 
   d="scan'208";a="119962059"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2018 12:53:48 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add arch/x86/kvm sub-directories to existing KVM/x86 entry
Date:   Thu, 20 Dec 2018 12:53:20 -0800
Message-Id: <20181220205320.24322-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A series currently sitting in KVM's queue for 4.21 moves the bulk of
KVM's VMX code to a dedicated VMX sub-directory[1].  As a result,
get_maintainers.pl doesn't get any hits on the newly relocated VMX
files when the script is run with --pattern-depth=1.

Add all arch/x86/kvm sub-directories to the existing MAINTAINERS entry
for KVM/x86 instead of arch/x86/kvm/vmx as other code, e.g. SVM, may
get similar treatment in the near future.

[1] https://patchwork.kernel.org/cover/10710751/

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8119141a926f..55db660a092b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8236,6 +8236,7 @@ W:	http://www.linux-kvm.org
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
 S:	Supported
 F:	arch/x86/kvm/
+F:	arch/x86/kvm/*/
 F:	arch/x86/include/uapi/asm/kvm*
 F:	arch/x86/include/asm/kvm*
 F:	arch/x86/include/asm/pvclock-abi.h
-- 
2.19.2

