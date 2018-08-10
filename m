Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0858C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CDB21A78
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CDB21A78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeHJOWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:22:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:38734 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727657AbeHJOWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:22:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47433AE92;
        Fri, 10 Aug 2018 11:52:58 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 06/10] x86/paravirt: introduce new config option PARAVIRT_XXL
Date:   Fri, 10 Aug 2018 13:52:48 +0200
Message-Id: <20180810115252.18213-7-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180810115252.18213-1-jgross@suse.com>
References: <20180810115252.18213-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A large amount of paravirt ops is used by Xen PV guests only. Add a new
config option PARAVIRT_XXL which is selected by XEN_PV. Later we can
put the Xen PV only paravirt ops under the PARACVIRT_XXL umbrella.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/Kconfig     | 3 +++
 arch/x86/xen/Kconfig | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 887d3a7bb646..3c967b803c21 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -754,6 +754,9 @@ config PARAVIRT
 	  over full virtualization.  However, when run without a hypervisor
 	  the kernel is theoretically slower and slightly larger.
 
+config PARAVIRT_XXL
+	bool
+
 config PARAVIRT_DEBUG
 	bool "paravirt-ops debugging"
 	depends on PARAVIRT && DEBUG_KERNEL
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index c1f98f32c45f..dd92d7bd3613 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -18,6 +18,7 @@ config XEN_PV
 	bool "Xen PV guest support"
 	default y
 	depends on XEN
+	select PARAVIRT_XXL
 	select XEN_HAVE_PVMMU
 	select XEN_HAVE_VPMU
 	help
-- 
2.13.7

