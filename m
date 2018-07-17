Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF76EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86318208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="f4fJNHJ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmrYqLw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86318208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeGQE77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:59:59 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:56633 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbeGQE76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:59:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B96CF373;
        Tue, 17 Jul 2018 00:29:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 17 Jul 2018 00:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LBEukSiOpZIHzJq8N
        5lWRH2JIQXUCu9WRyM5pd4kbu0=; b=f4fJNHJ89DuadTiZC1f+MD7i32G6usdlD
        nAcQD70yPJQmGhU56ApGpu4EnjdWWIWkmlXwkQBAXKTBJAODfQtT94bn8T0dxQdS
        n2LPcIx1vonQCClTwVBXjstAJiWo2gZWPHNngeHhnEJPdidBLIIzAI+ITX7jGAuw
        TvtzeYNxyeS+oe3Kl4jJJxEk3Xta67bRVCI4F1nae8px5X6k59+Ez23blUFYwnPg
        xSuDwnGQYIwgz/80mQbq10HR8UGs5HpioQbwR2pM+rfaPjiRWyXEae9XtvhP2084
        JBF6/5wG82CTr55BhRH5WYlrKfu5lo7AkHo8cLGJKGSfrT52QLG+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=LBEukSiOpZIHzJq8N5lWRH2JIQXUCu9WRyM5pd4kbu0=; b=EmrYqLw/
        K6SykQwyVDTXJoAP3OTOovmlFm6iIdzsSAHD/0XuJwM6VKVil2QEO5hT063Cq2+b
        Vd3x4SxhauGTXpWBTgNNRhh4Qa1cuLAv5HpNCRcoutBkgAr4GoQKUQkqf15Jd1Lt
        gXj8wcnIcjBAUk5/ydLD0bBc93pV9rWXWfwW0yUnqDWL+2EJeGfNTuwdZPRkYix4
        RhMfQ1nEQWDYW90cyK4dP1hIADefnaPW9I6GxPl8QQl5CQnr2d7z5tGnKswvKp/A
        CVFbtu8fqg0S8PB6i5ifcic4/0NyocGp6iDCJ9cRB+8vfZmYmJLDLoJZJCLBLKt7
        3wA8NRWT1RJOkA==
X-ME-Proxy: <xmx:oXBNW6Qj1-8dq8kKvH91UdXQEFlUjxuPtUziXY8MOvjoeFIQybMk1Q>
    <xmx:oXBNW_UbdxsXE8VpGTa75I3D_FwZr1S7Dt97NPZX_noJ3AHH7X-S7A>
    <xmx:oXBNW-RVMaAThztUOn-hp-rh6--xBlZbJORbqUEzXQSMRj7cAAqWQw>
    <xmx:oXBNW1k4KPCA0HnBL4rHac8tt-0RGL4HEOTnqnI8GDtJYUwb7SCoVg>
    <xmx:oXBNW68R0ZqIH2CMEOIZr1ctZlong_oxYPMl0wc99sGUT-bmBvVcYQ>
    <xmx:oXBNW83qYayKyZWW-aSAtGD0bUlDpRrRYdlZrz4zg29a0fPBtuVWEg>
X-ME-Sender: <xms:oXBNW8T0O-n-9qy6rGt_KLSaVGaFQSYlSWRpCqdleEva8cmNw2xsAw>
Received: from localhost (ppp121-44-239-37.bras2.syd2.internode.on.net [121.44.239.37])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8742E10261;
        Tue, 17 Jul 2018 00:29:20 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] docs: networking: Fix indices heading indentation
Date:   Tue, 17 Jul 2018 14:29:04 +1000
Message-Id: <20180717042906.17308-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042906.17308-1-me@tobin.cc>
References: <20180717042906.17308-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the 'Indices' heading is not aligned with column 0, it should
be.

Fix 'Indices' heading indentation.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 6123a7e9e1da..a4bbde70bcb9 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -20,7 +20,7 @@ Contents:
 
 .. only::  subproject
 
-   Indices
-   =======
+Indices
+=======
 
    * :ref:`genindex`
-- 
2.17.1

