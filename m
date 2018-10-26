Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AAAC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DA22082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DA22082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeJZOel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 10:34:41 -0400
Received: from mx.socionext.com ([202.248.49.38]:44527 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeJZOel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 10:34:41 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Oct 2018 14:59:02 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 1F635180B67;
        Fri, 26 Oct 2018 14:59:02 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 26 Oct 2018 14:59:02 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id A55F440394;
        Fri, 26 Oct 2018 14:59:01 +0900 (JST)
Received: from hamster.e01.socionext.com (unknown [10.213.134.20])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 5E967120144;
        Fri, 26 Oct 2018 14:59:01 +0900 (JST)
From:   Keiji Hayashibara <hayashibara.keiji@socionext.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     stable@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, linux-kernel@vger.kernel.org,
        hayashibara.keiji@socionext.com
Subject: [PATCH v2 0/2] spi: fix incorrect property items
Date:   Fri, 26 Oct 2018 14:58:43 +0900
Message-Id: <1540533525-1816-1-git-send-email-hayashibara.keiji@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes incorrect property because it was different
from the actual.

The commit 71b8dfc691a3 ("spi: uniphier: re-add addressing properties")
is the updated patch, therefore, it must be applied after
the commit 7662d1dc17d4 ("spi: uniphier: fix incorrect property items").

Changes since v1:
- Add commit 71b8dfc691a3 ("spi: uniphier: re-add addressing properties")
  The addressing properties of #address-cells and #size-cells
  are back again.

Keiji Hayashibara (2):
  spi: uniphier: fix incorrect property items
  spi: uniphier: re-add addressing properties

 Documentation/devicetree/bindings/spi/spi-uniphier.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.7.4

