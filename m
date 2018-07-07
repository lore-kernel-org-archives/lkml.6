Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0DDC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE89224D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+9pdK7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE89224D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeGGFnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 01:43:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46208 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbeGGFng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 01:43:36 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so3743005pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 22:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/1ZxHgiAk3xRN0ETasLw0aApS2qjZ6KJn/p3wIzUCVQ=;
        b=O+9pdK7hnFUM+rIVU3MY3jyxGbSTaBcfp7xXjwqx4U6Tixhr35nqr//8lzhJ2RP03F
         4p3bxaEsBJaJBf4VlxISqqiX3lm9qnmUr4Mfy3RvvvYmdL4aEVSyH90pTfHuYkan38eP
         fxhtghkFbsLbaGiCj6eNvXXxRASCHYCN2N02i4tVHzn23oaneKCTPRj3GHyqfTtwzUjp
         owRkzVTF/BifREqzReAw8QTLsY2JaE306JpCI5HuL9mB84cKFRXmFLSJstg21uoO+2sX
         596UxXTNOU59JZOjXK5+CRR7TnZ3cvYRO5qIaQJ/f3hH+DGTKmn3+95S/8LlKX5pga7Y
         nXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/1ZxHgiAk3xRN0ETasLw0aApS2qjZ6KJn/p3wIzUCVQ=;
        b=jLdqhdGjruORJt+MmFS9+QS6v6MEK7dSCGEk3J1aI8gyl2yvMxQtkfYywjD55Z/e4e
         TUhkH2PhQCgWUAn1eBOINIF0yeMME6mi4nJyxZEBJdNDFUmQILOzRtGhFJSPbEUzwMPf
         tm2Jk6DaJ4phnRwUC/2/gtbcvMILKGJv+H1wNYEfZ0hefKgauQ+O9Wq9MTIVUyx+PiBe
         Yz7XyiSu0o0Ieyrz8bdHNqpJKPm0KGENhy/2lD9PZECuQUUFUs/WaV6qn9lqcA8ZshCe
         C0+slICdwO56Mp9nRrbCasz7/N4iLfwNWN6doxyACoCEYOYDPe3amoZiAMulqPmnQZBc
         YUyA==
X-Gm-Message-State: APt69E3EzI3dno0FwyDph6vpgMQtc9IfcgDa5+SqmJELCX/R8uTzhKe8
        dgsYqf2wmbjpU/PUDH/DYlU=
X-Google-Smtp-Source: AAOMgpci5Mun2dtJc1JOAfuyj74JZdvS40FGRmNp6xYcrIHkmc4lX13Ek3VMTod47Avi4kArFKFcLg==
X-Received: by 2002:a17:902:205:: with SMTP id 5-v6mr12571043plc.301.1530942216542;
        Fri, 06 Jul 2018 22:43:36 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id t192-v6sm16505083pgc.74.2018.07.06.22.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 22:43:36 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, davem@davemloft.net
Subject: [PATCH v3 2/7] sparc: Make thread_info.h available directly
Date:   Fri,  6 Jul 2018 22:42:42 -0700
Message-Id: <20180707054247.19802-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707054247.19802-1-deepa.kernel@gmail.com>
References: <20180707054247.19802-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/compat.h was including this indirectly for
asm/compat.h dependencies.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: davem@davemloft.net
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 4eb51d2dae98..1b991cfcdd76 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -5,6 +5,8 @@
  * Architecture specific compatibility types
  */
 #include <linux/types.h>
+#include <linux/thread_info.h>
+#include <asm/thread_info.h>
 
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"sparc\0\0"
-- 
2.17.1

