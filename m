Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C352086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zdfyiXIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C352086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbeKTGSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:18:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41698 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTGSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:18:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so4720988wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bGkPooGCLY7EejzQftdYmZ3Q5PrbdQdfVNhjEzuvOHY=;
        b=zdfyiXIJtAGmkTaNbRTALuwdwLD9vm7FYQ4y4qBlHR7B3iHpf7N1Yw0NpkK5AYgSrC
         JVXtGXGQElrDkDtr56B8KvxNMYC4hQKc/PGSbyK9IxwbLU99ZxWinTv0W4u8EBMdI6K9
         D7+DfS6UyN/Tui4qosUHjt930MfsvFhoXNuyDK/tlaAZJKFQsJQeYLfPNIyqz+4vr42k
         vAbNekidHwtqecnvVk0EpUkA5LZriNHSRMTr3w9F2h1t6XwHeafNjQmbHPOggkY4Gtcg
         gAEVsrBx5EBt0+A5P4wIC5pE4PRm+Gc86ETWCPuhyIO6a5XsSggLh+2IuPk24v0e+ZLI
         FeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bGkPooGCLY7EejzQftdYmZ3Q5PrbdQdfVNhjEzuvOHY=;
        b=n+Nse0Yfqp3BFO7kcSUFq/KjcLth8aQlFVEZ+2V70kgZ3FYMiaOp29LQm23WF77HTL
         jy282cyXxeBeaP18vEdDf9O2rjOYCK3gc/HOfO7hOFpFbVWbwuWc2tk8qkAimK4b0uZt
         fRyurL4HGsrZT7FguHc+SbETh8uqiZz0/ilX0uXeSlcSfklsu8hLB0u33hQGh5A/PtFa
         42Y7VFK9C5HnLHd17yuUKvNv3X/hzbsWJ+wQoduzpw0LvKFsQn7cvA+9BosWB2vI0fkR
         khDtAfqMPogJ5alDk57bDj5QwECCRn45Or5IHrPJzFrWJswkNESZiy8DY80a+Hx8W29U
         IMIg==
X-Gm-Message-State: AGRZ1gKzl6MVY7aw483gNDamsRT1qYYl4zQm5svSvDREzvlBsOhKaB6H
        bf8uY3v3KXnkimv3tNm2uoxx8w==
X-Google-Smtp-Source: AJdET5fsSG4noGpU2TTfHsn65wtqZdHkJ+Ympn49Q5zcuxQ/EzY2BxLYgWzCbtrTBC3213UwJc5dLA==
X-Received: by 2002:adf:80c8:: with SMTP id 66-v6mr19177609wrl.57.1542657216720;
        Mon, 19 Nov 2018 11:53:36 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i16sm22954132wmd.28.2018.11.19.11.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 11:53:35 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 00/11] crypto: crypto_user_stat: misc enhancement
Date:   Mon, 19 Nov 2018 19:53:19 +0000
Message-Id: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset fixes all reported problem by Eric Biggers.

Regards

Changes since v2:
- Better locking of crypto_alg via crypto_alg_get/crypto_alg_put
- remove all intermediate variables in crypto/crypto_user_stat.c
- splited all internal stats variables into different structures

Corentin Labbe (11):
  crypto: move crypto_alg_get/crypto_alg_put to linux/crypto.h
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
 crypto/ahash.c                       |  23 ++-
 crypto/algapi.c                      |  10 +-
 crypto/crypto_user_stat.c            | 160 ++++++------------
 crypto/internal.h                    |  12 --
 crypto/rng.c                         |   6 +-
 include/crypto/acompress.h           |  38 +++--
 include/crypto/aead.h                |  38 +++--
 include/crypto/akcipher.h            |  72 ++++----
 include/crypto/hash.h                |  30 ++--
 include/crypto/internal/cryptouser.h |  17 ++
 include/crypto/kpp.h                 |  43 +++--
 include/crypto/rng.h                 |  22 ++-
 include/crypto/skcipher.h            |  32 ++--
 include/linux/crypto.h               | 236 ++++++++++++++++++---------
 include/uapi/linux/cryptouser.h      | 102 +++++++-----
 tools/crypto/getstat.c               |  72 ++++----
 18 files changed, 525 insertions(+), 392 deletions(-)

-- 
2.18.1

