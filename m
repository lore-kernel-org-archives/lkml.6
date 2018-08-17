Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36CBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B6921565
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B6921565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeHQNF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:05:29 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45150 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeHQNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:05:29 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M21dP-1gA3N422qx-00u4eZ; Fri, 17 Aug 2018 12:02:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     x86@kernel.org
Cc:     Nicolai Stange <nstange@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: mce: add notifier_block forward declaration
Date:   Fri, 17 Aug 2018 12:01:36 +0200
Message-Id: <20180817100156.3009043-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:R0c+WypTWKGLzDvn9yClcpZrzgal3Kubwv4Pp4u/9c+ujoU11uI
 F6NTkguZZeXk7cW0AB5bfeoiwcy50Gj4diPVNJzjaqT9v6UaV44evL5MYOIjRXShoBiqBy7
 MVsyVn1kRwx8YB3UFbxQV5m8zKGvKBI0E43JVEMBo0rKrEDBhoupEln9ZPMECtd0+Ik2I3v
 o7UK7ze0C4lwcg9NKHpLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3GhQ+9UHCck=:97U978XbdwVS18+6l/Ncrp
 pUKfCiT6DPa8i3aKOXAuDKskAlV1bJUx4fiGK+WqNa58oYCiGmNg8bO1MJpnLSY3Qpv8twbOY
 jA3aDhb3HP/tcymzLFMNsfCX+if9Sh1GqTCNM5LMzFXOvax1VYZB/n1kqS59qQIztq5e/ETMn
 IDldSS2vTICRmAwGjzGX8bPmF5T/kNtM9MW+xMPx9Iaz6p6C+qpuw6B98vAmZdDXWpkduLSKW
 IOtx2bk79O4HBqnAvJbdL7Jk7KHs89JYqRw3hRUkuu6hODBxJBUUcxIerjG0GoTb1wpRzo4c/
 ZWgBXsmEJcst8U90D5UlyZsxTg6k8+QuUPpJEmLqm0pYrtCfUJQfx44fPazSbe1rO7AOlTiot
 vK/xEqIR80iNbGiPWCFG7nfls0KF5QDy9xzhpCCT56Es/P9vZgwS8ID7SM5dVXNqLjMZ8fGOP
 0D17nyFRFfFHo4UbegU9IVPtknGTU5fLqTkJyHK3z+JgGWVnvoCHy4Tu4QECsi3w0GqU2oiT/
 yxCDXFnIRBjFCf9lsvM7dXsY5TtsPArwY53DDd+WY6pmsZRpI7EnmMV+OLJVRKY22Dcw8cC6j
 qNwxo7odkBQPoQso4x1dm+6H1yDL8py7VDnxr1hRzAu00+SLyJsgjQRt2YbQ1wALvXOydlFIo
 zAF3s2OFfNxDOVtXhtY4VxizI6WlQL9gqQVgyK3ol/KWe3Htck3p67i+F3hpzrFKaSu4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without linux/irq.h, we don't see a declaration of notifier_block,
leading to a build warning:

In file included from arch/x86/kernel/cpu/mcheck/threshold.c:10:
arch/x86/include/asm/mce.h:151:46: error: 'struct notifier_block' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]

It's sufficient to declare the struct tag here, which avoids pulling
in more header files.

Fixes: 447ae3166702 ("x86: Don't include linux/irq.h from asm/hardirq.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/mce.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 8c7b3e5a2d01..3a17107594c8 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -148,6 +148,7 @@ enum mce_notifier_prios {
 	MCE_PRIO_LOWEST		= 0,
 };
 
+struct notifier_block;
 extern void mce_register_decode_chain(struct notifier_block *nb);
 extern void mce_unregister_decode_chain(struct notifier_block *nb);
 
-- 
2.18.0

