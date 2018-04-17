Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2214042-1523981233-2-5731437952274967667
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523981232; b=DiGWmfTA8kOzFGqqYdy5LVCf7bDR9qcFOlra3jgDRtz0oXbDJu
    NO1ZGByDDawctstU2Gce8ROKyzDGgjkDY5vQlN1cUti2jjG8ga2hp8lpTwKbWeQa
    xGSy5VwuPElXxSW0dhrFFh2RBqTYDmJWmNaWUa+MnjRL+7QAR/wBHKDB/ecJwsGp
    2SiEBd2uYurhYX9eoYv8B9b5CLv4gYjTW7P/LpknnGxolzqClID4xaxkEtPfRQSG
    WDE4pkKWmdbPVA6J2L9LPp7cMF0KO00aSNsNtbb5Nbu1XL34OIylJBGJtPgzbP0z
    e2Wehl14J8NK1idm69YfuFFnDal4YTHHeI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981232; bh=yY1fHale4rgxCSE5iA7/4gJRYZR2ln
    tdDGwyGA6n4g0=; b=RsduoaY1Ng3xaDnvJQmm27PU4lcMQUDv4dap2yZJp9kCqP
    GAeeMb7+GpENaT8c5Y25OvXxI/3WuUbBZ7Wgam/I+eO3NGzBtqbW3cZg8BoAGF64
    MlVfsYjwjiBBZA5EvtSfX6QOG1Hq3fx37S0pdvBpTD4/mFHxqefUr39mArbn7XRK
    N/69Dy/cOXFNDTBt4dZnPAiuuXkSALjdVVSCVhiMysiZPoF3ns620Bmfx9X/4c5m
    Zqo/1PzNN49B/YTveCXxGHYvLIH3yJvR1uZ+zvExMi2yh29X5vJ3XBI1z7Fa6vTL
    221vNneessm33IUOQm1gHAllVLKcSOdm7SldiVuw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfM1N7DntTdQVKmIbTD8QkGmOp/LST008fAV75cxkwKWj8yI4+SQsT8vPJbOJcVlP/qsO/03ic6FX45goMYpLpC/OSDCZAfpgG8VU6emjQtm8AvDUqQ9k
    SrB67QIfnTSOx38vvHsp/0rCF0J44Qmx8mdTfsHeR2ofF/bqTO+pgXN9jZmg8Bft5j0pRCxgZq3ysnAi19igjtrVndfyai0yJnW02ZW8ZvhZQPRqdQvSU+uw
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=VtM-a2X5T2hzRkHJv_cA:9
    a=b0nMnecPyQpyTWiz:21 a=5GqiO4Z4mrcaEtdb:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755119AbeDQQHI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:07:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755115AbeDQQHF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:07:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 38/49] x86/mce/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type
Date: Tue, 17 Apr 2018 17:59:17 +0200
Message-Id: <20180417155716.836829100@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
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

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit 68627a697c195937672ce07683094c72b1174786 upstream.

Currently, bank 4 is reserved on Fam17h, so we chose not to initialize
bank 4 in the smca_banks array. This means that when we check if a bank
is initialized, like during boot or resume, we will see that bank 4 is
not initialized and try to initialize it.

This will cause a call trace, when resuming from suspend, due to
rdmsr_*on_cpu() calls in the init path. The rdmsr_*on_cpu() calls issue
an IPI but we're running with interrupts disabled. This triggers:

  WARNING: CPU: 0 PID: 11523 at kernel/smp.c:291 smp_call_function_single+0xdc/0xe0
  ...

Reserved banks will be read-as-zero, so their MCA_IPID register will be
zero. So, like the smca_banks array, the threshold_banks array will not
have an entry for a reserved bank since all its MCA_MISC* registers will
be zero.

Enumerate a "Reserved" bank type that matches on a HWID_MCATYPE of 0,0.

Use the "Reserved" type when checking if a bank is reserved. It's
possible that other bank numbers may be reserved on future systems.

Don't try to find the block address on reserved banks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.14.x
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-7-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mce.h           |    1 +
 arch/x86/kernel/cpu/mcheck/mce_amd.c |    7 +++++++
 drivers/edac/mce_amd.c               |   11 +++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -346,6 +346,7 @@ enum smca_bank_types {
 	SMCA_IF,	/* Instruction Fetch */
 	SMCA_L2_CACHE,	/* L2 Cache */
 	SMCA_DE,	/* Decoder Unit */
+	SMCA_RESERVED,	/* Reserved */
 	SMCA_EX,	/* Execution Unit */
 	SMCA_FP,	/* Floating Point */
 	SMCA_L3_CACHE,	/* L3 Cache */
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -82,6 +82,7 @@ static struct smca_bank_name smca_names[
 	[SMCA_IF]	= { "insn_fetch",	"Instruction Fetch Unit" },
 	[SMCA_L2_CACHE]	= { "l2_cache",		"L2 Cache" },
 	[SMCA_DE]	= { "decode_unit",	"Decode Unit" },
+	[SMCA_RESERVED]	= { "reserved",		"Reserved" },
 	[SMCA_EX]	= { "execution_unit",	"Execution Unit" },
 	[SMCA_FP]	= { "floating_point",	"Floating Point Unit" },
 	[SMCA_L3_CACHE]	= { "l3_cache",		"L3 Cache" },
@@ -127,6 +128,9 @@ static enum smca_bank_types smca_get_ban
 static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype, xec_bitmap } */
 
+	/* Reserved type */
+	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0), 0x0 },
+
 	/* ZN Core (HWID=0xB0) MCA types */
 	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFEF },
 	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
@@ -431,6 +435,9 @@ static u32 get_block_address(unsigned in
 	u32 addr = 0, offset = 0;
 
 	if (mce_flags.smca) {
+		if (smca_get_bank_type(bank) == SMCA_RESERVED)
+			return addr;
+
 		if (!block) {
 			addr = MSR_AMD64_SMCA_MCx_MISC(bank);
 		} else {
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -854,21 +854,24 @@ static void decode_mc6_mce(struct mce *m
 static void decode_smca_error(struct mce *m)
 {
 	struct smca_hwid *hwid;
-	unsigned int bank_type;
+	enum smca_bank_types bank_type;
 	const char *ip_name;
 	u8 xec = XEC(m->status, xec_mask);
 
 	if (m->bank >= ARRAY_SIZE(smca_banks))
 		return;
 
-	if (x86_family(m->cpuid) >= 0x17 && m->bank == 4)
-		pr_emerg(HW_ERR "Bank 4 is reserved on Fam17h.\n");
-
 	hwid = smca_banks[m->bank].hwid;
 	if (!hwid)
 		return;
 
 	bank_type = hwid->bank_type;
+
+	if (bank_type == SMCA_RESERVED) {
+		pr_emerg(HW_ERR "Bank %d is reserved.\n", m->bank);
+		return;
+	}
+
 	ip_name = smca_get_long_name(bank_type);
 
 	pr_emerg(HW_ERR "%s Extended Error Code: %d\n", ip_name, xec);
