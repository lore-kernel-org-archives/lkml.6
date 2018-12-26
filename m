Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EAAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D912171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="oCQPHEd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeLZSKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 13:10:08 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49118 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeLZSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 13:10:07 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 7A0B0BC3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 18:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lb8iLRg8ZuCd for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 12:10:06 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 50D85B11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 12:10:06 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id t13so14566045ioi.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 10:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Mjkli9qEz3XfIBVSkjFrEei2gi2+0gsWC4P+mtUqZuE=;
        b=oCQPHEd8KXwAYC35UO7b9tYfMwYvWLyOk7+DO08nXRDT2JzjXrJZKbYrl8A/sYxacx
         zqiMTBukE5C/XiEjHeuf7Lj6Q5pqU7F1i0sr9SsoJVkaQ1Yf43CudIZppkl3gVmjxv9U
         kaQc2ji7cTq4z2f16FRgR1HhDQxXdDunW7HRhBVBm09jNB7WMuHh5y52C7iSos+cv3nL
         AcS3BNpMnU8gBI09D8BDcC88zAknZvunFm5o2s2K3ntkXmeW5pTbW2dSIao6RaCQurht
         XKSQp7M8dzCNEVD6zX70o7kor2nJ7m/zLrNOGyPGTuu3mBP9gUFX245h3V9LxHD64krM
         Ld0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mjkli9qEz3XfIBVSkjFrEei2gi2+0gsWC4P+mtUqZuE=;
        b=PMrwIAjE+ZfC2AX2CseanSMeXxNa2CUt0luqi7emDMRXScPGD1aPGCXyCPGtxA7L/4
         fMI6nRFPYxbk9+fTP7n0CcT4DebsH9Nza6U9aZMDqsJfIQap9hL8QVJGn9T7oK2O6XnS
         +vZma/Rv+0LiQs7aqABeBOGRx32C9SK1DJZQPF1rqtG92txp3+/IJI84GXh/h0182QrY
         /Wfl2HiLjQU2uKRaKkk3GTVgNF/e7hsP23wg/6GBBvzQpDjeQVSlj5Wk/aaZUbOfGcbf
         GfdwhJsdLxTH23lxZclUcc3goJ7qY/4wwQm2mzEiEzY65fZgJKNhaCWMD0a5BkN1L6ea
         9/VA==
X-Gm-Message-State: AJcUukf9Gp/ff26BO/ZStqJEjQ+7rL5goChzyAzVIyXclaSV4Uh9Wc5J
        3dCD5RJNTKbJkYK5S6HhwPNmOCwkz/WA6ok3Mpku9Es2xHObWJ6Soy/EmxKxkAcXRI6R1RNlbuv
        k1kRcrUfXHNAkiDyfBolRXzGdKUIG
X-Received: by 2002:a6b:e20a:: with SMTP id z10mr13160136ioc.208.1545847805932;
        Wed, 26 Dec 2018 10:10:05 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6Mx/LbAZEuxxrsrQmEXlwYL3Ik0fgxC94A6PhQ9FZepRyraomQY352CXsK4cwu9rW3wSJpFQ==
X-Received: by 2002:a6b:e20a:: with SMTP id z10mr13160124ioc.208.1545847805711;
        Wed, 26 Dec 2018 10:10:05 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id t1sm17944513iol.85.2018.12.26.10.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 10:10:05 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hmm: Warn on devres_release failure
Date:   Wed, 26 Dec 2018 12:09:04 -0600
Message-Id: <20181226180904.8193-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devres_release can return -ENOENT if the device is not freed. The fix
throws a warning consistent with other invocations.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 mm/hmm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 90c34f3d1243..b06e3f092fbf 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1183,8 +1183,12 @@ static int hmm_devmem_match(struct device *dev, void *data, void *match_data)
 
 static void hmm_devmem_pages_remove(struct hmm_devmem *devmem)
 {
-	devres_release(devmem->device, &hmm_devmem_release,
-		       &hmm_devmem_match, devmem->resource);
+	int rc;
+
+	rc = devres_release(devmem->device, &hmm_devmem_release,
+				&hmm_devmem_match, devmem->resource);
+	if (rc)
+		WARN_ON(rc);
 }
 
 /*
-- 
2.17.1

