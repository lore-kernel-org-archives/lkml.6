Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D1C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9DE2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bfbf+3n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfBFANN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:13:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46169 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfBFALc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so4432435edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiW8u5Nz8oz6X6T0UBPC6luCzcvn2LEP6I2yT9EsYr8=;
        b=bfbf+3n9b/IlhtShm86KPqAPB6hQT4bOgMz2k7uWLsTzHXoTdKHPXhSVEvNupdMIio
         oDJiZKkWo9pITLRIyoKFec4E1BxfHr/ACOWt5zUPeWXYaLW+2wY0MJhfQmJvy7wMNi4R
         n7RdCAk+wRxjDC01zMzkumC2ki+pel2Q1XDc84uNetJPq6jFFUY0c2pzNRfyzUUc31QF
         Zzn8YqW2s7qqYbcLNlozh0dMPB8yJ0r8pcLf5BwyiyvH6nJ7koTyAlfJUQK4hE+8DCCM
         1JWRcWeywy2g70bcfM1gUg27nAtvobcIEK4cHQ3LjEqD13/1JFtfqM8wYaR+u59J0AGp
         WMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiW8u5Nz8oz6X6T0UBPC6luCzcvn2LEP6I2yT9EsYr8=;
        b=ZBNYQOMFrOvorZF3J8rLMinCpFJCXqt4zqcQMahUlD+XrVnIrGO+0+ald99+XdsqJp
         YSymoX8AghTCm4S/qZQN1ncqxufmIorVMUU5UOUzsGD95ruWb9hMyQH2yS3O8XVN30IR
         2b10NBgNdWfff1VeFVTVOOC8BIcHHddL5k/4Z37UcC17UyVuQVn0eWhpasGnO4ON+jao
         3R93/BZ3KG5AagHNQ+ivjZqOS4OUI/DcLgVYjLnQmXZVaWhc9IrHKhTVdb+K/gGkVw1c
         sClnsgJbcPLMPwiedZM/fQ295Rh+hgWd1g+fQZp+m0LdyYnKxWV0Wnv+Ub07MYYrer94
         9hbA==
X-Gm-Message-State: AHQUAuYXHE1P3Vx2NahbN22mYXvZNUnmWA8Qfhh+U5bY288vdwR0mViq
        QuJMP/quFK6PXfRLc892STs4Bq/hbnQ=
X-Google-Smtp-Source: AHgI3Iatgj9vNVXzmy8eNbXk35IaHi/T71C6IW5l/08/UKGu4pi2jLqkXV3bEPmHOM3KTlb5L2hz7A==
X-Received: by 2002:a50:a3d4:: with SMTP id t20mr6041122edb.159.1549411889843;
        Tue, 05 Feb 2019 16:11:29 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:29 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 15/32] x86/vdso2c: Optionally produce linker script for vdso entries
Date:   Wed,  6 Feb 2019 00:10:49 +0000
Message-Id: <20190206001107.16488-16-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two VDSO images (with/without code for adding offsets inside timens)
should be compatible by VDSO function offsets - this way kernel
can remap VDSO VMA for a task without fixupping GOT/PLT.

Add an optional parameter for vdso2c to generate .entries file from
vdso.so. As timens VDSO by nature is bigger in .text than VDSO for
tasks outside namespace, this parameter will be used to generate
.entries file from timens VDSO and include those aligns into linker
script for !timens VDSO building.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/.gitignore |  1 +
 arch/x86/entry/vdso/Makefile   |  7 ++++---
 arch/x86/entry/vdso/vdso2c.c   | 26 +++++++++++++++++++-------
 arch/x86/entry/vdso/vdso2c.h   | 16 +++++++++++++++-
 4 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/vdso/.gitignore b/arch/x86/entry/vdso/.gitignore
index aae8ffdd5880..9ab4fa4c7e7b 100644
--- a/arch/x86/entry/vdso/.gitignore
+++ b/arch/x86/entry/vdso/.gitignore
@@ -5,3 +5,4 @@ vdso32-sysenter-syms.lds
 vdso32-int80-syms.lds
 vdso-image-*.c
 vdso2c
+vdso*.entries
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 55ba81d4415c..ccb572831ea1 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -47,8 +47,8 @@ vobjs32-timens := $(foreach F,$(vobjs32-timens-y),$(obj)/$F)
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
-targets += vdso.lds $(vobjs-y) $(vobjs-timens-y)
-targets += vdso32/vdso32.lds $(vobjs32-y) $(vobjs32-timens-y)
+targets += vdso.lds $(vobjs-y) $(vobjs-timens-y) vdso64.entries
+targets += vdso32/vdso32.lds $(vobjs32-y) $(vobjs32-timens-y) vdso32.entries
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
@@ -73,7 +73,8 @@ HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(src
 hostprogs-y			+= vdso2c
 
 quiet_cmd_vdso2c = VDSO2C  $@
-      cmd_vdso2c = $(obj)/vdso2c $< $(<:%.dbg=%) $@
+      cmd_vdso2c = $(obj)/vdso2c $< $(<:%.dbg=%) $@ \
+		   $(filter %.entries,$(<:%-timens.so.dbg=%.entries))
 
 $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 	$(call if_changed,vdso2c)
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index ed66b023d4b9..72731c4cfdce 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -152,6 +152,7 @@ extern void bad_put_le(void);
 #define BITSFUNC3(name, bits, suffix) name##bits##suffix
 #define BITSFUNC2(name, bits, suffix) BITSFUNC3(name, bits, suffix)
 #define BITSFUNC(name) BITSFUNC2(name, ELF_BITS, )
+#define ELF_FUNC(f, x) (BITSFUNC2(ELF, ELF_BITS, _##f)(x))
 
 #define INT_BITS BITSFUNC2(int, ELF_BITS, _t)
 
@@ -169,16 +170,17 @@ extern void bad_put_le(void);
 
 static void go(void *raw_addr, size_t raw_len,
 	       void *stripped_addr, size_t stripped_len,
-	       FILE *outfile, const char *name)
+	       FILE *outfile, const char *name,
+	       FILE *out_entries_lds)
 {
 	Elf64_Ehdr *hdr = (Elf64_Ehdr *)raw_addr;
 
 	if (hdr->e_ident[EI_CLASS] == ELFCLASS64) {
 		go64(raw_addr, raw_len, stripped_addr, stripped_len,
-		     outfile, name);
+		     outfile, name, out_entries_lds);
 	} else if (hdr->e_ident[EI_CLASS] == ELFCLASS32) {
 		go32(raw_addr, raw_len, stripped_addr, stripped_len,
-		     outfile, name);
+		     outfile, name, out_entries_lds);
 	} else {
 		fail("unknown ELF class\n");
 	}
@@ -208,12 +210,12 @@ int main(int argc, char **argv)
 {
 	size_t raw_len, stripped_len;
 	void *raw_addr, *stripped_addr;
-	FILE *outfile;
+	FILE *outfile, *entries_lds = NULL;
 	char *name, *tmp;
 	int namelen;
 
-	if (argc != 4) {
-		printf("Usage: vdso2c RAW_INPUT STRIPPED_INPUT OUTPUT\n");
+	if (argc < 4) {
+		printf("Usage: vdso2c RAW_INPUT STRIPPED_INPUT OUTPUT [OUTPUT_ENTRIES.LDS]\n");
 		return 1;
 	}
 
@@ -245,11 +247,21 @@ int main(int argc, char **argv)
 	if (!outfile)
 		err(1, "fopen(%s)", outfilename);
 
-	go(raw_addr, raw_len, stripped_addr, stripped_len, outfile, name);
+	if (argc == 5) {
+		entries_lds = fopen(argv[4], "w");
+		if (!entries_lds) {
+			fclose(outfile);
+			err(1, "fopen(%s)", argv[4]);
+		}
+	}
+
+	go(raw_addr, raw_len, stripped_addr, stripped_len, outfile, name, entries_lds);
 
 	munmap(raw_addr, raw_len);
 	munmap(stripped_addr, stripped_len);
 	fclose(outfile);
+	if (entries_lds)
+		fclose(entries_lds);
 
 	return 0;
 }
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 61c8bb2e5af8..065dac6c29c8 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -7,7 +7,8 @@
 
 static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 			 void *stripped_addr, size_t stripped_len,
-			 FILE *outfile, const char *name)
+			 FILE *outfile, const char *name,
+			 FILE *out_entries_lds)
 {
 	int found_load = 0;
 	unsigned long load_size = -1;  /* Work around bogus warning */
@@ -111,6 +112,19 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 				syms[k] = GET_LE(&sym->st_value);
 			}
 		}
+
+		if (!out_entries_lds)
+			continue;
+
+		if (ELF_FUNC(ST_BIND, sym->st_info) != STB_GLOBAL)
+			continue;
+
+		if (ELF_FUNC(ST_TYPE, sym->st_info) != STT_FUNC)
+			continue;
+
+		fprintf(out_entries_lds, "\t\t. = ABSOLUTE(%#lx);\n",
+				(unsigned long)GET_LE(&sym->st_value));
+		fprintf(out_entries_lds, "\t\t*(.text.%s*)\n", name);
 	}
 
 	/* Validate mapping addresses. */
-- 
2.20.1

