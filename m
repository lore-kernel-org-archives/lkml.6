Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7395C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936A520859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfAPCvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:51:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17551 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729853AbfAPCvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:51:17 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 42B781181E3E55BC449B;
        Wed, 16 Jan 2019 10:51:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Wed, 16 Jan 2019 10:51:09 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <broonie@kernel.org>,
        <ard.biesheuvel@linaro.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH 0/5] Crypto Cleanup
Date:   Wed, 16 Jan 2019 10:50:29 +0800
Message-ID: <1547607034-40948-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset introduce a helper to (un)register a array of crypto templates.
The following patches use this helper to simplify the code. This is also
a preparation for a coming patchset, which will register several crypto
templates.

Xiongfeng Wang (5):
  crypto: api - add a helper to (un)register a array of templates
  crypto: ccm - use template array registering API to simplify the code
  crypto: gcm - use template array registering API to simplify the code
  crypto: ctr - use template array registering API to simplify the code
  crypto: chacha20poly1305 - use template array registering API to
    simplify the code

 crypto/algapi.c           | 27 ++++++++++++++++
 crypto/ccm.c              | 81 +++++++++++++++--------------------------------
 crypto/chacha20poly1305.c | 38 +++++++++-------------
 crypto/ctr.c              | 46 ++++++++++-----------------
 crypto/gcm.c              | 76 +++++++++++++++-----------------------------
 include/crypto/algapi.h   |  2 ++
 6 files changed, 113 insertions(+), 157 deletions(-)

-- 
1.7.12.4

