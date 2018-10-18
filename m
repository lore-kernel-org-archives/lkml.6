Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F582C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEC12145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdQl+5Rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEC12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeJSAIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:08:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33888 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeJSAIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:08:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id f18-v6so14538742plr.1;
        Thu, 18 Oct 2018 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=C8bE4KmkBYfe+pwepGdmrGPvLf2v2K63YsE1ZpunmkU=;
        b=ZdQl+5RgMxKKEDzH5pqiulF+KTuF6+FiFcUCNRTXp7VBLfUF8Hwe6L6lT9uaMHJxhf
         dEXvU3usXezBS5D+L2KWg3sCNiJvCMWCaYb8eLZ9zMbd2ndnsFATlNq6p5s/vs3ENeiZ
         zOdjhJFMwEB2Ik3j2iZ5NMtaqWC+OOCl5oruOzn15hpo66K2eJIRMhtwVpbjiAXpujoy
         hAA55o+VovIYnW7iXNsU99UaBKgvMdKPepsTdo3+haLXnyPXm056eX3nE1OHPKlP35QJ
         Gif7B3pyFMjLNggJbQDZnIX8cvtNRYmLR4vjjOEvyDfQhfiuwJ/eCmwMuzdzUpd3sOxH
         MEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=C8bE4KmkBYfe+pwepGdmrGPvLf2v2K63YsE1ZpunmkU=;
        b=GRTyx8ICO7Zsrg84UEVwqM4gUkrtx1ZydD9hLYN/QhewBl4AjDvoiXQhFQ4fF7hjdB
         5AmkiiB7R7GXd1n1EqBNcxbgwWeOP7dvjlEHYSPuibz2xMAYDyjrpiB/C+NL0aM+fSVQ
         S80Kxa6uymsMrn2uX1MyHPgcOsn7pwqPuDNmB9L+ykL1QMs46IpKBbB8Wu6NHRtF3U6Y
         nkIoJa/T58uBIWnne8Q4RCgOl5qLIVF0jlIoMB2w1g/rg82NIGTnPySkdnvr2Ory0T+w
         B+GAYfIn9GLSeqdzFWrSdTW2prtg6RE6MSJjuOL8A18HD/dNZERR0HLlwQ/mCWYxOVgt
         +b1g==
X-Gm-Message-State: ABuFfojSh6oOBgDlOzTSkk7akxPKOKtPQwP+g8q4wjwJwvJq/m/nNNcG
        HmxkoF6U3aum5k0Wnoy/P9M=
X-Google-Smtp-Source: ACcGV630pjfYl4TEv1vWGZyc2ZIXmM6tdYXMHfq1SdXojb3Gitrg1E2N24ANJo50Z+qL6azh6AtuDw==
X-Received: by 2002:a17:902:8646:: with SMTP id y6-v6mr30424689plt.86.1539878791156;
        Thu, 18 Oct 2018 09:06:31 -0700 (PDT)
Received: from sabyasachi ([45.116.191.237])
        by smtp.gmail.com with ESMTPSA id c24-v6sm31644508pgn.60.2018.10.18.09.06.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 09:06:29 -0700 (PDT)
Message-ID: <5bc8af85.1c69fb81.3eebc.a22b@mx.google.com>
X-Google-Original-Message-ID: <20181018160626.GA6010@sabyasachi.linux@gmail.com>
Date:   Thu, 18 Oct 2018 21:36:26 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        keescook@chromium.org, john.garry@huawei.com,
        jinpu.wang@profitbricks.com
Cc:     jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] scsi/mvsas/mv_sas.c: Use dma_pool_zalloc
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_pool_alloc + memset with dma_pool_zalloc
Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/scsi/mvsas/mv_sas.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index cff43bd..d00d37d 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -790,12 +790,11 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 	slot->n_elem = n_elem;
 	slot->slot_tag = tag;
 
-	slot->buf = dma_pool_alloc(mvi->dma_pool, GFP_ATOMIC, &slot->buf_dma);
+	slot->buf = dma_pool_zalloc(mvi->dma_pool, GFP_ATOMIC, &slot->buf_dma);
 	if (!slot->buf) {
 		rc = -ENOMEM;
 		goto err_out_tag;
 	}
-	memset(slot->buf, 0, MVS_SLOT_BUF_SZ);
 
 	tei.task = task;
 	tei.hdr = &mvi->slot[tag];
-- 
2.7.4

