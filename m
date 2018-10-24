Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF2C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C479620671
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C479620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJXLuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:50:51 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45258 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:50:51 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AD27372CC63;
        Wed, 24 Oct 2018 06:24:41 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5FD944A4A16;
        Wed, 24 Oct 2018 06:24:41 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] crypto: streebog - add Streebog hash function
Date:   Wed, 24 Oct 2018 06:23:48 +0300
Message-Id: <20181024032356.3388-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GOST/IETF Streebog hash function (GOST R 34.11-2012, RFC 6986)
generic hash transformation with appropriate testmgr and tcrypt
tests and vectors.

Streebog Hash Function (GOST R 34.11-2012, RFC 6986) is one of the Russian
cryptographic standard algorithms (called GOST algorithms).

References:
  https://tc26.ru/upload/iblock/fed/feddbb4d26b685903faa2ba11aea43f6.pdf
  https://tools.ietf.org/html/rfc6986

Tested using testmgr and tcrypt on x86_64, arm, arm64, and s390x on qemu.

Changes from v1:
- Fix of big-endian problem in add512.
- More architectures are tested, including big-endian and 32-bit.

Changes from v2:
- Register hash in Hash Info for use by IMA.
- Add hmac() tests.

Vitaly Chikunov (3):
  crypto: streebog - add Streebog hash function
  crypto: streebog - register Streebog in hash info for IMA
  crypto: streebog - add Streebog test vectors

 crypto/Kconfig                 |   12 +
 crypto/Makefile                |    1 +
 crypto/hash_info.c             |    4 +
 crypto/streebog_generic.c      | 1142 ++++++++++++++++++++++++++++++++++++++++
 crypto/tcrypt.c                |   35 ++
 crypto/testmgr.c               |   24 +
 crypto/testmgr.h               |  114 ++++
 include/crypto/hash_info.h     |    1 +
 include/crypto/streebog.h      |   34 ++
 include/uapi/linux/hash_info.h |    2 +
 10 files changed, 1369 insertions(+)
 create mode 100644 crypto/streebog_generic.c
 create mode 100644 include/crypto/streebog.h

-- 
2.11.0

