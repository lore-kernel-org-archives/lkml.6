Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94877C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3467E20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd+k/Aml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3467E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIZByR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:54:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51586 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZByQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:54:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id y25-v6so7235292wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7QrSfGg+m7wwBJbvpF/sopUqMmkgsyHFEUgr8QpLQc0=;
        b=Fd+k/AmllnYucV2djLKqGkR1Dw+QHlw44mJCWLiGIJApOWlTs7SH9dmM3/GXv7RDWd
         5Ne6uQfD7kGSxXs8IAaNOxYC/1z4W4ktminoRUIDg0smXkmP0+66H8bRF2ZpIoZl8hDe
         1nB2MRw+aDCnoelCl3B06v2l4IOHZVWhVYrhANdKztVl6ZlonBaEN1ojZ5kqpWLUXQrs
         JAGFF063rtDBcIQ2P/tLcFSEbYnxQL026K9KWyT7BFNNJ8A/7iAcIJn3WNFVtVaS1mtH
         aI214esKYRkkdWp2M0BFoZ2Ru4SwM5vF6rfIrBVZ7Yc5TxRWRX0Rta4WXMem+YqAAlq4
         6Z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7QrSfGg+m7wwBJbvpF/sopUqMmkgsyHFEUgr8QpLQc0=;
        b=kbkluzky951N5ZtG5jV/oDKQtzrH4HuOHiHeYenNAOGsmSgXY/tG3Opcgzq0CsIzeW
         +I/ii+FFYPSmPs0IJezIzgwhYLZpPBVWp1+GYR9FkYxBaukBANixe2flC2esxNuBmL1v
         60tg9E+Jt58KZUblHWlIHHQNYq2x91P3K98hH+Gy5qdfxpG4ureShMZK2DOvkas2Y0Eo
         vOz/fuuvn2ACslUVptekaAKAfMZ0KuVliGcHCcf557a9dlfMEzImpLWFeDp4u59ZaAsv
         AzJosB5MftgrTS+drJzkL3XhdwIqQcBYvWWcJD7SMcvuOtCnGkTLWUTgblvAU7gxgYHp
         DE5g==
X-Gm-Message-State: ABuFfoiUfDDK3o32RAeMHr4xaONl8OoB9RFEcLRLqoQsJRHeWiKk8pAD
        RvEsVMqaYClEeLBWb8Cmtl4=
X-Google-Smtp-Source: ACcGV63F+l1sY/B/LP7P47YHGpnvaNlt3fEuKOYG2DIZsY2Z8M8vRzm4ArDxcuXO79GNP2uSJ6Xu7w==
X-Received: by 2002:a1c:706:: with SMTP id 6-v6mr1878009wmh.83.1537904707702;
        Tue, 25 Sep 2018 12:45:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k63-v6sm4758089wmd.46.2018.09.25.12.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 12:45:07 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] arm64: percpu: Initialize ret in the default case
Date:   Tue, 25 Sep 2018 12:44:59 -0700
Message-Id: <20180925194459.13088-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that if the default case is taken, ret will be
uninitialized.

./arch/arm64/include/asm/percpu.h:196:2: warning: variable 'ret' is used
uninitialized whenever switch default is taken
[-Wsometimes-uninitialized]
        default:
        ^~~~~~~
./arch/arm64/include/asm/percpu.h:200:9: note: uninitialized use occurs
here
        return ret;
               ^~~
./arch/arm64/include/asm/percpu.h:157:19: note: initialize the variable
'ret' to silence this warning
        unsigned long ret, loop;
                         ^
                          = 0

This warning appears several times while building the erofs filesystem.
While it's not strictly wrong, the BUILD_BUG will prevent this from
becoming a true problem. Initialize ret to 0 in the default case right
before the BUILD_BUG to silence all of these warnings.

Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/include/asm/percpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 9234013e759e..21a81b59a0cc 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -96,6 +96,7 @@ static inline unsigned long __percpu_##op(void *ptr,			\
 		: [val] "Ir" (val));					\
 		break;							\
 	default:							\
+		ret = 0;						\
 		BUILD_BUG();						\
 	}								\
 									\
@@ -125,6 +126,7 @@ static inline unsigned long __percpu_read(void *ptr, int size)
 		ret = READ_ONCE(*(u64 *)ptr);
 		break;
 	default:
+		ret = 0;
 		BUILD_BUG();
 	}
 
@@ -194,6 +196,7 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
 		: [val] "r" (val));
 		break;
 	default:
+		ret = 0;
 		BUILD_BUG();
 	}
 
-- 
2.19.0

