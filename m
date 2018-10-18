Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543C4C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1698321476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1698321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=foss.arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeJRU5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:57:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37432 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeJRU5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:57:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 233BE341;
        Thu, 18 Oct 2018 05:56:38 -0700 (PDT)
Received: from ssg-dev-vb.kfn.arm.com (E111387.Emea.Arm.com [10.50.33.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FDCC3F59C;
        Thu, 18 Oct 2018 05:56:36 -0700 (PDT)
From:   Yael Chemla <yael.chemla@foss.arm.com>
To:     Yael CHEmla <yael.chemla@arm.com>, linux-kernel@vger.kernel.org
Cc:     Yael Chemla <yael.chemla@foss.arm.com>
Subject: [PATCH 0/3] crypto: ccree: add SM3 support
Date:   Thu, 18 Oct 2018 13:56:23 +0100
Message-Id: <1539867386-20344-1-git-send-email-yael.chemla@foss.arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SM3 in CryptoCell 713.

Yael Chemla (3):
  crypto: ccree: adjust hash length to suit certain context specifics
  crypto: ccree:  modify set_cipher_mode usage from cc_hash
  crypto: ccree: add SM3 support

 drivers/crypto/Kconfig                  |   1 +
 drivers/crypto/ccree/cc_aead.c          |  19 +++-
 drivers/crypto/ccree/cc_crypto_ctx.h    |   4 +-
 drivers/crypto/ccree/cc_driver.c        |  10 +-
 drivers/crypto/ccree/cc_driver.h        |   2 +-
 drivers/crypto/ccree/cc_hash.c          | 175 +++++++++++++++++++++++---------
 drivers/crypto/ccree/cc_hw_queue_defs.h |  27 +++++
 7 files changed, 182 insertions(+), 56 deletions(-)

-- 
2.7.4

