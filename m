Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B9AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C103320869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C103320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJPV0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:26:10 -0400
Received: from foss.arm.com ([217.140.101.70]:36414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeJPV0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:26:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B545980D;
        Tue, 16 Oct 2018 06:35:39 -0700 (PDT)
Received: from sugar.kfn.arm.com (unknown [10.50.4.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 844773F5D3;
        Tue, 16 Oct 2018 06:35:37 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ofir Drang <Ofir.Drang@arm.com>, Yael Chemla <Yael.Chemla@arm.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] crypto: ccree: add CryptoCell 713 baseline support
Date:   Tue, 16 Oct 2018 14:35:30 +0100
Message-Id: <1539696935-4433-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add first batch of patches for support of Arm TrustZone CryptoCell 713.

Gilad Ben-Yossef (3):
  crypto: ccree: add support for CryptoCell 713
  crypto: ccree: add dt bindings for ccree 713
  crypto: ccree: add SM4 support

 .../devicetree/bindings/crypto/arm-cryptocell.txt  |  5 +-
 drivers/crypto/Kconfig                             |  3 +-
 drivers/crypto/ccree/cc_cipher.c                   | 66 ++++++++++++++++++++++
 drivers/crypto/ccree/cc_driver.c                   | 23 +++++---
 drivers/crypto/ccree/cc_driver.h                   |  5 +-
 drivers/crypto/ccree/cc_hw_queue_defs.h            |  3 +
 6 files changed, 92 insertions(+), 13 deletions(-)

-- 
2.7.4

