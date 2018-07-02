Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC23EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB2125065
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TtTxd3Ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB2125065
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeGBVRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:17:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeGBVRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=auro2qPQhr9wCLR4shgWTH+LAyRTO3EqUUkAe+G2Y+k=; b=TtTxd3IioAZwHfJxtRqqUY+Kv
        XwFYd6H/iU4EYMTx4uU/Copud2Lu+N4qJHrn6TDL0Nu427BcKKx6c9CiEZSSUaYacvTSzpbSJvtFd
        nyyR5sed/f+gOaPIkoB1b8SAkvEhkABUuVGlbCjbUqaVzBaFnwAHcOtQJNQWZrN40WzPoJ7+FKGTt
        OlKOr6PXcmRC9NYyMbO2Mfx/zLOceKPRQiOeCS/o2q0yN4FB02puEClNwojbtTqVHOrtvN8d++LjJ
        rGoT9MJvmRRVJpjhUG+1SeXrR0wYKgoQaPQQJK4gMKARAiLCStdvcmvhHaDuJ+rPwbhtWy8Bo6S3G
        AA6rCjDoQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa6CT-00074N-Qd; Mon, 02 Jul 2018 21:17:33 +0000
Subject: [PATCH] arch/Kconfig: use a menu to reduce clutter
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702144711.22111-1-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ba546f8-42bd-4400-131f-bb389812cb56@infradead.org>
Date:   Mon, 2 Jul 2018 14:17:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702144711.22111-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Put everything in arch/Kconfig into a General options menu
so that they don't clutter up the main/major/primary list of
menu options.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 arch/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20180702.orig/arch/Kconfig
+++ linux-next-20180702/arch/Kconfig
@@ -3,6 +3,8 @@
 # General architecture dependent options
 #
 
+menu "General architecture-dependent options"
+
 config CRASH_CORE
 	bool
 
@@ -1028,3 +1030,5 @@ config REFCOUNT_FULL
 	  security flaw exploits.
 
 source "kernel/gcov/Kconfig"
+
+endmenu

