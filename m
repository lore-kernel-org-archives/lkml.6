Return-Path: <thgarnie@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520974852; cv=none;
        d=google.com; s=arc-20160816;
        b=PkXoqIy/f0lTBQPFNe8Desm1UwJ53UvY7WVyTxNmjjcM59juwrGlAvGjt56xbgU/2L
         7g81AI7YbfUiXcH/fBhNF6lutm4Nc5aERQ8E7BTjjNG/HU4fSVPh/ekaMCiSA11x/R2x
         HKdfD/cFhkMOC/0GhiGhWHZ/O1gH6HQUydi3LCfpq87j67lKVOM22EtTwRAU9OFwrFu2
         +s2NFlEm4mlsg4jFRgdWFV5YmPIgVF7C8Xm8MneGBstu2rD0VDjJ+UaDKNh+JalfZg8S
         BJUH+lcONS+MPhNI9zoKwrVojn8F215q7ag0ExwrLAIuAd+Fn6Fk/Ut9w9JAvu7jYlFi
         8CAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=wJcCSmKmn51WDIJKLXMINVpSvCZQ8Uy2YZG4Djtyi1s=;
        b=BYw7oP4WRKcNBoS6ypLvRoT5OD+EaI1sGWP8TUy2Ky2m0anWgAGSktcYHohmMVXeKP
         UMPkPLGUQP4KQ6AsCHeF35NSZ4IPzDHq84WQkjqGjcF1LtK9HRUlP6uEwduj4WR4hXJG
         y6lxDdwDhe8nICR2imhwPjq9Cablcpsd8MPDhNYfo+h+OzWcWzrpI/JHfVRNop0VAjQW
         Meze8NglweAP+8vqtEq1S1WaaO2DtQHEOdbsDjzEnVKYi/1vBFmlk7lMeJTvqx75Cdlr
         rQ5F8DgeoQwZ6EmE9r1/EsivH12/18o6mbQ9czH2dwZNfyDDlTzLZMnGcVCSdLgIajxI
         JWmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Q9Qh2Q/w;
       spf=pass (google.com: domain of thgarnie@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thgarnie@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Q9Qh2Q/w;
       spf=pass (google.com: domain of thgarnie@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thgarnie@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELtAOwaWcevIq+Cs8A51ZKqEFUqLtTk/Ep+QhItRoBt18uIuvpY9xLJ83Y1GQ+tB2AQonCNucA==
From: Thomas Garnier <thgarnie@google.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Garnier <thgarnie@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Borislav Petkov <bp@alien8.de>,
	Borislav Petkov <bp@suse.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Juergen Gross <jgross@suse.com>,
	Alok Kataria <akataria@vmware.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Dennis Zhou <dennisszhou@gmail.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Christopher Li <sparse@chrisli.org>,
	Jason Baron <jbaron@akamai.com>,
	Ashish Kalra <ashish@bluestacks.com>,
	Kyle McMartin <kyle@redhat.com>,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Lukas Wunner <lukas@wunner.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Ingo Molnar <mingo@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Cao jin <caoj.fnst@cn.fujitsu.com>,
	"H . J . Lu" <hjl.tools@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rik van Riel <riel@redhat.com>,
	Jia Zhang <qianyue.zj@alibaba-inc.com>,
	Jiri Slaby <jslaby@suse.cz>,
	Kyle Huey <me@kylehuey.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Michal Hocko <mhocko@suse.com>,
	Rob Landley <rob@landley.net>,
	Baoquan He <bhe@redhat.com>,
	Daniel Micay <danielmicay@gmail.com>,
	=?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
Cc: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org,
	linux-arch@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH v2 17/27] x86/relocs: Handle PIE relocations
Date: Tue, 13 Mar 2018 13:59:35 -0700
Message-Id: <20180313205945.245105-18-thgarnie@google.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180313205945.245105-1-thgarnie@google.com>
References: <20180313205945.245105-1-thgarnie@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594857727505534729?=
X-GMAIL-MSGID: =?utf-8?q?1594857727505534729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Change the relocation tool to correctly handle relocations generated by
-fPIE option:

 - Add relocation for each entry of the .got section given the linker does not
   generate R_X86_64_GLOB_DAT on a simple link.
 - Ignore R_X86_64_GOTPCREL.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/tools/relocs.c | 93 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 220e97841e49..a35cc337f883 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -32,6 +32,7 @@ struct section {
 	Elf_Sym        *symtab;
 	Elf_Rel        *reltab;
 	char           *strtab;
+	Elf_Addr       *got;
 };
 static struct section *secs;
 
@@ -293,6 +294,35 @@ static Elf_Sym *sym_lookup(const char *symname)
 	return 0;
 }
 
+static Elf_Sym *sym_lookup_addr(Elf_Addr addr, const char **name)
+{
+	int i;
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		struct section *sec = &secs[i];
+		long nsyms;
+		Elf_Sym *symtab;
+		Elf_Sym *sym;
+
+		if (sec->shdr.sh_type != SHT_SYMTAB)
+			continue;
+
+		nsyms = sec->shdr.sh_size/sizeof(Elf_Sym);
+		symtab = sec->symtab;
+
+		for (sym = symtab; --nsyms >= 0; sym++) {
+			if (sym->st_value == addr) {
+				if (name) {
+					*name = sym_name(sec->link->strtab,
+							 sym);
+				}
+				return sym;
+			}
+		}
+	}
+	return 0;
+}
+
+
 #if BYTE_ORDER == LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
 #define le32_to_cpu(val) (val)
@@ -513,6 +543,33 @@ static void read_relocs(FILE *fp)
 	}
 }
 
+static void read_got(FILE *fp)
+{
+	int i;
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		struct section *sec = &secs[i];
+		sec->got = NULL;
+		if (sec->shdr.sh_type != SHT_PROGBITS ||
+		    strcmp(sec_name(i), ".got")) {
+			continue;
+		}
+		sec->got = malloc(sec->shdr.sh_size);
+		if (!sec->got) {
+			die("malloc of %d bytes for got failed\n",
+				sec->shdr.sh_size);
+		}
+		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
+			die("Seek to %d failed: %s\n",
+				sec->shdr.sh_offset, strerror(errno));
+		}
+		if (fread(sec->got, 1, sec->shdr.sh_size, fp)
+		    != sec->shdr.sh_size) {
+			die("Cannot read got: %s\n",
+				strerror(errno));
+		}
+	}
+}
+
 
 static void print_absolute_symbols(void)
 {
@@ -643,6 +700,32 @@ static void add_reloc(struct relocs *r, uint32_t offset)
 	r->offset[r->count++] = offset;
 }
 
+/*
+ * The linker does not generate relocations for the GOT for the kernel.
+ * If a GOT is found, simulate the relocations that should have been included.
+ */
+static void walk_got_table(int (*process)(struct section *sec, Elf_Rel *rel,
+					  Elf_Sym *sym, const char *symname),
+			   struct section *sec)
+{
+	int i;
+	Elf_Addr entry;
+	Elf_Sym *sym;
+	const char *symname;
+	Elf_Rel rel;
+
+	for (i = 0; i < sec->shdr.sh_size/sizeof(Elf_Addr); i++) {
+		entry = sec->got[i];
+		sym = sym_lookup_addr(entry, &symname);
+		if (!sym)
+			die("Could not found got symbol for entry %d\n", i);
+		rel.r_offset = sec->shdr.sh_addr + i * sizeof(Elf_Addr);
+		rel.r_info = ELF_BITS == 64 ? R_X86_64_GLOB_DAT
+			     : R_386_GLOB_DAT;
+		process(sec, &rel, sym, symname);
+	}
+}
+
 static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 			Elf_Sym *sym, const char *symname))
 {
@@ -656,6 +739,8 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 		struct section *sec = &secs[i];
 
 		if (sec->shdr.sh_type != SHT_REL_TYPE) {
+			if (sec->got)
+				walk_got_table(process, sec);
 			continue;
 		}
 		sec_symtab  = sec->link;
@@ -765,6 +850,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		offset += per_cpu_load_addr;
 
 	switch (r_type) {
+	case R_X86_64_GOTPCREL:
 	case R_X86_64_NONE:
 		/* NONE can be ignored. */
 		break;
@@ -809,7 +895,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		 * the relocations are processed.
 		 * Make sure that the offset will fit.
 		 */
-		if ((int32_t)offset != (int64_t)offset)
+		if (r_type != R_X86_64_64 && (int32_t)offset != (int64_t)offset)
 			die("Relocation offset doesn't fit in 32 bits\n");
 
 		if (r_type == R_X86_64_64)
@@ -818,6 +904,10 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			add_reloc(&relocs32, offset);
 		break;
 
+	case R_X86_64_GLOB_DAT:
+		add_reloc(&relocs64, offset);
+		break;
+
 	default:
 		die("Unsupported relocation type: %s (%d)\n",
 		    rel_type(r_type), r_type);
@@ -1087,6 +1177,7 @@ void process(FILE *fp, int use_real_mode, int as_text,
 	read_strtabs(fp);
 	read_symtabs(fp);
 	read_relocs(fp);
+	read_got(fp);
 	if (ELF_BITS == 64)
 		percpu_init();
 	if (show_absolute_syms) {
-- 
2.16.2.660.g709887971b-goog
