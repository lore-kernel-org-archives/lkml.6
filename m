Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162539-2-7606860388066280319
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
    1527162538; b=Z1+qdTuRsTutx5qob5GDfJRASFiP6HFFLfK8JUVR5kcBaLUuCP
    Na/M1TtbKfuPgP5wAxkp706ssZK2fkaLkCtDJ0IcHet7bhuKvkZMpqn/7f4jct+R
    YVEijUCR1dm2cf/pcmgQRRAd+aY4EG6H5OTU2/Kv/x4xQ+gmyNUeRYQJt/IR6tGf
    SGoQyv7vL0PSr3q9hW7QmloQMQXW+xKMVOfitinkvUYDSt0lZ9lBkWvUaMTelSsv
    UpN+sPzPntqxNUgXB+jNwMHZxgAksZXIolcun5tp36AyrFCN1k56hHzgHZ0bT6A3
    WcpNZZH1mprHz0u2T0KSNzoxtMJEIYiLxOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162538; bh=vojFtKJNldIj/hJUpUVSaS2m90DD9d
    I0KCXu9qeVX5w=; b=HUQWmSprhij83hgneiHY5XSw1cpF+vrUI3s90ylG0Ux0Bh
    mgL7p2f8oa93N0BBga5mtZ1/+SnhZf5a1kNTHtDPtoazWZVBP8oKFqWW4WCYvea1
    Tz/mVXgJ0/qh/KT/2ESgiIzxTHD8pX4Ws5qHkdmMjEuRnz/V2tOK6hjchmypEJNe
    ZNqq8/084bbXHmFiZgjyty2Yi4a/t3IOyEVRDVre9oGQZKg0b8SvitCCk2xrm5Sf
    lj5M9WrC5PYhebzp5gbxiQqS9iZ8WhXGkQWcPUnGjNObrESkbj9jRJ3/6ClmvSYn
    IVZ4jkKQv1OGrMIjrgX68kU0VXOs3RWON2DsXhdA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=QQdqA85/ x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=QQdqA85/ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKcopnKSQHlsqvhcJBQAwe3s7WtVvbruXjv94IZujFiksEJvh8MwyFC40YVEfBX2GW562JGieiRcha6Nvf42xBWY+7c9ny3yTvQgtqvjS/79alD113Wl
    3Y3ZuOIqEgi3rtACZhiafgRgo4hKUyiLNMg6kXIUexqxGU5QQ0Bq0vIgIZVP9fG/pal+20prwQMxQfelEJghHRI4omb9pdCEl+QjbZX4NwKjVA3eu1LeLVLY
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=ufqGcfKlqT5-bIr_u84A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967027AbeEXJrQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967014AbeEXJrO (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 4.9 12/96] s390/lib: use expoline for indirect branches
Date: Thu, 24 May 2018 11:37:55 +0200
Message-Id: <20180524093606.287016953@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6,6 +6,9 @@
 
 #include <linux/linkage.h>
 #include <asm/export.h>
+#include <asm/nospec-insn.h>
+
+	GEN_BR_THUNK %r14
 
 /*
  * memset implementation
@@ -39,7 +42,7 @@ ENTRY(memset)
 .Lmemset_clear_rest:
 	larl	%r3,.Lmemset_xc
 	ex	%r4,0(%r3)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_fill:
 	stc	%r3,0(%r2)
 	cghi	%r4,1
@@ -56,7 +59,7 @@ ENTRY(memset)
 .Lmemset_fill_rest:
 	larl	%r3,.Lmemset_mvc
 	ex	%r4,0(%r3)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_xc:
 	xc	0(1,%r1),0(%r1)
 .Lmemset_mvc:
@@ -79,7 +82,7 @@ ENTRY(memcpy)
 .Lmemcpy_rest:
 	larl	%r5,.Lmemcpy_mvc
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .Lmemcpy_loop:
 	mvc	0(256,%r1),0(%r3)
 	la	%r1,256(%r1)
