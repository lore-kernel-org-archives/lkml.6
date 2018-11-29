Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73599C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED2920863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISNTitQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED2920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeK2PXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:23:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45364 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeK2PXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:23:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so352388pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 20:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/ZIRmepFPOzHIKOHLjcVe7J8nlQ4nUTQi0l5QIDNnMU=;
        b=ISNTitQqCbP+R1Dn1If3QdrmACYFvog23/Jy4nscxJKBt9xlkyL2ueoe2/jEryLFFV
         PoAXbA9p7AuxDRgoWoyuplnvvTeI9ZKUtqk6VkM3Zu5xltJGwIG2QXwlM/xZ1rgphlDS
         1Imi40JzQjrsuynNvegIFyCb0/VB8xV7vycn6T1Jtesz6hCr7JacmkQGBGi8pcC0W6vy
         HWpdSqtVzEsJ+zySg6aezt7xnMIrrgpRPdKaPquJpCtUC05LXJklM2VBmv1+BbNptzec
         m5JCLX7gLJagmQZm+VvZFrvAMxtbBv02F+wyMV77a76UxhypIsY+Qk04PLr01yswImHX
         y3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ZIRmepFPOzHIKOHLjcVe7J8nlQ4nUTQi0l5QIDNnMU=;
        b=b0yGjy7zMkZMm8SVjr0BgyBRhASyquPkfvS/GozHj//7XYaj30TZ6mPq+RJUcj+aoK
         rZTA5tIHHFoMj1L1wQ9qScxyLAVPA1c4d1D4MN+kV+1t/85s3RCftzI7NtavYz+540sT
         nvg74rflofyzKTE+Q03oFee8OqtZq32jQEqVNGte2BseQRu4/+qdN2KanODi5Gd4it/b
         6VCMFOwtNNXGSIxvgzslSw5CIEjXDtgwIYjnaZXP2rUe0R35n5YP9cRHrcp7J4sJqKka
         gePzALvmS9R3Ba1VY0ydUAqMiqs19YpCZPup8rc2Lfu2IWMJtv+mDW6eSj9VWYWDpFTu
         Ry2Q==
X-Gm-Message-State: AA+aEWZq1BkD6rixJmd+f6cVolPFtBsDbyuNaThwpcdtlImd1GlJIkoo
        fNiM7Wf040ChnzYQtQOReWE=
X-Google-Smtp-Source: AFSGD/Ul0T9OL/87xpCvpWBiIyJzcKbnX+EKZpXGP17vs6lRmQNnCwEHx7JpVgJIAWoEAMDlwn5fug==
X-Received: by 2002:a63:bc02:: with SMTP id q2mr35900544pge.116.1543465176798;
        Wed, 28 Nov 2018 20:19:36 -0800 (PST)
Received: from localhost.localdomain (c-24-5-140-25.hsd1.ca.comcast.net. [24.5.140.25])
        by smtp.googlemail.com with ESMTPSA id d68sm703139pfa.64.2018.11.28.20.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 20:19:36 -0800 (PST)
From:   Nick Desaulniers <nick.desaulniers@gmail.com>
To:     will.deacon@arm.com
Cc:     natechancellor@gmail.com,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: io: specify asm operand width for __iormb()
Date:   Wed, 28 Nov 2018 20:19:10 -0800
Message-Id: <20181129041912.5918-1-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the warning produced from Clang:
./include/asm-generic/io.h:711:9: warning: value size does not match
register size specified by the constraint and modifier
[-Wasm-operand-widths]
        return readl(addr);
               ^
./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
                                                          ^
./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
                                                  ^
./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
        asm volatile("eor       %w0, %1, %1\n" \
                                     ^
Though we disable Clang's integrated assembler with -no-integrated-as,
it still tries to do some validation of assembler constraints.

While __iormb() is type agnostic to operand widths for argument v, its
lone use is to zero'd out via eor (exclusive or).

Fixes commit 6460d3201471 ("arm64: io: Ensure calls to delay routines
are ordered against prior readX()")
Link: https://github.com/ClangBuiltLinux/continuous-integration/issues/78
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
Side note: is it not correct to cite SHAs from linux-next in "Fixes
commit ..." lines? I guess we can drop it.

Link to regression build:
https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/92799938

Link to build w/ this patch:
https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/92935901


 arch/arm64/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index d42d00d8d5b6..dbdebf81162b 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -115,7 +115,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 	 * later instructions. This ensures that a subsequent call to	\
 	 * udelay() will be ordered due to the ISB in get_cycles().	\
 	 */								\
-	asm volatile("eor	%0, %1, %1\n"				\
+	asm volatile("eor	%0, %x1, %x1\n"				\
 		     "cbnz	%0, ."					\
 		     : "=r" (tmp) : "r" (v) : "memory");		\
 })
-- 
2.17.1

