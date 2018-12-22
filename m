Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF90C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A53D21A47
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJdw+V5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392596AbeLVRge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:36:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34957 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733256AbeLVRge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:36:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so7232328edx.2;
        Sat, 22 Dec 2018 09:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5rL7TeKbaZPuzNhMrikno3mjr3qr+doiTuTaBueW9ok=;
        b=fJdw+V5iI252SXQP8yXDTz9d/6aeOsuvZl2yxQ6tUprfr1CMohL1wi655dADVRjkWV
         yI/QxtTIvEvchncbbCcgyhMu4X9mFOkkR69BpVF0cH5tm6UZd+zk4UznobaPxefTbdj4
         TP9h6c6HmSfQzck3VdTvifEQuyCjDYoAyaVsxBObsWIoeMaWwy7nCja90Ww5BdmXX0wg
         Ls/br2N6rA1U2LqLFtBKBQXEdm8gJiVQrKh2n8RqtKvsmPm99J+smo/n57t7P7tNxJr6
         XAmkZ/RXEmG9s12cAOWYj1U79Hra5Gi7eH8+DYZWfTEACEAcBLgyHNQ19kKzDBgWsXB0
         Slwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5rL7TeKbaZPuzNhMrikno3mjr3qr+doiTuTaBueW9ok=;
        b=qoEzRE0iog1HEUAe+Fu68RQgdusXZJLQr6ivXuV/SmncgOqK7dhiTEWZi6nePCgn3E
         SozKlVxRENLRQh7iljAlnbJdlmRotEA5bN8y2PciQZarhnxkChGu/JaUTOYO9S/5dyTX
         01VvDuSes79AaxxOWzCeWyooh+F2Sg9BCo+jyqUC1En2dyZ2PGX3ZwghYLbx253eXQFR
         C/m9DZweQ14wXUCUBAFjYd7v6rjjwMVocpePdgeVn/K0d30c5h0BD96J5a9C1Xda6Igi
         KqKVYjtxw9n+M7Koo1Lhi4KwJO85yPfQkUOnRLSTfIk5vl0JPf1yWXa5sEi4PcjVOryh
         9zXA==
X-Gm-Message-State: AA+aEWbeV1S5ZQtbMV5d19UF3vd099Kg4yo0hPD6SRjoeHML7p5WZJl9
        5JBcMSihrYbAQpe1gV8cV27PQVmXKYM=
X-Google-Smtp-Source: AFSGD/VNy8SahFPUExNOzUx4tDlivgY1Dg1p0lq4e0t8dzb5CFWV0CCwRXg4ZawssKGrxQewbjRVqg==
X-Received: by 2002:a17:906:49c2:: with SMTP id w2-v6mr4254172ejv.117.1545473307076;
        Sat, 22 Dec 2018 02:08:27 -0800 (PST)
Received: from bebop.suse.de (189.26.183.192.dynamic.adsl.gvt.net.br. [189.26.183.192])
        by smtp.gmail.com with ESMTPSA id p21sm7311727edr.67.2018.12.22.02.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 02:08:26 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     shli@kernel.org, marcos.souza.org@gmail.com,
        linux-raid@vger.kernel.org
Subject: [PATCH] drivers/md.c: Make bio_alloc_mddev return bio_alloc_bioset
Date:   Sat, 22 Dec 2018 08:08:45 -0200
Message-Id: <20181222100845.566772-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bio_alloc_bioset return a bio pointer or NULL, so we can avoid storing
the returned data into a new variable.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/md/md.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fc488cb30a94..42e018f014cb 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -207,15 +207,10 @@ static bool create_on_open = true;
 struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
 			    struct mddev *mddev)
 {
-	struct bio *b;
-
 	if (!mddev || !bioset_initialized(&mddev->bio_set))
 		return bio_alloc(gfp_mask, nr_iovecs);
 
-	b = bio_alloc_bioset(gfp_mask, nr_iovecs, &mddev->bio_set);
-	if (!b)
-		return NULL;
-	return b;
+	return bio_alloc_bioset(gfp_mask, nr_iovecs, &mddev->bio_set);
 }
 EXPORT_SYMBOL_GPL(bio_alloc_mddev);
 
-- 
2.16.4

