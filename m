Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1619120-1525105359-2-10968862542392933023
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES sk.us-asciien,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525105359; b=UY0b9mh9T7isHVClYEsFLlee09y5bcF1/8pPmELcRR72OxaZRQ
    G5YoKAq3HzpjmVGqJ8/sDd9OrMw3Kq4vx0gy87MbMrvg9ILh4phSpYE4TgtQTQLw
    zvrNvSAlhh25xLTrh5YpJNqplADLAJ2fLNy1bJMMUgcQP/6nt5qaXlcZcVU7V2L+
    +sdjM63CIZrAaapxiLA3ut9wvQqSIoJTUG2FBf/iohT0G0ZQtlQUXAGv/P8zaRWx
    PXiWb5hkyVEOYAseMcoFNY060JyxV+UY6g3ZPyFHAxdACrcaSydLSZL5iwZ7NNeu
    U71U7gNXH6EPlJBGNTzc7fzx0NaG5+j+GECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525105359; bh=
    BSLahkNdAGl01HEnmSDPGaGhcluTe6yZtcFicTra358=; b=i8CAgrJgWU4W20ME
    RJd5ZqeQnOmFAo7LDbn9afeNT3dZHkF7/NgAZpErzjGmlEaUksk4sj5HGT/QNPbk
    iGpUYt4K0eErS2rHe6ZCeWXdTCxTHOZc22uHSVoTA26kTeF2Rxb3D+nxNT0JD+H0
    arGh0Gz16IluHHcqU/bNidlU+/T/TfvHPb9vKGqyC39bY4xzVbMOSpO8gNje0WJt
    Fd7c5pr1tmhCCeUjGqVdwNq+2XRRDbpkosZ/MvGIxxxhrgtE0R/x4nOnwCS41BSV
    XA0JKCuPlk+siAHxNdD61WzDqAmy8IIdEDynKdLy2ZtZ/oiVpHZ9xzeeY7aT9JDX
    fXcszw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=SjkQnfdd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=SjkQnfdd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDjGAl3N8eVQhK6IDoYZoHRz/u3bFBbk2xrfzTba3NhHM/3o7yZWDQGQFB3TKmscewFGeYNk1ugXcK9n+Wkkqxr12Npx+vX1jKpV7JI7UkSPBxBErxIE
    lIfjGP80uFG9pHHfeK5qQ0ZJNuyBn3Jp7Eu163Mg2hsvl5k0HNEkOH0dmrcfN1E+g3K0Y3nJmkLgMdbwkFdhjHpICChX4SYmBhUxopYmhGK69vC0cIFLuJfX
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yPCof4ZbAAAA:8
    a=VwQbUJbxAAAA:8 a=LSXPwlEB9lKIrLBHdz0A:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754895AbeD3QVl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 12:21:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754557AbeD3QVk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 12:21:40 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH 3/4] xen/PVH: Set up GS segment for stack canary
Date: Mon, 30 Apr 2018 12:23:38 -0400
Message-Id: <20180430162339.17143-4-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=880
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300156
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We are making calls to C code (e.g. xen_prepare_pvh()) which may use
stack canary (stored in GS segment).

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org
---
 arch/x86/xen/xen-pvh.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index 373fef0..4eed586 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -54,6 +54,9 @@
  * charge of setting up it's own stack, GDT and IDT.
  */
 
+#define PVH_GDT_ENTRY_CANARY    4
+#define PVH_CANARY_SEL          (PVH_GDT_ENTRY_CANARY * 8)
+
 ENTRY(pvh_start_xen)
 	cld
 
@@ -64,6 +67,9 @@ ENTRY(pvh_start_xen)
 	mov %eax,%es
 	mov %eax,%ss
 
+	mov $(PVH_CANARY_SEL),%eax
+	mov %eax,%gs
+
 	/* Stash hvm_start_info. */
 	mov $_pa(pvh_start_info), %edi
 	mov %ebx, %esi
@@ -150,6 +156,7 @@ gdt_start:
 	.quad 0x00cf9a000000ffff            /* __BOOT_CS */
 #endif
 	.quad 0x00cf92000000ffff            /* __BOOT_DS */
+	.quad 0x0040900000000018            /* PVH_CANARY_SEL */
 gdt_end:
 
 	.balign 4
-- 
2.9.3
