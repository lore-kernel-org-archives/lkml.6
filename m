Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3702976-1526635468-2-8039397464746893779
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526635467; b=iasxrkRT14/ThSqxA5bGceYXt2ZHsNY4QBnkzEc2KnrqEZotIa
    huiPaOVdtvKo5i1+QaPbzruqFKmJFj+xr28NmdL5d2GP7ycfivSq/OfH6FfyHDFC
    yB4lj0k5NDOCE541wbOaT6zg8a69iVdfL6ZTGMMH01hs1gFw0A+h1j3W96lZCtEN
    K8Eg5yn8fvWsdN+RkKpnjph9DCfQts32fhCGtcMZpUrBGxdoyXDoYqhGTuC6Y3qP
    IuqHv7zOUWAqsaaikzvgTzs9S2DJpjSuuz0Dher5s/Nx3Fs5jjTo0YQ1RgOo6XIM
    xzzVSoeUIC7fZMau//RFG7k126t0X+OpGVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526635467; bh=
    wAnRynTQ/kGiZLsPnL1gljRtHeoAPWQsVNQt5FRLKsg=; b=J+57k2Ws4gStAr3z
    636IQLaCDQSvf8X2GZe6JDGy9KKdO5Vu871fkuspG/LpGxHCS2EftRbKDqe5Wtrk
    +XOQzjPSMTxwACh5Brt51QloLMxU0K+wF4f1sGUEw14JPgE5YsLr36BjXRa1vxz3
    rw9x4iLM7CgGi+UbFdE+BjAnwKcmDzf8Ogr8ea0tfXe3fTcCP/8e3eexiF9gflKC
    SNK8FW1266KkrAbA8ovW1yf/xwtB9B5aeOgc5Y4uAZ4y40rO6BPYZNZRyq2Xrvdt
    BJqU4/2dJhLmNxstYG6HO2YIIxsw0SZtHJOuqmFgKgWlgSh6ngPox8AHo3cnhOaE
    n1GeXg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfMNuuk39MDKk62tReKSXS2vN6dxExWLkdseU9G4FKhldKcu+4QXV/8c4vbxmrWXrGymOnDxTMHtUTXEWS0bvCbiA5DDQbTQoD/IMleiNfYxUVzjrJvpY
    CSCnsnhYAHcQSj6yQJSaiVLpMf5+dVgnQIar4YGQ08pHyMs2O/xjdN94SxtXoaxy3aGIKcWdvYyTItLlj4XjCUkV3utV+qDdG085SauD7AjwUh6Yk2jTzKjd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=FNyBlpCuAAAA:8
    a=J1Y8HTJGAAAA:8 a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=VwQbUJbxAAAA:8
    a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=cWRNjhkoAAAA:8 a=bD6g2wtbrv6IN7KrHosA:9
    a=RlW-AWeGUCXs_Nkyno-6:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=sVa6W5Aao32NNC1mekxh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeERJYY (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 05:24:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753016AbeERJRi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 May 2018 05:17:38 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-crypto@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH v6 09/28] x86/asm: annotate aliases
Date: Fri, 18 May 2018 11:17:02 +0200
Message-Id: <20180518091721.7604-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180518091721.7604-1-jslaby@suse.cz>
References: <20180518091721.7604-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

_key_expansion_128 is an alias to _key_expansion_256a, __memcpy to
memcpy, xen_syscall32_target to xen_sysenter_target, and so on. Annotate
them all using the new SYM_FUNC_START_ALIAS, SYM_FUNC_START_LOCAL_ALIAS,
and SYM_FUNC_END_ALIAS. This will make the tools generating the
debuginfo happy.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com> [xen parts]
Cc: <linux-crypto@vger.kernel.org>
Cc: <xen-devel@lists.xenproject.org>
---
 arch/x86/crypto/aesni-intel_asm.S | 5 ++---
 arch/x86/lib/memcpy_64.S          | 4 ++--
 arch/x86/lib/memmove_64.S         | 4 ++--
 arch/x86/lib/memset_64.S          | 4 ++--
 arch/x86/xen/xen-asm_64.S         | 4 ++--
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index b482ac1a1fb3..c85ecb163c78 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -1761,8 +1761,7 @@ ENDPROC(aesni_gcm_finalize)
 #endif
 
 
-.align 4
-_key_expansion_128:
+SYM_FUNC_START_LOCAL_ALIAS(_key_expansion_128)
 SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	pshufd $0b11111111, %xmm1, %xmm1
 	shufps $0b00010000, %xmm0, %xmm4
@@ -1773,8 +1772,8 @@ SYM_FUNC_START_LOCAL(_key_expansion_256a)
 	movaps %xmm0, (TKEYP)
 	add $0x10, TKEYP
 	ret
-ENDPROC(_key_expansion_128)
 SYM_FUNC_END(_key_expansion_256a)
+SYM_FUNC_END_ALIAS(_key_expansion_128)
 
 SYM_FUNC_START_LOCAL(_key_expansion_192a)
 	pshufd $0b01010101, %xmm1, %xmm1
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 9a53a06e5a3e..4911b1c61aa8 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -26,7 +26,7 @@
  * Output:
  * rax original destination
  */
-ENTRY(__memcpy)
+SYM_FUNC_START_ALIAS(__memcpy)
 ENTRY(memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
@@ -40,7 +40,7 @@ ENTRY(memcpy)
 	rep movsb
 	ret
 ENDPROC(memcpy)
-ENDPROC(__memcpy)
+SYM_FUNC_END_ALIAS(__memcpy)
 EXPORT_SYMBOL(memcpy)
 EXPORT_SYMBOL(__memcpy)
 
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index bbec69d8223b..50c1648311b3 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -26,7 +26,7 @@
  */
 .weak memmove
 
-ENTRY(memmove)
+SYM_FUNC_START_ALIAS(memmove)
 ENTRY(__memmove)
 
 	/* Handle more 32 bytes in loop */
@@ -208,6 +208,6 @@ ENTRY(__memmove)
 13:
 	retq
 ENDPROC(__memmove)
-ENDPROC(memmove)
+SYM_FUNC_END_ALIAS(memmove)
 EXPORT_SYMBOL(__memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 9bc861c71e75..927ac44d34aa 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -19,7 +19,7 @@
  *
  * rax   original destination
  */
-ENTRY(memset)
+SYM_FUNC_START_ALIAS(memset)
 ENTRY(__memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
@@ -43,8 +43,8 @@ ENTRY(__memset)
 	rep stosb
 	movq %r9,%rax
 	ret
-ENDPROC(memset)
 ENDPROC(__memset)
+SYM_FUNC_END_ALIAS(memset)
 EXPORT_SYMBOL(memset)
 EXPORT_SYMBOL(__memset)
 
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 417b339e5c8e..e8f6f482bb20 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -164,13 +164,13 @@ ENDPROC(xen_sysenter_target)
 
 #else /* !CONFIG_IA32_EMULATION */
 
-ENTRY(xen_syscall32_target)
+SYM_FUNC_START_ALIAS(xen_syscall32_target)
 ENTRY(xen_sysenter_target)
 	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
 	mov $-ENOSYS, %rax
 	pushq $0
 	jmp hypercall_iret
-ENDPROC(xen_syscall32_target)
 ENDPROC(xen_sysenter_target)
+SYM_FUNC_END_ALIAS(xen_syscall32_target)
 
 #endif	/* CONFIG_IA32_EMULATION */
-- 
2.16.3
