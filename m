Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF0FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB1E275DD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB1E275DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeF1PWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:22:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53456 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965236AbeF1PWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:22:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 312CD20703; Thu, 28 Jun 2018 17:22:04 +0200 (CEST)
Received: from localhost (nat.foo.tf [163.172.35.26])
        by mail.bootlin.com (Postfix) with ESMTPSA id 01A22203B4;
        Thu, 28 Jun 2018 17:22:03 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: [PATCH 0/5] crypto: inside-secure - support more algorithms
Date:   Thu, 28 Jun 2018 17:21:52 +0200
Message-Id: <20180628152157.23769-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds support for more algorithms in the Inside Secure
SafeXcel cryptographic engine driver. Those new algorithms are:
- MD5 (and its hmac).
- DES (ECB and CBC).
- 3DES (ECB and CBC).

The last patch was made on top of the algorithm additions, to enhance
the driver's performances.

This series should be applied on top of another one:
https://lkml.org/lkml/2018/6/28/516

Thanks!
Antoine

Ofer Heifetz (5):
  crypto: inside-secure - md5 support
  crypto: inside-secure - hmac(md5) support
  crypto: inside-secure - ecb(des) and cbc(des) support
  crypto: inside-secure - ecb(des3_ede) and cbc(des3_ede) support
  crypto: inside-secure - remove request list to improve performance

 drivers/crypto/Kconfig                        |   2 +
 drivers/crypto/inside-secure/safexcel.c       | 100 ++---
 drivers/crypto/inside-secure/safexcel.h       |  41 +-
 .../crypto/inside-secure/safexcel_cipher.c    | 369 ++++++++++++++----
 drivers/crypto/inside-secure/safexcel_hash.c  | 157 ++++++--
 drivers/crypto/inside-secure/safexcel_ring.c  |  48 ++-
 6 files changed, 553 insertions(+), 164 deletions(-)

-- 
2.17.1

