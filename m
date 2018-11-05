Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C26C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370BA20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="11jtr3QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370BA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeKEVBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:01:36 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51745 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbeKEVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:01:33 -0500
Received: by mail-it1-f196.google.com with SMTP id h13so12199011itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 03:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6VkKo/gA/7rVfoOYCcmwPUmucAY3X1LV11ImaJxs6o=;
        b=11jtr3QYUGJC75M6G9/yF2SxEoJkQYw0fygbIYrunsLG5UIwZPc+gRerMD+gQXbdTD
         Am+qjFjZipPuQyffjG23RotRgKgETqXOIvp0J3tAufz1E6uMseos+IC+pwo3VDbXqZGf
         B+GYhd+faNgv3oPs/7PTh9nJLjdzAKpH/Q2HRx8uDHCOTu/Re+KNpbZnaq+rhYh7X8jK
         SDc9cduLR7oBuUg3925BlzaR5c35/nrm6v0IE1emmaZskHKMcG+juyEJ7SkmjfJGr4kI
         xTz2DRYLrUD5KqYPcnfPk2e139oEKkTUQZscKWPOLhqZNfs0jtH8/Q6z3TxyvZWHvP9f
         PXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6VkKo/gA/7rVfoOYCcmwPUmucAY3X1LV11ImaJxs6o=;
        b=MQqFwPjajkV1rLmH/BuFa70xlUMFsBv6wiLk/67sCisRNyAqeawXSQtzSG7/DLuyUw
         jRSLe/NzcK2pM5bOGOoLITMianOENt8G4OLPYuG6Jkm4sMfYhGrbY/T3KgcNIunXmrFQ
         c9q/cztDGJZfpxpAahagRqGjO624ElbX/Hj0j/QdHsOP1sS5jxBDtcaY86Hokjo2w5l+
         DNw9o5caN5+puXL5xaEzgD1NRPLdAn6yIGYj+oDaU3rJRIDjnjcFAakSVDove/OXNG5r
         m46VPoxAwCBxFRPSX/x8b3armDBCfXJTrg3Ewv32ek3TeIO3uosXMApavdtABTEUrM7o
         05fg==
X-Gm-Message-State: AGRZ1gIMmCSwsbpMaAcdkIy+tBFUHQpykogdCIolE5A6mKV6SbOsKahF
        Ae2MiA+Ho/gXSC8PBjPXOeNzmg==
X-Google-Smtp-Source: AJdET5fARmOuOai4beCJqrcljzIAFavigSNdSetlSuDFLUjc9j8oND9BqbCzq3fe2E7aMePelUF2GQ==
X-Received: by 2002:a24:2b43:: with SMTP id h64-v6mr3414946ita.115.1541418134196;
        Mon, 05 Nov 2018 03:42:14 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 186-v6sm14880824itf.11.2018.11.05.03.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 03:42:13 -0800 (PST)
From:   Hans Holmberg <hans@owltronix.com>
X-Google-Original-From: Hans Holmberg <hans.ml.holmberg@cnexlabs.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 7/7] lightnvm: pblk: remove dead code in pblk_recov_l2p
Date:   Mon,  5 Nov 2018 12:41:13 +0100
Message-Id: <20181105114113.30932-8-hans.ml.holmberg@cnexlabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
References: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.ml.holmberg@owltronix.com>

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Remove the call to pblk_line_replace_data as it returns
directly as we have not set l_mg->data_next yet.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-recovery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 0fbd30e0a587..416d9840544b 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -805,7 +805,6 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
 							&l_mg->meta_bitmap));
 		spin_unlock(&l_mg->free_lock);
-		pblk_line_replace_data(pblk);
 	} else {
 		spin_lock(&l_mg->free_lock);
 		/* Allocate next line for preparation */
-- 
2.17.1

