Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA8DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6153020867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cX4359x3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6153020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeICXor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:44:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38811 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbeICXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:44:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so2042352wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=NP0ptNNhTiBiInHbkie2i25Bz/VQlq+c0ja9bm9q2r0=;
        b=cX4359x3cLfdO3RTMoM8BaayI6aVI4zGGCBz8J5si19G8LL5KGBzIKkuIwTCB3h0Sp
         vSxqV42VsktIr66YsyjhTkfkwMVmY/LWQwBhlI+Ns/Iz7vtWxbnZ8/+yzfoVEhCwr12H
         Ur5Y1D1OPVPn/+5wBXtg0PwXcAkvpg4CYr85Jv3KKlpWDh3SygS9aAXq0A1is1+xFN0Z
         YYrahJThgzHn8AZH3E+HAhnw9CRGdOb6wWBhGkFOMdckE/drkDGnM0A9jTdUV9mOaVYZ
         j0G1g6+2aJoKMGC51z5Jla/LpiiLQ7yKM9BoN1DdbxcKbXIWoz1VCGtgD05b+lOJqb5s
         3Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NP0ptNNhTiBiInHbkie2i25Bz/VQlq+c0ja9bm9q2r0=;
        b=t8nd3nnsiD9vdU3fqVAr9+XsHSCkkBiiddCYkNzaAk78mVb591LpGZ1TcPQhhYrwXX
         dU3VF8Ny602PJHVUD1MsmEo50C/yHREBYPOeIb0py96gP6XIaoAcB0Dvo33zmyloOq+p
         KG9Ci6TDIKFhH60U3hpzsikGIDKLbSAGL5kX/SzUcHPzw6BuaDSNCQ+pjGLucv59iHFn
         MAHLxmrlfGFa4cDK6AJ0I+zCabn5uSLPmUV/OG9g48PW9qAMojqYtU4fhcyjpdAwTi9l
         aByQsGMuB52re2M/GEViWxxtcQ3IdeYCrT92uJE+8EdWUZV+Z4YVPCn3+j/3yVTDh9+D
         oxiw==
X-Gm-Message-State: APzg51Dp11j4y7AY1KhpSCcR8/hR7ApnFMkJwIAvJ1dOO4pjjylgRa4e
        9Ojf6dCB+JbfIFUb21QVldy4cw==
X-Google-Smtp-Source: ANB0Vdbv19eH2dxp0E3jc79tg9AmeLdeCq4MNOcT1O2dShZiDnFZ1GjJGT7JC2UA1ay2cOwB/EWqMQ==
X-Received: by 2002:a1c:8682:: with SMTP id i124-v6mr458699wmd.77.1536002590158;
        Mon, 03 Sep 2018 12:23:10 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id h18-v6sm22707418wru.42.2018.09.03.12.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 12:23:09 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/2] crypto: Implement a generic crypto statistics
Date:   Mon,  3 Sep 2018 19:22:46 +0000
Message-Id: <1536002568-18949-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a try to implement a generic crypto driver statistics.
The goal is to have an "ifconfig" for crypto device.

Some driver tried to implement this via a debugfs interface.

This serie do it directly in the crypto API and give access to stats
via the crypto_user(netlink) API.
Then an userspace tool will collect information via netlink.
Note that this userspace tool is heavily copied from libkcapi and if
Stephan Mueller agree, I will made a PR for adding getstat to it unless
tools/crypto is the good place for it.

Example of output:
pkcs1pad(rsa-sun8i-ce,sha1)	Akcipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Sign: 0
	Verify: 5
	Errors: 0
cryptd(__xts-aes-ce)	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
xts-aes-ce	cipher
	Encrypt: 17 bytes: 4384
	Decrypt: 17 bytes: 4384
	Errors: 0
cryptd(__ctr-aes-ce)	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
ctr-aes-ce	cipher
	Encrypt: 19 bytes: 5551
	Decrypt: 19 bytes: 5551
	Errors: 0
cryptd(__cbc-aes-ce)	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
cbc-aes-ce	cipher
	Encrypt: 19 bytes: 3040
	Decrypt: 19 bytes: 3040
	Errors: 0
cryptd(__ecb-aes-ce)	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
ecb-aes-ce	cipher
	Encrypt: 14 bytes: 2624
	Decrypt: 14 bytes: 2624
	Errors: 0
cbcmac-aes-ce	Hash
	Hash: 20 bytes: 1244
	Errors: 0
xcbc-aes-ce	Hash
	Hash: 28 bytes: 543
	Errors: 0
cmac-aes-ce	Hash
	Hash: 36 bytes: 1472
	Errors: 0
__xts-aes-ce	cipher
	Encrypt: 17 bytes: 4384
	Decrypt: 17 bytes: 4384
	Errors: 0
ctr-aes-ce	cipher
	Encrypt: 19 bytes: 5551
	Decrypt: 19 bytes: 5551
	Errors: 0
__ctr-aes-ce	cipher
	Encrypt: 19 bytes: 5551
	Decrypt: 19 bytes: 5551
	Errors: 0
__cbc-aes-ce	cipher
	Encrypt: 19 bytes: 3040
	Decrypt: 19 bytes: 3040
	Errors: 0
__ecb-aes-ce	cipher
	Encrypt: 14 bytes: 2624
	Decrypt: 14 bytes: 2624
	Errors: 0
rsa-sun8i-ce	Akcipher
	Encrypt: 7 bytes: 232
	Decrypt: 6 bytes: 1152
	Sign: 0
	Verify: 5
	Errors: 0
sun8i_ce_rng	RNG
	Seed: 0
	Generate: 0 bytes: 0
	Errors: 0
ecb(des3_ede-generic)	cipher
	Encrypt: 24 bytes: 4584
	Decrypt: 24 bytes: 4584
	Errors: 0
ecb-des3-sun8i-ce	cipher
	Encrypt: 18 bytes: 3072
	Decrypt: 18 bytes: 3072
	Errors: 0
cbc(des3_ede-generic)	cipher
	Encrypt: 14 bytes: 5104
	Decrypt: 14 bytes: 5104
	Errors: 0
aes-ce	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
des3_ede-generic	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
des-generic	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
aes-arm64	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
crc32c-arm64-ce	Hash
	Hash: 92 bytes: 20649
	Errors: 0
cbc-des3-sun8i-ce	cipher
	Encrypt: 10 bytes: 3488
	Decrypt: 10 bytes: 3488
	Errors: 0
crc32-arm64-ce	Hash
	Hash: 92 bytes: 20649
	Errors: 0
ecb-aes-sun8i-ce	cipher
	Encrypt: 18 bytes: 3168
	Decrypt: 18 bytes: 3168
	Errors: 0
cbc-aes-sun8i-ce	cipher
	Encrypt: 24 bytes: 3712
	Decrypt: 24 bytes: 3712
	Errors: 0
sha256-ce	Hash
	Hash: 26 bytes: 8860
	Errors: 0
sha224-ce	Hash
	Hash: 26 bytes: 8860
	Errors: 0
cts(cbc-aes-sun8i-ce)	cipher
	Encrypt: 24 bytes: 956
	Decrypt: 24 bytes: 956
	Errors: 0
sha224-arm64-neon	Hash
	Hash: 26 bytes: 8860
	Errors: 0
sha256-arm64-neon	Hash
	Hash: 26 bytes: 8860
	Errors: 0
sha224-arm64	Hash
	Hash: 26 bytes: 8860
	Errors: 0
sha256-arm64	Hash
	Hash: 26 bytes: 8860
	Errors: 0
ctr-aes-sun8i-ce	cipher
	Encrypt: 24 bytes: 6738
	Decrypt: 24 bytes: 6738
	Errors: 0
sha1-ce	Hash
	Hash: 28 bytes: 9191
	Errors: 0
ecdh-generic	KPP
	Setsecret: 4
	Generate public key: 3
	Compute_shared_secret: 4
	Errors: 0
ghash-generic	Hash
	Hash: 32 bytes: 4358
	Errors: 0
jitterentropy_rng	RNG
	Seed: 0
	Generate: 1 bytes: 48
	Errors: 0
drbg_nopr_hmac_sha256	RNG
	Seed: 5
	Generate: 9 bytes: 1056
	Errors: 0
drbg_nopr_hmac_sha512	RNG
	Seed: 0
	Generate: 0 bytes: 0
	Errors: 0
drbg_nopr_hmac_sha384	RNG
	Seed: 0
	Generate: 0 bytes: 0
	Errors: 0
drbg_nopr_hmac_sha1	RNG
	Seed: 0
	Generate: 0 bytes: 0
	Errors: 0
drbg_pr_hmac_sha256	RNG
	Seed: 4
	Generate: 8 bytes: 1024
	Errors: 0
drbg_pr_hmac_sha512	RNG
	Seed: 0
	Generate: 0 bytes: 0
	Errors: 0
drbg_pr_hmac_sha384	RNG
	Seed: 0
	Generate: 0 bytes: 0
	Errors: 0
drbg_pr_hmac_sha1	RNG
	Seed: 0
	Generate: 0 bytes: 0
	Errors: 0
crct10dif-generic	Hash
	Hash: 24 bytes: 19893
	Errors: 0
crc32c-generic	Hash
	Hash: 92 bytes: 20649
	Errors: 0
aes-generic	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
sha224-generic	Hash
	Hash: 26 bytes: 8860
	Errors: 0
sha256-generic	Hash
	Hash: 26 bytes: 8860
	Errors: 0
sha1-generic	Hash
	Hash: 28 bytes: 9191
	Errors: 0
digest_null-generic	Hash
	Hash: 0 bytes: 0
	Errors: 0
compress_null-generic	Compress
	Compress: 0 bytes: 0
	Decompress: 0 bytes: 0
	Errors: 0
ecb-cipher_null	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
cipher_null-generic	cipher
	Encrypt: 0 bytes: 0
	Decrypt: 0 bytes: 0
	Errors: 0
rsa-generic	Akcipher
	Encrypt: 17 bytes: 2832
	Decrypt: 9 bytes: 1920
	Sign: 0
	Verify: 36
	Errors: 0

Futur possible additions:
- Add a "number of needed fallback" statistics.
- maximum request size

Please let me know your opinions about it

Regards

Changes since RFC:
- Do not use anymore CRYPTO_MSG_GETALG and added a dedicated CRYPTO_MSG_GETSTAT

Changes since RFC:
- Use cryptouser(netlink) instead of /sys
- Use atomic_t instead of unsigned long
- moved stat code into dedicated inline function
- spelling fixes

Corentin Labbe (2):
  crypto: Implement a generic crypto statistics
  crypto: tools: Add cryptostat userspace

 crypto/Kconfig                               |  11 +
 crypto/Makefile                              |   1 +
 crypto/ahash.c                               |  21 +-
 crypto/algapi.c                              |   8 +
 crypto/{crypto_user.c => crypto_user_base.c} |   9 +-
 crypto/crypto_user_stat.c                    | 463 +++++++++++++++++++++++++++
 crypto/rng.c                                 |   1 +
 include/crypto/acompress.h                   |  38 ++-
 include/crypto/aead.h                        |  51 ++-
 include/crypto/akcipher.h                    |  76 ++++-
 include/crypto/hash.h                        |  32 +-
 include/crypto/internal/cryptouser.h         |   8 +
 include/crypto/kpp.h                         |  51 ++-
 include/crypto/rng.h                         |  29 +-
 include/crypto/skcipher.h                    |  44 ++-
 include/linux/crypto.h                       |  83 ++++-
 include/uapi/linux/cryptouser.h              |  52 +++
 tools/crypto/getstat.c                       | 294 +++++++++++++++++
 18 files changed, 1237 insertions(+), 35 deletions(-)
 rename crypto/{crypto_user.c => crypto_user_base.c} (97%)
 create mode 100644 crypto/crypto_user_stat.c
 create mode 100644 include/crypto/internal/cryptouser.h
 create mode 100644 tools/crypto/getstat.c

-- 
2.16.4

