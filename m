Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB1DC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2141520827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="LoPTsKQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2141520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeKEVqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:46:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46256 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbeKEVqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:46:20 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8-v6so7263951edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=teEQfAz1c6m6rCPJfgLRxoSrnS8LNHIA5afev5lUxns=;
        b=LoPTsKQsAP+zS++JqKVLPkejyAxyOr3CzGAE/hrzpPdH1tTdfOqoJcqbNjTZBQ+r0j
         GX//652zX5wqDxlmpWgHMjdWU85TefPhXh2GZk9Mp02KjeauLpFlB0sEoItdBOoWtqFZ
         S+qPTV+b5EXDO2beVm6i74xjlF5zoZ15L6gbUN089hkzh416cyrukDoa4XLHpmn8FpRE
         HwHwj2muGaOBqPOEt58jPyHHuNTyDZdvde06t3l9oXagdapjDBdtB9AcwNRTgpZGpOMo
         ExRof+I0gQSQseiuLI6i3qoE5Q/TW9zhAO4NUaUs2Z8MrVR4tkSjqDLhqAzMhjoSZSiS
         mdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=teEQfAz1c6m6rCPJfgLRxoSrnS8LNHIA5afev5lUxns=;
        b=KMVVRZMAy/T9mBFHE+fop9NqMJxn90vE+fHcR4FNPjwnJUCtJDZbG3G5Xwaezq4Ino
         oGRwqwyOeFQHljT6AOVAgCczwYi6aeHqUary/HhXQfMobWN5DKB4Gltw2ZFbkCtlo4oD
         We3b/gYL6FMJi9LO2aRyuyjmQ6IuH0qt+gwz4KD/xnWx2NiioZemvvgzs5vsNrn+fL45
         PjIi/ZDbmhSk7hQpPktLi5mR43/8CaTe4Pxr3oB7Yt5D3uQ4udGiQvayL4VTzw6Wxffu
         hi8WzyX+lrjD10dWAzTlzOKtZrdVkpFwck0cJyPQ2uw3PjJXhFJUsqnhbXa2Hd7l3BI2
         gSOw==
X-Gm-Message-State: AGRZ1gIvjBERSg7HMZcFoE2C8aOHeif78DL0+0tBaNTGPkS0NCtDAvLE
        2JWDXQU8dEtlk0MwCPnGGVttOw==
X-Google-Smtp-Source: AJdET5eJP26S1glPFZkJfBv29jmXa6CW4Svf0mHNjgIHDIOihzQb9pdgyWV3WjD9EaRA5p+7oFMqbA==
X-Received: by 2002:a17:906:6411:: with SMTP id d17-v6mr13317366ejm.73.1541420808384;
        Mon, 05 Nov 2018 04:26:48 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 9-v6sm7046056ejw.46.2018.11.05.04.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 04:26:47 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 5/7] lightnvm: pblk: remove unused macro
Date:   Mon,  5 Nov 2018 13:26:08 +0100
Message-Id: <20181105122610.1555-6-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

