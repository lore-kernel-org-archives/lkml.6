Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0461C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A646B20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108217;
	bh=1OuT71R8SAsCPPRPqZgn+j6mc8Q5uc1RGfHmuw2boXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BrmZJ1FAOh+/UQJwuNRJjfSat3JdDuk08PbJs4DcSFzbdezaV2hH7X7tb6a6smw1A
	 Asy6j0zQWFbWBq4dPeB54eAxM4p7/VS7LVwnzSgv/HtclTO5ANJn/Br7oYiHZAM9If
	 AOX2dAfQzlJZpkwCKulN3NwVSxJElAztjnm8f03U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A646B20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeLFO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbeLFOnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9660A20661;
        Thu,  6 Dec 2018 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107387;
        bh=1OuT71R8SAsCPPRPqZgn+j6mc8Q5uc1RGfHmuw2boXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8oTZCGbabPC99Is6CHARr1wzmC0+fuhH2VLYCm6ObV71QY45D9bC5cRyVqY+YyfY
         03CrTOvWLFz/lnWnJSjcnb4U3frgW9UjnqHf84pzqNrl7kmr3Smz6a8KBAh2x1yX28
         KQuKWIdVmpXzT/CfdaNLSoDo9zRjQSCXzqMRxWhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.14 42/55] ARC: change defconfig defaults to ARCv2
Date:   Thu,  6 Dec 2018 15:39:16 +0100
Message-Id: <20181206143004.020725886@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -109,7 +109,7 @@ endmenu
 
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
@@ -15,6 +15,7 @@ CONFIG_PERF_EVENTS=y
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
@@ -16,6 +16,7 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_LBDAF is not set
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -16,6 +16,7 @@ CONFIG_EMBEDDED=y
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


