Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0D0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E824D213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qK613Bt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E824D213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbeK3BsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:48:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36145 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733258AbeK3BsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:48:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id a18so2510185wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=IHkt2HGx7WuiDkTk3GBuMzWLRqccGVKmG+KvpRRwvfM=;
        b=qK613Bt4ok/pOB7qu9PEYyBBDcu2oeLjZnwEI7lYEF1cVD8UZKVteAvKS5qtxy4PyH
         NMB3xReq+u0Tm6Ygu0JvHffIPpKgUT3y4m0A3j74XUjVG0zyvVaNVf9ciKiEHl4BRFh2
         COpPbyD15hyxVhXn9FYLH/Kh6zcy16gHCPNIURMq/L1aSbpfp4IuXonTHcdg1eAXD7Qp
         7vu9E2Py1Ti1QPagT50oXsNnL2WT9up97Yp/ZMbD2qMuBLT3QDuhK+KmiqwJCAMUUuQT
         8I5VSVTO2p1GQgQAUo+dOb4VQEiWIGHBQ8c3cuLV7eFkpND51VixMLAnNX/8vtiP4F+q
         zqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IHkt2HGx7WuiDkTk3GBuMzWLRqccGVKmG+KvpRRwvfM=;
        b=jp6J07WZaJBnB9UpkqGLQVX0ftpAxGj8HlN1kKxp5b1B87CVMSqGtRJ8C295tvbTaW
         klMCdf1dATeTZf8jqrc3vlPjdM6YvrbkFhADVRdwSJ08Op6XW/8ZHGM4PmGssDcd7Sx6
         42aQ/KguJHLyai1shqMCdZW8YfGLqh5NGxSfvwDfQLkjiC8/o5yDvRbN5PNmGhaZ7bLa
         lgH+8pUEvIWDW25IX4LoLQfDgGf8OdkfA/OiQx4mVxS2H5odbGxRGjXwlrxMUs7CVMlA
         7QRlvzWZYj8uG0h+Z7ty6eZ8mOL3B4tgygUOq57eJfvFsMZubR2L2z2SVuEh52JkbC5A
         7cPw==
X-Gm-Message-State: AA+aEWb03zYYpxVJ7Hylc4Cd4rJUwZNqrbHnYWk2wtLoygbsM9J5Vvjh
        mgGYu3CZER71v55C3TUiH7rQOw==
X-Google-Smtp-Source: AFSGD/VFQGa4xQUv7uqWismRnCoCOCRKX2wrPdWabhnQYPME6jS3yG34DG6LSTFRiTtICC7G3oO1Zw==
X-Received: by 2002:a1c:5656:: with SMTP id k83mr808322wmb.125.1543502553934;
        Thu, 29 Nov 2018 06:42:33 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t131sm875406wmt.1.2018.11.29.06.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 06:42:32 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 00/11] crypto: crypto_user_stat: misc enhancement
Date:   Thu, 29 Nov 2018 14:42:15 +0000
Message-Id: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset fixes all reported problem by Eric biggers.

Regards

Changes since v4:
- Inlined functions when !CRYPTO_STATS

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
 crypto/algapi.c                      | 247 ++++++++++++++++++++++-
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
 include/linux/crypto.h               | 290 ++++++++++++++++++---------
 include/uapi/linux/cryptouser.h      | 102 ++++++----
 tools/crypto/getstat.c               |  72 +++----
 17 files changed, 676 insertions(+), 530 deletions(-)

-- 
2.18.1

