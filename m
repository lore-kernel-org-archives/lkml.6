Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA1FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04AE20685
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Pw5RyNTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfAKDX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:23:58 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:59726 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbfAKDX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:23:57 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0B3MdXe025916;
        Fri, 11 Jan 2019 12:22:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0B3MdXe025916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547176963;
        bh=o960nwTIInwSpgZB4K5qD7Hn6Pqx0abIWDZYR2x41yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pw5RyNTAUnetSU3DE3wx+g10ghUpiX35CcH7FrO/qd+0DIlv6XA70xd/6UV58hNNM
         PEAwLwig++rrHkUcQ84szqCX4pog3pbgQMFQkSiDfmBSy4y2RL/gI5dRoKd/ExsKEX
         NBZ0f8l4kONuQIoP4xM0Zbe2zozM0hAZeeOs1zIgSi6IQsT+haBmgj3FZmwTxmapOO
         t91lQE/6mnQfzd6lPL+YPQF7TdyGxhilPs66BtV2Pv4dlP1vs/Z2+OS3OQB1OhWq44
         zIeC7LYo0fMmgbjXaFtjPd0o2BnFH0y/joBrIVAEcr7Dn3VVcORX8JAtYPBa5bczAB
         l15GPfodYXgLQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3] powerpc: math-emu: remove unneeded header search paths
Date:   Fri, 11 Jan 2019 12:22:33 +0900
Message-Id: <1547176954-17739-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
References: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header search path -I. in kernel Makefiles is very suspicious;
it allows the compiler to search for headers in the top of $(srctree),
where obviously no header file exists.

-Iinclude/math-emu seems unnecessary because all files include headers
in the form of #include <math-emu/...>.

I was able to build without these header search paths.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/math-emu/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index 494df26..a879403 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -17,4 +17,4 @@ obj-$(CONFIG_SPE)		+= math_efp.o
 CFLAGS_fabs.o = -fno-builtin-fabs
 CFLAGS_math.o = -fno-builtin-fabs
 
-ccflags-y = -I. -Iinclude/math-emu -w
+ccflags-y = -w
-- 
2.7.4

