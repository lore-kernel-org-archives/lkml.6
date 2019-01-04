Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A72C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B06221872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRRTOMlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfADJ2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:28:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46082 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADJ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:28:04 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so31175030edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2nwlgmQ1pKF6ZBcLi62Mt7YJmEymWM13iEI3HkbeSBc=;
        b=oRRTOMlK9vGJxFAY6Sdz4d+Uxyq5JAVIPTdN5v+GUpa6GVySBGSruMSFcg3do/GzzF
         kvx9WOvBqDs5LcnJLFRrkz0CQQ/d/8nhqgi33ufNzyjD78MU0lg6B0dbphOZgFSINTyY
         9M7EsARP16/W8btpcybPp0BaoMn/lbfCf9IOeFefYTYYROWQC1NDPOPPlOSHvC48DC6I
         mUCHSvworz21XDYbTkAMMuYPQq8N79D4o0BE+WDQ9QpHGgHSoqf5CG/m1fCkc5tH1E7f
         YapXgjB827NgVH88LRQK38STisBuIBH9SL3yCxKe4svurTZVIIxJJWsySdD3zy/g3BLY
         tDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2nwlgmQ1pKF6ZBcLi62Mt7YJmEymWM13iEI3HkbeSBc=;
        b=AcXjmI7/mBq7kLY7Mcr+YpNEK3eiv0sveUPtObQlM67LiZreshjfVnzZV2qpICWoHh
         /Rluvsfqfc+cQkhTMytryRBUBqnizvLMsbOiIwwjGLPeyZRv91g89Fg40K1r1lp0HOpk
         RD0FyrPUgtQuppHAf0nZ6dBEquav8s4VATrxwKUO+v+ZdrQUgQM7gn/qt9T85Imf5yf2
         fk0JEeugcbS+MUaVdJpYxQ1M8TfLl6N/1r0W2XMESCQrUkxNiLWYBirfU55lodQARRCE
         jVA4di6Cdvb4X/GXqKdUD6oAi5APf74wuLGgmoFR2rjgwNKNsdwS+7YeAyNGT0ayN2Ii
         P+4w==
X-Gm-Message-State: AA+aEWYdadRqkyTGvVM+p4EXcLH1AH69xZBglzYCXuDaLzsA6rRQMUVC
        G6LawHjqFVlGy1BNJ7rPlgAc0eKP
X-Google-Smtp-Source: AFSGD/VbSrg0TLNue3xEQQZWrztkLIZRkSri7ifn1MWPnP29bXxYq0iZYHnJ0LeuTTyET493xgHd0w==
X-Received: by 2002:a50:f284:: with SMTP id f4mr45193034edm.77.1546594082326;
        Fri, 04 Jan 2019 01:28:02 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id 49sm25983769edz.59.2019.01.04.01.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 01:28:01 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 4E7B4114685F; Fri,  4 Jan 2019 10:28:00 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove 'type' argument from access_ok() function
Date:   Fri,  4 Jan 2019 10:27:58 +0100
Message-Id: <20190104092758.4378-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
access_ok()") an attempt was made to remove a warning by referencing the
variable `type`, however in commit 96d4f267e40f ("Remove 'type' argument
from access_ok() function") the variable `type` has been removed.

Revert commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
access_ok()") to fix the following compilation error:

  arch/powerpc/include/asm/uaccess.h:66:32: error: ‘type’ undeclared (first use in this function)

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index b31bf45eebd4..5f0c98e511a0 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -63,7 +63,7 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
 #endif
 
 #define access_ok(addr, size)		\
-	(__chk_user_ptr(addr), (void)(type),		\
+	(__chk_user_ptr(addr),			\
 	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
 
 /*
-- 
2.19.2

