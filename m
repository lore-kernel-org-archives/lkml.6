Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6BEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388C22081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="kj9Zxz7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388C22081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbeKFW7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:59:07 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38389 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388425AbeKFW7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:59:06 -0500
Received: by mail-it1-f193.google.com with SMTP id k141-v6so15766068itk.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=im8NeFbgzA6SbKu0U4oV8gAJiI5O2suBuQF856AHMAw=;
        b=kj9Zxz7GZStsQLPH3kPSTiGkZXstVtaXHmqS9oo0vKZ79ZVFZ9zAGgQgdGWLGQedVO
         9uri9OrQ5MxMyYcupktu8whM4qeV96s2qjeabX+sm/hGPpIC6UBo7B5weCk+yW8ySNds
         YbpCR0cBfgvior1wKBWRajXIm7sY+7BSB3blDSwrPGxYPSCprQCaZEhOU0JMzaSAXUEy
         apiQPPsyCTP6i8PojxYAdunsuRmN2S4WCk0oBGAeHGkbS8YFA3zg6TNnS/U1iQTvhtS0
         lkTvV+LF1rUzmCVjr/jEAqoTHu5PvEhQ5zR6DDZueo7KSY/VNj9E/V6dOmo1VHYUsh/e
         uA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=im8NeFbgzA6SbKu0U4oV8gAJiI5O2suBuQF856AHMAw=;
        b=MmL46rs8lVttQqAdeUBVsIbGJA9Iu2Hyuwf2Dxjp5Z+/gNEL2YP0R0zP0SlPQDSKNq
         gfWw7lFDm3WMEWJXJnO8xbeVmLLwHy11Qau9IBh1slvJv24I6l5dozjl0VcYEJD9vGRw
         Q2gbVRzXfFdRHF7mG/Ampx9hNyDhGmwVye5fJC2H7j2XNACaxLjQvsDfAcXwe0y3i4VZ
         erAfjX43Xe2AjgYr29Iq04Y7LPWJhGuTX/vGaJdVNzLMlhNigW19f8hRCcBKGLucqoLS
         KRFPZlemJLtL/cfGKsXBNpjZX0bNkm6/qUAUQBSQmMGhUFKFLxxL7UZxaQdPGmkQEGOd
         DGog==
X-Gm-Message-State: AGRZ1gJ7IeMxAKX70CjLcvIqlknAVUEv59SuzjpF082EiV3xLUw5CeYN
        aea2jwlyMKl3Qu6G0t5H1zSaKw==
X-Google-Smtp-Source: AJdET5eetHOQVtYnyLotcA/5StnVthdrsjDJWEwnklfzT8GX/EQltKtKjmOkiQppjmkh935c6U4z9g==
X-Received: by 2002:a24:81d7:: with SMTP id q206-v6mr1764195itd.94.1541511230985;
        Tue, 06 Nov 2018 05:33:50 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id u132-v6sm897282itb.21.2018.11.06.05.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 05:33:50 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 7/7] lightnvm: pblk: remove dead code in pblk_recov_l2p
Date:   Tue,  6 Nov 2018 14:33:30 +0100
Message-Id: <20181106133330.26570-8-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Remove the call to pblk_line_replace_data as it returns
directly because we have not set l_mg->data_next yet.

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

