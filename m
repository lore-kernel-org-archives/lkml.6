Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0510AC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA98820820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oL6iiWQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA98820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503924AbeKWWq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:46:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46791 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405215AbeKWWq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:46:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so12088404wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ojIUOINBRIfe2p3Olm0keViWGXDb6jSTuVXHiDp2Q6k=;
        b=oL6iiWQNORVXCFQFdxOYYIX2kKlh3oduvLj6flUXKMFAvjEqxkGmCUkf4rgMqOQOFL
         JYog9JGxUo1fmrc87AojcftP8HHAUkwCFRAAyDmAzE7W8VmqRdQZftwAH9HGx5tyVUPv
         kCk4lh12v1NPcauRcGdtETSE99/O7yvVaAOTKFwznhsFv1gDNfw706WsD4zGNaC9Z22g
         XFnGBT3Sr4qS9+0osW+eQd3YZ8xDysK5BsuRJZb96xj6Uxzhx32QbNyzBJLqLLrl8e9D
         BPGtbzhDGOSxISAwyZDJRPrAn3zMOewf5v9eeA+iNH0uZKyt8s9lC8L+OU/tynhZz7Xf
         GQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ojIUOINBRIfe2p3Olm0keViWGXDb6jSTuVXHiDp2Q6k=;
        b=lFLTrPq3eq6z/Mho5xpD+ktR+sfA3xu4RCqcyuZDdn/ZOnSApmyPkUAyRSH6dQ8Wb5
         W4U4+MafFHQ4L9DCcyckbZS8QXkl2OGQEtSNysf1MbouijhpGJtesYTvgkrY9exHpHWT
         GYR/7vEGwCDbEt8P9891xratYVhqYF1Wa5OkQ445WR5IJjp917uRoCU8s3Bx5NEUZ7i2
         OMT3UoMuYSDyCiA5WTRKxF9O3TnWteJeWBXGjufrpXZBgxD2BoafHsFkBfS50Eqjt/wh
         EQvIZizVFDZB6Ocrh9Daq4Z3xDxWm7Im6a5GlD1pmHNkCVSBSVh9UW5Y7P+rrzN8kBkU
         SL7A==
X-Gm-Message-State: AA+aEWaHq6hDNlQB5BGA4tR9YPaiXq/pq86p2XmG2ZmUxuOKMDl0p3tu
        mVQkprfr2JqV4Ozk0nrQAXRorQ==
X-Google-Smtp-Source: AFSGD/UUyh3MP5qzj0JZ5cV2liTyo6HQPJj9XoHgUL6Y0KSVGGrDpmc0x5hACkXY5knIWdFs/Q4Uew==
X-Received: by 2002:adf:8101:: with SMTP id 1-v6mr6348629wrm.18.1542974549393;
        Fri, 23 Nov 2018 04:02:29 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a18sm25164379wrp.13.2018.11.23.04.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 04:02:28 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 00/11] crypto: crypto_user_stat: misc enhancement
Date:   Fri, 23 Nov 2018 12:02:10 +0000
Message-Id: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset fixes all reported problem by Eric biggers.

Regards

Changes since v3:
- Added a crypto_stats_init as asked vy Neil Horman
- Fixed some checkpatch complaints

Changes since v2:
- moved all crypto_stats functions from header to algapi.c for using
  crypto_alg_get/put

Changes since v1:
- Better locking of crypto_alg via crypto_alg_get/crypto_alg_put
- remove all intermediate variables in crypto/crypto_user_stat.c
- splited all internal stats variables into different structures

Corentin Labbe (11):
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
  crypto: crypto_user_stat: Add crypto_stats_init

 crypto/Kconfig                       |   1 +
 crypto/Makefile                      |   3 +-
 crypto/ahash.c                       |  17 +-
 crypto/algapi.c                      | 300 ++++++++++++++++++++++++++-
 crypto/crypto_user_stat.c            | 160 +++++---------
 crypto/rng.c                         |   4 +-
 include/crypto/acompress.h           |  38 +---
 include/crypto/aead.h                |  38 +---
 include/crypto/akcipher.h            |  74 ++-----
 include/crypto/hash.h                |  32 +--
 include/crypto/internal/cryptouser.h |  17 ++
 include/crypto/kpp.h                 |  48 +----
 include/crypto/rng.h                 |  27 +--
 include/crypto/skcipher.h            |  36 +---
 include/linux/crypto.h               | 246 +++++++++++++---------
 include/uapi/linux/cryptouser.h      | 102 +++++----
 tools/crypto/getstat.c               |  72 +++----
 17 files changed, 685 insertions(+), 530 deletions(-)

-- 
2.18.1

