Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022049-2-8320570122806320999
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022049; b=D0t8UukjZMD3iskza1eIJy7J1gGWl/g534jh3eb7kyEtrRXdgw
    E1bSBTtsblH5Zs5dUJpQKw36oY+0oIDS8oxcGf9ezU8my3Nv+i4Y4Ih/a4UTc9VF
    2iRAi2+IlZ8WqvaEfLsPc4WyOLfjRmixARpFgsgIIicjJLl8aX9O/gB115ckXpse
    UGPUURq5o90K5w/2qVP/X4Lu2L1EwncuuPE7sAmjcu35BcbPgLs31iyqte7ERyB9
    oKZA+p0gnAeI18hdwgBGRKucldd7knoekmUP/azI1BsWam1oCEhFrOnU3p9V+gcG
    MPYdDG8Ij79co053uPVwRpBwbBLLfoJHFvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022049; bh=p7HPsa0thHQRwW/4cgud5jwfkBKlzj
    OLTc0lyeWJG4Y=; b=hnGCJdMZSRx50JyFPh0AuXHcsBI2G+8/LFAk8JzDxK3fXM
    Ii40H/VgYV8HGYmA4hHEPq79TMAG0x91kp/CXw1Vc6wkm3wQqPKQJ7slkBmvY/au
    EbXNotASFIOOK63Xql4DASnJ0DmR063PxXsfYZGo+q0kzPTX2YPmzb1rFFgArTWt
    he5iQ72zJuC3AFEMr5ddouEVF3EVBntsj3mE72T60cEE1GHejYqxJ+Pho6liY5Jd
    DyIcJ2KX7Xqv+l9e227ItQBJ/K2kmGFvTeRRDXWqxGrD0ztkmDsn0W0ngwfZ/XZ0
    mg9GMo/tHVRKzZCLaYCSS3eU78K2p4a1tbz36qZA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF3xFoFWZOwZB2VmWNZRBQ+rvxgmoRZ54ExhEXkH6SeRFNOGM5bfi6YROsv6oYh8PFEqxu1fHjrnmMckeVAXbi+dEWdLps2TGRyTQC7uNEsa2jAO0g67
    DbKu86IEtNwB7tH4NOuZ3LFJp3I6FEBMd1vx0gG9mke2d3F+n17Tn6qzP2XpqrR02ow8Zrf6X7rAiFlryzFXG2hvDo31++wzEj+MsElZiYKFwA0F3vUJGD7u
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=2KMo9-giAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=ag1SF4gXAAAA:8
    a=Wtz7PzlzdcFW-RrdzLIA:9 a=gVnYXrw_FYviVAWL:21 a=SZQ7LzIvdTYveJlX:21
    a=QEXdDO2ut3YA:10 a=UeCTMeHK7YUBiLmz_SX7:22 a=AjGcO6oz07-iQ99wixmX:22
    a=aeg5Gbbo78KNqacMgKqU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeDFNkq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:40:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeDFNkp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:40:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.15 01/72] ARM: OMAP: Fix SRAM W+X mapping
Date: Fri,  6 Apr 2018 15:23:36 +0200
Message-Id: <20180406084349.546848637@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

commit eb85a355c3afd9379f5953cfe2df73632d14c884 upstream.

We are still using custom SRAM code for some SoCs and are not marking
the PM code mapped to SRAM as read-only and executable after we're
done. With CONFIG_DEBUG_WX=y, we will get "Found insecure W+X mapping
at address" warning.

Let's fix this issue the same way as commit 728bbe75c82f ("misc: sram:
Introduce support code for protect-exec sram type") is doing for
drivers/misc/sram-exec.c.

On omap3, we need to restore SRAM when returning from off mode after
idle, so init time configuration is not enough.

And as we no longer have users for omap_sram_push_address() we can
make it static while at it.

Note that eventually we should be using sram-exec.c for all SoCs.

Cc: stable@vger.kernel.org	# v4.12+
Cc: Dave Gerlach <d-gerlach@ti.com>
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/plat-omap/include/plat/sram.h |   11 ----------
 arch/arm/plat-omap/sram.c              |   36 ++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 11 deletions(-)

--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -5,13 +5,4 @@ void omap_map_sram(unsigned long start,
 			unsigned long skip, int cached);
 void omap_sram_reset(void);
 
-extern void *omap_sram_push_address(unsigned long size);
-
-/* Macro to push a function to the internal SRAM, using the fncpy API */
-#define omap_sram_push(funcp, size) ({				\
-	typeof(&(funcp)) _res = NULL;				\
-	void *_sram_address = omap_sram_push_address(size);	\
-	if (_sram_address)					\
-		_res = fncpy(_sram_address, &(funcp), size);	\
-	_res;							\
-})
+extern void *omap_sram_push(void *funcp, unsigned long size);
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -23,6 +23,7 @@
 #include <asm/fncpy.h>
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include <asm/mach/map.h>
 
@@ -42,7 +43,7 @@ static void __iomem *omap_sram_ceil;
  * Note that fncpy requires the returned address to be aligned
  * to an 8-byte boundary.
  */
-void *omap_sram_push_address(unsigned long size)
+static void *omap_sram_push_address(unsigned long size)
 {
 	unsigned long available, new_ceil = (unsigned long)omap_sram_ceil;
 
@@ -60,6 +61,30 @@ void *omap_sram_push_address(unsigned lo
 	return (void *)omap_sram_ceil;
 }
 
+void *omap_sram_push(void *funcp, unsigned long size)
+{
+	void *sram;
+	unsigned long base;
+	int pages;
+	void *dst = NULL;
+
+	sram = omap_sram_push_address(size);
+	if (!sram)
+		return NULL;
+
+	base = (unsigned long)sram & PAGE_MASK;
+	pages = PAGE_ALIGN(size) / PAGE_SIZE;
+
+	set_memory_rw(base, pages);
+
+	dst = fncpy(sram, funcp, size);
+
+	set_memory_ro(base, pages);
+	set_memory_x(base, pages);
+
+	return dst;
+}
+
 /*
  * The SRAM context is lost during off-idle and stack
  * needs to be reset.
@@ -75,6 +100,9 @@ void omap_sram_reset(void)
 void __init omap_map_sram(unsigned long start, unsigned long size,
 				 unsigned long skip, int cached)
 {
+	unsigned long base;
+	int pages;
+
 	if (size == 0)
 		return;
 
@@ -95,4 +123,10 @@ void __init omap_map_sram(unsigned long
 	 */
 	memset_io(omap_sram_base + omap_sram_skip, 0,
 		  omap_sram_size - omap_sram_skip);
+
+	base = (unsigned long)omap_sram_base;
+	pages = PAGE_ALIGN(omap_sram_size) / PAGE_SIZE;
+
+	set_memory_ro(base, pages);
+	set_memory_x(base, pages);
 }
