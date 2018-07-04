Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA6EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD1123BFB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD1123BFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932835AbeGDKOF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:14:05 -0400
Received: from mx.socionext.com ([202.248.49.38]:46254 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeGDKOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:14:04 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 04 Jul 2018 19:14:03 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id BF13D60034;
        Wed,  4 Jul 2018 19:14:03 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 4 Jul 2018 19:14:03 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 52D3A1A01BB;
        Wed,  4 Jul 2018 19:14:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] reset: simple: export reset_simple_ops to be referred from modules
Date:   Wed,  4 Jul 2018 19:13:56 +0900
Message-Id: <1530699236-27867-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow reset_simple_ops to be referred from modules that use reset-simple
framework by adding EXPORT_SYMBOL_GPL.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/reset/reset-simple.c | 1 +
 1 file changed, 1 insertion(+)

This patch is due to the building issue as modules [1].
[1] https://lkml.org/lkml/2018/6/29/181

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index f7ce891..a91107f 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -87,6 +87,7 @@ const struct reset_control_ops reset_simple_ops = {
 	.deassert	= reset_simple_deassert,
 	.status		= reset_simple_status,
 };
+EXPORT_SYMBOL_GPL(reset_simple_ops);
 
 /**
  * struct reset_simple_devdata - simple reset controller properties
-- 
2.7.4

