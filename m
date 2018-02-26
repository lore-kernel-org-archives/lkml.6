Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387443-1519634353-2-16724512728308545637
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519634352; b=TyjlJwOFOz8m/GM7RKcpxGILtTKi7F0qJEUvMHAC/Nk4+b0
    JBd5LF5Ur/P6wV+1sR0dYheily49YBWCpJZmmLZufSM0DCCxFpqSnYAe8hDgBrrW
    U5v27VtWkV8K/X/1P6L1zp66+fc2KBhX/5nxpiSgYj2BtqiFPG7X+PMaqgUZitnP
    Btu+At7k46jkXnVxfpznmSABI5JVyaavyGNia7eFD5l4ODZPYOpIF1MrxX/x0EaO
    ZMXoperpVM3Uo9zHtJBHsJzjkPtNnEaBg/O67Ju58LdaIufSZNipfQ1c3Q15ZjhF
    6oO4KH6kkZ90rtsJFhX5kRUJvGNPs4Pi/oRmxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519634352;
    bh=Bg7B0hfDb1LbDSK0bEabGd/Si+r1Y+auDWs+NQonZeA=; b=LijRFOzPTckT
    /43j/aHLM2WTFjTepPayw9Y+g9vymZLHQsd0xc0OGdgMeUhqZcZEONBIzT6IzByz
    u6QEjdlHWd4jJ7WEt2XeQ1i9QJVvXYRshRzwkW2MAYJ+j19V6OvdQO84aui/1q3T
    JG0yti4YgEjoPPXqhVAI/HQY6h6qrpMBaBq5Zt4Tr6XkWotte4Ww/MoUU9H9Sj6x
    62p+tttg87azmt/OaW59eG++dGwvwKw2Gn43c4slsIZkOzT0hbBS14fhcm/Lugza
    QlRxP8O2wBOnMQIOEn2RzuuHUp6pHHCHF5b9CgQJYY7YR23Im3AHPSHRvD9ClnWV
    pABb4GJk4g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=BMCqSGmr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DUSyLFO6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=BMCqSGmr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DUSyLFO6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBZIjK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:39:10 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37479 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBZIVP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:21:15 -0500
X-Google-Smtp-Source: AH8x225GtuDjcL0QucfzSjww7zbNpuJoA5RCQwI3ED+F5YO4e197B7t5BtuY38zYorreW7S7hTkXwg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kernel@vger.kernel.org (open list)
Cc: Laura Abbott <labbott@redhat.com>
Subject: [PATCH 01/52] mm: Introduce lm_alias
Date: Mon, 26 Feb 2018 16:19:35 +0800
Message-Id: <1519633227-29832-2-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
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
