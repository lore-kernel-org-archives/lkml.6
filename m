Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33478C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFDC213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Gp3ABTyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfAEVVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 16:21:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46003 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfAEVVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 16:21:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so19919786pfd.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 13:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TF8DZUPrmtApW+U4qPG1tASLC2r/54NTnf6VZywr0OU=;
        b=Gp3ABTyK0wqofMcAU5zmRymlC23yRS16nI3/GoGOfbJoeo9jAK7gFkKBJiFAKR3PE8
         wZxrrCBxXfhj+k9eseH16XHX5VMZkV7Bqw0FClBYoLgCrtp/jwZ/92rkmZcVicJZRLGR
         pbdkORZriUtPy3jdA3hT4VsYDS9BCyRs4wgj0IVLaFaIel69kxikQIw8lrIHi16x8MbY
         Lv57ahuJ4e+gCUQlmcua/Whp72QAVyZKBzRdo5znpMbZsucVva9OAjBjfrC4gkjiTUoV
         VUUatLh9VHgwhilVNdZSO7/ugJjg/AK0H1n8bPOoo14E4PmKUnYVyl+cxi/rcqACijbB
         Atgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TF8DZUPrmtApW+U4qPG1tASLC2r/54NTnf6VZywr0OU=;
        b=HNO28w4DhWKkU5T7d2Ywbuwq/0TW+b1/rpMeRDKgEzp+R11X1bgg0Yjx7VUZ4oN6vs
         aH5rXID28atSmMb9viu7/UTrHYclXRk+wjZ90LhpgtbgnaXT2VOwjMxqEhG0nV0pdUcu
         ceifvJNzy2nAZsv6dgwkS6wg6PYhEQcIinT+ADZXTKUS8Wba0z9Wsn1sNR+YTun87ilS
         Fa/5ddY9yeNz1kXWmjnEUjc9M3rXFYyO4VWLj/t0ZYH9zUCeRGK4eHoHSTeU3DvvMZGy
         BQYZqHhJ8juujk1Pkl8jYkk69NNxxUHr3pgtXgH+PAwLvAMYYmuUN24QIywTyPPhnMjd
         91vQ==
X-Gm-Message-State: AJcUukeOXHY1FqKjjxP42RUc3Xn8vdVr66C284ZQ1snnwozXJeYhNVUn
        cxRWpUHgOHrw0lxcwY7Fab+f2w==
X-Google-Smtp-Source: AFSGD/VYEjbuPo61rL1Y9azGgMwanvPTVk6dvXPwnD/yw4ULrlw9jclAEFat7H2b2x0wd9IVPRaPwA==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr58400755pfn.125.1546723284749;
        Sat, 05 Jan 2019 13:21:24 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id j9sm80358474pfi.86.2019.01.05.13.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 13:21:23 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Skidanov <alexey.skidanov@intel.com>
Subject: [PATCH] lib/genalloc.c: include vmalloc.h
Date:   Sat,  5 Jan 2019 13:21:18 -0800
Message-Id: <20190105212118.61022-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes build break on most ARM/ARM64 defconfigs:

lib/genalloc.c: In function 'gen_pool_add_virt':
lib/genalloc.c:190:10: error: implicit declaration of function 'vzalloc_node'; did you mean 'kzalloc_node'?
lib/genalloc.c:190:8: warning: assignment to 'struct gen_pool_chunk *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
lib/genalloc.c: In function 'gen_pool_destroy':
lib/genalloc.c:254:3: error: implicit declaration of function 'vfree'; did you mean 'kfree'?

Fixes: 6862d2fc8185 ('lib/genalloc.c: use vzalloc_node() to allocate the bitmap')
Cc: Huang Shijie <sjhuang@iluvatar.ai>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Skidanov <alexey.skidanov@intel.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 lib/genalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index f365d71cdc774..7e85d1e37a6ea 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
 #include <linux/of_device.h>
+#include <linux/vmalloc.h>
 
 static inline size_t chunk_size(const struct gen_pool_chunk *chunk)
 {
-- 
2.11.0

