Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E563C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBB420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBB420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbeGXPU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:20:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52274 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388460AbeGXPU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:20:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 836017A9;
        Tue, 24 Jul 2018 07:13:49 -0700 (PDT)
Received: from sugar.kfn.arm.com (E110176.Emea.Arm.com [10.50.4.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D84863F237;
        Tue, 24 Jul 2018 07:13:47 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] crypto: ccree: fixes and cleanups
Date:   Tue, 24 Jul 2018 15:12:42 +0100
Message-Id: <1532441567-11694-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various code clean ups and fix ups.

Gilad Ben-Yossef (4):
  crypto: ccree: drop useless type flag during reg
  crypto: ccree: remove cipher ivgen left overs
  crypto: ccree: zero all of request ctx before use
  crypto: ccree: allow bigger than sector XTS op

 drivers/crypto/ccree/cc_aead.c       | 16 +---------------
 drivers/crypto/ccree/cc_buffer_mgr.c |  8 ++------
 drivers/crypto/ccree/cc_cipher.c     | 36 ++++--------------------------------
 drivers/crypto/ccree/cc_cipher.h     |  1 -
 drivers/crypto/ccree/cc_driver.h     |  1 -
 5 files changed, 7 insertions(+), 55 deletions(-)

-- 
2.7.4

