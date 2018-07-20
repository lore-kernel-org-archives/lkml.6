Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6522ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2CE2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="upUpbs5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2CE2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeGTDVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 23:21:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730998AbeGTDVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 23:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=39J5+tfU5/IfVaFOIq7uRFIL+IeshvyBjcc9Sln63f0=; b=upUpbs5ldoMzgp8hp148URZa1
        LelAgpotJWH+pgQU0fN8wK2Di6s8OT7SMaaaDNb/WHP8aRXjCkPvnBm5PJL1gGw0gFStCZYfsv6Zk
        6EirvrqOD2Ma0le85a67jbuEmhdtgz3AbtKX4uNh92mfq6kn0aqICrdRpD0tAnnPr9UQtaZy/E4Gf
        p+dpgjVdkT7kNGjoIMLo3d2PRC2IO4gEW8J5oqw0zHAio0GuEE6NB5XYEk9B94zhTURqlnBBIB4O7
        1Fht7IdPcwswT+IqQzucPMf75e6wHg3nHVon4w0oLSmrFe9BoR4CL6nQ7CFwtxqUPu0ZhnZJNmlia
        WNF3JNv5g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgLFu-0000y0-Sk; Fri, 20 Jul 2018 02:34:54 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/h8300: eliminate ptrace.h warnings
Message-ID: <c08b3519-0e43-98ff-1e09-397bcfd55270@infradead.org>
Date:   Thu, 19 Jul 2018 19:34:53 -0700
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

Add a "struct task_struct;" stub to arch/h8300's ptrace.h header to
eliminate gcc warnings (gcc version is 8.1.0).

../arch/h8300/include/asm/ptrace.h:32:34: warning: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration
 extern long h8300_get_reg(struct task_struct *task, int regno);
../arch/h8300/include/asm/ptrace.h:33:33: warning: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration
 extern int h8300_put_reg(struct task_struct *task, int regno,

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
---
 arch/h8300/include/asm/ptrace.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20180717.orig/arch/h8300/include/asm/ptrace.h
+++ linux-next-20180717/arch/h8300/include/asm/ptrace.h
@@ -4,6 +4,8 @@
 
 #include <uapi/asm/ptrace.h>
 
+struct task_struct;
+
 #ifndef __ASSEMBLY__
 #ifndef PS_S
 #define PS_S  (0x10)


