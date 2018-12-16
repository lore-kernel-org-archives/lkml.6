Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2C0C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE3E2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rUw0Zz+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbeLPQDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:03:39 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:31836 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 11:03:39 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wBGG3W04022527;
        Mon, 17 Dec 2018 01:03:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wBGG3W04022527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544976213;
        bh=yTYMr1eBwO/WK1VTgMsGwA3+XWkJEdrqIxYn/H0e0K0=;
        h=From:To:Cc:Subject:Date:From;
        b=rUw0Zz+RTLTc06j7yWzxrQP2V0vNc1AYWdRPoTELaGctjwBJMrfM8td8+ZdCSEcFV
         tC86QT9vmTkZgYT0xmZb99vl3OwV3gP4KOAvXDeGIZujaY31Sn9lHORvRa8rLyC40w
         d87y1X68FANpO1raztQjmV5h9bXgf+Fb57oyKLPNdtFt4pB46nJ7XmbbQPQ6YQW2Wp
         5U0l0oBUYAkLH1u2bVdb2J0+MEKttODmdu80/vQg5+vSKyT9A5Ij5gvffXcq2FTjUd
         +X30a1yowmGA3JpFwbMk0rjE0BmAXNXXsUEllZuT2RWyfJ8oUZPB8kwozHkMsj/sL5
         VqLdYmgr0uoqQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] csky: remove meaningless header-y
Date:   Mon, 17 Dec 2018 01:03:25 +0900
Message-Id: <1544976205-18762-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fcc8487d477a ("uapi: export all headers under uapi
directories"), header-y is meaningless because headers under uapi
are all exported.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/csky/include/uapi/asm/Kbuild | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/csky/include/uapi/asm/Kbuild b/arch/csky/include/uapi/asm/Kbuild
index e02fd44e..7449fde 100644
--- a/arch/csky/include/uapi/asm/Kbuild
+++ b/arch/csky/include/uapi/asm/Kbuild
@@ -1,7 +1,5 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-header-y += cachectl.h
-
 generic-y += auxvec.h
 generic-y += param.h
 generic-y += bpf_perf_event.h
-- 
2.7.4

