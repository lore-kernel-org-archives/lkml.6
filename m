Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5267EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A282086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5gHqgZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A282086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbeKNBHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:07:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35525 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbeKNBHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:07:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so5829256pgu.2;
        Tue, 13 Nov 2018 07:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=LrFT96nQO7JoOz7xbcIC7WLL1z5MWl1lCYpeDUFRRNM=;
        b=I5gHqgZtzODbxkBbApY9DEZOtbF2vrG7DknCDUxdB7NaiIXn55xD/hdAIHQLCaY3Lx
         4Tz3s+sC5dsGqUMVWnw4G1VAbpskTz4sd8up+tVYEW9X9XVwdZp/OqBQ1FyRuJgWPLGE
         W3CqGuHT5BGecl2C1j/HSli89UDunaGF/5NEyyGLiBrR0ceGsAlM/PLd+GEBxugNs88f
         jYRyMTEwCy243KrLczeCCVWm6oQPfMFAlVAHVmnCdUEsYZK4RZtnbvfSwzInMaoC3JnZ
         7R9DFya/AKTOtzI4hTt/a9IHKOGVtVzRxNuULaTI06c7PrwQciURTgdvdKyMgEjOI0mY
         LSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=LrFT96nQO7JoOz7xbcIC7WLL1z5MWl1lCYpeDUFRRNM=;
        b=BY/uSa/57eudXSGzWMxxralkt+2YgTKYhCrYFhrpF2Z/w1Ow7GDxZ8BGkG7Sf3idXd
         et2grcBSg2HalQFTnEptK70eYUCF4pmvqDWeWnIHVmmrEJaqitP28PakElL+ITM2uGc9
         TKu9rDzAm4YiTFTApa+ByWJ/BbXZRPmXSWWqPGLCTYIawf/WpqDdIKfHheJKjBUNc78P
         a8AUUbIRlHyNfT03Un2PC8Z7BNH/OGWQLP9iyVVO7bLfIVKiiafIn4vcDCOYhyTgOzDA
         neePfyaLp4nQGQlcGmH4b6s/gNF2bhxyDeCBffoTQBSKWuYgmvA8BZGiHMXwU2UB/KvT
         1c1Q==
X-Gm-Message-State: AGRZ1gIKKSUdvXV7omnKANNa7ZNeC27uJakfRNiZFU5gdZ/219M7sbx5
        yLT5EraCQudCpzRrcbpgAUE=
X-Google-Smtp-Source: AJdET5fJiTAPxAZrKpiPw5CCB1+4PkF2rZEpaEguRPfb9l8vDV/Ha2Ew8Ldof3yee1v6HToOvs5rcA==
X-Received: by 2002:a62:6408:: with SMTP id y8mr1381701pfb.202.1542121728917;
        Tue, 13 Nov 2018 07:08:48 -0800 (PST)
Received: from sabyasachi ([2409:4061:58b:8913:4cbf:4030:4d3c:b3ed])
        by smtp.gmail.com with ESMTPSA id y123-v6sm22546449pfg.140.2018.11.13.07.08.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 07:08:47 -0800 (PST)
Message-ID: <5beae8ff.1c69fb81.bd59a.b7fa@mx.google.com>
X-Google-Original-Message-ID: <20181113150841.GA12938@sabyasachi.linux@gmail.com>
Date:   Tue, 13 Nov 2018 20:38:41 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced vmalloc + memset with vzalloc

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/scsi/fnic/fnic_trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index 8271785..129ab27 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -468,14 +468,14 @@ int fnic_trace_buf_init(void)
 	fnic_max_trace_entries = (trace_max_pages * PAGE_SIZE)/
 					  FNIC_ENTRY_SIZE_BYTES;
 
-	fnic_trace_buf_p = (unsigned long)vmalloc((trace_max_pages * PAGE_SIZE));
+	fnic_trace_buf_p = (unsigned long)vzalloc((trace_max_pages *
+								PAGE_SIZE));
 	if (!fnic_trace_buf_p) {
 		printk(KERN_ERR PFX "Failed to allocate memory "
 				  "for fnic_trace_buf_p\n");
 		err = -ENOMEM;
 		goto err_fnic_trace_buf_init;
 	}
-	memset((void *)fnic_trace_buf_p, 0, (trace_max_pages * PAGE_SIZE));
 
 	fnic_trace_entries.page_offset =
 		vmalloc(array_size(fnic_max_trace_entries,
-- 
2.7.4

