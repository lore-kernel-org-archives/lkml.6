Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34540C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50422077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50422077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJJTew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:34:52 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42400 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:34:51 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8827372CA57;
        Wed, 10 Oct 2018 15:12:56 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 408CF4A4A29;
        Wed, 10 Oct 2018 15:12:56 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH v2 0/2] crypto: streebog - add Streebog hash function
Date:   Wed, 10 Oct 2018 15:12:50 +0300
Message-Id: <20181010121254.12220-1-vt@altlinux.org>
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

Vitaly Chikunov (2):
  crypto: streebog - add Streebog hash function
  crypto: streebog - add Streebog test vectors

 crypto/Kconfig            |   12 +
 crypto/Makefile           |    1 +
 crypto/streebog_generic.c | 1142 +++++++++++++++++++++++++++++++++++++++++++++
 crypto/tcrypt.c           |   27 ++
 crypto/testmgr.c          |   12 +
 crypto/testmgr.h          |   71 +++
 include/crypto/streebog.h |   34 ++
 7 files changed, 1299 insertions(+)
 create mode 100644 crypto/streebog_generic.c
 create mode 100644 include/crypto/streebog.h

-- 
2.11.0

