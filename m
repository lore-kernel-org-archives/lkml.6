Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DBFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C770D2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C770D2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeHPVu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:50:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbeHPVsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:48:39 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34F74CB7;
        Thu, 16 Aug 2018 18:48:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.18 02/22] x86: i8259: Add missing include file
Date:   Thu, 16 Aug 2018 20:45:18 +0200
Message-Id: <20180816171556.589478070@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171556.502583508@linuxfoundation.org>
References: <20180816171556.502583508@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3,6 +3,7 @@
 #define _ASM_X86_I8259_H
 
 #include <linux/delay.h>
+#include <asm/io.h>
 
 extern unsigned int cached_irq_mask;
 


