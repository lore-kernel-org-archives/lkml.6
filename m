Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5882CC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272D82086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/7psQnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfBBPfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:35:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35153 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfBBPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:35:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so4785558plo.2;
        Sat, 02 Feb 2019 07:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nMJW8bDTxPcPIJ2T8+2A8pdItA3MVUSjynKWNU3ZF9s=;
        b=d/7psQnNs+wH73S+53c9tPIWCg2Oi4MLY0RwuBuTqtsD1zMgd9Gp2zcIQVt6kNuFqi
         CytY4WHlss/t4aLmSsAEH+kqPro8YTD61arwAe1pCoE9Dxw3jD3yz0YmQf8CiUYkNj2K
         LdmFTTG8fqENRulw/czztRBXZIrk2+XYUt7qt0w3jmU7Q7KygzyMWddXdB+syukP1b9Q
         BwRt3luiwbp6guuS55ZjdlxxedKArkyf23BZgTXU8VdnJUl/H6/n9h7Hb3lhixuuyLyo
         QDrWkoqXoOZMx803S5cVlhQfmOLd0bZ787n8Ke7jwxxZqkGW5ljxKRyqRM83AoiMZ3kB
         xJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nMJW8bDTxPcPIJ2T8+2A8pdItA3MVUSjynKWNU3ZF9s=;
        b=Bgas1z7X4G08/BRYVnJJZ8XZzCYry8agiepRyqcoKq9vXwfVecKP5MhDMfMgn6dADV
         HgOj72o18HZXK1Z9RxWnxvWKj5Yz4mgU0yG6syi8Cs1ljCGI5BtvogSjvgGUqRgZPZ8o
         l8xi6d/X4ef9glWB+47E2/Quvo1839+JvG9qWGH73VDWcTHRq01h6+SIOygBhv5S+ZSU
         VVI4NlD0b0cguBXFarFHy+AauOVEM0FAFSz3m+45JVo1VWuRM/qpNdy7YCbIoeo12xlK
         mjV5mhI6iViBjnGfDwK/KMcjb/AwevX7uoIg8wKMtNyp/48WyVZJVmMVjXVpAAw2z1dy
         HO3g==
X-Gm-Message-State: AJcUukcOgu6PnErjvlu9cP0NnCw/GmeduFyAS6q3tkR6sUYaB41KNxOl
        WVwYgLVvWO7M6XzF7rdGgWo=
X-Google-Smtp-Source: ALg8bN5K6Ldmwcim25bTutk5eDEZ8JttpCuJpXO+Y4Fkyj1uGDQsNxvABampVOoWaXQoqyuZdMYUWw==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr42706841pla.252.1549121737673;
        Sat, 02 Feb 2019 07:35:37 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id m20sm16221611pgb.56.2019.02.02.07.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:35:37 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        sparclinux@vger.kernel.org
Subject: [PATCH net-next v5 05/12] arch: sparc: Override struct __kernel_old_timeval
Date:   Sat,  2 Feb 2019 07:34:47 -0800
Message-Id: <20190202153454.7121-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202153454.7121-1-deepa.kernel@gmail.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct __kernel_old_timeval is supposed to have the same
layout as struct timeval. But, it was inadvarently missed
that __kernel_suseconds has a different definition for
sparc64.
Provide an asm-specific override that fixes it.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/uapi/asm/posix_types.h | 10 ++++++++++
 include/uapi/linux/time.h                 |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/sparc/include/uapi/asm/posix_types.h b/arch/sparc/include/uapi/asm/posix_types.h
index fec499d6efb7..f139e0048628 100644
--- a/arch/sparc/include/uapi/asm/posix_types.h
+++ b/arch/sparc/include/uapi/asm/posix_types.h
@@ -19,6 +19,16 @@ typedef unsigned short         __kernel_old_gid_t;
 typedef int		       __kernel_suseconds_t;
 #define __kernel_suseconds_t __kernel_suseconds_t
 
+typedef long		__kernel_long_t;
+typedef unsigned long	__kernel_ulong_t;
+#define __kernel_long_t __kernel_long_t
+
+struct __kernel_old_timeval {
+	__kernel_long_t tv_sec;
+	__kernel_suseconds_t tv_usec;
+};
+#define __kernel_old_timeval __kernel_old_timeval
+
 #else
 /* sparc 32 bit */
 
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 6b56a2208be7..04d5587f30d3 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -63,10 +63,12 @@ struct __kernel_itimerspec {
  * here, this is probably because it is not y2038 safe and needs to
  * be changed to use another interface.
  */
+#ifndef __kernel_old_timeval
 struct __kernel_old_timeval {
 	__kernel_long_t tv_sec;
 	__kernel_long_t tv_usec;
 };
+#endif
 
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
-- 
2.17.1

