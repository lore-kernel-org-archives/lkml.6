Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A38C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C0D20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfAONov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:44:51 -0500
Received: from foss.arm.com ([217.140.101.70]:50800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfAONov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:44:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C20CA78;
        Tue, 15 Jan 2019 05:44:51 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (e110176-lin.kfn.arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B4D3F70D;
        Tue, 15 Jan 2019 05:44:49 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] crypto: ccree: bug fixes and cleanups
Date:   Tue, 15 Jan 2019 15:44:46 +0200
Message-Id: <20190115134447.29064-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assorted bug fixes and cleanups

Gilad Ben-Yossef (3):
  crypto: ccree: unmap buffer before copying IV
  crypto: ccree: shared irq lines are not a bug
  crypto: ccree: don't copy zero size ciphertext

Hadar Gat (4):
  crypto: ccree: improve error handling
  crypto: ccree: add error message
  crypto: ccree: fix free of unallocated mlli buffer
  crypto: ccree: remove legacy leftover

 drivers/crypto/ccree/cc_buffer_mgr.c | 87 ++++++++++++++--------------
 drivers/crypto/ccree/cc_cipher.c     |  6 +-
 drivers/crypto/ccree/cc_driver.c     |  6 +-
 drivers/crypto/ccree/cc_driver.h     |  2 -
 4 files changed, 50 insertions(+), 51 deletions(-)

-- 
2.20.1

