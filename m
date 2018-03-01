Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519908924-2-17005596757719263630
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519908924; b=AnLec7+bR8JpSXWrmUmafXVo2Go9PT/OYMgV7WiU2pzZ4JR
    2uhAnXIrm9K+3EL9z/KAEam+El1jgf60+U9+uCRi/r/WsA3YL7lsDLI7WiLjB5K5
    vAjaQQBNY8A2gnWrCd0hOLuKHTMwdIP7WuGJbMdwVGpd1TvEv33bkGAQ5dqu2H0t
    3cFcR4Q7wrVLYQ5IDk8CkLCXoBW/hErMkZ8INXnGvIk9zjQv3yP1ebUh/TFqHYRe
    NRC2UBQV2aEH3lwY5OGZlPypRqlZDOeXJNAOcYnM3cYOEH05lF0SYnzaM3pZPsCo
    BQNKZvV/ygDzQ+trOb0lB+DFNaMyj51PIC6/laA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519908924;
    bh=Bg7B0hfDb1LbDSK0bEabGd/Si+r1Y+auDWs+NQonZeA=; b=v5BZHDE1ML7X
    ftAEES8wuSZUBveb7HJBtUohw7m09PaPYz3R0vdfzvbsKn1m73bHG/iZRFuMJ6/7
    eR8KQm5hAnlPLnSu3IwpIvSI2WHFtBbDHgIed1s/b3jvs6uEdIL9tf9aAw0IHRej
    in9NeZGbMlC1O4bhQPkQvfGgs+JdmCVDANsDiFF8qID16kO+pXnZ4qhj0ksGC+ST
    blLy+Y7R0Q3zTA2OZ9tAFX+0lsLKKB7/M7aTzROF/wKWl/YKzwk0Gj+YxG/K3WHD
    qq2BDsjMUXJOMXQ+vubiAwMDFlDCivKdQyn4U6jl0vgD8QpwQrOtwPZm5GgchV9w
    WPTbgevjgQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Em5SaGCp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WBKLbEIW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Em5SaGCp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WBKLbEIW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030486AbeCAMzT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:55:19 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32852 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030549AbeCAMzQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:55:16 -0500
X-Google-Smtp-Source: AG47ELtE0egcSDkbOW2sCHkd+qP67Yy8XRiwKXOj8uugzbA1Z7v5lP+mIxWrJL5etdQlLFPpwgcOhQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Laura Abbott <labbott@redhat.com>, Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 01/45] mm: Introduce lm_alias
Date: Thu,  1 Mar 2018 20:53:38 +0800
Message-Id: <1519908862-11425-2-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Laura Abbott <labbott@redhat.com>

commit 568c5fe5a54 upstream.

Certain architectures may have the kernel image mapped separately to
alias the linear map. Introduce a macro lm_alias to translate a kernel
image symbol into its linear alias. This is used in part with work to
add CONFIG_DEBUG_VIRTUAL support for arm64.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 include/linux/mm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2217e2f..edd2480 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -76,6 +76,10 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
 #endif
 
+#ifndef lm_alias
+#define lm_alias(x)	__va(__pa_symbol(x))
+#endif
+
 /*
  * To prevent common memory management code establishing
  * a zero page mapping on a read fault.
-- 
2.7.4
