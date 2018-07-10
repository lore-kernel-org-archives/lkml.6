Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC3EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC53D20840
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="V5rrUtXC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pnzfhcD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC53D20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeGJA0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:26:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42625 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754624AbeGJA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:26:06 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2EA7B21D4E;
        Mon,  9 Jul 2018 20:26:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 09 Jul 2018 20:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LZfXKN8sq5UmfFmmM
        bxpK1K+IL+6XGgXUvN5oVmGgj4=; b=V5rrUtXCTcTUoMLi1csjl24IACICNyMdj
        MlvqWUs2Bg+PcVW/5m1AGqsRYIfGC7b6BpxRQGr9f/qjfet14CREn0dGvs3eCXts
        im5WgbNeonp2j+zANmQtmV2DD0pHOyXpBkuzTM4X6z025+dG5rcfyyWWKeoRKvBr
        6SzCHv6HN984EC24pdPb3B5XELcceblrkxhFNMV3Vnh12sH09UI1nx3MG6LCq6Pv
        Bw+4TaVBZ5NU8PTR2xyOQarjWN5Y72cjCP+hShVfNDqernGzyRaenC0UQ3WRmeNe
        2vw50WA26oT8oqpIkLtpIRUNadnuL2L24oT1ID+lFBbJRN3sD7HnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=LZfXKN8sq5UmfFmmMbxpK1K+IL+6XGgXUvN5oVmGgj4=; b=pnzfhcD1
        n66d09veGZ0aw0en59aF/5yf25+aPOVju7YzNMAzwVCqKf8DBNfKp1/PHIgNboym
        n70/QWJU3WRIXvBbPOXZuVbaqlJiJBk5scRpYRoeISYb0tFCy3k4T1gIoNb3Z7sj
        lfyY3CUvfsCAPRzaW9R9i4ewGjdyv79zC9cWEyOaB3l9q2+IzRp8hTZEBZi2IQVD
        ldHl4y4ZC/16/DySaNUTAHAsoPqvAIvEUnUb1gvZi1brfInaBaZ6Yhm+P3erH/rU
        50HTexoGl20EzdmdGOxDsM+ro/HePNMCxzwmvkFeTWv0RKabyIcGNYG2Xea3Bsfx
        holgjEmnSiTABQ==
X-ME-Proxy: <xmx:Hf1DW4Pj5D7lzsWhwfNMg4bq0plvAFbj7PzkApR0d_4Du8y9N2O7Uw>
    <xmx:Hf1DW534Be_4t1UpLjbO-JHatqSQRPNoWlsHBNTRpJ5PgqnJb1ll4g>
    <xmx:Hf1DWwPJq-escpnk5lLclV-USY40F_ggedZK5EsTdCZEz5XYy7QsBQ>
    <xmx:Hf1DW3umV97Fw23d15YB_J46_URBj4pFYMyFp0lfA88vy5CJk1jwmg>
    <xmx:Hf1DW7GjPSKT0vfF1dHtTuXhRoTfnkd3m45Vl7oAJrQaiDR_AgecZw>
    <xmx:Hf1DW9FOBUoBLe1pm56qhFW7NiFOnNN_IRFS7imEnYCvCTi3puXP5A>
X-ME-Sender: <xms:Hf1DW8UxX2Zjzt6Ek94JEDZOECNk-MNF63ubznv88IALwWjf36F8PA>
Received: from localhost (ppp121-44-208-89.bras1.syd2.internode.on.net [121.44.208.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5CC9CE45C9;
        Mon,  9 Jul 2018 20:26:04 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] docs: Fix docs for boot parameter debug_boot_weak_hash
Date:   Tue, 10 Jul 2018 10:25:19 +1000
Message-Id: <20180710002519.5044-4-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710002519.5044-1-me@tobin.cc>
References: <20180710002519.5044-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently boot parameter 'debug_boot_weak_hash' was added.  Latter
discussion on LKML developed more descriptive documentation but due to
the programmers lack of understanding (*cough* me) on how linux-next
works these improvements never got picked up.

Update documentation for boot parameter 'debug_boot_weak_hash' as
discussed (patch posted and acked) on LKML.

Fixes: bfe80ed3d7c76 ("vsprintf: add command line option debug_boot_weak_hash")
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31c9b76058a7..e3b1c84d19c6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -749,13 +749,12 @@
 	debug		[KNL] Enable kernel debugging (events log level).
 
 	debug_boot_weak_hash
-			[KNL] Enable printing pointers early in the boot
-			sequence.  If enabled, we use a weak hash instead of
-			siphash to hash pointers.  Use this option if you need
-			to see pointer values during early boot (i.e you are
-			seeing instances of '(___ptrval___)').
-			Cryptographically insecure, please do not use on
-			production kernels.
+			[KNL] Enable printing [hashed] pointers early in the
+			boot sequence.  If enabled, we use a weak hash instead
+			of siphash to hash pointers.  Use this option if you are
+			seeing instances of '(___ptrval___)') and need to see a
+			value (hashed pointer) instead. Cryptographically
+			insecure, please do not use on production kernels.
 
 	debug_locks_verbose=
 			[KNL] verbose self-tests
-- 
2.17.1

