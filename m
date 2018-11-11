Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB0EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630712148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630712148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbeKLGUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:20:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50408 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730412AbeKLFsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:20 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsf-0000oU-FJ; Sun, 11 Nov 2018 19:58:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001sO-Dg; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Catalin Marinas" <catalin.marinas@arm.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.103430795@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 347/366] arm64: use linux/types.h in kvm.h
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit d19279154b3fff9adff96b54d1a77dfb8f01e3da upstream.

We should always use linux/types.h instead of asm/types.h for
consistency, and Kbuild actually warns about it:

./usr/include/asm/kvm.h:35: include of <linux/types.h> is preferred over <asm/types.h>

This patch does as Kbuild asks us.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/include/uapi/asm/kvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -32,7 +32,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/psci.h>
-#include <asm/types.h>
+#include <linux/types.h>
 #include <asm/ptrace.h>
 
 #define __KVM_HAVE_GUEST_DEBUG

