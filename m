Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A571C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BADC2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BADC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbeLJUyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:54:20 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:58651 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeLJUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:54:20 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MtOSu-1hJDBU36WE-00uq8N; Mon, 10 Dec 2018 21:53:14 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Oscar Salvador <osalvador@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stefan Agner <stefan@agner.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: mm: remove unused variable
Date:   Mon, 10 Dec 2018 21:53:02 +0100
Message-Id: <20181210205309.2794444-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yCH03GP4qhHadJnzsehxhfFpcyMSm8NyfRszg1Xwscl4maIXqMZ
 bP+8lbM8NYB2UwXPxazPsohiReP4Ab21cK2+xph73iJRpcfMfXGHYb8lU4jmXj48lYX6VY4
 XSRLGC0D3H1MDlEAjFU75dotK3288oB3YNaF3ltFiTe1ur4dBmad7QEUNqzNa/ZaVeXklG4
 LMCBAgFzmQHtKHFADoqUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LI/pbccW/cs=:SFoAhw4/LlAAeg4yLDGDTh
 qP2zKgGBkCDLF5+YlD2M2MegTAdB6/G1KEtvvPoBwlv4EH1/DW8VTk2NTaA/JullJXAlY6O46
 Whakxpn48COmZNODZPJL77m1jCXLrhdycDrE96aDuRZkURdI+UFvVoXHZt4Y7uZp6yKmwrxd0
 NN9oKTO5NWYtAnCbGdwDpg6EWcsNqzBmLwL64gGjCwXzRIPaeQGgY7TFn/seM2RWaCxYCqAwo
 9v/N5+Ic19ZtsW3IAUAppLs4q9Lc5JlQ+4FC5d34KRlBzQMFqG9yyh/aycnjnzyDnTG1x+ssU
 +pb5h+D4ZmyRYFBGuWwFdo753AqUkjQeReVV4jbheMAoeA6ahbJhPCOBw+oxjJlcUiRvMP9xf
 R13WBxwAjeGkmDHGWvTmZcUjavtsAGHIiyoZtQntwXiRh7z7azWyMnYm+Nw3yxK6jvdFMePDR
 OADLrRauKdwmrdecdqTmLUSSI8RcXA/csTp4KGflT+008u9nFb5m6XYb5BYP5gP0iUb3ZWDaC
 9XBBSa21iD9iL0rnYOg19IIz14tuQw3WmILQURzzus2dBQoZWLUCtDzAEORYd5NqAd8KmtTR3
 W/oUFLi4PJ9fO7/Fv7jNnQ6rBdlMKBXj7f3/JpWIXO4UN+Qg8Mtrq/v/+x8W0tPBhVm0EcQ8S
 RHyPt7UDc/QhOVRKRXb0/zI5FcBMvtU6hgA0/Ue8NmVO1PKE4T8Mpjaumob/3SSZxHec5+il8
 SA0yyCT29GWhE9M7BZZUUWk1X+8Q7qAJjFizIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change dropped the only user of the variable, which should
now be removed as well to avoid this warning:

arch/x86/mm/init_32.c: In function 'arch_remove_memory':
arch/x86/mm/init_32.c:867:15: error: unused variable 'zone' [-Werror=unused-variable]

Fixes: dd99d07f818b ("mm, memory_hotplug: move zone/pages handling to offline stage")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/mm/init_32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 0b8c7b0033d2..c75c26497c4f 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -864,7 +864,6 @@ int arch_remove_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
-	struct zone *zone;
 
 	return remove_sections(nid, start_pfn, nr_pages, altmap);
 }
-- 
2.20.0

