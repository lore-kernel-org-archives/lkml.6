Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1BDC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6EE21908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBHGDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:03:04 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45593 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfBHGDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 01:03:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so2678482qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 22:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4J99pS820vJG8R6BMT8R5uc5unH9zi10s5KwbbGVQ8w=;
        b=dRZVO6Vt/zdYYf0B9KzyWm5pLw87kawzg4XephBVWpkiYlipjW8zlz8ayV71Lvs8FP
         FN3ChoUeAwu4rP39kmhROzVy7+HgYIHqjpwmnF70/ARofBV5QprR3/u6SBT4UXe9on1b
         ZJtvGwdv1sma9eY5DcE937RyeR+4AozkZ96cWpaqNNoTYrKhEe+lJOceoxbPq+aeZRl9
         RfuIU+kme3C8aZMusCvusx2OdlczCVpDCEulQQz/AHnX7F6rydCgsmsA8dLwGhEb9rOQ
         XvJnC4YW2jIW+l05u6OGVcbfCbRhLVx2XEd/gDlMVgYrW9o9AXmDGRQrIDcccwxaVB8j
         HPnw==
X-Gm-Message-State: AHQUAuZstmEtQ0CKVGsUC1WRazxJ9Xg85MqDtqCAMwe1Z6NytZ5r8BYu
        v9o5m+ZnKci+ASZIe6ISLje45NQ1DJ00/g==
X-Google-Smtp-Source: AHgI3IaUfH9TnFt1mis/ttpKDH7qHAxs74b4Ncs9bdwAemJnW8cCjyxCkg7otaEX2ZpNx0Y1qFSa2w==
X-Received: by 2002:ac8:5157:: with SMTP id h23mr9091612qtn.370.1549605779973;
        Thu, 07 Feb 2019 22:02:59 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id s40sm1191106qtb.83.2019.02.07.22.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 22:02:59 -0800 (PST)
Date:   Fri, 8 Feb 2019 01:02:58 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/3] drm: tweak header name
Message-ID: <20190124142448.23243-4-mst@redhat.com>
References: <20190124142448.23243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use linux/mman.h to make sure we get all mmap flags we need.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/drm/drmP.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index bdb0d5548f39..a3184416ddc5 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -57,8 +57,7 @@
 #include <linux/workqueue.h>
 #include <linux/dma-fence.h>
 #include <linux/module.h>
-
-#include <asm/mman.h>
+#include <linux/mman.h>
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
 
-- 
MST

