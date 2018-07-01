Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D5C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E512596B
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YNUkIz4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E512596B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965205AbeGASWc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:22:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933606AbeGASWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AxbaeoqOPKDoZlC4kDXPbXRRtuIcktzPq4Y1ODVxouA=; b=YNUkIz4waIURQ24wKFwF8kQT/
        bX5DJlQzj/b1/UizGmhYR93deYMPbZvuQ4gWaRzBN5MQtjR6xPJD2a401tg5FuV/Ih95zRccFM5ow
        by9ilqMwoi9op6hNAnsCJPS0v1TyPzJO4EdoMKSwD7b0dUeu4lgdHXv+oigYF8T+EdNoNyhCxoDyP
        C9Z6RzOZbmGtkkRU4gx+i+ECVU2QsbuZEJmT3JxrSMJ8wm9qFP9/OoUfz4XDaNM9dJeu85mUWlyOC
        3W/WSfDNE2bb51FIA0fY4OmCdTj63hhv8FeFCxUT2d/pjx0uWy7IwWyK2ItWm7OyMzKK8uDAOm+6R
        23LzuMR8w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZgzA-0001WA-A6; Sun, 01 Jul 2018 18:22:08 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sysctl: fix typos in comments
Message-ID: <bb09a8b9-f984-6dd4-b07b-3ecaf200862e@infradead.org>
Date:   Sun, 1 Jul 2018 11:22:05 -0700
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

Fix a few typos/spellos in kernel/sysctl.c.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/sysctl.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- lnx-418-rc2.orig/kernel/sysctl.c
+++ lnx-418-rc2/kernel/sysctl.c
@@ -222,7 +222,7 @@ static int proc_dopipe_max_size(struct c
 		void __user *buffer, size_t *lenp, loff_t *ppos);
 
 #ifdef CONFIG_MAGIC_SYSRQ
-/* Note: sysrq code uses it's own private copy */
+/* Note: sysrq code uses its own private copy */
 static int __sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
 
 static int sysrq_sysctl_handler(struct ctl_table *table, int write,
@@ -1973,13 +1973,13 @@ static void warn_sysctl_write(struct ctl
 }
 
 /**
- * proc_first_pos_non_zero_ignore - check if firs position is allowed
+ * proc_first_pos_non_zero_ignore - check if first position is allowed
  * @ppos: file position
  * @table: the sysctl table
  *
  * Returns true if the first position is non-zero and the sysctl_writes_strict
  * mode indicates this is not allowed for numeric input types. String proc
- * hadlers can ignore the return value.
+ * handlers can ignore the return value.
  */
 static bool proc_first_pos_non_zero_ignore(loff_t *ppos,
 					   struct ctl_table *table)

