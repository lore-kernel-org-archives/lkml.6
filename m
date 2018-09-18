Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BDFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B81F21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnR8I1gA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B81F21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeIRSiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:38:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46283 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRSiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:38:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so985613pfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1a2U8BQyEsSn6l+/bDVwsJsFBUD0QbFEgCGuHrWLnvs=;
        b=fnR8I1gA1EPSGC1lvkpmWe4zOlwZHLP0d04yWx2pgwOfaU38xk8USRgo5Q6tgKFR5y
         SG1A9oPA1BxoYQyVTco3Om+hp6FZJDxfG8+UERF5/Yc6ebjHSZpC633Ss0aB8LF9pUVQ
         5VKFQwuFCNRKlMv21v+usQMA+1ouHSKJu8b5Hefm8c5F7r2nWO5vIB3x6qFjqjDLru8+
         txMhFpTo8CHSDwOpTq9/WLupQTx6D2iyOeiuoVyHnu2rARMEUuoGsRybXbU5KyxrFH/o
         ueE0uMumEbrMKIqTAymQcS+jXedJK4cW++O+ufvAOH+4diz/oET5fWxMUVNT8e6YvuTu
         i90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1a2U8BQyEsSn6l+/bDVwsJsFBUD0QbFEgCGuHrWLnvs=;
        b=ba6d5GquJ2KMOutQf6YNpWJLIamhVbHDG1BT82RHEx3VtGtWIYNQSksWXwfFtOFuVQ
         p53UeKunsu2LHcpFtgUWV111pk0hkVCZCrS3smjbrgoH3k855M0rKSynsnZTf+Nhuciv
         zjVGfv/KrKTy72EcRnm7RKwlGKXByI4yaxTSNgSHMNrz8qt7ou7HeV0puRcwKq4OHuGV
         CjNSCeo1cSapTiEnHcPFOFc7k845AvhcsL6wbaFYUhb0VxAtQCSPXLUojLcrjo5K9BnK
         XCjrrLyPdfNHrUe3mSUMh+BN+ejQIMW22X818UvdWnHaWBdww4k0fvFrfOS9ofqRnnJr
         rIfw==
X-Gm-Message-State: APzg51AyhfRbohr+JjkcVAv99CeONvAymmSXlA0oEnFDd9bMxcQY6fyX
        l7QbPykrF9/GfsfMMpXa6WY=
X-Google-Smtp-Source: ANB0VdangKKK9EqYVo4mMUaDuI7dMJg6LQ0knWkt++VlG8L9Y0DICVEhAB2Ir/hFEMUJ8CEpO4uI/Q==
X-Received: by 2002:a63:3dc6:: with SMTP id k189-v6mr27735061pga.191.1537275953136;
        Tue, 18 Sep 2018 06:05:53 -0700 (PDT)
Received: from localhost (27-32-189-129.static.tpgi.com.au. [27.32.189.129])
        by smtp.gmail.com with ESMTPSA id l6-v6sm25142198pfl.169.2018.09.18.06.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 06:05:52 -0700 (PDT)
From:   Andrew Worsley <amworsley@gmail.com>
To:     Artem Bityutskiy <dedekind1@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org (open list:UNSORTED BLOCK IMAGES (UBI)),
        linux-kernel@vger.kernel.org (open list)
Cc:     Andrew Worsley <amworsley@gmail.com>
Subject: [PATCH] Round UBI average erase count up to next integer
Date:   Tue, 18 Sep 2018 23:05:21 +1000
Message-Id: <20180918130521.22880-2-amworsley@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180918130521.22880-1-amworsley@gmail.com>
References: <20180918130521.22880-1-amworsley@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a slightly larger than average EC so these PEBs will be
reinitialised with erase counts that make them less likely to
be reused than other (perhaps less worn or error-prone) PEBs

We have more frequent ECC failures on reads of page 0 of some PEBs
which manifest itself commonly during ubiattach. We believe this is due to
"program disturb" and want those PEB to be re-used later than average.

Signed-off-by: Andrew Worsley <amworsley@gmail.com>
---
 drivers/mtd/ubi/attach.c  | 2 +-
 drivers/mtd/ubi/fastmap.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index 93ceea4f27d5..f97e2ba56fb2 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -1414,7 +1414,7 @@ static int scan_all(struct ubi_device *ubi, struct ubi_attach_info *ai,
 
 	/* Calculate mean erase counter */
 	if (ai->ec_count)
-		ai->mean_ec = div_u64(ai->ec_sum, ai->ec_count);
+		ai->mean_ec = div_u64(ai->ec_sum+ai->ec_count-1, ai->ec_count);
 
 	err = late_analysis(ubi, ai);
 	if (err)
diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 462526a10537..91e513788f38 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -684,7 +684,7 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 			be32_to_cpu(fmec->ec), 1);
 	}
 
-	ai->mean_ec = div_u64(ai->ec_sum, ai->ec_count);
+	ai->mean_ec = div_u64(ai->ec_sum+ai->ec_count-1, ai->ec_count);
 	ai->bad_peb_count = be32_to_cpu(fmhdr->bad_peb_count);
 
 	/* Iterate over all volumes and read their EBA table */
-- 
2.11.0

