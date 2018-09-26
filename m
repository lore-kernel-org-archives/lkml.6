Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3768ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6AD20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="YV3qXhhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6AD20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIZU3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:29:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53182 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeIZU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:29:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id l7-v6so2483040wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J05zKTNn2Y/+M4Dr898zqUw6g0HICBbnSSgbu+L2HHQ=;
        b=YV3qXhhKBy4l4H8m06ErtKrlCnSUbIyTr0XuQ72d+vMzBCI5vY/uQM8N6zCjNJo2sn
         LxMmWyZuy+cnPwvwQ7pVcEG3q2LVyvMP2eSfD9Fel4jxNUtBg9yTK2KFmZF7uU4MC8/E
         GDGe7hhUCRKeeFmTk6Hp00MQv1LoqKMukqciOZRMlWgpekgWGpS8FFYeMei7ys1xH8r0
         JpEIo2rHmsyOrRhnXq+bFSDWnvQjmoLZOpnLJPkCe1jHSSV4uCL0L76ZQ2H570cbifJP
         hCWSURv6JCt/dEbnhaAIZmCd9Zg+caTAWXqhnM/ZDN071HWHYW6flSnAQg9IA5c892YE
         f/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J05zKTNn2Y/+M4Dr898zqUw6g0HICBbnSSgbu+L2HHQ=;
        b=IT5sH/xV1zsV4cbe7FdavrefBRhjXtp9+tI2V9jEom6tzlmKKXBCHW7TswO5NVlxky
         RotaBLgi2A4yxCkgn8UslcwsUuzRgKXy5C3psSpD4HUlCJHpS7B//Yw7/vDIHLZyUZIx
         N4bBTLbwPbxq8mbTHC+JW3Zeg3x3oSLDPawc9JLsfoW9GFNdP5pULR5mPMOLGp0Ws1PQ
         hPl+trm1+SeI1Fmdu4xN0NFSG3j43X+WguvM6+tLBpauTdf7c3+xb3qe+w+xyOiJaGL/
         6CfCkyudXM6he3GAGF7f7EtPbItNIrWBakQ/+RQYnyU1DKH/Cf0ZDeLhzV1wQW2Ei6F3
         rwYQ==
X-Gm-Message-State: ABuFfoghVqpo2akFZHmPOJWUzCfGvQEoVo4oGwD67oe5CJlkDXoD1qBQ
        E5DH3ni61Q67XJxefy9JtttIN6burPI=
X-Google-Smtp-Source: ACcGV60s9M/PNH/k2m1O0VS2vMgLeMeHk3ryFFXsaDDLWpnk3uCsLSeaYifG0lUiLZ/IIXtD99TJPg==
X-Received: by 2002:a1c:6543:: with SMTP id z64-v6mr4758611wmb.57.1537971399868;
        Wed, 26 Sep 2018 07:16:39 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id v14-v6sm3209974wmh.41.2018.09.26.07.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:16:39 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] lib/scatterlist: Fix overflow check in sgl_alloc_order
Date:   Wed, 26 Sep 2018 15:16:25 +0100
Message-Id: <20180926141625.17727-7-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

It is necessary to ensure types on both sides of the comparison are of the
same width. Otherwise the check overflows sooner than expect due left hand
side being an unsigned long length, and the right hand side unsigned int
number of elements multiplied by element size.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 581a2e91e515..c87243d46f10 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -485,7 +485,7 @@ struct scatterlist *sgl_alloc_order(unsigned long length, unsigned int order,
 
 	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
 	/* Check for integer overflow */
-	if (length > (nent << (PAGE_SHIFT + order)))
+	if (length > ((unsigned long)nent << (PAGE_SHIFT + order)))
 		return NULL;
 	nalloc = nent;
 	if (chainable) {
-- 
2.17.1

