Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB15C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A842075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="N1sQ6EPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A842075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeKTXCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:02:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38931 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbeKTXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:02:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id b13so1790818wrx.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1aCpJW3/a42CFCztC9Cmox2pxI2mezP04ciavDjkWRE=;
        b=N1sQ6EPq1pFpDFVrTTo2AXERw+/j40ZOBYM3IXFLKtKxXBzVVQ9ZTNjBnfiG71zXcy
         eM+pRv/aXQMyiAvEnXJD8pMD9wHI20J3IxkNc+7+sPRBOCxt7ZGgSMAIyIMzhllkuK2D
         FcnuH8HLPQZcyCkaoYp4Bk4WgSvk4shmDtz15zSF0OEvdh6hoDGuRqL9BOnVBCpIR4/I
         78ewyCtpiFZYCqih9+Pu5TI8Qh7SiuYDnUcVCdPAKgPUNNINZ481dij73ksMjVpm+UE8
         Ld3CC02zIMG8XETpA6qphphg/LfByehwqiw7VMS4bWkbRuCYYekbBI+jHr3zjPUgUTJB
         Xftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1aCpJW3/a42CFCztC9Cmox2pxI2mezP04ciavDjkWRE=;
        b=Fym13trcD/tcuJxNeSzmBDoSy7zGSc3Pd5+TfoxtwfAPLSrDHPXrUT39EbmqeqH4fG
         RDNHzYKdUXnc/lHRZWBTPHA8ppQSxPXlbqkir1vIitER/mSDRGpCT+gJJh9W9jhXbT1Y
         0B/tTJ4+iFc0vmJe88Qa5Pi9J+2zga2/5GvAWcCRT5I1w9c2vnHZqpfLCrBcKIMJZH45
         wpVi9rIbaBh6wcaZTGSN2a8WPMvgzdbNT/qBXEUhVoRySzQJpy2sBFZLFtsWHJeICSKo
         w7La5kxIuUKx72GpXWInouoTRp8+k9VUaz4aodoo7Fflri7+GDnKFzelQMaQ4xo6mayO
         tK4w==
X-Gm-Message-State: AA+aEWZCujQTHrW3SLKQpXOrj2TVDPtJY2BBOMdD77ap3e+VYL1y6F7N
        KpDecfH9OQCF3CyVGIoj7cM5dw==
X-Google-Smtp-Source: AFSGD/UH9/XjRfTQIU0rpOJqliSMpspewuNK3MmS51JSJ2VUE4whqd+7pM9QlUAw0AZAnstwiQOdmg==
X-Received: by 2002:adf:9bd6:: with SMTP id e22-v6mr1734089wrc.295.1542717200563;
        Tue, 20 Nov 2018 04:33:20 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x81sm2766951wmg.17.2018.11.20.04.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 04:33:19 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 01/10] crypto: crypto_user_stat: made crypto_user_stat optional
Date:   Tue, 20 Nov 2018 12:32:17 +0000
Message-Id: <1542717146-34917-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
References: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if CRYPTO_STATS is set to n, some part of CRYPTO_STATS are
compiled.
This patch made all part of crypto_user_stat uncompiled in that case.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/Makefile                      |  3 ++-
 crypto/algapi.c                      |  2 ++
 include/crypto/internal/cryptouser.h | 17 +++++++++++++++++
 include/linux/crypto.h               |  2 ++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/crypto/Makefile b/crypto/Makefile
index abbd86fdbad2..22f9f84f961d 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -54,7 +54,8 @@ cryptomgr-y := algboss.o testmgr.o
 
 obj-$(CONFIG_CRYPTO_MANAGER2) += cryptomgr.o
 obj-$(CONFIG_CRYPTO_USER) += crypto_user.o
-crypto_user-y := crypto_user_base.o crypto_user_stat.o
+crypto_user-y := crypto_user_base.o
+crypto_user-$(CONFIG_CRYPTO_STATS) += crypto_user_stat.o
 obj-$(CONFIG_CRYPTO_CMAC) += cmac.o
 obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
 obj-$(CONFIG_CRYPTO_VMAC) += vmac.o
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 2545c5f89c4c..f5396c88e8cd 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -258,6 +258,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 	list_add(&alg->cra_list, &crypto_alg_list);
 	list_add(&larval->alg.cra_list, &crypto_alg_list);
 
+#ifdef CONFIG_CRYPTO_STATS
 	atomic_set(&alg->encrypt_cnt, 0);
 	atomic_set(&alg->decrypt_cnt, 0);
 	atomic64_set(&alg->encrypt_tlen, 0);
@@ -265,6 +266,7 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 	atomic_set(&alg->verify_cnt, 0);
 	atomic_set(&alg->cipher_err_cnt, 0);
 	atomic_set(&alg->sign_cnt, 0);
+#endif
 
 out:
 	return larval;
diff --git a/include/crypto/internal/cryptouser.h b/include/crypto/internal/cryptouser.h
index 8db299c25566..3492ab42eefb 100644
--- a/include/crypto/internal/cryptouser.h
+++ b/include/crypto/internal/cryptouser.h
@@ -3,6 +3,23 @@
 
 struct crypto_alg *crypto_alg_match(struct crypto_user_alg *p, int exact);
 
+#ifdef CONFIG_CRYPTO_STATS
 int crypto_dump_reportstat(struct sk_buff *skb, struct netlink_callback *cb);
 int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh, struct nlattr **attrs);
 int crypto_dump_reportstat_done(struct netlink_callback *cb);
+#else
+static int crypto_dump_reportstat(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return -ENOTSUPP;
+}
+
+static int crypto_reportstat(struct sk_buff *in_skb, struct nlmsghdr *in_nlh, struct nlattr **attrs)
+{
+	return -ENOTSUPP;
+}
+
+static int crypto_dump_reportstat_done(struct netlink_callback *cb)
+{
+	return -ENOTSUPP;
+}
+#endif
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 3634ad6fe202..3e05053b8d57 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -515,6 +515,7 @@ struct crypto_alg {
 	
 	struct module *cra_module;
 
+#ifdef CONFIG_CRYPTO_STATS
 	union {
 		atomic_t encrypt_cnt;
 		atomic_t compress_cnt;
@@ -552,6 +553,7 @@ struct crypto_alg {
 		atomic_t compute_shared_secret_cnt;
 	};
 	atomic_t sign_cnt;
+#endif /* CONFIG_CRYPTO_STATS */
 
 } CRYPTO_MINALIGN_ATTR;
 
-- 
2.18.1

