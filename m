Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF656C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FBE20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gIWEx3yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FBE20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeKTXCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:02:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51040 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbeKTXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:02:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id 125so1979073wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kuzrXezwzyApcc5DTCPJd/xXBSCO9YhTkcWCo1bZE5A=;
        b=gIWEx3yS5VlPXZ3Xnxpa01havirTaIUkqoMa1c9kOFc7PurRF8GykwjE24npbiE4cC
         Zjl7RQ1nZsyq3bORmjkYP8Rmupnpsec9wtA63BijHda+wnOfu9T0g4xUA1VnFawQe6vp
         wgdwHc3ltEdEO2o9i9Bpxr/10OhI6llGvf5yz5VSTdj/kyoxt/IkX99p4TO/btn/MmWt
         IlTwlLEqJbmWscK77eRPLXfZXVf5Baf760R8KDwGt9Gzz4XhG7gGyVjiVOqo3DL22g0g
         TTNAM6Vx56+BSqVV0qygl+mWnFIeNDOZ8b5Uu0by/3dbkadKOvcJhSngTVeNvMQ1i+IJ
         eDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kuzrXezwzyApcc5DTCPJd/xXBSCO9YhTkcWCo1bZE5A=;
        b=FMFiS4DDqen9AIXhh/YQFko8sL2vQ44NH15PVe2LopYlUwabytEeVR6SUa6RSH2U8C
         OXwCE3B1Mz4SfL7a2QOcsRFK5WXXLYXA28PuY/pNDsqsm9BlSuBC5psMuczHNSJTPHKv
         Wkhdc5L2zSmR5QrlHtEy17v+CXyoMmn8tEmUBiCvbJF7dfI/Wb3S1w3X43RjbmErprju
         xXUfqS5SrEmNYJoZ9WVRiI2iZbBr6TM3ymyQLY7CuNnyDU2QYtP6m+rV5jx6d3PXfHa9
         6az005JNWKp6i3MFGD1Z4qTFjI2ilZPEqA/l9Psw6y02uV+iKY70HhYtKA4d+vtJ+QeP
         wfaQ==
X-Gm-Message-State: AGRZ1gLsMw3xtyxJ5sa9cYm1RImlt4YO4RJMkAicxMmM/7kZ5Ab+CBT7
        HLpNGzUJtsIgYjjbpZNB/EnA/KGrUdg=
X-Google-Smtp-Source: AJdET5duMscE5A77fQJG33yH0R/4DlB7UNwftDTeMauUvX76VEFMSjuFgIBV1h8Gef27Ih1snnMUlA==
X-Received: by 2002:a1c:af89:: with SMTP id y131mr1975010wme.137.1542717199667;
        Tue, 20 Nov 2018 04:33:19 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x81sm2766951wmg.17.2018.11.20.04.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 04:33:18 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 00/10] crypto: crypto_user_stat: misc enhancement
Date:   Tue, 20 Nov 2018 12:32:16 +0000
Message-Id: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset fixes all reported problem by Eric biggers.

Regards

Changes since v3:
- moved all crypto_stats functions from header to algapi.c for using
  crypto_alg_get/put

Changes since v2:
- Better locking of crypto_alg via crypto_alg_get/crypto_alg_put
- remove all intermediate variables in crypto/crypto_user_stat.c
- splited all internal stats variables into different structures

Corentin Labbe (10):
  crypto: crypto_user_stat: made crypto_user_stat optional
  crypto: CRYPTO_STATS should depend on CRYPTO_USER
  crypto: crypto_user_stat: convert all stats from u32 to u64
  crypto: crypto_user_stat: split user space crypto stat structures
  crypto: tool: getstat: convert user space example to the new
    crypto_user_stat uapi
  crypto: crypto_user_stat: fix use_after_free of struct xxx_request
  crypto: crypto_user_stat: Fix invalid stat reporting
  crypto: crypto_user_stat: remove intermediate variable
  crypto: crypto_user_stat: Split stats in multiple structures
  crypto: crypto_user_stat: rename err_cnt parameter

 crypto/Kconfig                       |   1 +
 crypto/Makefile                      |   3 +-
 crypto/ahash.c                       |  17 +-
 crypto/algapi.c                      | 293 ++++++++++++++++++++++++++-
 crypto/crypto_user_stat.c            | 160 +++++----------
 crypto/rng.c                         |   4 +-
 include/crypto/acompress.h           |  38 +---
 include/crypto/aead.h                |  38 +---
 include/crypto/akcipher.h            |  74 ++-----
 include/crypto/hash.h                |  32 +--
 include/crypto/internal/cryptouser.h |  17 ++
 include/crypto/kpp.h                 |  48 +----
 include/crypto/rng.h                 |  27 +--
 include/crypto/skcipher.h            |  36 +---
 include/linux/crypto.h               | 245 +++++++++++++---------
 include/uapi/linux/cryptouser.h      | 102 ++++++----
 tools/crypto/getstat.c               |  72 +++----
 17 files changed, 677 insertions(+), 530 deletions(-)

-- 
2.18.1

