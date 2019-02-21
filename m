Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E78DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFBD2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760074;
	bh=jKv3Wadhwki1RXrg5X7AnIE7PgCDy7ETKtxTfi4QFiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xs+/SoXMbVRAGXIC51rSAOv+qjpK8/kVVg21M1+PBAKkz2NHYzD/BH6PU57ckO2EE
	 4EDNASqDxCEgi9NTiN/vHRl0Z6loG9fekcmBFjELKXBphOZ0yuSg0IC3xd7/FO//Eo
	 yzRPv+hUX4+RRwgeQo1d0K7zJFGTDkbq7QkgmfGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfBUOlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:41:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbfBUOlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:41:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88D542080D;
        Thu, 21 Feb 2019 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760070;
        bh=jKv3Wadhwki1RXrg5X7AnIE7PgCDy7ETKtxTfi4QFiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOOt483ib2zRwlhH9VnSIdb+jFoJ9sW/0kE9SLoqvPAB3rzWjx1JDB9P3HCfHlIB/
         JylUxSjYlTf+A0QXck8Kd7ke9uvvVFqkIIXluY906tH8jn7aZGU6LkKj87hSsoi1qJ
         NUWNXQr6Amyrb05ZQgQYQAorNLPTGyov4+5Omr0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 17/30] net: Add header for usage of fls64()
Date:   Thu, 21 Feb 2019 15:35:59 +0100
Message-Id: <20190221125251.487508262@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8681ef1f3d295bd3600315325f3b3396d76d02f6 ]

Fixes: 3b89ea9c5902 ("net: Fix for_each_netdev_feature on Big endian")
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdev_features.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index fce28562bed29..4c76fe2c84880 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -11,6 +11,7 @@
 #define _LINUX_NETDEV_FEATURES_H
 
 #include <linux/types.h>
+#include <linux/bitops.h>
 #include <asm/byteorder.h>
 
 typedef u64 netdev_features_t;
-- 
2.19.1



