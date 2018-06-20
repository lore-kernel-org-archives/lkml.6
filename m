Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED579C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6CC20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Lh9sYRUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6CC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754494AbeFTQgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:36:14 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:52433 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754272AbeFTQgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:36:13 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 58F9F1E04A8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529512572; bh=3RGQjbQdeRD/wXTKjWos3PRcfo3NtV5xF+yHF+9mBvw=;
        h=From:To:Cc:Subject:Date:From;
        b=Lh9sYRUywZEmRtgJ0FKmcDeOqRvUEnQaq/uiXeqKjKr54Wddg/U+cbZvx0UdHtTQO
         fifcDGYSHuLDSYct9BY8Gz8ezCnWTdp2wrkOF5DxAguBc8gYkLPEF54mr7ns9+Hx2A
         TmEkCecRqy6BSpimhqV9aWPbzYzrIGbm8kIkrr2s3j27K+9yAfRE6N6xRf1eDM1Gal
         pJrqa3mBzu4xg9Z3R+qYOxzCkT9qDotYMw2Zf5n/QuywaCzvp+qKqUVXoPcDPvRodG
         Rw+/0cq3DNr55uQ5f0tJoGNiQKULX9yAymO9vfJ9m0JqUHNg43VskA2OxvsOLbN6sG
         N6tMXRga8EWZA==
Received: from pt02.synopsys.com (pt02.internal.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id 546883699;
        Wed, 20 Jun 2018 09:36:11 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 9B4D13D5AB;
        Wed, 20 Jun 2018 17:36:10 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     Vineet.Gupta1@synopsys.com, Eugeniy.Paltsev@synopsys.com,
        Alexey.Brodkin@synopsys.com, robh@kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2] ARC: Add PCIe support for ARC HSDK platform
Date:   Wed, 20 Jun 2018 17:36:03 +0100
Message-Id: <9f41b2f9d6da018563fa35aee462ddb60afd922f.1529505192.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI support to the ARC HSDK platform allowing to use the generic PCI
setup functions.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
 - Split initial patch, following Alexey Brodkin suggestion.

 arch/arc/plat-hsdk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/plat-hsdk/Kconfig b/arch/arc/plat-hsdk/Kconfig
index 19ab3cf..556bc5e 100644
--- a/arch/arc/plat-hsdk/Kconfig
+++ b/arch/arc/plat-hsdk/Kconfig
@@ -9,3 +9,4 @@ menuconfig ARC_SOC_HSDK
 	bool "ARC HS Development Kit SOC"
 	select CLK_HSDK
 	select RESET_HSDK
+	select MIGHT_HAVE_PCI
-- 
2.7.4


