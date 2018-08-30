Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBDFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B362083C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNl6NgmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B362083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeHaCkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37400 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaCkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so8571434ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Njnb4DELLycSINkSTeBYdp4m9K7+Xl1KQVFgU0Z8DoE=;
        b=hNl6NgmPhdSmxH4tYDvMzUnSdNTGdD3CSUs95WbFopwnvDxCudlHrJT/qPgbAVHD8N
         8R2lv8knSru0Pu5QUbVCPGo7tj8tRguciT1t1e+M+655jDn4TEwN5GxTuN0nuNxqfGx5
         qX5rteBavIVadNalChjDlufXtkCiRAyfiPrsrEic2oNtLWZE7REJUYzbD+N/n73Af3et
         FKqfpaLJsI77fwJJsnApEhTqhvL53OwJM9D5N3Ev7XtFz3zirjYIhyS3Us6Q610IIjDK
         kOXJZu1RTqI7zeo6vHcY2wapicZO4/jvnxgETl55ze0YRUHFZ45otMR4Pj4YLoW1c0FJ
         yjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Njnb4DELLycSINkSTeBYdp4m9K7+Xl1KQVFgU0Z8DoE=;
        b=jEZPz/bzW/5WH4zi69OREX6GmQGxx11edgbpCmsBIhek0g60tA+JYEZhviUhIoKcU+
         Bp4KM2riq3qQa4ive20LpFOTZ/K7UQh8S2+CjKBPq/gGezOt8P7Y7nW7Q+29kifaJJr1
         7/PWQF0O2UrLt76eOmcs1z1cZJz/HmIgJ3RgHDdqUuCIKVM9OxZf/19lYkU/CdvyMM9U
         Tff+i+XZjHO2IEvAK00Aiq8vj0rzCtwcfPk5AVKVR0k4kvwB/eDDyb1GewXc63LW6ouo
         VIna7QAC3IhoFk3Ok1DpR/NVo/drUvVFw22UE3aKa+BEgrOGgIuZnCCSRTmuuOBwIQBP
         CtIg==
X-Gm-Message-State: APzg51CVSYkgoT9GcQBIoytrPqd7S60AeF7b1kavBkSjaVzzRIde29fP
        vcjjZE2SZ9VPS8HvGlKR7YOLzmS5h8M=
X-Google-Smtp-Source: ANB0VdZHP4Rgz8nnQ5mn2paEmvizQ6ST3hLsvk1N+e6TBAmTW/OeThT1FXIhsGkr651UKRcG6slDSw==
X-Received: by 2002:a2e:9198:: with SMTP id f24-v6mr8177624ljg.64.1535668546028;
        Thu, 30 Aug 2018 15:35:46 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:45 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Joe Thornber <ejt@redhat.com>, Alasdair Kergon <agk@redhat.com>
Subject: [PATCH 16/23] lvm: device mapper: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:22 +0300
Message-Id: <20180830223429.30051-17-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Joe Thornber <ejt@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
---
 drivers/md/dm-cache-policy-smq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-cache-policy-smq.c b/drivers/md/dm-cache-policy-smq.c
index 1b5b9ad9e492..b61aac00ff40 100644
--- a/drivers/md/dm-cache-policy-smq.c
+++ b/drivers/md/dm-cache-policy-smq.c
@@ -1200,7 +1200,7 @@ static void queue_demotion(struct smq_policy *mq)
 	struct policy_work work;
 	struct entry *e;
 
-	if (unlikely(WARN_ON_ONCE(!mq->migrations_allowed)))
+	if (WARN_ON_ONCE(!mq->migrations_allowed))
 		return;
 
 	e = q_peek(&mq->clean, mq->clean.nr_levels / 2, true);
-- 
2.17.1

