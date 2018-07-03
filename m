Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE48C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C342409E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y/yPzVTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C342409E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeGCToC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:44:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbeGCToA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T4fq5kb/8/V1GJAHW61w3uaMXpaP/lVhRTUvi2D8ZfE=; b=Y/yPzVTfdpWDYB5JmCGT3Rv2V
        zPq9EITj/oAatQpw0hiZRbzWLx0PmydkSz7/iVSvtzDMQU1J21/rSiMaAjDZhtc/1Ls1Ptyo0Uesm
        4uKXKcrrKmj/qNxS6i7Y9TwnH+eayBLiVdzOLdlY5leR2vxOsmJ4pjT9SeH87mJd48yUjk+I8Peln
        C4zobm8mkTMPzYHHDfjrnavkXCHyhxwpaU0AFVqpYbYkpYinikDIM8OtBoGxCw6sWVOojg9lwc/bb
        5Ac3vu6uMYi8P8IoeckbXX2Sn+pnNO9ReD7Tv/bdZDrbnOtchuXzrGtQVsO9tGawHdDnjLCEtORlt
        8mBcjbndA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faRDS-0005oW-Ux; Tue, 03 Jul 2018 19:43:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-doc@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] reed_solomon: Fix kernel-doc
Date:   Tue,  3 Jul 2018 12:43:54 -0700
Message-Id: <20180703194354.21614-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current doc build warns:
./lib/reed_solomon/reed_solomon.c:287: WARNING: Unknown target name: "gfp".

This is because it misinterprets the "GFP_" that is part of the
description.  Change the description to avoid the problem.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 lib/reed_solomon/reed_solomon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index d8bb1a1eba72..e5fdc8b9e856 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -283,7 +283,7 @@ static struct rs_control *init_rs_internal(int symsize, int gfpoly,
  *		in index form
  *  @prim:	primitive element to generate polynomial roots
  *  @nroots:	RS code generator polynomial degree (number of roots)
- *  @gfp:	GFP_ flags for allocations
+ *  @gfp:	Memory allocation flags.
  */
 struct rs_control *init_rs_gfp(int symsize, int gfpoly, int fcr, int prim,
 			       int nroots, gfp_t gfp)
-- 
2.18.0

