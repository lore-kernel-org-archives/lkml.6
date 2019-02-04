Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AE2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EBA2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfBDOIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:08:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34987 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfBDOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:08:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so13723757wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 06:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+sD3PrEyub5P/0oS4H0y4P3lCicLbsdhQOJ4ExAWFI=;
        b=GN41S7DtCchXxwX7lg44Ye7ehWGwRWeNkhTOs6kjqJdscmjI2OArAKO0OJn/S8v3o4
         AqUVounbDfg7/hdOEH8OsK2x+C2PG+yjGnUkGumNv/OXb7EULchmFQAxz+HOOF4cYUmz
         s3dgGRezkbNCXKjVlGlZ2m/MFS+QpCP8Z+VvkkFiTDYTdFbwuiFrEjxQ5/Sfk7UmeIcx
         kD9ApicXFqin4spEXpMt5QtBbHjcMUt/RrDrJmvPEhXgMdcWUQSnUZDbD5BOAOWSa/d/
         wYcjPdL/CeKdIxDdxdrI1aAXH5UvXSlLPE6IFYGa/MmyyOESkqH7CF2mkz9eSCnECSxh
         eGDw==
X-Gm-Message-State: AHQUAuYVBtykW/02QosCt8m5saDLR7fRkbCGClR2zFrgNr6ILWlZrSb2
        c6Jcnz4DzB4/9FYas/CjynRY1w==
X-Google-Smtp-Source: AHgI3IavhXJ/vHqQcn+6eTI+PXQkbalPD96ap3lQnDTWlSBbaetiv15sMg/CFeVPFlousSyQbWHcsA==
X-Received: by 2002:a7b:c951:: with SMTP id i17mr14389449wml.70.1549289287457;
        Mon, 04 Feb 2019 06:08:07 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v26sm17734411wrv.78.2019.02.04.06.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 06:08:06 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH] sysfs: remove unused include of kernfs-internal.h
Date:   Mon,  4 Feb 2019 15:08:00 +0100
Message-Id: <20190204140800.28544-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This include is not needed (fs/sysfs/file.c builds just fine without
it). Remove it.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/sysfs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 52d9235e0291..130fc6fbcc03 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -17,7 +17,6 @@
 #include <linux/seq_file.h>
 
 #include "sysfs.h"
-#include "../kernfs/kernfs-internal.h"
 
 /*
  * Determine ktype->sysfs_ops for the given kernfs_node.  This function
-- 
2.20.1

