Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2968864-1520296167-2-12922278752962057614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520296166; b=F3kwURGAeXXRYZwoXYZu0GfCNMC7lLPqAFpW9cGGb0YXQMC
    D753+J12t7b+k2QXYEC9/K1L4OFl2216KJNSGv+awOoS2z8lHLbZANKSMMW5dbfs
    jIRUGwbCyEcr5iL+iCRKUKAIB1ptay/RTvtpIikjm+e+5ZatRB1hnrdMlUihw7Tg
    htuCYKAQJtuhaK3GTbzWSGviq6mK3KXIGT+IOCjJ4fj7f4hKZzVbi8Iw9BJtTafq
    BC4c5efYu6AF9jrAnQC7d8/A1NDKkuGG2h5SihhVTk1+JsaH3z+BA2MKf6ONPR1W
    vmrPpysLcGY5LIk6BroLbkkS/jFv/a/PH+wuq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296166;
    bh=UVNG4HagMrisyQniJEhR90qzoHHYVktKgQwjwBvcE2g=; b=Rq/dq6YqZQNk
    3uzS/BVehQJLxHYg5aWDNG+sLO5DW9T5zbCfINeu5jv/G31l3u2ze0VAYxFpUZFr
    6RpoFUHMO5SQ/4s2NqNpJ/zrw9/snBgKSPMxzcH2o7FEax4PhErvlOlL7HsD/T6C
    ajdwp+ENx8aL0/t65EQH3pzEN3xc0awNfMIQdnsQLLtac2OU8DK53JK+CsI3e+HB
    HpcageS5bZjrM3sgSpfZaLk8MHCJLBnc/iuLJVsKwShYlWDSLNDw1F998Yopm6fn
    CwPHa64mbf75ynBOdJ3dnPe8xfHxslFRwqY9LZam3R/2oGYfZUGtF9d3VD6Ez9iR
    ibszhGO/Mw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=TRRDUzza x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=TRRDUzza x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933532AbeCFA2o (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:28:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56696 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933534AbeCFA1A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:27:00 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 62/65] PTI: unbreak EFI old_memmap
Date: Mon,  5 Mar 2018 19:25:35 -0500
Message-Id: <20180306002538.1761-63-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=859
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060005
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Kosina <jkosina@suse.cz>

old_memmap's efi_call_phys_prolog() calls set_pgd() with swapper PGD that
has PAGE_USER set, which makes PTI set NX on it, and therefore EFI can't
execute it's code.

Fix that by forcefully clearing _PAGE_NX from the PGD (this can't be done
by the pgprot API).

_PAGE_NX will be automatically reintroduced in efi_call_phys_epilog(), as
_set_pgd() will again notice that this is _PAGE_USER, and set _PAGE_NX on
it.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/platform/efi/efi_64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 18dfaad71c99..12118bae3caf 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -90,6 +90,12 @@ pgd_t * __init efi_call_phys_prolog(void)
 		save_pgd[pgd] = *pgd_offset_k(pgd * PGDIR_SIZE);
 		vaddress = (unsigned long)__va(pgd * PGDIR_SIZE);
 		set_pgd(pgd_offset_k(pgd * PGDIR_SIZE), *pgd_offset_k(vaddress));
+		/*
+		 * pgprot API doesn't clear it for PGD
+		 *
+		 * Will be brought back automatically in _epilog()
+		 */
+		pgd_offset_k(pgd * PGDIR_SIZE)->pgd &= ~_PAGE_NX;
 	}
 out:
 	__flush_tlb_all();
-- 
2.16.2
