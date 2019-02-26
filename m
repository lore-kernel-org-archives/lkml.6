Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C61AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374322147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gGm0Zfv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfBZQmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:42:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54578 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfBZQmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dHDScHa9IXrLExKJjEALoxWykNLX1hESDzNeVaEll6s=; b=gGm0Zfv0cD/R0ANLBAlla5Tw35
        jypSU82G3barkk68nRAQMHrCUmMmKDKCM6At2wT0/FRe5sWNYDPk/nhOWBB14/OwdtGD6/ZOZagSy
        bKSUbqOPkVVgd4Nilq2U6gBbDoTXyUC9pz0jkiBz232/WAZhzqJA/mCRa23FuMZ09qQc1/LLBNgM3
        XrIl7PDkaxuVX2+lBpAKgZlTjby9+J/LL23eFGvbnym1VPk50mEayNGlXEcfAXE6+a3UBaFfKwWjy
        MjXJTpkGLlJGJW8FF8CuaT5DB4COPwLnHohY+Op4Nh7s42sM9LiwhDEr/zU8kIgAvZgWFqLbPyKek
        Zaj3a44Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyfoV-0007Gi-Ty; Tue, 26 Feb 2019 16:42:40 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] misc/habanalabs: adjust Kconfig to fix build errors
Message-ID: <75aefec9-9906-60e9-2e67-8c60e7f4d970@infradead.org>
Date:   Tue, 26 Feb 2019 08:42:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Several places in the habanalabs driver use gen_alloc functions,
so select GENERIC_ALLOCATOR to make those functions available.

Fixes these build errors:

ERROR: "gen_pool_alloc" [drivers/misc/habanalabs/habanalabs.ko] undefined!
ERROR: "gen_pool_add_virt" [drivers/misc/habanalabs/habanalabs.ko] undefined!
ERROR: "gen_pool_destroy" [drivers/misc/habanalabs/habanalabs.ko] undefined!
ERROR: "gen_pool_create" [drivers/misc/habanalabs/habanalabs.ko] undefined!
ERROR: "gen_pool_free" [drivers/misc/habanalabs/habanalabs.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20190226.orig/drivers/misc/habanalabs/Kconfig
+++ linux-next-20190226/drivers/misc/habanalabs/Kconfig
@@ -6,6 +6,7 @@ config HABANA_AI
 	tristate "HabanaAI accelerators (habanalabs)"
 	depends on PCI
 	select FRAME_VECTOR
+	select GENERIC_ALLOCATOR
 	help
 	  Enables PCIe card driver for Habana's AI Processors (AIP) that are
 	  designed to accelerate Deep Learning inference and training workloads.


