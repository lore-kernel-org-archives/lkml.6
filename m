Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E514C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C76A2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGRcDNxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C76A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeLEJgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbeLEJgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:08 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1E82084C;
        Wed,  5 Dec 2018 09:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002568;
        bh=5XAvFSj6C/C391eQcF60pP7KHUlt1odczXxyW6KZqYc=;
        h=From:To:Cc:Subject:Date:From;
        b=kGRcDNxTSTDWKtZkVwZ2Gw//F1Ooiqyfe5qHJeHMX2ut7Xj/2fssNWM41ernatAeO
         U2eME+uSA+Kxzttty1CpM3oyj4KMYy3w7yoxEgR9FlOEwibSmGxRsMMnufNYNmLO8O
         JcqVpVVA9x4EbT+dOP5pYURLGIkjsxeEfVzx849Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 001/123] ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup
Date:   Wed,  5 Dec 2018 04:33:53 -0500
Message-Id: <20181205093555.5386-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit eef3dc34a1e0b01d53328b88c25237bcc7323777 ]

When building the kernel with Clang, the following section mismatch
warning appears:

WARNING: vmlinux.o(.text+0x38b3c): Section mismatch in reference from
the function omap44xx_prm_late_init() to the function
.init.text:omap44xx_prm_enable_io_wakeup()
The function omap44xx_prm_late_init() references
the function __init omap44xx_prm_enable_io_wakeup().
This is often because omap44xx_prm_late_init lacks a __init
annotation or the annotation of omap44xx_prm_enable_io_wakeup is wrong.

Remove the __init annotation from omap44xx_prm_enable_io_wakeup so there
is no more mismatch.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/prm44xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 7b95729e8359..38a1be6c3694 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -351,7 +351,7 @@ static void omap44xx_prm_reconfigure_io_chain(void)
  * to occur, WAKEUPENABLE bits must be set in the pad mux registers, and
  * omap44xx_prm_reconfigure_io_chain() must be called.  No return value.
  */
-static void __init omap44xx_prm_enable_io_wakeup(void)
+static void omap44xx_prm_enable_io_wakeup(void)
 {
 	s32 inst = omap4_prmst_get_prm_dev_inst();
 
-- 
2.17.1

