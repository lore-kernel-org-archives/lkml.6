Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D063320827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="LSTRXrj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D063320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbeKEVBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:01:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35330 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbeKEVBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:01:30 -0500
Received: by mail-io1-f66.google.com with SMTP id 79-v6so6245159iou.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 03:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmp5m3FdPiylEmUW8CNgXsb2BFd/kBJdIrvq/1re7hI=;
        b=LSTRXrj5POp177ymc+YCrU7HuNuRYD1E1hzkKDDAkIpXhr9DpRLmgzEDaJwFzE4SPo
         G/EyxzbR4DX0jmS4RdG4lN0CWpw2xoDvM26bhpaDM6ZJ4aw+1Mrn+PXluZp2VIRnWLhp
         4T5NFjbKhbqcNTXs2pmDbQDAI+2TFTeUxUetTfrZAG9zNPEYr92P0hmg9jcplVURpuwO
         T6hlcWcHjx+NLTJLlXK8FZZGirjTKP4cvhvgJ19BoaHOs9K5XXcJFRcFg8O9Q9rAGtsI
         5DBloKBh1EjqYGZueoEpKrwMsjE5ZYJxXFoxzieaZ9xgZF6kLQOk39rvZf1xYMTIuYMs
         WSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qmp5m3FdPiylEmUW8CNgXsb2BFd/kBJdIrvq/1re7hI=;
        b=mKDHwXKMSzdu5FT6fWuNlZtqqn3lCjJO53B/OkqLB6n4EwkBCDFuGQsGbQy9nIiqIp
         QnEQcIXEA1T/hBu0YIkJfQT4wcMnG1hgnL5hiAnJqKzlvo9zwNlOTPDRN2HsOh7yOUpu
         YULqzKWEF3aHHnYxQ8bfLCNUYV14vEkjgq/29i9xGfZOdBcW00Bi+PgtXT6ceW7z4zhI
         9AEkBRoO0L1Zji1CrenTbqGBU/HUcbSSeZPc4YVMM2oTAjjwIMICN+mNTXaewhZZntf9
         OdXERXBsgvFiLAeXoqhk421dbNpXgwwJgxvLwPN+UPY48EnV5qIARv6fnFA2ft/OTjjC
         ggAA==
X-Gm-Message-State: AGRZ1gI99zu828tZSLhZkPXMHhl7uDgquRnzp0XhmwcIVb5b6FkBGM1Z
        DeqHF2djT+vNAxx17fXDm/LFew==
X-Google-Smtp-Source: AJdET5cE78AdGuslIrBDmhDhhOGchcCfDIcOnB4C9WiEo1MnnQ/9vLKSOT2B2HJPhDcVHP4ad884Aw==
X-Received: by 2002:a6b:d50d:: with SMTP id m13-v6mr18515586iog.152.1541418130637;
        Mon, 05 Nov 2018 03:42:10 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 186-v6sm14880824itf.11.2018.11.05.03.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 03:42:10 -0800 (PST)
From:   Hans Holmberg <hans@owltronix.com>
X-Google-Original-From: Hans Holmberg <hans.ml.holmberg@cnexlabs.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 5/7] lightnvm: pblk: remove unused macro
Date:   Mon,  5 Nov 2018 12:41:11 +0100
Message-Id: <20181105114113.30932-6-hans.ml.holmberg@cnexlabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
References: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.ml.holmberg@owltronix.com>

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

ADDR_POOL_SIZE is not used anymore, so remove the define.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 8b89bb26b0f1..33c1e83327c3 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -207,9 +207,6 @@ static int pblk_rwb_init(struct pblk *pblk)
 	return pblk_rb_init(&pblk->rwb, buffer_size, threshold, geo->csecs);
 }
 
-/* Minimum pages needed within a lun */
-#define ADDR_POOL_SIZE 64
-
 static int pblk_set_addrf_12(struct pblk *pblk, struct nvm_geo *geo,
 			     struct nvm_addrf_12 *dst)
 {
-- 
2.17.1

