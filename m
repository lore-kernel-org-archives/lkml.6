Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrCcJh/HcEbVZ6X2voDzYhDzMRXYqGNGaLjWlBwByWNeB5qINa6Z6cXXgWh7oFVcTLSerZU
ARC-Seal: i=1; a=rsa-sha256; t=1524838143; cv=none;
        d=google.com; s=arc-20160816;
        b=iZ94O4vq0to9kjOsU6BxCD0f9lkXJPIh0wSCq2YAf18fl6/fgMT64Dh1OeWyqyL/p1
         OGbKnSy6MTD+BvrUAz/MzUkd48m1XdWO+BObWtcdah7eaHkPzOyEBjmmcmLGSdAFyJRw
         BYpcs9cIYT6tKeGQaGja/OiSx2bbOxIDrpogTE/yFIlurCC9FYIIiizjp7rFJ0/wcf8V
         0YR5MDUTDpqaO8+MRRMTIpR+VIlWnhRf1pmZYOyNEVGsk8hSrsngW7c/WSBKun4CseaF
         nMNeXoCvOvO5f/Ql0GwbqZm5oS+TDGGiyY0inDvjTqNCJm0DLy7GBUgo+4D2dwdIg3yD
         R/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=c6g3SOeXTlwX6Fsm41nuioB5Bb2iVLTmZErvzd2eOgg=;
        b=eoOf6gLVuz8ZBrZFW2IQ8ZugJrcqxKajE782M7pZ/glxA0ZEWvakQ8mj76voRBL1Wt
         wQthpQ4GHq5RQnPIIpNvRwNrqGpoB5JjJwBKJiezrF1DJ/3GQMkW74zsCOQTe4xpBdbA
         C2nyvGEEeejQwAopb+IFUypDNrodxjaZzA97isItwQue4BU/x8s85sHArJoT1/b7duwn
         9Bdd2WyuRHwb+dOFWC5cprF+OgVDfbe0DdM9SXk7Y/fLHMIcL2RlALk+WmoFy7zGusvO
         RdxbcmcZfaRWcInXXv8Lb8zp36zQyQEq9jMZcC5eFtEhSVyempiQThKebKq1rv0PaGnY
         joHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D437121892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 4.14 43/80] s390: enable CPU alternatives unconditionally
Date: Fri, 27 Apr 2018 15:58:36 +0200
Message-Id: <20180427135735.137254532@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908248930767762?=
X-GMAIL-MSGID: =?utf-8?q?1598908680886339915?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit 049a2c2d486e8cc82c5cd79fa479c5b105b109e9 ]

Remove the CPU_ALTERNATIVES config option and enable the code
unconditionally. The config option was only added to avoid a conflict
with the named saved segment support. Since that code is gone there is
no reason to keep the CPU_ALTERNATIVES config option.

Just enable it unconditionally to also reduce the number of config
options and make it less likely that something breaks.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Kconfig                   |   16 ----------------
 arch/s390/include/asm/alternative.h |   20 +++-----------------
 arch/s390/kernel/Makefile           |    3 +--
 arch/s390/kernel/module.c           |   15 ++++++---------
 4 files changed, 10 insertions(+), 44 deletions(-)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -538,22 +538,6 @@ config ARCH_RANDOM
 
 	  If unsure, say Y.
 
-config ALTERNATIVES
-	def_bool y
-	prompt "Patch optimized instructions for running CPU type"
-	help
-	  When enabled the kernel code is compiled with additional
-	  alternative instructions blocks optimized for newer CPU types.
-	  These alternative instructions blocks are patched at kernel boot
-	  time when running CPU supports them. This mechanism is used to
-	  optimize some critical code paths (i.e. spinlocks) for newer CPUs
-	  even if kernel is build to support older machine generations.
-
-	  This mechanism could be disabled by appending "noaltinstr"
-	  option to the kernel command line.
-
-	  If unsure, say Y.
-
 endmenu
 
 menu "Memory setup"
--- a/arch/s390/include/asm/alternative.h
+++ b/arch/s390/include/asm/alternative.h
@@ -15,14 +15,9 @@ struct alt_instr {
 	u8  replacementlen;	/* length of new instruction */
 } __packed;
 
-#ifdef CONFIG_ALTERNATIVES
-extern void apply_alternative_instructions(void);
-extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
-#else
-static inline void apply_alternative_instructions(void) {};
-static inline void apply_alternatives(struct alt_instr *start,
-				      struct alt_instr *end) {};
-#endif
+void apply_alternative_instructions(void);
+void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
+
 /*
  * |661:       |662:	  |6620      |663:
  * +-----------+---------------------+
@@ -109,7 +104,6 @@ static inline void apply_alternatives(st
 	b_altinstr(num)":\n\t" altinstr "\n" e_altinstr(num) ":\n"	\
 	INSTR_LEN_SANITY_CHECK(altinstr_len(num))
 
-#ifdef CONFIG_ALTERNATIVES
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, altinstr, facility) \
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
@@ -130,14 +124,6 @@ static inline void apply_alternatives(st
 	ALTINSTR_ENTRY(facility1, 1)					\
 	ALTINSTR_ENTRY(facility2, 2)					\
 	".popsection\n"
-#else
-/* Alternative instructions are disabled, let's put just oldinstr in */
-#define ALTERNATIVE(oldinstr, altinstr, facility) \
-	oldinstr "\n"
-
-#define ALTERNATIVE_2(oldinstr, altinstr1, facility1, altinstr2, facility2) \
-	oldinstr "\n"
-#endif
 
 /*
  * Alternative instructions for different CPU types or capabilities.
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -57,7 +57,7 @@ obj-y	+= processor.o sys_s390.o ptrace.o
 obj-y	+= debug.o irq.o ipl.o dis.o diag.o vdso.o als.o
 obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o
-obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o
+obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
@@ -75,7 +75,6 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
-obj-$(CONFIG_ALTERNATIVES)	+= alternative.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_cpum_cf.o perf_cpum_sf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf_events.o
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -433,16 +433,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const Elf_Shdr *s;
 	char *secstrings;
 
-	if (IS_ENABLED(CONFIG_ALTERNATIVES)) {
-		secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-		for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
-			if (!strcmp(".altinstructions",
-				    secstrings + s->sh_name)) {
-				/* patch .altinstructions */
-				void *aseg = (void *)s->sh_addr;
+	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
+		if (!strcmp(".altinstructions", secstrings + s->sh_name)) {
+			/* patch .altinstructions */
+			void *aseg = (void *)s->sh_addr;
 
-				apply_alternatives(aseg, aseg + s->sh_size);
-			}
+			apply_alternatives(aseg, aseg + s->sh_size);
 		}
 	}
 
