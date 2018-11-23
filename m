Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC6AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D497420672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TgRdK4DL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D497420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504065AbeKWWqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:46:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33154 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504039AbeKWWqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:46:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so6476633wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hRGHdejg5JBOgjxW3k8B0GPaLm05r9sHdxdq5izdOJ8=;
        b=TgRdK4DLEyYzVpTHihkZZBMVJ/pRVEBvFIUlK1jmulrWpI1KMwKWQU3E4rsg+wm30D
         GMd2H0ER+TSCgNanVn7XXk4WXyxJQ4br6pArdjoPejQ2Yv/NaSrU6oFlQgYbn07SISYD
         WktdGSJY4v+DFOWqrWZfKhq/A81RsRjISTUWvdlVArCIJqZBuojciuaqxfsPivrFjgax
         jsCj33U1hilXzWRNEjuGPLiQAKYhyRwmRLLkBFAPyoi4bSmzKIdtlyGB7DVZBfXjW84c
         yE8zMDq/9RQJUPRVlJoIk4WnXbufQ2Pd4m2UT5Z9S6iuh7GWkQfn0Tv/1TDlmRNKi8SN
         vnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hRGHdejg5JBOgjxW3k8B0GPaLm05r9sHdxdq5izdOJ8=;
        b=NwUywZaC7geRbVR9OdH1kvy39kGZJgJrclPd7dLrt5q6+ouv6RuSRipk3y6IqYEdrk
         +tOD1eyHlrNmaT3xjDVdzsEcHTdsv7zk8gsOQ64+yDkjSEFDZ3xbPiRGnuGYrQaeoDJ8
         lxnSiy213Kr8nAmvf4lrcHHLWE7dBNO+s/vQuzSfczJNrBZ5yXP3CGBcDsZ+YZluMQcD
         Cwj/+6P4/02qjKS0v448//FnHsBFWgsG7AnxHOybN2uKil8nTPldPY5nA7jM4felO+BW
         8V6M55xRtMBhEzQ84WxAtN249/mgWxL2IkZtakP/2mvGU2GU1oXCHKlvK+Kr6UZY4CbY
         qkSQ==
X-Gm-Message-State: AA+aEWYxcaOo1QTcqHhsXAxLkxyTUMuvtp5wR3CxbX01NZyrcgTCS0cI
        hOspcm+XqHPfbtEecFlEUb1WgQ==
X-Google-Smtp-Source: AFSGD/VA0FvHaQW9s8VBCEg+qmgw7k9bl1dAqLPDdIv6eL167R+L8ftg/7HjUdJkJ256MEh4L4NYfQ==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr14014405wrs.279.1542974570922;
        Fri, 23 Nov 2018 04:02:50 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a18sm25164379wrp.13.2018.11.23.04.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 04:02:49 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 11/11] crypto: crypto_user_stat: Add crypto_stats_init
Date:   Fri, 23 Nov 2018 12:02:21 +0000
Message-Id: <1542974541-23024-12-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
References: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the crypto_stats_init() function.
This will permit to remove some ifdef from __crypto_register_alg().

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/algapi.c        | 11 ++++++++---
 include/linux/crypto.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 84e9b4e5389a..0a76d8464d9f 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -258,9 +258,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 	list_add(&alg->cra_list, &crypto_alg_list);
 	list_add(&larval->alg.cra_list, &crypto_alg_list);
 
-#ifdef CONFIG_CRYPTO_STATS
-	memset(&alg->stats, 0, sizeof(alg->stats));
-#endif
+	crypto_stats_init(alg);
 
 out:
 	return larval;
@@ -1073,6 +1071,11 @@ int crypto_type_has_alg(const char *name, const struct crypto_type *frontend,
 EXPORT_SYMBOL_GPL(crypto_type_has_alg);
 
 #ifdef CONFIG_CRYPTO_STATS
+void crypto_stats_init(struct crypto_alg *alg)
+{
+	memset(&alg->stats, 0, sizeof(alg->stats));
+}
+
 void crypto_stats_get(struct crypto_alg *alg)
 {
 	crypto_alg_get(alg);
@@ -1284,6 +1287,8 @@ void crypto_stats_skcipher_decrypt(unsigned int cryptlen, int ret,
 	crypto_alg_put(alg);
 }
 #else
+void crypto_stats_init(struct crypto_alg *alg)
+{}
 void crypto_stats_get(struct crypto_alg *alg)
 {}
 void crypto_stats_ablkcipher_encrypt(unsigned int nbytes, int ret,
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 132a052b3483..4fa9903c0887 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -613,6 +613,7 @@ struct crypto_alg {
 
 } CRYPTO_MINALIGN_ATTR;
 
+void crypto_stats_init(struct crypto_alg *alg);
 void crypto_stats_get(struct crypto_alg *alg);
 void crypto_stats_ablkcipher_encrypt(unsigned int nbytes, int ret, struct crypto_alg *alg);
 void crypto_stats_ablkcipher_decrypt(unsigned int nbytes, int ret, struct crypto_alg *alg);
-- 
2.18.1

