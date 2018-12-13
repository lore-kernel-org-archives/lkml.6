Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4574C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F4420849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Egm3leTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F4420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeLMIgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:36:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40443 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeLMIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:36:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so1410325wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 00:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D8CzV6WWzTCWf1HHBmtp+kKm2qfuYLU6yigq75L6qUw=;
        b=Egm3leTUd7iYuf/iP8q324h5tK2IpP/XkUqsVbdHS0PHMnY8rhJAod479bQid5/cgV
         EHsYsplQ4ZcUqMb8/AIXdbjDET3r33Pw+gaSl6Txikl4UMNDowXKhoOXbTnmLuKAzr2q
         L6rQsVMIv5qFW96BIoU3ZALGAg0GvzRhR5Ep0aniZuAwEUUP0BLSTEZpxDR3ATzpeJlD
         W7Gw09ms8u0vyH0i8XxnGSf45OSJyud4/zFi/YdE9a1c1fQWpo/A0Zy8t16CSluR9rEh
         yg2jheOANX/WMuFCnAwT+Gu384Us9xaHrBsmdt+nwxgf+WkxR1WKVr4zf/ukwGrh1f3x
         w2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D8CzV6WWzTCWf1HHBmtp+kKm2qfuYLU6yigq75L6qUw=;
        b=kFE+UJxnp2uY9bF2RnQAylZoPkiO3AjGqYNBz9h53ChyHAEgk0IPVAKMvHjkeggQfW
         X7Fe1lSIx2nFr1VASQEoj97KMl264KVLptkWD9zuI/f/t0f5moPix6+RaE4mVAZlaZa0
         ajbaxPQOcHG/NowriVnD/tdFiFX84tR7vFuFttT++6fBy1MmGuusGpN37GcvSmL6IVuc
         2Ks7AEG/hx1ZpBs3tLmv95XugFiobs0OThP5gahMKHIMlYxIk7c+qSesV2g8vbJPLcpR
         fFMCcHkfRfsZrX2BISDgK9eEymcvGXlldTCVlSCuirsfDuzdww5+bTkH5cZaTkPSYBAw
         P6rg==
X-Gm-Message-State: AA+aEWbZSWWq1eRMnXbgAtOuePcjaJU3+oqI+SAqL/E6/XqMXT7GEocb
        nf/eThSBDnZDG/ngy5c3PrLKPg==
X-Google-Smtp-Source: AFSGD/UGaDnDtDJ+MUUxi2ACAMIt0zl0zwM6qdzC2QnE/QqygtM6xCeYZfcKFqN4x+XB9BwGcsIyQg==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr8966925wma.47.1544690206147;
        Thu, 13 Dec 2018 00:36:46 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id e19sm1823258wrc.25.2018.12.13.00.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 00:36:45 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] crypto: document missing stats member
Date:   Thu, 13 Dec 2018 08:36:38 +0000
Message-Id: <1544690198-21993-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544690198-21993-1-git-send-email-clabbe@baylibre.com>
References: <1544690198-21993-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs adds missing member of stats documentation.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/crypto.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 9850b41e38ae..81e178fb9ed8 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -564,6 +564,13 @@ struct crypto_istat_rng {
  * @cra_destroy: internally used
  *
  * @stats: union of all possible crypto_istat_xxx structures
+ * @stats.aead:		statistics for AEAD algorithm
+ * @stats.akcipher:	statistics for akcipher algorithm
+ * @stats.cipher:	statistics for cipher algorithm
+ * @stats.compress:	statistics for compress algorithm
+ * @stats.hash:		statistics for hash algorithm
+ * @stats.rng:		statistics for rng algorithm
+ * @stats.kpp:		statistics for KPP algorithm
  *
  * The struct crypto_alg describes a generic Crypto API algorithm and is common
  * for all of the transformations. Any variable not documented here shall not
-- 
2.19.2

