Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0C4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EA820864
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="TowtiU/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EA820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbeGRKSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:18:46 -0400
Received: from 8bytes.org ([81.169.241.247]:54792 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731827AbeGRKSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:44 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 296DA30A8; Wed, 18 Jul 2018 11:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906887; bh=8glzuKAs23d7wHuOZFiXc3kocfypfj5+orC4WHMKs0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TowtiU/2lgahyk1yLnLJZp83KaIfz92h7GQp5i7MLWzkj8zPrcQ6syXlpDHwUq7LB
         zCuPNg5E3AjPKPP1bsXtvLOxD6s4k5lwXIKvUj5qIAmPCxTeE7xbAodBQbEEq+/fhw
         tS92WuqXiUKtzJzEUkJL1xuqLkTrEEfXuhfxWj7LtBp+I8EiGiUcoloUdKE3lUEtes
         bVnNhWHRGZPrEAleugjRfrBQvsUU02sNTk1AGmX6ORZUH9FfvUsHYrtbJ+Pnlj2Nr7
         G1E1EkQMGcNqVn6XG7GZ78gDMw8NlGlZ9ZGBjET9xKvssOZ8PbGhXsdbKF9CasBxaE
         jsy6ZpgLGQyCg==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 37/39] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
Date:   Wed, 18 Jul 2018 11:41:14 +0200
Message-Id: <1531906876-13451-38-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Allow PTI to be compiled on x86_32.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 security/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index c430206..afa91c6 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -57,7 +57,7 @@ config SECURITY_NETWORK
 config PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
 	default y
-	depends on X86_64 && !UML
+	depends on X86 && !UML
 	help
 	  This feature reduces the number of hardware side channels by
 	  ensuring that the majority of kernel addresses are not mapped
-- 
2.7.4

