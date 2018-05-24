Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162596-2-8887903217315529431
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enfrda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162596; b=DlG5Ws2Ogrjdwn0payTKzEChdRCjL1Ops666YSjw50zd97f44h
    5U1pndHvhEPPRw0HNJYkaAF4P5N1CIUZQmSkB+j11Zm1+E5/IzJm7j51iqEG/64a
    BnwYjUgtQK/Q/koCjdnMEterN6l/4K22GFfHJzTRcMkmocwSvQ9mXm0dtAHji/vH
    yrCZWsM3ul2PUcb8soEZDhZodozUs9dNCq9ickip/UFP7d+lODB5OBfa69VzXCz8
    Dn5qy9Gwl62NqLjUaJUfGZ/Twjkh9/WsqzfNlzjaP3qkDYYOahvg9CSfGE6jvuDC
    OPgqCnUgOq4/q1woQ6fB75HKG6zO7Nxl9siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162596; bh=VXYRoc1g+ZZLw6KppkHPq6xlWaa2rb
    IlHvOsb/yOi6w=; b=aRIdDCesIDTVkZhiZRaSNxmDFbix/cBlIVukMfi1lxZ2tK
    dZB/xbfRHhrA+cabqvV8yJKDq483PzGmhmR9N954GDdTnlgzk7D9NhJK4ofpz7fS
    LX/4Q7fLaW7/BsjdzXsgK8YTITNIRRn1ooUkP2iuxeEu429HcMAvFhkpufwUJQfa
    8nCilvRW6XQ8mYFdiMkwCmWF2OjaPFNDy1NPLSAe9DtAKT/hXnJ6BopzT4m6n4Kn
    GSvWkUMsbo5u1yR2T/mIDsF7xl2oGHDSC83z/Plf7wBoREZ+a88SkhKRIYCj9ku3
    92V1784mC1dScTyBJ5uzQ2sGJuVbM2B1AsJDLRZw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=qWRDBE7y x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=qWRDBE7y x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBBYZDd5yCwhpG4dEki48/dcRSBqOG6QcxCZ7RaZVWkr71ZLLtl6yTLn8AUJ0mO8qk8osfDcOZrcq3xoMRNxm0ksUbQCdMDn+kaMtTr71rfBEQpFjcdy
    Kv58W3EjFMENHH5EZfu1apdoYO8LbW/ZO0p8DSubWcGpEUtjrALrAvgNq/PkFxT50SJFlEl7v9l6+IiKnB0PkfCOA0MFytNi21U5minGsYZ+mvfDxQfNx1rq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=ufqGcfKlqT5-bIr_u84A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966560AbeEXJrF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967000AbeEXJrE (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.4 78/92] s390/lib: use expoline for indirect branches
Date: Thu, 24 May 2018 11:38:55 +0200
Message-Id: <20180524093206.724794605@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit 97489e0663fa700d6e7febddc43b58df98d7bcda ]

The return from the memmove, memset, memcpy, __memset16, __memset32 and
__memset64 functions are done with "br %r14". These are indirect branches
as well and need to use execute trampolines for CONFIG_EXPOLINE=y.

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/lib/mem.S |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -5,6 +5,9 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
+
+	GEN_BR_THUNK %r14
 
 /*
  * memset implementation
@@ -38,7 +41,7 @@ ENTRY(memset)
 .Lmemset_clear_rest:
 	larl	%r3,.Lmemset_xc
 	ex	%r4,0(%r3)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_fill:
 	stc	%r3,0(%r2)
 	cghi	%r4,1
@@ -55,7 +58,7 @@ ENTRY(memset)
 .Lmemset_fill_rest:
 	larl	%r3,.Lmemset_mvc
 	ex	%r4,0(%r3)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_xc:
 	xc	0(1,%r1),0(%r1)
 .Lmemset_mvc:
@@ -77,7 +80,7 @@ ENTRY(memcpy)
 .Lmemcpy_rest:
 	larl	%r5,.Lmemcpy_mvc
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .Lmemcpy_loop:
 	mvc	0(256,%r1),0(%r3)
 	la	%r1,256(%r1)
