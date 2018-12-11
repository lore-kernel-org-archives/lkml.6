Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549CAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9872087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="c1L5Ikd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9872087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeLKTSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:18:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41215 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeLKTRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so11607970lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOW9wFX34gWOAKoN5HihAA6SRqAtZzTmFquuKLMZvdM=;
        b=c1L5Ikd+EXv32Knl/Tz/CKL+UJQEeSF8PfbIDlTNRgWMLI3lP9DNhOe9noGCOjrIDN
         /oIoexjQWE6TWGM/27v2QJgbdXUcpIsCKxY4nbvcdLBkjGfzaKNvwj9ZEGEkVeRXWxIq
         TUrjZ0VxHXq3jICtKdoiQ7x2/k6qBYiwNgFhkI9NTrfChFpbmsr5nWXJX7sFmZXnhNwj
         lZ9+hqWogwn2hl2Dur0+A7jqAl7LH710+zn4WMa+OepdBuJrwG4N/SWD/55uzdEq+ijt
         86s8pX8Y8VoDxWYJEcT9ZUJ21s/zbhWuk+mS/k9P8E3zIFfmwP05xTqvG46cXD+lIy8K
         fKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOW9wFX34gWOAKoN5HihAA6SRqAtZzTmFquuKLMZvdM=;
        b=qJ6Is8Vh+wOZUaz82UQDsa1manEWRkDUCpltUpAeDGUPGV+xdJiHsOWDRxYlaLNzcr
         2ilZI9N0hWz1sRKpIgI9W5ySrZuGJOqOx857czT+zlBPjdhw5at/N43eJ5ZZipjy1UfL
         2znD+UsBG6wRnilaDf8FcG+3GKm8i0bI3FmDAyDQ8xJjQuXaCLUY5sCoG2fili9JhiXz
         3CobG4VcxpvDoQ1Ts4IgnCvX3py4X8FNKSlXlaHPALKUpWtlhDKmxb5UKXrSlG+WHNQI
         v34ykzqh0hGHCrqBylV/C1F4ff3UkxmZH/R1t7TZXNnYUDE6sh5TEVJvkGixznQJp1Gb
         KpNQ==
X-Gm-Message-State: AA+aEWYYnSOuCIrhKxkSw8TfRXXNAEDRNoiqSoVhbtTz/3mNd0B1+2eC
        J/+BNFF53258T2Zk1mFSU5fnkg==
X-Google-Smtp-Source: AFSGD/VM+oaqfcsp+kc9wHOqGjj6QFmibLugoXvHGOVErcJmL65UcCF8yEMUbqjcaKzp1iY5h1iFHA==
X-Received: by 2002:a19:94d5:: with SMTP id o82mr9557203lfk.155.1544555830462;
        Tue, 11 Dec 2018 11:17:10 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:09 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 09/21] lightnvm: pblk: fix pblk_lines_init error handling path
Date:   Tue, 11 Dec 2018 20:16:15 +0100
Message-Id: <20181211191627.15542-10-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The chunk metadata is allocated with vmalloc, so we need to use
vfree to free it.

Fixes: 090ee26fd512 ("lightnvm: use internal allocation for chunk log page")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3219f335fce9..0e37104de596 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1060,7 +1060,7 @@ static int pblk_lines_init(struct pblk *pblk)
 		pblk_line_meta_free(l_mg, &pblk->lines[i]);
 	kfree(pblk->lines);
 fail_free_chunk_meta:
-	kfree(chunk_meta);
+	vfree(chunk_meta);
 fail_free_luns:
 	kfree(pblk->luns);
 fail_free_meta:
-- 
2.17.1

