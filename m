Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5157C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC2420842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="JPT2SYaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC2420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeIZU3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:29:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36227 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeIZU3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:29:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10-v6so4057907wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WIumTALDyRogYEoP1QrbXd8riZBSOvTxtsNvDZrDYv4=;
        b=JPT2SYaGDJQAdW8qCCI8Q9jEFGBDA7j4NZjDU8Ytj4xtkDL2e1US6yb833ZTNryyV4
         uZGZ+6YCeZTD1TRG/8K8lBpIULoeZLsTrqhMbwD9dvqiIHm98yL/J6Hu6R9k3FPfmQ7N
         ZY4RIAESLsO/WCcw3axTQD6eoa4KrPViyEVRHBFUM2Gjos3zzcaBLCVwD423Drsq8ca4
         8TDBM1FvCGsAg2mG1+DhAICJjritQCkds3oMx40HBpUmt1v3pslJqcdtnZ+oR94Wab+a
         XwDVHlbIEmgZbmD7373qqUN38XqiKhW6vwzUrtQoLr9rHjvM4CcMxtarAfLdvPAMx1fv
         cwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WIumTALDyRogYEoP1QrbXd8riZBSOvTxtsNvDZrDYv4=;
        b=hP6zS3bndxCN+iSpkTbZ8sw+MC3noP6UCgUTu/psCACQsCSHDeG8zYAA+foEctjeKq
         Gw2/ZnHXrNL0URATmRoIARkPSKrD4fZd0qinTtpXmOWjqcTxHjiUhuQu6tWNWdTBHZSu
         5RLftQGETxqf1REppwJj1VS7twSqZZeZCDSPeJ0Y8Vs1ydQB0N6+rJB3yC/066kR0GsQ
         we8GhyoQjQlMO8VuwVrpiL11KA5A2e+dAvrwy8VbQDSbSD5r6zVjNyRIldReTyIszH3s
         vNEi+lUgJVhQ2VY1Iy4bLWtgYvYUfWZzYVDdgQNcUQRSgJ3TKfumbHuzKnW6TEnFei8x
         adcA==
X-Gm-Message-State: ABuFfogs0G5b9ISxMYBL4hmFmjiqGB5OLEJi0XC4nDnJtVnH0tM5jRTY
        UFxxlQvoYuexD/VqgjGgntaMh4BquAA=
X-Google-Smtp-Source: ACcGV63JBvBhzRrchGh00HoU/kPbi+4bQVav5r7+LM+7yEQCkh1hCU6oJznr8QyUO08fcrTgJzwtAQ==
X-Received: by 2002:adf:ef47:: with SMTP id c7-v6mr5262742wrp.182.1537971397006;
        Wed, 26 Sep 2018 07:16:37 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id v14-v6sm3209974wmh.41.2018.09.26.07.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:16:36 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/6] lib/scatterlist: Skip requesting zeroed allocations in sgl_alloc_order
Date:   Wed, 26 Sep 2018 15:16:22 +0100
Message-Id: <20180926141625.17727-4-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

sg_init_table will clear the allocated block so requesting zeroed memory
from the allocator is redundant.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 lib/scatterlist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 23e53dce897d..3cc01cd82242 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -495,8 +495,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 			return NULL;
 		nalloc++;
 	}
-	sgl = kmalloc_array(nalloc, sizeof(struct scatterlist),
-			    (gfp & ~GFP_DMA) | __GFP_ZERO);
+	sgl = kmalloc_array(nalloc, sizeof(struct scatterlist), gfp & ~GFP_DMA);
 	if (!sgl)
 		return NULL;
 
-- 
2.17.1

