Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D52C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC732184D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691070;
	bh=J7awTv4PeS1XC2RfXErFy6KB3u756blQbjFvWInqLNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xlwPG5cwgfpYzoxYy28jRcWxNMWz2wWNRQSFe3f1s6JsQseaYpybUv5lwQ14mI3p/
	 sgc+4iSFMyt5FxaxIcICLckj6avvsCEL49Z8lKCeX/J2+3IfFuLi19NmBwNwRBbDvH
	 viAWMs7E5oaUEp2JxIkTiAKTr95xoTfru9k6lFvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfA1P5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:57:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbfA1P5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:57:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85F52175B;
        Mon, 28 Jan 2019 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691064;
        bh=J7awTv4PeS1XC2RfXErFy6KB3u756blQbjFvWInqLNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztXhvHa+ODh8f2Xjq2NBgQi+xJ7GEIkujQzdFT/NhR95EGMaOcT2+zJR6t5fG9r1w
         4Y/G0MQ9vPH4ds+rx4PkJSHDx80f6tltTFAV8IUl7feHDz8l8TeLLEsOX7zTIZwnL4
         i+kBWbVMz8aLIAKwDlCr7iFHP5CFoRXxpawdEe/s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-sh@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 277/304] arch/sh/boards/mach-kfr2r09/setup.c: fix struct mtd_oob_ops build warning
Date:   Mon, 28 Jan 2019 10:43:14 -0500
Message-Id: <20190128154341.47195-277-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 440e7b379f91acd245d5c8de94d533f40f5dffb3 ]

arch/sh/boards/mach-kfr2r09/setup.c does not need to #include
<mtd/onenand.h>, and doing so causes a build warning, so drop that header
file.

In file included from ../arch/sh/boards/mach-kfr2r09/setup.c:28:
../include/linux/mtd/onenand.h:225:12: warning: 'struct mtd_oob_ops' declared inside parameter list will not be visible outside of this definition or declaration
     struct mtd_oob_ops *ops);

Link: http://lkml.kernel.org/r/702f0a25-c63e-6912-4640-6ab0f00afbc7@infradead.org
Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/boards/mach-kfr2r09/setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index e59c577ed871..c70bc7809dda 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -25,7 +25,6 @@
 #include <linux/memblock.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
-#include <linux/mtd/onenand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_data/lv5207lp.h>
 #include <linux/platform_device.h>
-- 
2.19.1

