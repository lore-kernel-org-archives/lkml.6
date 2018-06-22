Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E797BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5F322BCC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="DcoR7N1B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oa/b10oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5F322BCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934125AbeFVAh3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:37:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33293 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933452AbeFVAhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:37:25 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A219721C49;
        Thu, 21 Jun 2018 20:37:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 20:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ljT2nPuahOKWGQfXA
        NK/6VXUifV3Vqdmpa630xZbqMM=; b=DcoR7N1BM8EJmS4RTKMnTzghOlQ+w+1oO
        3R/c8819MSgMcuKBQ3tiM/SMbj7Lni5ObUuuvY6PCSyyvOqg0MJxlB9joREMAeB5
        Uwj/3x1Ob/8WksvwZlf7z9tHdJS0ZUkGtlGMSQ39lL0WBn4RS+YYp6jpj2dammNA
        kFGBVct8AwpJgZ49rJEf0f+WPRD44QQ63PQtbrpzdKNu8SUAov13vqLWhv4EW2xT
        L8pSJYczt9TSL1ZQ+twlby4yJlRn1CdcIowsQy1j0KypC+FQ2ZU6ivMGky1N6sre
        5Huvkq1m0z3TsLr0K4NU+kZ7U37gSqHici2V7Rr1Y+xwOTulMmt9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ljT2nPuahOKWGQfXANK/6VXUifV3Vqdmpa630xZbqMM=; b=oa/b10oq
        RlTRA2bqroyJODc6te6N3ULH84e6TNHoJOgNxIx7HWZ5vaVa0OHH11gP8driwbE6
        kQ5Or/4MElatkQRL9BERiUwEEQwX0OBLlYiwqsFglx4o9qX2bT5IpL/yLSMOl/SG
        mDGRFOKJpCSqK1u4z+vOQ4wjzD30h7ADw1OM08GyksrNCfXYW/mumQjVesx84Be6
        O0SjlOuGYtuzAy6raECIfLCtsm8fKZ/iXelxJr4M52hXzoXzHrQXunvCyGeuWJCh
        7u5zexa55WddCm7c2pB85JoplDGZdgjq6HrIo0a9ptlvlsEHiV0NV1dieuIYmMcK
        p8BFoQZj2s+keQ==
X-ME-Proxy: <xmx:xEQsW1UXVkamWFgYJY3dRBAFF0ojDJvGiX_kp53MFanO-WwXarJaCQ>
    <xmx:xEQsW1xDQ7gbtiACRrDawMH66T51WaXrJvGYHCN9w5oCdc1RxBY27w>
    <xmx:xEQsWzOf0usEP9dED6OiCSe6Xka7a1ZddpBvaIvG60M9D44bqDOIYA>
    <xmx:xEQsW24YgIoRqi1aTYwWUt16YBAgyFKsAySGwsB9vvBoYkF4oOhAcw>
    <xmx:xEQsW0MmfZVD1SfYjeDwzVH-eGw71LjgJQbXsBn7AdjPKYIjFKyfzg>
    <xmx:xEQsW7Svh3jqKUr9xrlY2piJ7Ut16cfp501n4lYtOS8HQdimgUDmng>
X-ME-Sender: <xms:xEQsW3AqZ8GPuz_QminVH8CWBmzND6THRax7ePkI9KxklRrMKPOPkA>
Received: from localhost (124-169-15-204.dyn.iinet.net.au [124.169.15.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3373E4448;
        Thu, 21 Jun 2018 20:37:23 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Documentation: e100: Use correct heading adornment
Date:   Fri, 22 Jun 2018 10:37:05 +1000
Message-Id: <20180622003708.31848-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622003708.31848-1-me@tobin.cc>
References: <20180622003708.31848-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently documentation file was converted to rst.  The document title
has the incorrect heading adornment.  From kernel docs:

	* Please stick to this order of heading adornments:

	  1. ``=`` with overline for document title::

	       ==============
	       Document title
	       ==============

Add  overline heading adornment to document title.

Fixes commit (85d63445f411 Documentation: e100: Update the Intel 10/100 driver doc)

CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/e100.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/networking/e100.rst b/Documentation/networking/e100.rst
index d4d837027925..59b80608e27d 100644
--- a/Documentation/networking/e100.rst
+++ b/Documentation/networking/e100.rst
@@ -1,3 +1,4 @@
+==============================================================
 Linux* Base Driver for the Intel(R) PRO/100 Family of Adapters
 ==============================================================
 
-- 
2.17.1

