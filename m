Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334CDC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E09920651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfAONne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:43:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50718 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbfAONnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:43:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AAD7A78;
        Tue, 15 Jan 2019 05:43:33 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (e110176-lin.kfn.arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C2623F70D;
        Tue, 15 Jan 2019 05:43:31 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] bug fixes and cleanups
Date:   Tue, 15 Jan 2019 15:43:10 +0200
Message-Id: <20190115134318.28712-1-gilad@benyossef.com>
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

