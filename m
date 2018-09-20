Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30272ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2CB2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2CB2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbeITTCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:02:45 -0400
Received: from foss.arm.com ([217.140.101.70]:45830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeITTCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:02:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12917A9;
        Thu, 20 Sep 2018 06:19:15 -0700 (PDT)
Received: from sugar.kfn.arm.com (E110176.Emea.Arm.com [10.50.4.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 555DF3F5BD;
        Thu, 20 Sep 2018 06:19:14 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ofir.drang@arm.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] crypto: OFB and tests
Date:   Thu, 20 Sep 2018 14:18:37 +0100
Message-Id: <1537449521-16182-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OFB mode generic implementation and more SM4 tests

Gilad Ben-Yossef (3):
  crypto: testmgr: update sm4 test vectors
  crypto: add output feedback mode
  crypto: tcrypt: add OFB functional tests

 crypto/Kconfig   |  12 +++
 crypto/Makefile  |   1 +
 crypto/ofb.c     | 225 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto/tcrypt.c  |  17 +++++
 crypto/tcrypt.h  |   1 +
 crypto/testmgr.c |  12 +++
 crypto/testmgr.h | 122 ++++++++++++++++++++++++++++--
 7 files changed, 383 insertions(+), 7 deletions(-)
 create mode 100644 crypto/ofb.c

-- 
2.7.4

