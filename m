Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FCCC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF6C21531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxGfdy68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF6C21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeHTSi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:38:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34964 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:38:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so14334929wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/tPhnI6SyktAtmSAOFq+CgJ3FbUuJxfP+9dl1iG6bzc=;
        b=WxGfdy689LklJaisnlvbuuatiD1Uq9HSSa+QZITN1jIVoLuAOgDeUtpw+RlYL5p5cj
         UYYimIJHplC4uOrcE0DtYuoFJd8Qq3ldVyDm3a+anaKN6Pmc5k0h+6H3AcQjXIzg1WJr
         7JjKhbczoRtdAizXdad5SeIGVqAdxX6HL1DvJ1rwY2t2liZVy4cmxa2UGyxII1WGCZpc
         LeJqyjlCy2zrwEHVhh7oWP+bV4JCu0QLSYXwgmswP3sH85nTviC+u6A1GghAbuCeozKZ
         ZXXGLwohZtUaEbvFF18XRvPIN2bXmOmoWiX5NgqmHJxZO+qTnWeQN7zybls6oJA2UUMU
         ikXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/tPhnI6SyktAtmSAOFq+CgJ3FbUuJxfP+9dl1iG6bzc=;
        b=BoJbZnpR1RPPv/6NcUaLcfL3JScsB82eP7sGVCeU4Ps0ILbi4ZMQeKXiXMLPrHxn0i
         oC4yfTLATxTU6rRn/VXhtzR+CsS2huVWU+HwUA4jCX3c23pRqkXhUdpVKCL6UnK2Ubb+
         R/oUY9TOvKtwlh4NxaTvD53eIiDzUC2sjyNfgqawR7F1uZ859/EGMBQX/Dhter9aLj1H
         ZsM53K7rx9+gLOKJBlX57B1E9pGi3z1oVCW+lKjMT2Zr4arStR+/a99MBmmO5I/A185W
         F7lztzMIjIVt+86BKpYj0fpDRnCuUT1ZXSn7gfJ5T/25QLXsi6+CP5HITF79EoW+N1ae
         /aMA==
X-Gm-Message-State: AOUpUlHcW/dh8y3mH0k/9VLwFHtENWkCHUyzBGJlgiGS1CjvL9U0xXcf
        HR1lk7fe456fUifFmg6uh3X4fUtC
X-Google-Smtp-Source: AA+uWPzK5HG9c3J+JTmk7Go3jh5/7rG8K6n7NcBgtSrb3G6teThJqt/czu91YXC9gTzWtsKnhGRCfw==
X-Received: by 2002:a1c:3545:: with SMTP id c66-v6mr26561353wma.120.1534778543854;
        Mon, 20 Aug 2018 08:22:23 -0700 (PDT)
Received: from localhost.localdomain.com (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id d22-v6sm5571653wra.80.2018.08.20.08.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 08:22:23 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH] x86, asm: Use CC_SET()/CC_OUT() for __cmpxchg_double
Date:   Mon, 20 Aug 2018 17:22:16 +0200
Message-Id: <20180820152216.9447-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove open-coded uses of set instructions to use CC_SET()/CC_OUT() for __cmpxchg_double.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/cmpxchg.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index a55d79b233d3..bfb85e5844ab 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -242,10 +242,12 @@ extern void __add_wrong_size(void)
 	BUILD_BUG_ON(sizeof(*(p2)) != sizeof(long));			\
 	VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));		\
 	VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));	\
-	asm volatile(pfx "cmpxchg%c4b %2; sete %0"			\
-		     : "=a" (__ret), "+d" (__old2),			\
-		       "+m" (*(p1)), "+m" (*(p2))			\
-		     : "i" (2 * sizeof(long)), "a" (__old1),		\
+	asm volatile(pfx "cmpxchg%c5b %1"				\
+		     CC_SET(e)						\
+		     : CC_OUT(e) (__ret),				\
+		       "+m" (*(p1)), "+m" (*(p2)),			\
+		       "+a" (__old1), "+d" (__old2)			\
+		     : "i" (2 * sizeof(long)),				\
 		       "b" (__new1), "c" (__new2));			\
 	__ret;								\
 })
-- 
2.17.1

