Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ECDC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 07:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A758723C39
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 07:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A758723C39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeGAHDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 03:03:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47326 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751633AbeGAHDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 03:03:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E2BC18A;
        Sun,  1 Jul 2018 00:03:30 -0700 (PDT)
Received: from sugar.benyossef.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41EFD3F318;
        Sun,  1 Jul 2018 00:03:28 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] crypto: fixes and cleanups                                 
Date:   Sun,  1 Jul 2018 08:02:33 +0100
Message-Id: <1530428560-4440-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set fixes ccree IV handling, finup() operation (provided           
by Hadar Gat) and CTS-AES mode of operation along a code cleanup.                                             
                                                                                
Since our finup() method was obviously broken but was not detected              
by testmgr, I've added finup() test to testmgr to catch it next                 
time it happened.

Changes from v1:
- Add missing "static" qualifier reported by kbuild bot
- Add CTS-AES fix and some more cleanups


Gilad Ben-Yossef (5):
  crypto: testmgr: add hash finup tests
  crypto: ccree: fix iv handling
  crypto: ccree: remove dead legacy code
  crypto: ccree: use CBC-CS3 CTS mode
  crypto: ccree: rate limit debug print

Hadar Gat (1):
  crypto: ccree: fix finup

 crypto/testmgr.c                 |  55 +++++++++++++---
 drivers/crypto/ccree/cc_cipher.c | 137 +++++++++++++++++++++++++--------------
 drivers/crypto/ccree/cc_driver.c |   4 +-
 drivers/crypto/ccree/cc_hash.c   |  81 +++++------------------
 4 files changed, 153 insertions(+), 124 deletions(-)

-- 
2.7.4

