Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3687130-1526635072-2-10780817780909305800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526635072; b=MYK8Du05dwLQTVL59ywkNTJu+MEe/nWfK8/C6fG5PfXNjWc4fO
    TK27u97wcA92SLkboFpTFkBSfBP9CiFML017I6i4QIXqmIlrQYgXxyAp/eLiDPuO
    EZtoHsxXGkd+Kg6TzNH81BffSdEf3dy02DpEvxm9L/9LD6t3DVp6MJaTqFtiuaay
    18eIEg25AimOD3/4Ha6Gbht3tvlZDG/EVptMIl7JQUJyelQtAWzitJ1oH7FkTxaS
    XwOJHSrjYE/6Oq+SYa52vEuCYhhKA7c0SPtvDeDYrkU7ulnqA6rxYAnAfA0kfE/4
    zGQ4FQC2c6H/ihyR1wSYgXhrn7nX62rgVIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526635072; bh=
    W3a9UvMQ7wLrJQ4wo++ETvRdh6owrcfKVDfFe3qkC2M=; b=GkN1D4kiBQI5Fjdd
    p1RMg92SIU5BGWSXgCmxyRJ8i+WEC24LVixS20MagzrjoBsHJ5Wc9eQ5HjUMsBT9
    HMPXVxURw5UKQYCL/wTtEq1wtIYJ8zlOa83pxJNz/li/HiKuRbCGgZrpC5xj2b+l
    dsiAY9QzWap9wLr2dt7P6JSig2WKN2z7lhWeXVxc2rj7qnTPnpVh/18FcGGLd3Vl
    mV2JPg6QOI6bs3RWhtp8xNvIgetAAU3cFCRFVdCnmpg17CPIa5Sss2kJ8Vs9kJ9J
    XdX/vg7lab3AauFtAsHFp/2bpQbWeFMKqfiSAjKJoFW/YE0D74FJkXe2y91UJLi+
    F+vPIg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGgSNAnG2vDjKMaxGWhmEMfb58EPjZ+vUPUBrHMsDdrwwmTlgEgbQ57twMxTjPLC/gKt0B95XWBTiWMxVqN4HtAOTK1+XT59UOo3QXlYfOz/A1HTu+Cw
    oVIs/0PsYh+X6Xbj1HH520/GFDlKnF2MHq117UeDYGBdQQi+Jm4gl+/k8hHU4wkEV9Xw1rpb1vLr34QOqjUDBq9CPCpLfYQjxBqfNC0zeb7EKHlKprITZfvU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yPCof4ZbAAAA:8
    a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=VwQbUJbxAAAA:8
    a=cWRNjhkoAAAA:8 a=7oKMMc3qSL3hCyy2-ucA:9 a=WzC6qhA0u3u7Ye7llzcV:22
    a=NdAtdrkLVvyUPsUoGJp4:22 a=AjGcO6oz07-iQ99wixmX:22 a=sVa6W5Aao32NNC1mekxh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeERJRt (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 05:17:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:45458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752835AbeERJRm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 May 2018 05:17:42 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v6 14/28] xen/pvh: annotate data appropriatelly
Date: Fri, 18 May 2018 11:17:07 +0200
Message-Id: <20180518091721.7604-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180518091721.7604-1-jslaby@suse.cz>
References: <20180518091721.7604-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the new SYM_DATA_START_LOCAL, and SYM_DATA_END* macros to have:
  0000     8 OBJECT  LOCAL  DEFAULT    6 gdt
  0008    32 OBJECT  LOCAL  DEFAULT    6 gdt_start
  0028     0 OBJECT  LOCAL  DEFAULT    6 gdt_end
  0028   256 OBJECT  LOCAL  DEFAULT    6 early_stack
  0128     0 OBJECT  LOCAL  DEFAULT    6 early_stack

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/xen/xen-pvh.S | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index e1a5fbeae08d..52b28793a625 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -137,11 +137,12 @@ END(pvh_start_xen)
 
 	.section ".init.data","aw"
 	.balign 8
-gdt:
+SYM_DATA_START_LOCAL(gdt)
 	.word gdt_end - gdt_start
 	.long _pa(gdt_start)
 	.word 0
-gdt_start:
+SYM_DATA_END(gdt)
+SYM_DATA_START_LOCAL(gdt_start)
 	.quad 0x0000000000000000            /* NULL descriptor */
 	.quad 0x0000000000000000            /* reserved */
 #ifdef CONFIG_X86_64
@@ -150,12 +151,12 @@ gdt_start:
 	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
 #endif
 	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* __KERNEL_DS */
-gdt_end:
+SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 4
-early_stack:
+SYM_DATA_START_LOCAL(early_stack)
 	.fill 256, 1, 0
-early_stack_end:
+SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
 
 	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,
 	             _ASM_PTR (pvh_start_xen - __START_KERNEL_map))
-- 
2.16.3
