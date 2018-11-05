Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC863C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5AD20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G9CB2Qwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5AD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeKEWLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:11:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46244 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeKEWLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:11:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id 74-v6so9371119wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=QtON/trzx51iCvNHUp101pkkVDDExDxZGsHSUZ1m/F8=;
        b=G9CB2QwkQYKCh4vtBhT1ZlMYe4btz4H8m/f8Ufbre4xFxBfqInDJHKSoMTSyqnCs6Y
         LQKT5c9mtRLWQ5Mu1+TVEgurB/qHLI5C4RzKAXKUQDMJoho10OapF8wn9+Yztsqzs12e
         HzSyO86tKExAiA0QbukOm9BSFKuP9WDH0BrQYTrLSLaPWBodvfv+BzhhjkhkhVo2W0Tz
         GpnKmD78bUt1BOi0pSSKZA7ZVTr23upqpqexGImb7tsuk9uu4FQa6xrMBJte3Xr6Cy/k
         AkchRF6V/jvoMqx4RKWi/kurPAN2Rq+gsZfk9JEm8Gcufwbi22rgKiylVFsRmkhIicXv
         AvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QtON/trzx51iCvNHUp101pkkVDDExDxZGsHSUZ1m/F8=;
        b=YWv1909XE/QIEd1N1SmFZlEBz9RY53qTC4FybnKF997hd1uZZVHqieRTTaNDOcQE8u
         V9XgpbCOk8PEsGrcQJac4UpI5ud4fQkq3/G0lUddIpO7glnWsJ4I8jkdS4pxYYsg88rL
         LjoVVYzF985nP+zyHtWQlrzgVHQ1s8zo9Foj2ay7R3WXMENthQzGPy639Layw8NVyRos
         9zSXZM/UUuzd15yM+PyuhJ34pk3/t/rBIdBhyFbNyzgGm6RvpaChHyhZM3HlKG8/L7Mu
         BCAG5vnVqCt7Bs4qxRQDtkEsis+JCaRI3EtNI2DUaPOkGTazf0GxVPhz22RVM1DHfpuD
         XV0g==
X-Gm-Message-State: AGRZ1gJ2tYuMkNHsnfUw9eXukCb9mRtpVdFO0cTouhNmIVLZPBFV8PE2
        hILaRXNYqSYDqoM2Bir9SdY8OX9jT3Y=
X-Google-Smtp-Source: AJdET5dS5xBJBMj1BWlWUOh/LBJMauk+5O6HfkzIpSvwwicdSmc8dzJzVM1YFLoKenqVjRS1p0kaLw==
X-Received: by 2002:adf:f20a:: with SMTP id p10-v6mr14364456wro.293.1541422285009;
        Mon, 05 Nov 2018 04:51:25 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l4-v6sm56114579wrb.92.2018.11.05.04.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 04:51:24 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/5] crypto: crypto_user_stat: misc enhancement
Date:   Mon,  5 Nov 2018 12:51:09 +0000
Message-Id: <1541422274-40060-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset fixes all reported problem by Eric biggers.
This patchset should be applied on top of Eric biggers patchset "crypto: crypto_user reporting fixes and cleanups"

Regards

Corentin Labbe (5):
  crypto: crypto_user_stat: made crypto_user_stat optional
  crypto: crypto_user_stat: convert all stats from u32 to u64
  crypto: crypto_user_stat: split user space crypto stat structures
  crypto: tool: getstat: convert user space example to the new
    crypto_user_stat uapi
  crypto: crypto_user_stat: fix use_after_free of struct xxx_request

 crypto/Makefile                      |   3 +-
 crypto/ahash.c                       |  14 ++-
 crypto/algapi.c                      |  12 ++-
 crypto/crypto_user_stat.c            | 134 +++++++++++++--------------
 include/crypto/acompress.h           |  30 +++---
 include/crypto/aead.h                |  30 +++---
 include/crypto/akcipher.h            |  56 ++++++-----
 include/crypto/hash.h                |  25 ++---
 include/crypto/internal/cryptouser.h |  17 ++++
 include/crypto/kpp.h                 |  26 +++---
 include/crypto/rng.h                 |   8 +-
 include/crypto/skcipher.h            |  24 +++--
 include/linux/crypto.h               |  74 +++++++--------
 include/uapi/linux/cryptouser.h      | 103 ++++++++++++--------
 tools/crypto/getstat.c               |  54 +++++------
 15 files changed, 329 insertions(+), 281 deletions(-)

-- 
2.18.1

