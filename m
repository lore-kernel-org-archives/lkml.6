Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2757788-1519128110-2-14438094056952688288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519128108; b=Ce+Gh1AyWFOLuOHvwPUJ11SgNFAeg7xbGLA5enYx0xsdJVb
    re8FO+gs1dsQJQgYpNZE9VDGWsyu6+EpC/Ho47PnQa806DwQswHycK1ZNrNU56pi
    UKDQcN52l5lWQo6T4CCfTns/xpakN2imuZhA5ExGfyBZyAJQdlLbwEppnKn+9BYf
    c+IXgUVKyXvgaqPlwWvdamuB/7N/5tpDAwgHXtPkLQSnl5QLN5Mc33l5ZSGJSyX4
    1CrdHV4O1Eoq+8AnulkO85IapW9OKmgD4VWhYmXiiTln4MWEagu13LhP7xe0McYM
    QlJg0ZCcOqj8PbSE7qOYI7BmTPVaaJdELaW1GEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519128108;
    bh=STfyYkQNttJko4nQxXNkFvQN9OwWEZTdfoBqwAFtIK0=; b=eCMad9TntkFU
    E4cALN+hfE6p0RUcVtE8lmti4ykpXo1YvVsd9H5lDTuw3rkPWpvrGTKJII7kdmIF
    dTCWbwrRdzj4oJh6MnCKxSm3jzCyXTgEQBdrNirVJnKwZnMoxtCpVtdJF5QLrgXL
    br40QQM9EDAohDGXHs04m9Rwv/HgamX0qqK9Q7q9FBOzb287+1IDF3X/iWNawnvN
    W1CI8qL3TxEusNwSgyCjCpK6PP3xlqoA0D5puuE/5ImCSJJw/5tNjx8His8Lpd/J
    02WMiaKSEJG+t4f1qnPxqV4Q4dLWVZarQ/1rLBgFPaTv8MsAn/X53hGOvkgUbium
    +clW6aS++w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeBTMBb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 07:01:31 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeBTMBa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 07:01:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [4.4-stable 18/22] x86/microcode/AMD: Change load_microcode_amd()'s param to bool to fix preemptibility bug
Date: Tue, 20 Feb 2018 12:55:05 +0100
Message-Id: <20180220115527.1806578-19-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:uqE8s66uMNTDhEJLexQJsyxkl+IH4+MKM+9K2WK5FlmqSq2hlB2
 aWuM+QMpAZs9EZeTjd9BQW0H/tOR3kJJ9nYsAdas+xWJObHX1dPUTcGG+45PXBqZiqhsqGq
 9eeBNX9y4vFMPg4rBzm9QRtoMZxNPBqsI/UAcZQrjzTVCaiaqVxoiKRGNZJpbZ5LDrvvQGE
 HLLeYdXCmTCs285sUIpYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jq9k2wDqHgE=:ddbdEMsb4jpd0hcyKLuMOj
 H7IHjddmguNQKGuIG98Zv4/jmdMft3VirdpRgfGJ9GA7iE498yhNoTLgeuQVlb4dOGV1p7CEA
 adgSF7V5cf1gZIshxnVOuE0bXXewYOdSlAjtXBILVHz64E0y7W4k7d9GtRdm6L9f/qEK4QF2g
 1InWNB5Xt8eSyciuUw7SWN8PhbXspfzyqrp9l0m8/7fvYOXRjeLduSsFFN7BSeOhyZXpWSGWb
 SDsl9hkQetHxMAzbEk+LuvNwD4sQTo8OaY2JgfcO0vaEqHTGeJcXZ02Lm9a5/PAa6MIKks/li
 oV/SaXKquVrbZg+SfmqL/p3iyrckopVvVHJW6NF4xrcuRdaLO3D+PdA5toIdzZtolga2pW1/S
 8jotCcrKfGiSQ5BowHJ9M4hYN5CFZnF8iwK1W3f80RqICpJ6UDjYCjSjx1NkVBdP9gO3nvF5E
 nNKr2N23qvOQ8d+xL5Hofiyfwrq9cZzsVxCL0tx9E/OIXuC1NbzFdzZ8pJzdRoN8VFgGUw3gA
 +/Ju0ZnnZ0/a6dK+8Bag8L0UrD1iwv6fUhDdBTAk9CVKt6V56+fh9ws8HxPK5zxWq193qAV8a
 IWz1wRf32erbqoJMRWuC94SXAD3tsbcq0cdDUbjl7lZuA5Xpep7P6O5JcEOYO36lx+E3tYBTu
 j6Tv3VLZFBKFiZq3obgDOF/l8Q7Rq16qFA5ws6LyQdRRrcoUtJsBgsY2v66KpXnLFE5qUEpFN
 u3eZWpX+uE7c/WGbxJE+GS9/UsMKJ5l2DlbFew==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Borislav Petkov <bp@suse.de>

commit dac6ca243c4c49a9ca7507d3d66140ebfac8b04b upstream.

With CONFIG_DEBUG_PREEMPT enabled, I get:

  BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
  caller is debug_smp_processor_id
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc2+ #2
  Call Trace:
   dump_stack
   check_preemption_disabled
   debug_smp_processor_id
   save_microcode_in_initrd_amd
   ? microcode_init
   save_microcode_in_initrd
   ...

because, well, it says it above, we're using smp_processor_id() in
preemptible code.

But passing the CPU number is not really needed. It is only used to
determine whether we're on the BSP, and, if so, to save the microcode
patch for early loading.

 [ We don't absolutely need to do it on the BSP but we do that
   customarily there. ]

Instead, convert that function parameter to a boolean which denotes
whether the patch should be saved or not, thereby avoiding the use of
smp_processor_id() in preemptible code.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170528200414.31305-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[arnd: rebased to 4.9, after running into warning:
 arch/x86/kernel/cpu/microcode/amd.c:881:30: self-comparison always evaluates to true]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/microcode_amd.h |  1 -
 arch/x86/kernel/cpu/microcode/amd.c  | 17 +++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index adfc847a395e..fb163f02ebb1 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -59,7 +59,6 @@ static inline u16 find_equiv_id(struct equiv_cpu_entry *equiv_cpu_table,
 
 extern int __apply_microcode_amd(struct microcode_amd *mc_amd);
 extern int apply_microcode_amd(int cpu);
-extern enum ucode_state load_microcode_amd(int cpu, u8 family, const u8 *data, size_t size);
 
 #define PATCH_MAX_SIZE PAGE_SIZE
 extern u8 amd_ucode_patch[PATCH_MAX_SIZE];
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 2a0f44d225fe..6da6f9cd6d2d 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -131,6 +131,9 @@ static size_t compute_container_size(u8 *data, u32 total_size)
 	return size;
 }
 
+static enum ucode_state
+load_microcode_amd(bool save, u8 family, const u8 *data, size_t size);
+
 /*
  * Early load occurs before we can vmalloc(). So we look for the microcode
  * patch container file in initrd, traverse equivalent cpu table, look for a
@@ -438,7 +441,7 @@ int __init save_microcode_in_initrd_amd(void)
 	eax   = cpuid_eax(0x00000001);
 	eax   = ((eax >> 8) & 0xf) + ((eax >> 20) & 0xff);
 
-	ret = load_microcode_amd(smp_processor_id(), eax, container, container_size);
+	ret = load_microcode_amd(true, eax, container, container_size);
 	if (ret != UCODE_OK)
 		retval = -EINVAL;
 
@@ -854,7 +857,8 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	return UCODE_OK;
 }
 
-enum ucode_state load_microcode_amd(int cpu, u8 family, const u8 *data, size_t size)
+static enum ucode_state
+load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 {
 	enum ucode_state ret;
 
@@ -868,8 +872,8 @@ enum ucode_state load_microcode_amd(int cpu, u8 family, const u8 *data, size_t s
 
 #ifdef CONFIG_X86_32
 	/* save BSP's matching patch for early load */
-	if (cpu_data(cpu).cpu_index == boot_cpu_data.cpu_index) {
-		struct ucode_patch *p = find_patch(cpu);
+	if (save) {
+		struct ucode_patch *p = find_patch(0);
 		if (p) {
 			memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
 			memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data),
@@ -901,11 +905,12 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	bool bsp = c->cpu_index == boot_cpu_data.cpu_index;
 	enum ucode_state ret = UCODE_NFOUND;
 	const struct firmware *fw;
 
 	/* reload ucode container only on the boot cpu */
-	if (!refresh_fw || c->cpu_index != boot_cpu_data.cpu_index)
+	if (!refresh_fw || !bsp)
 		return UCODE_OK;
 
 	if (c->x86 >= 0x15)
@@ -922,7 +927,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 		goto fw_release;
 	}
 
-	ret = load_microcode_amd(cpu, c->x86, fw->data, fw->size);
+	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
 
  fw_release:
 	release_firmware(fw);
-- 
2.9.0
