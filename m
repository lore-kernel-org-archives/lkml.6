Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D44C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2DE20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="nwX8goWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2DE20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbeKEVqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:46:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36553 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbeKEVqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:46:21 -0500
Received: by mail-ed1-f67.google.com with SMTP id x2-v6so7326018eds.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YuGGm/kvIUR64EfEJF8Xc35VgZELoo5NN5dE/gXYmfQ=;
        b=nwX8goWLq3/PU7hl5yIl5XCHNBeAuz+lAhtBRv3n/duhlL1+pQF+6w4xp1o1bstrSr
         iFQs5y6LnShfnER9RY0T3SHr0aq2r6/exFAvhP/oTwQ74hN4mAg9ZEE2rfufoIUnfWA/
         chNDlQVKoWqmQERj/b3Q8dTOSD7YYAm/FSqMTzH7XTEDDFPWqqG5Ls1KxXTERq3jDxZb
         kNhOSu6nDojy5kY61oNDFdzZRFmVGNsAqsZFFOaimaTCoyHrRh3xDC0l7pOpUuNucImK
         q10tR9ybWG4Gik/F0uaJp8cy8UMLveIu1LtodB0bE/Zz1h4pLzELOk87oxDuKkSZMnJV
         po+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YuGGm/kvIUR64EfEJF8Xc35VgZELoo5NN5dE/gXYmfQ=;
        b=slodq5I3prWp+2kt7j7rxiXnwcmknskkLGqVG0R3hUWqB0yHZ77u+YwRTC54HPjN46
         1dPkTRG++XPGC3+Fgkqyf7pt3J1VQd9epxOlvXlfFOh3benzq6n04+9Zbu4GUvBofWk8
         k6DcTUZp90bIgIOHJpXVc30p2RZo0ybjWMAJEt4Bz9M3QUoTEHOOCsiW3kaz8956Ul+n
         JiINSdjL7S51dAjnyQafAGbaWgyt7ecaAYEJBrVXbmfxWPbPZ3jBf6RO3eVzNzLn7OwS
         +XLL3S2jffIEOxnj85XkozHgfe6Mjx7ijZ/74NfFOesMOPEjxDDbhdUmMjgKa1M7RPYG
         uj6w==
X-Gm-Message-State: AGRZ1gJNbs9LDofcxQ1gut3UZT8gGqFTAvYV/xX0zUSM10XffOxuTmK8
        zImSu2/9dNX78oeEYozM9ksqhg==
X-Google-Smtp-Source: AJdET5da6wVH3UMraaSgSs5yZ++UmAaFYT79I5Gg1ALa7WyijnT/p9bIB9eMESz3iVNyu23gdbMyIQ==
X-Received: by 2002:a05:6402:170a:: with SMTP id y10mr18358000edu.45.1541420810433;
        Mon, 05 Nov 2018 04:26:50 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 9-v6sm7046056ejw.46.2018.11.05.04.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 04:26:49 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 7/7] lightnvm: pblk: remove dead code in pblk_recov_l2p
Date:   Mon,  5 Nov 2018 13:26:10 +0100
Message-Id: <20181105122610.1555-8-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

