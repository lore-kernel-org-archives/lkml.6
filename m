Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2968864-1520296109-5-9816449193914520756
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520296108; b=Q706KzYg9/tmmA+CtXnDwGHZynJKpx6J3aVyzfgd/rlFF/F
    0apmafb8aUM+YV/nr6lyIhfwAd7dZKV9zgkrJoX2u8Lr4gPhTD0rHXTu5wr8Xhei
    OtwRbHjX+lnEIWhKqhd9rGsTIJ+cA1Otvih4E6gRqnjQOD0mJkfeW2sDCTSNUYKx
    wlej1Z8HqAFlJypGFQtkRkFP0JFbXsI3MwNWs84sXziUI2uphm+RiMmzmVVYCfDK
    wh6pjw63byeQAa93345hIlS75qKxlW/gimFaPTjXS3JrewU7vfb5oyzdgwaFgHSZ
    sWg/D11I6/K9UFmVn0vWd19/eGIjh0ZXqRn3UoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296108;
    bh=U66QPEXpCGVww41zgajJgDJZTQsz73FWdDkSbwjNl8M=; b=UqriTHiDRNfR
    03s4TdN4DZuyzKexBPlTPjrerpCnKJDf/cJIuOPxRqziGwlq22FrL6336bsWvJNp
    xubk1UohO5iEgCcX7jYZShMA79M1NE06Yk4GaLjUEPzTjUEzFmMYMrvJeu4GmJUk
    6Nps7SY5OUIms43yMZI3s1sOUPB2sgwi+/E2c7wWwgMfwAbVB3ngMjILWuhzZBUB
    qmEaMlT5e+BsS98dDAjW4IKYAufeISxhHdeTj+Py7pitHc82gehx/YBE2y7OJtgc
    NQ3tvfs5Qs7Tk5b7Rz1z7PhA53NtuZ+pAd4IMHQiSgPA8Op+rcxhVUDZ2MEGi2aH
    ZaMYvQJu2w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=KgrR82CI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=KgrR82CI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933540AbeCFA1A (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:27:00 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35250 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933324AbeCFA06 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:26:58 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 59/65] x86/kaiser: Move feature detection up
Date: Mon,  5 Mar 2018 19:25:32 -0500
Message-Id: <20180306002538.1761-60-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060005
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

... before the first use of kaiser_enabled as otherwise funky
things happen:

  about to get started...
  (XEN) d0v0 Unhandled page fault fault/trap [#14, ec=0000]
  (XEN) Pagetable walk from ffff88022a449090:
  (XEN)  L4[0x110] = 0000000229e0e067 0000000000001e0e
  (XEN)  L3[0x008] = 0000000000000000 ffffffffffffffff
  (XEN) domain_crash_sync called from entry.S: fault at ffff82d08033fd08
  entry.o#create_bounce_frame+0x135/0x14d
  (XEN) Domain 0 (vcpu#0) crashed on cpu#0:
  (XEN) ----[ Xen-4.9.1_02-3.21  x86_64  debug=n   Not tainted ]----
  (XEN) CPU:    0
  (XEN) RIP:    e033:[<ffffffff81007460>]
  (XEN) RFLAGS: 0000000000000286   EM: 1   CONTEXT: pv guest (d0v0)

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 7f79599df9c4a36130f7a4f6778b334a97632477)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/kernel/setup.c
---
 arch/x86/include/asm/kaiser.h | 2 ++
 arch/x86/kernel/setup.c       | 7 +++++++
 arch/x86/mm/kaiser.c          | 2 --
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 906150d6094e..b5e46aa683f4 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -96,8 +96,10 @@ DECLARE_PER_CPU(unsigned long, x86_cr3_pcid_user);
 extern char __per_cpu_user_mapped_start[], __per_cpu_user_mapped_end[];
 
 extern int kaiser_enabled;
+extern void __init kaiser_check_boottime_disable(void);
 #else
 #define kaiser_enabled	0
+static inline void __init kaiser_check_boottime_disable(void) {}
 #endif /* CONFIG_KAISER */
 
 /*
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1473a02e6ccb..1adaca0050b0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -111,6 +111,7 @@
 #include <asm/mce.h>
 #include <asm/alternative.h>
 #include <asm/prom.h>
+#include <asm/kaiser.h>
 
 /*
  * max_low_pfn_mapped: highest direct mapped pfn under 4GB
@@ -1034,6 +1035,12 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	init_hypervisor_platform();
 
+	/*
+	 * This needs to happen right after XENPV is set on xen and
+	 * kaiser_enabled is checked below in cleanup_highmap().
+	 */
+	kaiser_check_boottime_disable();
+
 	x86_init.resources.probe_roms();
 
 	/* after parse_early_param, so could debug it */
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 9d6b7517fca5..50783ad4861d 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -306,8 +306,6 @@ void __init kaiser_init(void)
 {
 	int cpu;
 
-	kaiser_check_boottime_disable();
-
 	if (!kaiser_enabled)
 		return;
 
-- 
2.16.2
