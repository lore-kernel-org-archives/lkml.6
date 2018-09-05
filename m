Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9FBC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2C42077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0k1/q/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2C42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeIETGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:06:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41881 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIETGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:06:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so3537195pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=P91aXxxB9n/3j5Inu+NxoRI5BxGOsBBTIg+ibZpLtCw=;
        b=Z0k1/q/mN8neN6Up/kTutq8qRndBnjJJCiXj9e5MlSN8tWKpnqdO8nG6x0X9qh6CKG
         8uSMYFWWftHS/FsoJl2r9Y7nlXGGvkT0PZnTLx6tpJBp4AqClAcNBAAY+cuDPZec3xeY
         NH3swv6K9r8dYThS+WBFw0DlleW/lajqZObZYpwMyBTCrhcmHovS5IlLX0pwHCLfO1RN
         RbikKM7bni74mCr/KbzVDvhXmyCtb4QGP+PQ3gtnhrrOsi+vEVAI0EP4Fa74xncC7Jru
         zHRoi7V3JJDziJ58ux+jG6+5QtAXnEEMmLIvNYhQIEWz4Mw+TSna06kCb5DYJzhQtFUt
         xOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=P91aXxxB9n/3j5Inu+NxoRI5BxGOsBBTIg+ibZpLtCw=;
        b=GXnwfEoWyd9RwRfzH77B4Gqgz3hQi9OdVBZqPFnqlmG1RCjVnirOAtiRzatUF9Z9AM
         lOj6awXIQYdJySE9QN2BZ2a7gY1ydIJ+1b0irmly05QI5H5Nnw19/bZTweqN0HfelAhs
         vn9yAxULYhVO8agIZeq9N9XQBy7dmX/29oZ5Rp6ZG1qFugh7vdjCu2aYyxPEBEbufYRL
         kVf9rDS5ILf8G16+UxEiuD14kDhBOl8xthUIdqzVgo2GDxpmRU8r8zNQuNFsc7dc1Rlq
         xGLWwHvrVLUX9bXZVe5nY8HM0+XpV6OIv9mQrAtLT3IWF5VxPXmnzmT6RBIHojjbOAF2
         D8yA==
X-Gm-Message-State: APzg51BMgdeBeYLFoQPmr7HAyA1VP/n6jq4ziuGUS0B0lwXqmn4F7NLU
        J/GCjUvoGJXhC+1j+0DwaFs=
X-Google-Smtp-Source: ANB0VdZBb+CfR4tv15a9Rzqe8zDh7fK4NY7vxaC4NF1k53ZPHg3oi2kdfscRPEimzy2wMtnNIeOHTw==
X-Received: by 2002:aa7:86cb:: with SMTP id h11-v6mr40393038pfo.58.1536158169474;
        Wed, 05 Sep 2018 07:36:09 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k126-v6sm6193172pgk.26.2018.09.05.07.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:36:08 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH -next] RISC-V: Request newstat syscalls
Date:   Wed,  5 Sep 2018 07:36:06 -0700
Message-Id: <1536158166-3397-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 82b355d161c9 ("y2038: Remove newstat family from default
syscall set"), riscv images fail to boot with the following error.

/sbin/init: error while loading shared libraries: libc.so.6:
	cannot stat shared object: Error 38
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00

Explicitly request newstat syscalls to fix the problem.

Fixes: 82b355d161c9 ("y2038: Remove newstat family from default syscall set")
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I would suggest to merge this patch with the offending patch.

 arch/riscv/include/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 0caea01d5cca..eff7aa9aa163 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -16,6 +16,7 @@
  * be included multiple times.  See uapi/asm/syscalls.h for more info.
  */
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 #include <uapi/asm/syscalls.h>
-- 
2.7.4

