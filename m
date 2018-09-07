Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C95C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FEC2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi+D+/qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FEC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeIGWwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:52:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37656 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIGWwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:52:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so12996864ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F9DaonvEapl6YnvqzHacv5ImpGQxDeye4uIerD81AMI=;
        b=Fi+D+/qfmMWDcgBzAYimV5Y29P0squZ3TNNPZy2QsMLNci/FRfYrCDhS25iD1rYOLa
         bViX/JnfA1NCa2zKOtmpsDAdRO9veEqjrygac1JVQ6ByDl4ichAIwYvG+fRY3wyx39pG
         595nppdmZtLvAGI+NPefoXO6B7vwkhmzKtQ3Y+E+1IulPFa+c8yO7KX+2VAqjL94vGU3
         WW9EUiNCMSnQg20ellMt5ALTtDEx2sHEKC7FX4H1vyoFrZDMlLegAW9c5rnaFAF4kCre
         GOi5+cs8+6d5HybPTTnrXy8aQ4IpwotVzigancqCnUQ44Ccpa/t7ULmwx8O9sFqL8q90
         f/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F9DaonvEapl6YnvqzHacv5ImpGQxDeye4uIerD81AMI=;
        b=hjk2Mnc5nql4sLsI3HG6yGSxLeRKOBNZNP4Ai4TFs6IqlR/P8Pw5myRYfqWdDk1pYK
         gT98fGs/6PV1IHuK/d7YFxZ8BTavBFH1O5UFEyaeNsuk7imduWdGcZ8jY4bOgAPeAfrE
         qKdgzneLJVYTAPnz9qEsmwq7dqmVPTyXgYbl1vqnloHsbn2lWfCfeGgtWKVkL0VPcvDa
         igrRJSxWD11XSOhKlmUCkFph7gMWs+AyB4bMHVRWHNXKbip7mXb4PJBzHnOYPBjZOjUZ
         A1cwb3ZnDedNDcuPmDHAeXubvSh7EOhcFZ/maGrU9jvMHiTnt0ykhC0rW0atPN8Nx+g6
         BEvw==
X-Gm-Message-State: APzg51BeF3fHLmg1Un2yT+/WB0l/psXvcXwbqidE/SpEw7R6MAp/ilCN
        h/6C8bjNRn0+5bDQr98u3MLGlsf732o=
X-Google-Smtp-Source: ANB0VdZ30thomy/lrOkzwsn6dgsPFOLavg57KYdfI0QJo3fvY6+StyK4stXnxxL7rPYWheGWgUVypg==
X-Received: by 2002:a2e:5719:: with SMTP id l25-v6mr5551804ljb.125.1536343846335;
        Fri, 07 Sep 2018 11:10:46 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id f74-v6sm1396307lfg.61.2018.09.07.11.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:10:45 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        zijun_hu <zijun_hu@htc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] mm: percpu: remove unnecessary unlikely()
Date:   Fri,  7 Sep 2018 21:10:35 +0300
Message-Id: <20180907181035.1662-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Acked-by: Dennis Zhou <dennisszhou@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: zijun_hu <zijun_hu@htc.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index a749d4d96e3e..f5c2796fe63e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2588,7 +2588,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 	BUG_ON(ai->nr_groups != 1);
 	upa = ai->alloc_size/ai->unit_size;
 	nr_g0_units = roundup(num_possible_cpus(), upa);
-	if (unlikely(WARN_ON(ai->groups[0].nr_units != nr_g0_units))) {
+	if (WARN_ON(ai->groups[0].nr_units != nr_g0_units)) {
 		pcpu_free_alloc_info(ai);
 		return -EINVAL;
 	}
-- 
2.17.1

