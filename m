Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5809D20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfARF66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:58:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2257 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbfARF65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:58:57 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C316EE5D7D3A6B51A102;
        Fri, 18 Jan 2019 13:58:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 13:58:48 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <ebiggers@kernel.org>
CC:     <wangxiongfeng2@huawei.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
        <ard.biesheuvel@linaro.org>, <jonathan.cameron@huawei.com>
Subject: [PATCH V3 0/5] Crypto Cleanup
Date:   Fri, 18 Jan 2019 13:58:10 +0800
Message-ID: <1547791095-48339-1-git-send-email-wangxiongfeng2@huawei.com>
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

Changelog:
v2 -> v3:
	remove the extra blank line in the fourth patch
	change author to Xiongfeng Wang <xiongfeng.wang@linaro.org>
v1 -> v2: 
	rebased to cryptodev, fix some format issue

Xiongfeng Wang (5):
  crypto: api - add a helper to (un)register a array of templates
  crypto: ccm - use template array registering API to simplify the code
  crypto: gcm - use template array registering API to simplify the code
  crypto: ctr - use template array registering API to simplify the code
  crypto: chacha20poly1305 - use template array registering API to
    simplify the code

 crypto/algapi.c           | 27 ++++++++++++++++
 crypto/ccm.c              | 78 ++++++++++++++---------------------------------
 crypto/chacha20poly1305.c | 37 +++++++++-------------
 crypto/ctr.c              | 42 +++++++++----------------
 crypto/gcm.c              | 73 ++++++++++++++------------------------------
 include/crypto/algapi.h   |  2 ++
 6 files changed, 103 insertions(+), 156 deletions(-)

-- 
1.7.12.4

