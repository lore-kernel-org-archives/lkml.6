Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1B4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24212054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24212054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeH3NmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:42:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeH3NmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:42:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7U9ehcL1703544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Aug 2018 02:40:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7U9egcZ1703540;
        Thu, 30 Aug 2018 02:40:42 -0700
Date:   Thu, 30 Aug 2018 02:40:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nick Desaulniers <tipbot@zytor.com>
Message-ID: <tip-1f59a4581b5ecfe9b4f049a7a2cf904d8352842d@git.kernel.org>
Cc:     ndesaulniers@google.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        ben.hutchings@codethink.co.uk, hpa@zytor.com, tglx@linutronix.de,
        boris.ostrovsky@oracle.com, gregkh@linuxfoundation.org
Reply-To: jgross@suse.com, ben.hutchings@codethink.co.uk, hpa@zytor.com,
          boris.ostrovsky@oracle.com, gregkh@linuxfoundation.org,
          tglx@linutronix.de, ndesaulniers@google.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180827214011.55428-1-ndesaulniers@google.com>
References: <20180827214011.55428-1-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/irqflags: Mark native_restore_fl extern inline
Git-Commit-ID: 1f59a4581b5ecfe9b4f049a7a2cf904d8352842d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1f59a4581b5ecfe9b4f049a7a2cf904d8352842d
Gitweb:     https://git.kernel.org/tip/1f59a4581b5ecfe9b4f049a7a2cf904d8352842d
Author:     Nick Desaulniers <ndesaulniers@google.com>
AuthorDate: Mon, 27 Aug 2018 14:40:09 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 30 Aug 2018 11:37:09 +0200

x86/irqflags: Mark native_restore_fl extern inline

This should have been marked extern inline in order to pick up the out
of line definition in arch/x86/kernel/irqflags.S.

Fixes: 208cbb325589 ("x86/irqflags: Provide a declaration for native_save_fl")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180827214011.55428-1-ndesaulniers@google.com

---
 arch/x86/include/asm/irqflags.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c14f2a74b2be..15450a675031 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -33,7 +33,8 @@ extern inline unsigned long native_save_fl(void)
 	return flags;
 }
 
-static inline void native_restore_fl(unsigned long flags)
+extern inline void native_restore_fl(unsigned long flags);
+extern inline void native_restore_fl(unsigned long flags)
 {
 	asm volatile("push %0 ; popf"
 		     : /* no output */
