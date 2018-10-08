Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63BBC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CECC21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p33AiDgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CECC21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbeJICBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA62204FD;
        Mon,  8 Oct 2018 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024527;
        bh=W4QCjauf1T4jsfZGRdHEUA4WTmHgk1EXhZiqir/X5ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p33AiDgSAq8ECY6BQO7lxiW/ILsXBvLzwtXUE2wWay9UgjejyInNtWFA0uYdda19A
         rQpouB9uOEJ0aiRftNJ8/kbcuahPv8ccuMMm3NQLXxNfBR/wE+rVDL29FaHWn7DbgM
         qLfDHWeyShZ+doLja4r37tXkSOW2CMSobXZelqRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greentime Hu <greentime@andestech.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 070/168] nds32: fix build error because of wrong semicolon
Date:   Mon,  8 Oct 2018 20:30:50 +0200
Message-Id: <20181008175622.726538952@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greentime Hu <greentime@andestech.com>

[ Upstream commit ec865393292f5ad8d52da20788b3685ebce44c48 ]

It shall be removed in the define usage. We shall not put a semicolon there.

/kisskb/src/arch/nds32/include/asm/elf.h:126:29: error: expected '}' before ';' token
 #define ELF_DATA ELFDATA2LSB;
                             ^
/kisskb/src/fs/proc/kcore.c:318:17: note: in expansion of macro 'ELF_DATA'
     [EI_DATA] = ELF_DATA,
                 ^~~~~~~~
/kisskb/src/fs/proc/kcore.c:312:15: note: to match this '{'
    .e_ident = {
               ^
/kisskb/src/scripts/Makefile.build:307: recipe for target 'fs/proc/kcore.o' failed

Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nds32/include/asm/elf.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -121,9 +121,9 @@ struct elf32_hdr;
  */
 #define ELF_CLASS	ELFCLASS32
 #ifdef __NDS32_EB__
-#define ELF_DATA	ELFDATA2MSB;
+#define ELF_DATA	ELFDATA2MSB
 #else
-#define ELF_DATA	ELFDATA2LSB;
+#define ELF_DATA	ELFDATA2LSB
 #endif
 #define ELF_ARCH	EM_NDS32
 #define USE_ELF_CORE_DUMP


