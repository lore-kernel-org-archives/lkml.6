Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB36C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EAF21528
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nS5KvpKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EAF21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeJTVaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 17:30:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36493 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeJTVaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 17:30:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so40181609wrw.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzApm7vE/dD/uAgWrxiW5K0X3tLU6m2ZUdn2itnPQ5Q=;
        b=nS5KvpKx1dAorQ050f/JzMWYvmikmKaoewGANqh/GYQgPZC0UuwUbLvlcSJ9IbEYfL
         8EwkkPUXEYqT6izt0jMy4LkYbrt6rHWMP+RE0cw+PIwajjsN6mWByZum1Ik8g92w3afq
         PjG1NjuLF3FNsMmevh6/7DisUKKBINHBMBNcNvD6uVNKyjcMInCgE7/W7Vi95OkaXDqe
         rfTFCTonHBalR31QQvX6FRUaasbkX6uT/Ki/2AahQqifhZSpyFjWwLiXlgFr6HPJRKea
         RL2z5CfsWRXFkhAoYlqzJZ6ll0U+5Pv7UtBxbRyr85rRifMFZbypHTUchJddute5GlOR
         RCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzApm7vE/dD/uAgWrxiW5K0X3tLU6m2ZUdn2itnPQ5Q=;
        b=SSOizN0TYuOUH0m3b9s5jjQ0wXLvn+pKCmA1QjshAq0KYCUR0/hcJ7EBkyLevLbMG8
         Mui/jwh7VvhlhxjQWDWY/SNfW4S+N9/PdVRSRy1o59zxDSuHp1/yuGxOyLjoXeB30eMD
         WDhfhpQY+9IskBDguYkU/6XttzHVwlocszkp8veVNokEFRx2UCFjlGYjHDp4EYDWYTQ8
         UP7WHLJu96QP7iHVOsujl9h7xoRAa1q/yiYsyY6nut9gY2qYrcMBd5FIUe1VcduO/8/B
         q66qqI2DfRG2dsuO4L6Mn6ExkBBr9juS07FI8A5QY+BMxZ520e25Nvwxj+T9ViZTdC65
         13MA==
X-Gm-Message-State: ABuFfoh61p5/zXe6afnn7KFxi8c9E9tnKf/yb0bm2zOtKQ2M/rQtau79
        7F0MfW4d+faIppBvzlw6UJuhOK+oPwZV4A==
X-Google-Smtp-Source: ACcGV63bzc5nTA8frVPeryrewxRZFuRmqoFOkogujxpRh0ppBFglLZDHwm79plBXj/tbyickiRl6pQ==
X-Received: by 2002:adf:e784:: with SMTP id n4-v6mr40743788wrm.187.1540041584656;
        Sat, 20 Oct 2018 06:19:44 -0700 (PDT)
Received: from viisi.sifive.com ([37.152.39.96])
        by smtp.gmail.com with ESMTPSA id 5-v6sm11394568wra.48.2018.10.20.06.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 06:19:44 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Jim Wilson <jimw@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] modpost: skip ELF local symbols by default during section mismatch check
Date:   Sat, 20 Oct 2018 06:19:14 -0700
Message-Id: <20181020131911.22443-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181020131911.22443-1-paul.walmsley@sifive.com>
References: <20181020131911.22443-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During development of a serial console driver with a RISC-V toolchain,
the following modpost warning appeared:

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

Thus, disable section mismatch reporting on ELF local symbols by
default.  The rationale here is similar to that of commit
2e3a10a1551d6ceea005e6a62ca58183b8976217 ("ARM: avoid ARM binutils
leaking ELF local symbols") and of similar code already present in
modpost.c:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/mod/modpost.c?h=v4.19-rc4&id=7876320f88802b22d4e2daf7eb027dd14175a0f8#n1256

Since it might be useful for some static analysis runs to detect
whether any new symbols have been added that result in any section
mismatches, even from ELF local symbols, this change can be disabled
(along with other tests that can often generate false positives) by
passing the '-P' switch on the modpost command line.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Jim Wilson <jimw@sifive.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 scripts/mod/modpost.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 38fc1bd47926..2b8c960ece66 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1255,6 +1255,17 @@ static inline int is_arm_mapping_symbol(const char *str)
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
@@ -1537,6 +1548,9 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	if (strstarts(fromsym, "reference___initcall"))
 		return;
 
+	if (!accept_falsepos_risk && is_local_symbol(fromsym))
+		return;
+
 	tosec = sec_name(elf, get_secindex(elf, sym));
 	to = find_elf_symbol(elf, r->r_addend, sym);
 	tosym = sym_name(elf, to);
-- 
2.19.1

