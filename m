Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937706-2-11211113096603098495
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937705; b=S+9sJ+C2y827jBqmnqESsY3nXnWXVYY9+aMc9j0vd3NeZjJ3VY
    BcdzaY/88XNDxazzUthwRWSxLuquDMTaeKYkMY5WI5ANb/Tht3zBQg7Wbr1QcWMg
    0ww5KvwaSTeHZpr6WEL49ugCoJXecIBjJrXkxYUyuKflj35R+coYkzxT/J6WaHWz
    bR/VxeFyt5lW4pS+rARmHD+LxTGb0adSrD1lRsfAJmxz54IOKvJU5VIdcfAR1rto
    02GRHLZh4DnlDPplgXVBxz31IQDmqAloDNyw8ssjmojr2STMR9AtbxnU6E4s0ykQ
    j8ykykMiNP781hvCGntQcc29goosRxvqBOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937705; bh=nHNNv70LhP3s+JQsl+9bxjnS16W+sd
    bxalHGtXD2pPU=; b=FwxHlbCdMbeY2orw21AX46ZorIPDls5KFAR5cTN5z0muRw
    nFnwKmFMBRqPnr9vIqM3nFf8ozDpYO8YESutks4zHLoThlPuAJ2yM4NxKB7DoiXZ
    lhyH4Z1a6nfs01kn+gMk3WVmUYaH2MZ8h2GkFc4MjRssH+GcGUAeAdXhSudnj54Y
    4DCVYnzejU5WDcsO5MDMANwLoc4Sj50g4JtykH5yLT7ygiuZRC5I66mfWd1P87Yt
    4JXxG/aJ6HyslkCF1hJt0OoiLJAAGEpxXGJNOJIc+4C7YcOgeyZ+DfQaf3Xj18b/
    LdaJkxK6hV3/SykUmmmFGYcAG89LDeY/eq+OsS1g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=03nhXchn x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=03nhXchn x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKGA6fSThPP6Vhyj063Y76L45xnqso1utHy3LtLGrWhQuhNyn6x8IfaG2qQJTbJkIAHz5PXzZbkeVnMVXB3D0q72DMtfmb3o4BLNHJby9+W+726By49d
    bWCOvTrhJg+nf45eQK1+qAYpglX98tvbKQuZvO8h4iNB9iki1fcBElGUQOEQLxF9M4Fle4lmuur74yLWcJJ4CmBdvIWw+M0k9hhqhabfEm4WHdSFjgPSBqQs
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=pSg6CVZTXii4w-zA4e8A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754102AbeEUVVl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753331AbeEUVVk (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:21:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 89/95] x86/bugs: Unify x86_spec_ctrl_{set_guest,restore_host}
Date: Mon, 21 May 2018 23:12:19 +0200
Message-Id: <20180521210503.043907401@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit cc69b34989210f067b2c51d5539b5f96ebcc3a01 upstream

Function bodies are very similar and are going to grow more almost
identical code. Add a bool arg to determine whether SPEC_CTRL is being set
for the guest or restored to the host.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/spec-ctrl.h |   33 ++++++++++++++++++---
 arch/x86/kernel/cpu/bugs.c       |   60 +++++++++------------------------------
 2 files changed, 44 insertions(+), 49 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -13,10 +13,35 @@
  * Takes the guest view of SPEC_CTRL MSR as a parameter and also
  * the guest's version of VIRT_SPEC_CTRL, if emulated.
  */
-extern void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl,
-				    u64 guest_virt_spec_ctrl);
-extern void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl,
-				       u64 guest_virt_spec_ctrl);
+extern void x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool guest);
+
+/**
+ * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+static inline
+void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+{
+	x86_virt_spec_ctrl(guest_spec_ctrl, guest_virt_spec_ctrl, true);
+}
+
+/**
+ * x86_spec_ctrl_restore_host - Restore host speculation control registers
+ * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
+ * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
+ *				(may get translated to MSR_AMD64_LS_CFG bits)
+ *
+ * Avoids writing to the MSR if the content/bits are the same
+ */
+static inline
+void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+{
+	x86_virt_spec_ctrl(guest_spec_ctrl, guest_virt_spec_ctrl, false);
+}
 
 /* AMD specific Speculative Store Bypass MSR data */
 extern u64 x86_amd_ls_cfg_base;
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -151,55 +151,25 @@ u64 x86_spec_ctrl_get_default(void)
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
-/**
- * x86_spec_ctrl_set_guest - Set speculation control registers for the guest
- * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
- * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
- *				(may get translated to MSR_AMD64_LS_CFG bits)
- *
- * Avoids writing to the MSR if the content/bits are the same
- */
-void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
+void
+x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
-	u64 host = x86_spec_ctrl_base;
+	struct thread_info *ti = current_thread_info();
+	u64 msr, host = x86_spec_ctrl_base;
 
 	/* Is MSR_SPEC_CTRL implemented ? */
-	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		return;
-
-	/* SSBD controlled in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
-
-	if (host != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, guest_spec_ctrl);
-}
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
-
-/**
- * x86_spec_ctrl_restore_host - Restore host speculation control registers
- * @guest_spec_ctrl:		The guest content of MSR_SPEC_CTRL
- * @guest_virt_spec_ctrl:	The guest controlled bits of MSR_VIRT_SPEC_CTRL
- *				(may get translated to MSR_AMD64_LS_CFG bits)
- *
- * Avoids writing to the MSR if the content/bits are the same
- */
-void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl)
-{
-	u64 host = x86_spec_ctrl_base;
-
-	/* Is MSR_SPEC_CTRL implemented ? */
-	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		return;
-
-	/* SSBD controlled in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
-
-	if (host != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, host);
+	if (static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
+		/* SSBD controlled in MSR_SPEC_CTRL */
+		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
+			host |= ssbd_tif_to_spec_ctrl(ti->flags);
+
+		if (host != guest_spec_ctrl) {
+			msr = setguest ? guest_spec_ctrl : host;
+			wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+		}
+	}
 }
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
+EXPORT_SYMBOL_GPL(x86_virt_spec_ctrl);
 
 static void x86_amd_ssb_disable(void)
 {
