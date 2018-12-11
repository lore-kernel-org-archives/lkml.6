Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F7FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E742084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544988;
	bh=7Ggeck8wQb4CpeQ/vdbJmdjcECKkUglFwyrQBscj4zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LToRGqw9AdWbvnTgDHNa5+McB/pWioeYkDV5S4JKoSsPdrSrxjj/ie/mP9OFS/yCX
	 prWxykd8l+QfFPMmEu4vEsCLbXPzi8qrh7SB6v8RO83RZNxjcTw1gz9RS3jnpYjl8o
	 LcD0C+YYsfyQ4wN/ZIf8VzxFCXHPL5Ar6XxdxlqE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E742084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbeLKPsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbeLKPrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:47:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4178420989;
        Tue, 11 Dec 2018 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543274;
        bh=7Ggeck8wQb4CpeQ/vdbJmdjcECKkUglFwyrQBscj4zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1QHEFcbJWzM4uNY93lrkkryAP631ps41UfetNyS9c65j+Y/pibEgH+GsSspihR8kr
         Be66BTRD7ieAdOW6EQatesU2XKzzuW7RvJpQRK+h2+s7UwksvR4LuIUE5XFuV8zLuk
         621n99n1wC40GAIawzNGyC4gVUx57Z13w3bjRCIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.4 52/91] ARC: change defconfig defaults to ARCv2
Date:   Tue, 11 Dec 2018 16:41:11 +0100
Message-Id: <20181211151610.187087935@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 arch/arc/configs/nsim_700_defconfig |    1 +
 arch/arc/configs/nsimosci_defconfig |    1 +
 arch/arc/configs/tb10x_defconfig    |    1 +
 6 files changed, 6 insertions(+), 2 deletions(-)

--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -96,7 +96,7 @@ endmenu
 
 choice
 	prompt "ARC Instruction Set"
-	default ISA_ARCOMPACT
+	default ISA_ARCV2
 
 config ISA_ARCOMPACT
 	bool "ARCompact ISA"
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -12,7 +12,7 @@ ifeq ($(CROSS_COMPILE),)
 CROSS_COMPILE := arc-linux-
 endif
 
-KBUILD_DEFCONFIG := nsim_700_defconfig
+KBUILD_DEFCONFIG := nsim_hs_defconfig
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
 cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -17,6 +17,7 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_MODULES=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARC_PLAT_AXS10X=y
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -16,6 +16,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
+CONFIG_ISA_ARCOMPACT=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_LBDAF is not set
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -17,6 +17,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
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


