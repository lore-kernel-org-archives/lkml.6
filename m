Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5710FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153FA208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="llN7otdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153FA208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeKOLCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:02:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41688 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeKOLCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:02:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so8167834pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 16:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jR9p6ed+q044UxVDucQZ+/nHR0L7rs3Ohg9y+9jXu4E=;
        b=llN7otdymbhNFelaODeLHIUTU7aUH9dEHfq+jb2Nb81I+TkP+gVSksg0nsBxC2gKr/
         gsjHC2Ct85U+EDnUaKLJuo/A41z/L4/rvjz4e9GQnstxopY3ewLDzqL/RQ2+Kf2GWlGX
         LihIWlPV2LSSRplH5LQcbdJQRkx3e3M9yhi02imjHjL+yDA5oSrv89s+3wHtNSEr7Txe
         NhOg34w+iQZad9vdP2y20tOvAfqfcc5qmrwKjeqLFhbNDO34n7UDuw2p/AlW0N5DWpL6
         DSGco/eHWpmUkVjRGfC/M2meipxJKfkfK6IJMw2LCdKwfDtPrSIVShviqEJ1+UrDYM9q
         DhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jR9p6ed+q044UxVDucQZ+/nHR0L7rs3Ohg9y+9jXu4E=;
        b=mbpt7dsazsgS1Vz0ZWanCwZXccRSmBOMAYBChnegB4fuR8NGtv3YRnB5AndtIRRBII
         DTPqSLub59gsOwl9wo/jgCok9I9tdDJCgKC37EMwxway83i3oUmbBJ0zaY46gDQQP0ZT
         OqF7ZkbanUfRaM3cBvWEtUqDRdd+s6aq8ZJLvIcgddLvJOkr8MGWbgGOPcnKEDbTH7i/
         ZE88xusDofrYIN1V8Kf+Y1dsOnRyWcRp28JMjBsm0l/QFcBq6bB340UT3nkNARSfibC3
         vjwJ3xxwOW7ao4i1Jil7OjoNHlxs3U/eoYH/BxySoraygDAo4R6811CaPYVgdqHpkTTH
         1HgQ==
X-Gm-Message-State: AGRZ1gIbnSc6ntsDzzzU5FWHvSVxfk6lNtfd4/wZtdE2SP4aSAxREL+W
        u5JWpnt1pG1tMTMT6LD9fEBlInTvKCk=
X-Google-Smtp-Source: AJdET5cXIT3hSCvPSprLZrzA+WmIlEidifP4rT35J+g20Tmt3Dm1n7cAu7esjTcsho3o2E3AqsyvIw==
X-Received: by 2002:a63:8c2:: with SMTP id 185mr3940793pgi.26.1542243392970;
        Wed, 14 Nov 2018 16:56:32 -0800 (PST)
Received: from viisi.sifive.com ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id m10-v6sm47343509pfg.180.2018.11.14.16.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 16:56:32 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Jim Wilson <jimw@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 2/2] modpost: skip ELF local symbols by default during section mismatch check
Date:   Wed, 14 Nov 2018 16:56:02 -0800
Message-Id: <20181115005602.30746-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115005602.30746-1-paul.walmsley@sifive.com>
References: <20181115005602.30746-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During development of a serial console driver with a gcc 8.2.0
toolchain for RISC-V, the following modpost warning appeared:

----
WARNING: vmlinux.o(.data+0x19b10): Section mismatch in reference from the variable .LANCHOR1 to the function .init.text:sifive_serial_console_setup()
The variable .LANCHOR1 references
the function __init sifive_serial_console_setup()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
----

".LANCHOR1" is an ELF local symbol, automatically created by gcc's section
anchor generation code:

https://gcc.gnu.org/onlinedocs/gccint/Anchored-Addresses.html

https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/varasm.c;h=cd9591a45617464946dcf9a126dde277d9de9804;hb=9fb89fa845c1b2e0a18d85ada0b077c84508ab78#l7473

This was verified by compiling the kernel with -fno-section-anchors.
The serial driver code idiom triggering the warning is standard serial
driver practice, and one that has a specific whitelist inclusion in
modpost.c.

I'm neither a modpost nor an ELF expert, but naively, it doesn't seem
useful for modpost to report section mismatch warnings caused by ELF
local symbols by default.  Local symbols have compiler-generated
names, and thus bypass modpost's whitelisting algorithm, which relies
on the presence of a non-autogenerated symbol name.  This increases
the likelihood that false positive warnings will be generated (as in
the above case).

Thus, disable section mismatch reporting on ELF local symbols.  The
rationale here is similar to that of commit 2e3a10a1551d ("ARM: avoid
ARM binutils leaking ELF local symbols") and of similar code already
present in modpost.c:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/mod/modpost.c?h=v4.19-rc4&id=7876320f88802b22d4e2daf7eb027dd14175a0f8#n1256

This second version of the patch drops the option to keep section
mismatch warnings for local sections, based on feedback from Sam
Ravnborg <sam@ravnborg.org>; and clarifies that these warnings
appear with gcc 8.2.0.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Jim Wilson <jimw@sifive.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 scripts/mod/modpost.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 85bd93c63180..0fb148171b78 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1253,6 +1253,17 @@ static inline int is_arm_mapping_symbol(const char *str)
 	       && (str[2] == '\0' || str[2] == '.');
 }
 
+/*
+ * If a symbol name follows the convention for ELF-local symbols (i.e., the
+ * name begins with a ".L"), return true; otherwise false.  This is used to
+ * skip section mismatch reporting on ELF-local symbols, due to the risk of
+ * false positives.
+ */
+static inline int is_local_symbol(const char *str)
+{
+	return str[0] == '.' && str[1] == 'L';
+}
+
 /*
  * If there's no name there, ignore it; likewise, ignore it if it's
  * one of the magic symbols emitted used by current ARM tools.
@@ -1535,6 +1546,9 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	if (strstarts(fromsym, "reference___initcall"))
 		return;
 
+	if (is_local_symbol(fromsym))
+		return;
+
 	tosec = sec_name(elf, get_secindex(elf, sym));
 	to = find_elf_symbol(elf, r->r_addend, sym);
 	tosym = sym_name(elf, to);
-- 
2.19.1

