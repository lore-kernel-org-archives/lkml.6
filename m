Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F92DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 01:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD93E2082C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 01:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XRFvgxVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfBDByi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 20:54:38 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:47408 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbfBDByi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 20:54:38 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x141rNQO008993;
        Mon, 4 Feb 2019 10:53:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x141rNQO008993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549245205;
        bh=waD41spIXeo55DISU4dm31e4PUr+6bTrF1VdnT98FdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRFvgxVMegYsPNNQawvsXKBxphCjPzofgGwYahvjrbg7ankZ2xUXKHVz1bRYa2bGl
         hXTsfZ8dzXJQSjxoOQz9m70lwRtcfqEykhhUtumvS8Lj1OXo+vDKUnH6hrHIVr6L/W
         GVMZcDjo59/rTFHe1/VF2VqyS5dkkuD4iMcCAwIEDR2jx5pLw2gMm1MCui6YsxRouA
         qtL7wbn1fAzzZuV6XMdNwypYfTbsBUHX+bBNXYyh9cJqaVf5xdrU7JO2YoMHJN4E80
         hBpFKa1ntq1M+zFpXV9MBXOphl5iDmWtl9fsoIyYI3osAECtS43u+XIxhWGQkmpjIh
         18tJubD57ymzw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Jan Beulich <JBeulich@suse.com>,
        nixiaoming <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 3/3] kallsyms: include <asm/bitsperlong.h> instead of <asm/types.h>
Date:   Mon,  4 Feb 2019 10:53:18 +0900
Message-Id: <1549245198-6182-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549245198-6182-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549245198-6182-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<asm/bitsperlong.h> is enough to include the definition of
BITS_PER_LONG.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f1b5749..03ff265 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -331,7 +331,7 @@ static void write_src(void)
 	unsigned int *markers;
 	char buf[KSYM_NAME_LEN];
 
-	printf("#include <asm/types.h>\n");
+	printf("#include <asm/bitsperlong.h>\n");
 	printf("#if BITS_PER_LONG == 64\n");
 	printf("#define PTR .quad\n");
 	printf("#define ALGN .balign 8\n");
-- 
2.7.4

