Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3A320645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0hE2nE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391539AbfAOXwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:52:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36568 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbfAOXwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:52:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so200683wmc.1;
        Tue, 15 Jan 2019 15:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGRR3uVIK4MaU+S3I1jx9NkzHUW5ABrDwkALea7IxVU=;
        b=m0hE2nE1R8cXtaBPMUC4kmJtWyIOxMoLlCfvtij6TD2/wpHIaqgsaX2hIAS8k7OX+6
         UQp6OgX+7Pzo1HipcFbdeLDhOVT7g8MHlXuGy3lhC2KzezaxzX87+7cKqcYZK+iZ9Hr4
         iFm1+4tYQ8V+EWhmgJlge0C/Sc5uJs/ckXDa5FKX2KqlL9FG0mr38eER0Bck0ZaODyyw
         mM96JMTjpZ2keLv5dkyTm/jNw7g3EDGpnw+9ERxM/wp58mh3PCcyDMNDuohxefhq+zNW
         BLzQeVa8rBfSXSIOxmjApXlgqy4F7uRar6M5qfFQOah229Q2z2+xJRYSj1C3ma5Icchd
         z9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGRR3uVIK4MaU+S3I1jx9NkzHUW5ABrDwkALea7IxVU=;
        b=kqiGvVII2JNJGsy7RfFtj264UGyMACNEdWQj/poPksJv2GSd8zlbSTQF4r3KcK5n7n
         d1hWeKoMawTVUrMr3tYR6OriL20p9xwhZb4W76aKnuuU8v4d3qfFk/ypMnX0Wkba8k/e
         TN183Uir47djDTc/Ip9R2/9UroERQwiPCBT6SF+8pwxnwFXRHT8ExZICJjtfZkavtudx
         pVBBF0ucFYuGxSuyCY8z8dCPeyv3/lG205TQICMRjuxsiSHjNR1vYpRIwahliwvU9RAg
         6r4rQytaRs7ZG2aZvPIC8yenP2pax5BWPW6o9uUAzrx3NBO44vlYLysMGcgy0VXQC0CN
         2AdQ==
X-Gm-Message-State: AJcUukfx+eNp43sKoetgrTJKfORNVFI4ya/KTMgwjhJGCrRKwTrePjtG
        ycLGftogANmFNA61f94CFrfQmNdOrnY=
X-Google-Smtp-Source: ALg8bN6wte41Xku6eYN7mDyTLmvMDVS1Au6UlgeC4FdNaTVCa97zTt6DjeX4o5A4kxGCXwPTx6iAug==
X-Received: by 2002:a1c:ae15:: with SMTP id x21mr5099654wme.146.1547596319802;
        Tue, 15 Jan 2019 15:51:59 -0800 (PST)
Received: from voyt-hp.fritz.box ([2001:16b8:a091:1400:57d5:5ac2:9f28:7c58])
        by smtp.gmail.com with ESMTPSA id a132sm42725405wmh.5.2019.01.15.15.51.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 15 Jan 2019 15:51:58 -0800 (PST)
From:   voytikd@gmail.com
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Voytik <voytikd@gmail.com>
Subject: [PATCH] scsi: be2iscsi: fix potential NULL pointer dereference
Date:   Wed, 16 Jan 2019 00:51:52 +0100
Message-Id: <20190115235152.32499-1-voytikd@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Voytik <voytikd@gmail.com>

Fix potential NULL pointer dereference wich might happen
in function beiscsi_alloc_mem() if kmalloc_array() for
mem_descr->mem_array fails and as a result deref of NULL
occurs while passing parameters to dma_free_coherent().

Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
---
 drivers/scsi/be2iscsi/be_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 74e260027c7d..7867f7d2aca7 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -2527,8 +2527,11 @@ static int beiscsi_alloc_mem(struct beiscsi_hba *phba)
 		mem_descr->size_in_bytes = phba->mem_req[i];
 		mem_descr->mem_array = kmalloc_array(j, sizeof(*mem_arr),
 						     GFP_KERNEL);
-		if (!mem_descr->mem_array)
+		if (!mem_descr->mem_array) {
+			/* mem_array must point to valid memory. */
+			mem_descr->mem_array = mem_arr_orig;
 			goto free_mem;
+		}
 
 		memcpy(mem_descr->mem_array, mem_arr_orig,
 		       sizeof(struct mem_array) * j);
-- 
2.20.1

