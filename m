Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835C2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382D820673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CBNUx9Qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382D820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeGTDWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 23:22:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbeGTDWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 23:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Yg9IIdtDMt3XObLs8JRDH6X0MbbctWjkD0O95sDmIo=; b=CBNUx9QmlgGkJOF9IFowuBHRB
        WD69Jzcsc+Y1fvPWeHOyusJpoqTNlvBD5FR69i//2PmOtmoDbJFR0uRvHz6gxXo6tBOycVz5EmBlU
        WwwQRo9zJPHzwTho8uen3O6D2JeFdIdjVgqRuD12h4vtoZCjvYpijx8IeunW49wIeIZ+hylT7bv20
        d1GEjWsMbsYB1qqg8smgznXe7ndiGkAB+IuZGM0VyGaXVbPjCy9pg3o9MXTnJS7PE0wXennT09t8g
        WEwak+7diDB6QV7uxvn1OpBh7Uj9M/qPoLjtKFYVTXYOSkAIOZBl4FxFk3HUEMVaOAxMa0VlJPUuK
        PltFxNbgQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgLH5-0002IA-Ge; Fri, 20 Jul 2018 02:36:07 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/h8300: eliminate kgbd.c warning
Message-ID: <7c458f27-9603-af24-e4e3-b87ef99693e3@infradead.org>
Date:   Thu, 19 Jul 2018 19:36:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the "const" qualifier from arch_kgdb_ops to eliminate the gcc
warning (gcc version is 8.1.0).

arch/h8300/kernel/kgdb.c:132:24: error: conflicting type qualifiers for 'arch_kgdb_ops'
 const struct kgdb_arch arch_kgdb_ops = {
In file included from ../arch/h8300/kernel/kgdb.c:12:
../include/linux/kgdb.h:284:26: note: previous declaration of 'arch_kgdb_ops' was here
 extern struct kgdb_arch  arch_kgdb_ops;

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
---
 arch/h8300/kernel/kgdb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180717.orig/arch/h8300/kernel/kgdb.c
+++ linux-next-20180717/arch/h8300/kernel/kgdb.c
@@ -129,7 +129,7 @@ void kgdb_arch_exit(void)
 	/* Nothing to do */
 }
 
-const struct kgdb_arch arch_kgdb_ops = {
+struct kgdb_arch arch_kgdb_ops = {
 	/* Breakpoint instruction: trapa #2 */
 	.gdb_bpt_instr = { 0x57, 0x20 },
 };


