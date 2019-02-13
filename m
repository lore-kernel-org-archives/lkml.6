Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08729C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97342175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U488pN3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393076AbfBMRkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:40:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389327AbfBMRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZRQGd3OlQ7EtmCJo+Bpz2CuIbUAAtlxOqCv8rWaLtn8=; b=U488pN3ty7DUsrvdxkNWj34OEF
        XCVHFtL1I0vKYB9YwCcygYFZkfhcDv5XrIEaeRIzPwZ098ezWFUOLxquo/sPtNYcZorYZM3H6XlJG
        WF+bECzAZV+0sjML3yFRRiySZ66Bp+okm7fUWl5VGjjnpqhThVSSc3DgL7o/z6KLJXyg+6Kd1BTdf
        lAeVs/7+xZRQGy+hvcqwnMbXoIB77hFzuBufKeqsdi6ZPq2w4On1rvwKzqx24j6JC1/e07TLXWnu1
        yr9aWv4LIm2nKPh3g2aKf94GL3vMWVXupF61AXkuSVQ65RCYOvFq26yMWDBZ7cEriBCRwqgXO/aF1
        oQE4gYjQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyWA-00087z-1M; Wed, 13 Feb 2019 17:40:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
Date:   Wed, 13 Feb 2019 18:39:55 +0100
Message-Id: <20190213174005.28785-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213174005.28785-1-hch@lst.de>
References: <20190213174005.28785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__KERNEL__ is never not defined for non-uapi headers, and GENERIC_CSUM
isn't ever set for powerpc either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/checksum.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index a78a57e5058d..37c309500260 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -1,6 +1,5 @@
 #ifndef _ASM_POWERPC_CHECKSUM_H
 #define _ASM_POWERPC_CHECKSUM_H
-#ifdef __KERNEL__
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -9,9 +8,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifdef CONFIG_GENERIC_CSUM
-#include <asm-generic/checksum.h>
-#else
 #include <linux/bitops.h>
 #include <linux/in6.h>
 /*
@@ -217,6 +213,4 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 			const struct in6_addr *daddr,
 			__u32 len, __u8 proto, __wsum sum);
 
-#endif
-#endif /* __KERNEL__ */
-#endif
+#endif /* _ASM_POWERPC_CHECKSUM_H */
-- 
2.20.1

