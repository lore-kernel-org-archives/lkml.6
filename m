Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128B9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD90B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="z6FiVD5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD90B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeIZUEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:04:24 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:58749 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeIZUEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:04:24 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f6686659;
        Wed, 26 Sep 2018 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=uKpKMy5FfMSy1J34424TG8ucA80=; b=z6FiVD5thW0VNrx/kyYR
        QLQsWB4x2oybfDjDyxlpFL+hH6ClSsiZgDqyiOgXB0GqeA59Q1dJGLVzmC5ujypo
        D1S9FO+z4gSWjXD2qH9UDT7Arg42tYqOj72Etig0wXB3r1CHISEe7WpsbIY4RiFg
        JJ6icqaeG0ox56saAswgqZ7SpqN/45rXPgaTiExiDzOjmCxa/kJ3iuXCBPEKZLXn
        fjGQooBK7nr4nT85X9UB1JBZ6CoSGETcoQZYu/FXBEoXAGBqXMCzj6Fa5hChJcOs
        8mLPyhE8nlMviS4NtSXUSgkOIfagTO7b/1E+6APdMNxzdh5NnDi3yZnfRkgJFJuU
        1Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7110e961 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 26 Sep 2018 13:32:45 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] arm: support big-endian for the virt architecture
Date:   Wed, 26 Sep 2018 15:51:10 +0200
Message-Id: <20180926135110.13061-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This architecture, used for running in QEMU, runs just fine when
compiled in big-endian mode. So enable it. This is enabled in exactly
the same way that it is for other platforms (such as vexpress) that also
support big-endian mode in QEMU successfully.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Personally, I'm using this as part of WireGuard's CI, and patching
kernels to include this is a bit annoying. Any chance this can get into
4.19?

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..b8c6062ca0c1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -701,6 +701,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
+	select ARCH_SUPPORTS_BIG_ENDIAN
 
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
-- 
2.19.0

