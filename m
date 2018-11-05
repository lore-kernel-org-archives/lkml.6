Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0805AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4C720827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="UgTp+ct+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4C720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbeKEVBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:01:33 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38431 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbeKEVBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:01:31 -0500
Received: by mail-it1-f195.google.com with SMTP id k141-v6so10272579itk.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mq2pXsxBVKjyR6ETTb+oyHYfaQtkfPqHe/RfPr8ip58=;
        b=UgTp+ct+aU5PtwaUn6O3C8Sq3F5oN6oCcmhY9THHY5jVrBd3GYIq96ufAPzeal6VHd
         KZR4ZcRc9DYtRvajRD4zU+yDLPIOYON5bD9JYxRQ/DsixzE2UlPGxOlU91PzYAHhbOPN
         +TBJq7vlEYMASC3GV0WPvYkiXk2KxJRpVto3D9SW2vXTV8Jm81IdSiYZ8raMywmJmkhM
         cdy2ECWGRj6C+MwQRtBfeHUlVfm7h/i5U6RAkDOrJ8oatsjJaTxB7cqYzDb3/8BIbX5Z
         m+MYJhv1ssWET6hgqJnHMdTS4cs/eppFpij7y3MiG9VDYGRDVd/6SfQZtG3k6fep+4Tb
         BROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mq2pXsxBVKjyR6ETTb+oyHYfaQtkfPqHe/RfPr8ip58=;
        b=lL5nAPz7s7jGbTzcvICcNVWQ5U0KeCLUf13wE/DtqXu7wdnND6B7fM72WIMYSbDaaw
         ECCaIEZjbNt3xZbVfoqBfe/xtsIqcqSPrQaeyMXPenTSXnv2BSUIe90pvyvltcGk9Gji
         vHsIwS0BD+PEv1rIxi85lzcZLuWzUvLV2k4oH4YLKyV5TPPNNPlR9K/mi8KA4ziMu1Sw
         0sAMGqT5o6aAyungWS3NWSzcaNOzj+wmGbLoZ1mxNGjJAqKWxbAVBqyghoFfVTsEWwAg
         XZpYTGHXSXiFm96arirUdb+vYOH0RRPoSnQL6VxR4EUqrR+vykcHwPVYiccrU1IXCoZ6
         SXRA==
X-Gm-Message-State: AGRZ1gISdow5qfjG3fJSxyx7jbLJT0UN2RxqdwRo+uVy51+KQssJau4e
        wWkT7dEZrscUFuNSG4/+S1vzqg==
X-Google-Smtp-Source: AJdET5cJ1rI+ft7/vUO3bvpx/k/ItUMtrMwHSZ+Go19X1/S9cXv/7cmklU8xDN77WdYuZXmDyaNj1w==
X-Received: by 2002:a02:5f96:: with SMTP id x22-v6mr20275912jad.43.1541418132408;
        Mon, 05 Nov 2018 03:42:12 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 186-v6sm14880824itf.11.2018.11.05.03.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 03:42:11 -0800 (PST)
From:   Hans Holmberg <hans@owltronix.com>
X-Google-Original-From: Hans Holmberg <hans.ml.holmberg@cnexlabs.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 6/7] lightnvm: pblk: fix pblk_lines_init error handling path
Date:   Mon,  5 Nov 2018 12:41:12 +0100
Message-Id: <20181105114113.30932-7-hans.ml.holmberg@cnexlabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
References: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.ml.holmberg@owltronix.com>

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

The chunk metadata is allocated with vmalloc, so we need to use
vfree to free it.

Fixes: 090ee26fd512 ("lightnvm: use internal allocation for chunk log page")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 33c1e83327c3..ae9686b5d521 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1053,7 +1053,7 @@ static int pblk_lines_init(struct pblk *pblk)
 		pblk_line_meta_free(l_mg, &pblk->lines[i]);
 	kfree(pblk->lines);
 fail_free_chunk_meta:
-	kfree(chunk_meta);
+	vfree(chunk_meta);
 fail_free_luns:
 	kfree(pblk->luns);
 fail_free_meta:
-- 
2.17.1

