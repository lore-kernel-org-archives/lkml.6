Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C26C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0D620842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="U7S9wRsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0D620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeIZU3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:29:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36225 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeIZU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:29:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10-v6so4057752wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7jBGSGoO9Na8wA0FYWVL2leoWtovndEd33LsU+rLxBE=;
        b=U7S9wRspREAMaon28fJboJiOjLNK9udVcFIRK2PFHKjV7IalCW82Dx5YpCP4IxrKaT
         0tWax0XVIJYN2QSyYT7m0Sf/J9WVwEGM1GJ7dFO2itsJ0hzxjyn65Q1pLkotaFc8ECql
         h7NVxTRRUWlIJW/V1uyRiNG8YG3gI3D0RpHIzCkmhbSRnwR89W8lQLP0UUtRhLp+X3yR
         sTipVOQ5x1fjm3f1wmZmkLJcfiqpYaOEAGUkkvXXxTiMntREcxpl8mXhapA0IWF8GVq5
         jchtExiFxI9SVkhAdozCp+pNhNNw1xSWAK+qBLDd3d3HoW05xKGxWRYmOOojvGGKK/sk
         aP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7jBGSGoO9Na8wA0FYWVL2leoWtovndEd33LsU+rLxBE=;
        b=sqvHizX8qUpam+HzoB2WaDj6iYuTfnPiEE58q3Dzfymtgd/ihy0TDmzZo8XCcsrulV
         ebiGo4gBgN9aJC6QQ+QrfniRpcSduf7NYyUZJCzdXyZfQYlTz6phrPVtYo/ZEelKsa3U
         +wWefmHwQftL+83S51Dh7kKcc2XVbFX33ffyzuhtir87V7DVXGREa9mLdoClx3P2HPHs
         1rToGteBIZkie6igvZ4jVUsno5msoqrVpQTpUchIcRCbrTmag1EMykT32yVI5FMYs4lu
         /UKJY5AJ33N1rUjQYfuUQ1yDYe3u1r/sQ0Qq+vlvnhMQGeK3D///0itpqN8xfXFrusjD
         LqTg==
X-Gm-Message-State: ABuFfohY131FpUPleERID2FBoB0KaI7Oz9Kr3O9U/nh5zZm1ix0UqDQ8
        xLhl9jYZgF/xin25Vmjj805VrDZEgUs=
X-Google-Smtp-Source: ACcGV638nGgWoK8ap8K3k8aBxXY+rNuBSm6iAr4ZaALAFQmp3ihU46l/ibIJnskcu/mYJJkEHykiew==
X-Received: by 2002:adf:e409:: with SMTP id g9-v6mr5070699wrm.96.1537971395044;
        Wed, 26 Sep 2018 07:16:35 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id v14-v6sm3209974wmh.41.2018.09.26.07.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:16:34 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] lib/scatterlist: Use natural long for sgl_alloc(_order) length parameter
Date:   Wed, 26 Sep 2018 15:16:20 +0100
Message-Id: <20180926141625.17727-2-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

None of the callers need unsinged long long (they either pass in an int,
u32, or size_t) so it is not required to burden the 32-bit builds with an
overspecified length parameter.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 include/linux/scatterlist.h |  8 ++++----
 lib/scatterlist.c           | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 093aa57120b0..bdede25901b5 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -280,10 +280,10 @@ int sg_alloc_table_from_pages(struct sg_table *sgt, struct page **pages,
 			      unsigned long size, gfp_t gfp_mask);
 
 #ifdef CONFIG_SGL_ALLOC
-struct scatterlist *sgl_alloc_order(unsigned long long length,
-				    unsigned int order, bool chainable,
-				    gfp_t gfp, unsigned int *nent_p);
-struct scatterlist *sgl_alloc(unsigned long long length, gfp_t gfp,
+struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
+				    bool chainable, gfp_t gfp,
+				    unsigned int *nent_p);
+struct scatterlist *sgl_alloc(unsigned long length, gfp_t gfp,
 			      unsigned int *nent_p);
 void sgl_free_n_order(struct scatterlist *sgl, int nents, int order);
 void sgl_free_order(struct scatterlist *sgl, int order);
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 7c6096a71704..014018f90e28 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -475,9 +475,9 @@ EXPORT_SYMBOL(sg_alloc_table_from_pages);
  *
  * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
  */
-struct scatterlist *sgl_alloc_order(unsigned long long length,
-				    unsigned int order, bool chainable,
-				    gfp_t gfp, unsigned int *nent_p)
+struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
+				    bool chainable, gfp_t gfp,
+				    unsigned int *nent_p)
 {
 	struct scatterlist *sgl, *sg;
 	struct page *page;
@@ -514,7 +514,7 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
 		length -= elem_len;
 		sg = sg_next(sg);
 	}
-	WARN_ONCE(length, "length = %lld\n", length);
+	WARN_ONCE(length, "length = %ld\n", length);
 	if (nent_p)
 		*nent_p = nent;
 	return sgl;
@@ -529,7 +529,7 @@ EXPORT_SYMBOL(sgl_alloc_order);
  *
  * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
  */
-struct scatterlist *sgl_alloc(unsigned long long length, gfp_t gfp,
+struct scatterlist *sgl_alloc(unsigned long length, gfp_t gfp,
 			      unsigned int *nent_p)
 {
 	return sgl_alloc_order(length, 0, false, gfp, nent_p);
-- 
2.17.1

