Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93949C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5846620700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760639;
	bh=v9T6TakFieP3mgPHy/P4zktVpXhCSK3iwEKJiUnSC9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HeSr5l7VQEm/G5m5IHteQaZPq2lnpjcmEjob0htn5VONQEXV5E07/RsfwIkGXO4jV
	 Y+zL5PCArKPP6ZC6c4BtK8DDaWVuMyuF/t6FN5dTnxYy3ltf8Zw3NwqSdYwx/x/maB
	 n6G9VOm1dDe1/+qWUAagyd8hXRJAvbpKWAM1Cw2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfBUOiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:38:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbfBUOiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:38:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE3020838;
        Thu, 21 Feb 2019 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759889;
        bh=v9T6TakFieP3mgPHy/P4zktVpXhCSK3iwEKJiUnSC9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OS4Ihu3Xv7O5sOoCAM5RnvKV17ZN59unCeTIn0toA1KTHNUGNPSguM8k2tf6PvNry
         2wm0oSKon5glDT2l6mxRiimMkPA4QPqRh+GrIUlP7sw8S5Xt9xLZfW7ZhwhKsuBGPX
         mdOVp4y7fLvvhT906dfziw7q+yw/Bn7bMn+zpbHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 06/20] net: Add header for usage of fls64()
Date:   Thu, 21 Feb 2019 15:35:36 +0100
Message-Id: <20190221141946.957736250@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
References: <20190221141946.772985220@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "David S. Miller" <davem@davemloft.net>

[ Upstream commit 8681ef1f3d295bd3600315325f3b3396d76d02f6 ]

Fixes: 3b89ea9c5902 ("net: Fix for_each_netdev_feature on Big endian")
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/netdev_features.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -11,6 +11,7 @@
 #define _LINUX_NETDEV_FEATURES_H
 
 #include <linux/types.h>
+#include <linux/bitops.h>
 #include <asm/byteorder.h>
 
 typedef u64 netdev_features_t;


