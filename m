Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3989416-1519035439-2-10265518106292007797
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519035438; b=ZdUVnpFlXm81W7iWCc1b8c1GOAApMWRCO3TSC8arfuTbJjt
    a7VwcgRXLnKBKCK/OeRgz/BOvAfZcByAeWhEOuCWsGRNZK73DdxxoUjGHo7zzqKK
    RtvaPca6IBULnxtjaNzesI63IcrG1pH4RRTlqPQc+tLH1ornnlydkSreC92GePdp
    iFcX/MQ6RQ8DXTpyqQ9vjzX6NDTI81bZ130A3tdU2Eg4uBAKVgiYvrxWlwHg2a+S
    A1SUz4/yxLpEku+eCLvfns6RmXqHbh8bIqLKJwcxiXpO7eoBWSrs6N/VV4W1nU3V
    t9n1pJKY1KVw5IA7vigIgDtKS0it4X55DrqF6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519035438;
    bh=acPV9+Vvii0MQv+6zcfARsxdyUCgSMkykczyp8FBWNw=; b=NbtK4OgcwQbf
    BCv5pu+wAoahfC6qu4d4mg5yVyyq09AIqY0KsBL9BZpKCaq2rOaIY7sJif8OPG0s
    nnbxj7ZQbpqO0pDv3rQX6q+7cjA1RTWIv/3QUnLGbO9nxT4DtfZ0JyCVywYLdgMh
    CQFITVL4s/N0Hyl3xXhUtA/YY5yk6NsrMddL2PVPogQanqHyX3LKdyt/Tzn2PcUr
    ng4wlI/+ztFMzRVeUQW01tYXemLQawW0GcbHLiXBXwUfLUD3b1pIa/U71cRGYr9D
    jdq6GqBddRW8rVoOdfvqz4sjzmxU2tqgbK7JiU7ro4+9lLoXp6IbFOSQbQiIW6kp
    O2gPqTD9ng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeBSKRD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 05:17:03 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:42783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbeBSKRB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 05:17:01 -0500
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
Subject: [4.9-stable 9/9] x86/microcode/AMD: Change load_microcode_amd()'s param to bool to fix preemptibility bug
Date: Mon, 19 Feb 2018 11:13:28 +0100
Message-Id: <20180219101343.2922561-10-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
References: <20180219101343.2922561-1-arnd@arndb.de>
X-Provags-ID: V03:K0:miF91a+nOXIMpHw0LqA4YS6FMvmvDqfDx/QEyBcZHPJ2KQxRIKm
 OEqMmjZuawoQOR1NyJQpXNYAZ2aj1qaYmqZwrEbC07h5sALNZK1i80TKZRwcXed19SpFq+I
 DBKJVY0JXqVllr1kCUEBNEHBmjV6TiKMbZ1vvhAWCWrjzz/ceOLoCky8QfPnKVL69bqoQCp
 oHHNu6Ix9kWJgBoybyzxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4rg4hwcvZ60=:YJTNypg7s12hmv9xz/iRSG
 6j6J1yhwta+h8rB9oFkXWtHJ1HbHTeB2eRfohjNLxY+AwuqPtgYp/RG1dMDbGw+vVZ1VriX1W
 339HuijABq5NqomorXzkYpl6Umxqf9j9MoGuZWzk7FjdXGhDSlvl0+Sumc/ULAqfQjTMSaadA
 /eV90d0bTPAr3YTzc8Pj7cmmsgJoK5urUbRXEwJbR78UnLHDjj+7sIjjCAgNNtF3V/NbiiPI2
 +lVrxQv3KqvsiHooJep4WTQrvk1No2V6WkQmbi0OWQHo9n3RIxFe+OSA2/rsCbVdkpRjtZI0F
 R+O0FdYK7bTv+wG6n53wTODCxWEoo8DWctdDB4/WY02sQUI/IOtyGdjY7il1V3RRb1ggXGL9h
 H2FTQO/8j2T4JImI4GL4fuH6Y/LIJ7zAHpPWENGKwCMoZDZEJwBqSKXpuDwWsORD3uFb57SiU
 /e/k9/PI1ZmnrwBunN5M1Ow7A3eUIM3SCUCA6/YUGyvIoVfjTA+FpyexMyyaVc6aRSSsKsY5S
 73rYZiwechNFS9AkjmhYtCM2Ei89DRASN4Joo70jbkDLkRQvxoc6S9CE4F239D8rcAnKPBycs
 LyEQyPstiM8gVW3fWB8MYXvp080zQKULW0KiI4UBsMgfwTJD1RlATH+oAl72w0xN2T0ugrJs6
 CXcLcniUQ9HeZ75ycm3adT3/M3OpHOIiG49uA4vUSh7clthc6VfU7+Cekt3kZMGuecKNlUg+m
 OXUsl3Nu3oqDVWgHo7j06k0Jmz5PHUKmCAlxPg==
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
index 15eb75484cc0..98ccbd1dbb01 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -59,7 +59,6 @@ static inline u16 find_equiv_id(struct equiv_cpu_entry *equiv_cpu_table,
 
 extern int __apply_microcode_amd(struct microcode_amd *mc_amd);
 extern int apply_microcode_amd(int cpu);
-extern enum ucode_state load_microcode_amd(int cpu, u8 family, const u8 *data, size_t size);
 
 #define PATCH_MAX_SIZE PAGE_SIZE
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index b74bb29db6b9..732bb03fcf91 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -135,6 +135,9 @@ static size_t compute_container_size(u8 *data, u32 total_size)
 	return size;
 }
 
+static enum ucode_state
+load_microcode_amd(bool save, u8 family, const u8 *data, size_t size);
+
 /*
  * Early load occurs before we can vmalloc(). So we look for the microcode
  * patch container file in initrd, traverse equivalent cpu table, look for a
@@ -451,7 +454,7 @@ int __init save_microcode_in_initrd_amd(void)
 	eax   = cpuid_eax(0x00000001);
 	eax   = ((eax >> 8) & 0xf) + ((eax >> 20) & 0xff);
 
-	ret = load_microcode_amd(smp_processor_id(), eax, container, container_size);
+	ret = load_microcode_amd(true, eax, container, container_size);
 	if (ret != UCODE_OK)
 		retval = -EINVAL;
 
@@ -864,7 +867,8 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	return UCODE_OK;
 }
 
-enum ucode_state load_microcode_amd(int cpu, u8 family, const u8 *data, size_t size)
+static enum ucode_state
+load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 {
 	enum ucode_state ret;
 
@@ -878,8 +882,8 @@ enum ucode_state load_microcode_amd(int cpu, u8 family, const u8 *data, size_t s
 
 #ifdef CONFIG_X86_32
 	/* save BSP's matching patch for early load */
-	if (cpu_data(cpu).cpu_index == boot_cpu_data.cpu_index) {
-		struct ucode_patch *p = find_patch(cpu);
+	if (save) {
+		struct ucode_patch *p = find_patch(0);
 		if (p) {
 			memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
 			memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data),
@@ -911,11 +915,12 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
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
@@ -932,7 +937,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 		goto fw_release;
 	}
 
-	ret = load_microcode_amd(cpu, c->x86, fw->data, fw->size);
+	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
 
  fw_release:
 	release_firmware(fw);
-- 
2.9.0
