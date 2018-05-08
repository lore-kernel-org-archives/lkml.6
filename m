Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZrRuEUi+xh4wUA64OAWY/qQEFIB90p6UEwE/q46XIdGD0ldA5x9lQXjAvMT+JekfWtfUwVu
ARC-Seal: i=1; a=rsa-sha256; t=1525786489; cv=none;
        d=google.com; s=arc-20160816;
        b=Tjq8ZFC1lVbtnAUPdm4Trlkgz3/RDwJg+NtRLndk5AJ5osRbQGTEanpD7HT1y6S1PO
         fu4UtKEgU6kxMPa1KseYM4PUt4UHAkxD9h67YsdTeICmyhvzEd7NXyR5Fqm9VyoeKERz
         A85cG2DHx9KwEFyfh3ky5SMzcvdKqXnAkr63V/qZF3d+FsHZydKSo0avVwQA9YGg9e8b
         iPGSGX8WHQeSQVHQSe7p4huumWxlt9C4bi92RavMDpVGWEUxZ3U2mHfSwUgFc4qD/iJF
         olftSlnjw/f/xKlkWCaGaCnQo77R22OktxdyvD6VkiddNEYC+DUTgyiZQ2AAXftJ7/Ux
         Ubgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=XWlG/yaiNf+OF5LFXMfhCD7n1iz5YdMpC1uaOKktrmE=;
        b=bjAjZEREW5oA4PKfKitB4M5Sl2nj1Ln/QV4iaaFugK9OF3HirMVscDzZu3QtdGNb4p
         JYFTcVy3fQ3K7M/hSFyGYXTRKq20dCZkxTfot2juLJ7oDb7Cg5KW/PEu9+Vr2hxOVD8a
         tS2+DofVUgf8G7u7PD+IQ+NDIghMkW5Wj66tYdSPjcQPuPjXbNNhONiFEu6x5acQoxEP
         QaOiZu98ygtWrVPaauj3UmWm5pbPaEAJ/aJz6M8dorSF4VwxS4pPnmuw7n9/qm37CtKC
         EIpgdUXGnCjBHeF11GiMDftbKzESQdXck17WgYtschi5CXwEvuyB82oYIYpCHRmUlpa7
         ZeZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 8 May 2018 08:34:47 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: damian <damian.tometzki@icloud.com>, peterz@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: Kernel build with gcc 8 a lot of warnings
Message-ID: <20180508133226.uwjbx44fwlxgyzu5@treble>
References: <20180505192112.GA18728@zrhn9910b>
 <20180507045453.leou4zypnlcck4vr@treble>
 <20180508055126.GA18724@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180508055126.GA18724@kroah.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599903094060891144?=
X-GMAIL-MSGID: =?utf-8?q?1599903094060891144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 07:51:26AM +0200, Greg KH wrote:
> On Sun, May 06, 2018 at 11:54:53PM -0500, Josh Poimboeuf wrote:
> > On Sat, May 05, 2018 at 09:21:12PM +0200, damian wrote:
> > > Helllo together,
> > > 
> > > Hello everybody,
> > > 
> > > is something special to note when kernel build with gcc 8? I receive various warnings from the objtool:
> > > With GCC 7 works all fine.
> > > 
> > > kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x40: sibling call from callable instruction with modified stack frame
> > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x2a3: sibling call from callable instruction with modified stack frame
> > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x20b: sibling call from callable instruction with modified stack frame
> > > kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x296: sibling call from callable instruction with modified stack frame
> > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_sk_alloc_disable()+0x10: sibling call from callable instruction with modified stack frame
> > > kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags.cold.45()+0xa: call without frame pointer save/setup
> > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files.cold.46()+0x17: call without frame pointer save/setup
> > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable.cold.47()+0x24: call without frame pointer save/setup
> > > kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems.cold.48()+0x10: call without frame pointer save/setup
> > > kernel/cgroup/cgroup.o: warning: objtool: cgroup_sk_alloc_disable.cold.49()+0x7: call without frame pointer save/setup
> > >   CC      kernel/cgroup/stat.o
> > >   CC [M]  arch/x86/kvm/../../../virt/kvm/kvm_main.o
> > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_register_lapic()+0x10: sibling call from callable instruction with modified stack frame
> > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_map_cpu()+0x2c: sibling call from callable instruction with modified stack frame
> > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_register_lapic.cold.6()+0x7: call without frame pointer save/setup
> > > arch/x86/kernel/acpi/boot.o: warning: objtool: acpi_map_cpu.cold.7()+0x7: call without frame pointer save/setup
> > 
> > Thanks, this is a known issue with GCC 8 that I haven't gotten a chance
> > to fix yet.  They're related to the fact that GCC 8 is splitting out
> > 'unlikely' code into 'cold' subfunctions in .text.unlikely.
> > 
> > I've got some old patches that fix it.  Now that GCC 8 is out, I'll need
> > get the patches dusted off and cleaned up for merging.
> 
> Any pointers to these patches?  Archi linux just changed their default
> compiler to gcc 8 and now I'm seeing this in my local builds :(

I'm still dusting the code off, but this fixes most of the warnings.
The rest of the code should hopefully be ready soon.

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] objtool: Detect GCC 8 cold subfunctions

GCC 8 moves a lot of unlikely code out of line to "cold" subfunctions in
.text.unlikely.  Properly detect the new subfunctions and treat them as
extensions of the original functions.

This fixes a bunch of warnings like:

  kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x33: sibling call from callable instruction with modified stack frame
  kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x290: sibling call from callable instruction with modified stack frame
  kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x25b: sibling call from callable instruction with modified stack frame
  kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x325: sibling call from callable instruction with modified stack frame

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 7 ++++---
 tools/objtool/elf.c   | 3 +++
 tools/objtool/elf.h   | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 264522d4e4af..a8b3a8613b5e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1753,7 +1753,6 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 	while (1) {
 		next_insn = next_insn_same_sec(file, insn);
 
-
 		if (file->c_file && func && insn->func && func != insn->func) {
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
@@ -1869,7 +1868,9 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 		case INSN_JUMP_UNCONDITIONAL:
 			if (insn->jump_dest &&
 			    (!func || !insn->jump_dest->func ||
-			     func == insn->jump_dest->func)) {
+			     func == insn->jump_dest->func ||
+			     insn->func->subfunc ||
+			     insn->jump_dest->func->subfunc)) {
 				ret = validate_branch(file, insn->jump_dest,
 						      state);
 				if (ret)
@@ -2064,7 +2065,7 @@ static int validate_functions(struct objtool_file *file)
 
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
+			if (func->type != STT_FUNC || func->subfunc)
 				continue;
 
 			insn = find_insn(file, sec, func->offset);
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c1c338661699..0c0c7ab4a014 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -260,6 +260,9 @@ static int read_symbols(struct elf *elf)
 		sym->offset = sym->sym.st_value;
 		sym->len = sym->sym.st_size;
 
+		if (sym->type == STT_FUNC && strstr(sym->name, ".cold."))
+			sym->subfunc = true;
+
 		/* sorted insert into a per-section list */
 		entry = &sym->sec->symbol_list;
 		list_for_each_prev(tmp, &sym->sec->symbol_list) {
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index d86e2ff14466..dc411f9859b1 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -61,6 +61,7 @@ struct symbol {
 	unsigned char bind, type;
 	unsigned long offset;
 	unsigned int len;
+	bool subfunc;
 };
 
 struct rela {
-- 
2.17.0
