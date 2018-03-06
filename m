Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2968864-1520296123-2-12100733491029154685
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
    t=1520296123; b=KeUKGSc34KI5mEWydDPGjKohXshgfbWj+zh7ZWA0qQ3hExS
    2K6Tv5I2UkQ//PCKZOSsXqoTBtu3OrPgu+j/M7INSrP6JgFw2CWoLMzH+L3JCUiP
    jLfG0i/UktjkM4kx7/dC6eC9oYFsGYkPDBjn+VSf9WLRxJtbqdcZAYrIQCY1UeOp
    avYo/q+Lc2cafIA/RDMXSfoXgNIodH+0BFdqDbR/7tEeLmUAkb+C8U2OOxOimZEq
    OgdZezDvVdBN3HV/jqPU8ygD2K4NU7C4kfkRrhQ4XTSQwSidrhgol+9Sdp6EsAMT
    HvBSnEYXuFCahz1qLp0/Y4BWC/lINF+9LYI8pUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296123;
    bh=t+mWKNqW984M7Ne4VJ8aF2LblQ8IFlUZQSrdxYPX/U0=; b=lE3/if5b30EQ
    9wuwwqtoo+/PmjgwJDzTnjjvbma1PBoprkawIguT+Wh8Z02SC8+SZBbITCwrgJCh
    NdVJs/Nketf7/9+TvwdVQFUvWclsvY1ZQguAKHBq7c60Lm0A6bmlV0auvPGuS4ix
    92/4kilRNKkfQycxa4rbgwHpyN5wcEgUjxv3Fd6rOtswi19oDAh8S8rVCk634MQi
    17rm8A67RtCbYl8g8B0b5OPwlqH3/gufgo86FIfR0MPPyVoPmZzYbivgPW+XOFTf
    Hc/EeMT5MMaVQl5fZcKd0EEERDdxJjUUeFS5WKhfbeZ2XgdxRZIdCaUlbvklJo/Y
    +1yKQ2gjyw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=t6l25PSw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=t6l25PSw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933098AbeCFA21 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:28:27 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41058 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933533AbeCFA1A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:27:00 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 58/65] x86/kaiser: Reenable PARAVIRT
Date: Mon,  5 Mar 2018 19:25:31 -0500
Message-Id: <20180306002538.1761-59-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=536
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060005
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

Now that the required bits have been addressed, reenable
PARAVIRT.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 750fb627d764eb66430c36961b94ab0002694c02)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 security/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index 9d63046e4794..ae44b94d63b2 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -34,7 +34,7 @@ config SECURITY
 config KAISER
 	bool "Remove the kernel mapping in user mode"
 	default y
-	depends on X86_64 && SMP && !PARAVIRT
+	depends on X86_64 && SMP
 	help
 	  This enforces a strict kernel and user space isolation, in order
 	  to close hardware side channels on kernel address information.
-- 
2.16.2
