Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wso0BzNcGVsWIwAAmS7hNA
	; Thu, 07 Jun 2018 16:26:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 060E4608B8; Thu,  7 Jun 2018 16:26:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1Ooun3FR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5B3F8605A2;
	Thu,  7 Jun 2018 16:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B3F8605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753829AbeFGQ0H (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:26:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbeFGQ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dz1g0yN6Vrw1QqhKc51eeRhIxjNgIfWOk7o5Mf3X1p4=; b=1Ooun3FRC3mhfHt08Xv8Bx43XN
        TyEN60A7ddz110llFRMfpV62uVKvZtjea7aU67WOqalEaLZcgVX5Kc4S98TDCwHFvtI0r6u+rYT8m
        akfqS9kZyYZS7tlHnzWaYEF1mHsecHvEkKedp08+PxLbZSn4JffTiU+gOrGccOTzvQS8wH/UWZDJs
        7JLwfZQT9ezuRdeLBXTSjbrFI8LcA8riDFITeQY6ocoUJeHWOrYFS7lgzHKhtcn0XYpylqC0AZaGv
        syv5QjDc9+zMcRLoCBkyhYtcoY2ZiBzIRMABqEg8RrJO3g8U7qSVyjN7WD5UlztI5wuoonDxPp5BD
        bZU87YNA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQxjd-0001cI-W0; Thu, 07 Jun 2018 16:26:02 +0000
To: LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] lib/ucs2_string: add MODULE_LICENSE()
Message-ID: <b2505bb4-dcf5-fc46-443d-e47db1cb2f59@infradead.org>
Date: Thu, 7 Jun 2018 09:25:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix missing MODULE_LICENSE() warning in lib/ucs2_string.c:

WARNING: modpost: missing MODULE_LICENSE() in lib/ucs2_string.o
see include/linux/module.h for more information

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Found in linux-next but applies to current mainline.

 lib/ucs2_string.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20180607.orig/lib/ucs2_string.c
+++ linux-next-20180607/lib/ucs2_string.c
@@ -112,3 +112,5 @@ ucs2_as_utf8(u8 *dest, const ucs2_char_t
 	return j;
 }
 EXPORT_SYMBOL(ucs2_as_utf8);
+
+MODULE_LICENSE("GPL v2");
