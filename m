Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2A4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A1A21476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="aEPqihC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A1A21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbeGLILq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:11:46 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:56394 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeGLILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:11:45 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w6C81cQg012716;
        Thu, 12 Jul 2018 17:01:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w6C81cQg012716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531382501;
        bh=2GPOkadRziKxw03k7uWwGARi/4AY/9BJBdsFxAPPIXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEPqihC3Wb8hLO9MPxzPOg4+ijqdYJHmjC17dj9ONRAJcm9AkGxnI1YaaQ6nCCKgk
         JKpZ/Ea19kAVn5ZmQvIHIecHRIfVhvUbzim2MjQU6KmTd7dj1dXRy7VjTRtfPsTnmk
         S2QqGVPEvS8hJ/V1dLMuTwHajOm0a/KJauGSqxLUOKiHjVWpxpUHOF+l8xxeo1L8I/
         NjtdKhMRvMx1jKZh6XLzS+ryQwOI4HSqU7vWJ/WqkeeDtFiQezz6CaPrKb/1RIdMn/
         iIr67XmIyuv6zIoq3pbgq6xStL7gdra54RBMOpuIusb2A6qtcip+SrdOtQ5nErLGGD
         qxqoOEbVglrtw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, x86@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        openrisc@lists.librecores.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Jeff Dike <jdike@addtoit.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/6] um: remove redundant 'export LDFLAGS' in arch/x86/Makefile.um
Date:   Thu, 12 Jul 2018 17:01:31 +0900
Message-Id: <1531382496-3719-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already exported by the top-level Makefile.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Makefile.um | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 45af199..5296f8c 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -13,8 +13,6 @@ KBUILD_CFLAGS		+= $(call cc-option,-m32)
 KBUILD_AFLAGS		+= $(call cc-option,-m32)
 LINK-y			+= $(call cc-option,-m32)
 
-export LDFLAGS
-
 LDS_EXTRA		:= -Ui386
 export LDS_EXTRA
 
-- 
2.7.4

