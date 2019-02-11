Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02A0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2FF222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895915;
	bh=2l9BBsmRms9mgsFsiNrPTOobi9ccC+9erzvE/OdvxrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ul3LvP+aOBmC3tBwA4ueF4dy7cTixoXjqbBMjAFxTkosFhWSTlTVmM4b8Dl/cLhRk
	 hmYkglSvis6oqLxc5V29HkRWB2i4QzNtFZhnDesHEc0D3VKj+aY45lcR5AqpJv162t
	 Gd5kdtYG7nQvx9uUBJkzSx03tW4NoRrDH1VwtY1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfBKOid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731683AbfBKOia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:38:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2E0222A2;
        Mon, 11 Feb 2019 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895909;
        bh=2l9BBsmRms9mgsFsiNrPTOobi9ccC+9erzvE/OdvxrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1Lo/2iTSJMBulKG7Rd40GgSBdl0QR/B6EpZlVV77Azp4NwgPgX0GLJeJN4I7UKFD
         geCiVx7msn03NW3A11k/YHSrETCI4yInWxms605HcXYi1Hcdb1JdTc/lFsQ+FFDdmp
         fGLRLlx6476XklndMdlWtokmtyW7+2Sc75ii/uGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nickhu <nickhu@andestech.com>,
        Zong Li <zong@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 011/313] nds32: Fix gcc 8.0 compiler option incompatible.
Date:   Mon, 11 Feb 2019 15:14:51 +0100
Message-Id: <20190211141853.806050847@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit 4c3d6174e0e17599549f636ec48ddf78627a17fe ]

When the kernel configs of ftrace and frame pointer options are
choosed, the compiler option of kernel will incompatible.
	Error message:
		nds32le-linux-gcc: error: -pg and -fomit-frame-pointer are incompatible

Signed-off-by: Nickhu <nickhu@andestech.com>
Signed-off-by: Zong Li <zong@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/nds32/mm/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
index 6b6855852223..7c5c15ad854a 100644
--- a/arch/nds32/mm/Makefile
+++ b/arch/nds32/mm/Makefile
@@ -4,4 +4,8 @@ obj-y				:= extable.o tlb.o \
 
 obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
 obj-$(CONFIG_HIGHMEM)           += highmem.o
-CFLAGS_proc-n13.o		+= -fomit-frame-pointer
+
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_proc.o     = $(CC_FLAGS_FTRACE)
+endif
+CFLAGS_proc.o              += -fomit-frame-pointer
-- 
2.19.1



