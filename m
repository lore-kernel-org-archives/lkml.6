Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0796EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD5C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD5C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeHPVoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:44:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbeHPVoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:44:38 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA22ACE8;
        Thu, 16 Aug 2018 18:44:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 02/15] x86: i8259: Add missing include file
Date:   Thu, 16 Aug 2018 20:41:55 +0200
Message-Id: <20180816171625.917350241@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171625.340082081@linuxfoundation.org>
References: <20180816171625.340082081@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 0a957467c5fd46142bc9c52758ffc552d4c5e2f7 upstream.

i8259.h uses inb/outb and thus needs to include asm/io.h to avoid the
following build error, as seen with x86_64:defconfig and CONFIG_SMP=n.

  In file included from drivers/rtc/rtc-cmos.c:45:0:
  arch/x86/include/asm/i8259.h: In function 'inb_pic':
  arch/x86/include/asm/i8259.h:32:24: error:
	implicit declaration of function 'inb'

  arch/x86/include/asm/i8259.h: In function 'outb_pic':
  arch/x86/include/asm/i8259.h:45:2: error:
	implicit declaration of function 'outb'

Reported-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Suggested-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Fixes: 447ae3166702 ("x86: Don't include linux/irq.h from asm/hardirq.h")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/i8259.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -2,6 +2,7 @@
 #define _ASM_X86_I8259_H
 
 #include <linux/delay.h>
+#include <asm/io.h>
 
 extern unsigned int cached_irq_mask;
 


