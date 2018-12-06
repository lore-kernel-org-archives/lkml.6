Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897E5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB3F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107294;
	bh=VCYQy6SGP+uqQvfkLwpcS6gGoWRAD3vJPEbsHA9XvoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KUUOQ9z2p2IlbSKDVFD0BQTD5XBob29JbkT16YpaZ6fv/H9KPUiPKQ1CqEvcCCbG6
	 3NezhXbip1+FCYUn8MIKb7dp8nPAPKJXpJedsNSpVFAKp9ZIsKX4MdpgyZ7Ae0DYf/
	 gpjaSlaDylGNb/CeIz8r9uhHl9sSpD2r4+fymp3s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB3F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbeLFOld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730251AbeLFOl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17C9F214DA;
        Thu,  6 Dec 2018 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107288;
        bh=VCYQy6SGP+uqQvfkLwpcS6gGoWRAD3vJPEbsHA9XvoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7LNMGHHV8XT3FV0Bqeb78rjXaPtQIMMqBuY1mjubVD5K2pBOa0Dg/a1JARvEnZiE
         SxDpvZFjBHYh1jd19Tysy/TMjFNo/Mh9kyRGgl6mh3vpILmYmIUHUGXMqd84Vg/Gn9
         QTYlUeJesZYDX02dXjbIuHg1CAR3o6zojj7RrNKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.19 39/41] ARC: change defconfig defaults to ARCv2
Date:   Thu,  6 Dec 2018 15:39:19 +0100
Message-Id: <20181206142953.867781836@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Hilman <khilman@baylibre.com>

commit b7cc40c32a8bfa6f2581a71747f6a7d491fe43ba upstream.

Change the default defconfig (used with 'make defconfig') to the ARCv2
nsim_hs_defconfig, and also switch the default Kconfig ISA selection to
ARCv2.

This allows several default defconfigs (e.g. make defconfig, make
allnoconfig, make tinyconfig) to all work with ARCv2 by default.

Note since we change default architecture from ARCompact to ARCv2
it's required to explicitly mention architecture type in ARCompact
defconfigs otherwise ARCv2 will be implied and binaries will be
generated for ARCv2.

Cc: <stable@vger.kernel.org> # 4.4.x
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/Kconfig                    |    2 +-
 arch/arc/Makefile                   |    2 +-
 arch/arc/configs/axs101_defconfig   |    1 +
 arch/arc/configs/nps_defconfig      |    1 +
 arch/arc/configs/nsim_700_defconfig |    1 +
 arch/arc/configs/nsimosci_defconfig |    1 +
 arch/arc/configs/tb10x_defconfig    |    1 +
 7 files changed, 7 insertions(+), 2 deletions(-)

--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -111,7 +111,7 @@ endmenu
 
 choice
 	prompt "ARC Instruction Set"
-	default ISA_ARCOMPACT
+	default ISA_ARCV2
 
 config ISA_ARCOMPACT
 	bool "ARCompact ISA"
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -6,7 +6,7 @@
 # published by the Free Software Foundation.
 #
 
-KBUILD_DEFCONFIG := nsim_700_defconfig
+KBUILD_DEFCONFIG := nsim_hs_defconfig
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
 cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -14,6 +14,7 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
--- a/arch/arc/configs/nps_defconfig
+++ b/arch/arc/configs/nps_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -15,6 +15,7 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_LBDAF is not set
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -15,6 +15,7 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_LBDAF is not set
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -19,6 +19,7 @@ CONFIG_KALLSYMS_ALL=y
 # CONFIG_AIO is not set
 CONFIG_EMBEDDED=y
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y


