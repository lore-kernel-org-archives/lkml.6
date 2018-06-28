Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876BCC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1C02702D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1C02702D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934125AbeF1HdA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:33:00 -0400
Received: from foss.arm.com ([217.140.101.70]:42202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933094AbeF1Hc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:32:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 825F618A;
        Thu, 28 Jun 2018 00:32:59 -0700 (PDT)
Received: from sugar.kfn.arm.com (unknown [10.45.48.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D17AE3F5C0;
        Thu, 28 Jun 2018 00:32:57 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] crypto: fixes and cleanups
Date:   Thu, 28 Jun 2018 08:32:50 +0100
Message-Id: <1530171175-31960-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set fixes ccree IV handling and finuo() operation (provided
by Hadar Gat) along a code cleanup.

Since our finup() method was obviously broken but was not detected
by testmgr, I've added finup() test to testmgr to catch it next
time it happened

Gilad Ben-Yossef (3):
  crypto: testmgr: add hash finup tests
  crypto: ccree: fix iv handling
  crypto: ccree: remove dead legacy code

Hadar Gat (1):
  crypto: ccree: fix finup

 crypto/testmgr.c                 |  55 +++++++++++++++---
 drivers/crypto/ccree/cc_cipher.c | 117 ++++++++++++++++++++++++++++-----------
 drivers/crypto/ccree/cc_hash.c   |  81 ++++++---------------------
 3 files changed, 146 insertions(+), 107 deletions(-)

-- 
2.7.4

