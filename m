Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA0AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974CF20672
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kiQOQlXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974CF20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbeKVHuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:50:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46161 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbeKVHuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:50:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so7185673ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 13:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=LlHtzztzxS4T2OrKG7lTvEsNJe4iqA/i93T5/U6Zcy8=;
        b=kiQOQlXOQKLKGRU1CZ04S8T1Pog+mbGDwMYrY/o2Xl9nn6k3T1gEOBz4urwjvPH4t2
         NIM7j0tl0M8VG3REU6vGQ0I0X+X0jX4fCIFPX4WPaEwR0v5gYLakYW/c35zLVRf1NrNF
         3Y+qft45hd1Fvn+GRQ7s7w0BQn9AYA0viFPU1N2NqDflS6NJgL8dGVcdJ4fwTDwWgMuq
         bDUAuUq2rLyfGZo+HLvdBRG9umn0C7y1RE0OKHQtRDH3ZStpV3OowjNaih5O2HrcB0dM
         pyk2aMsQk7QubJ8MRKniYB8uvgPK7qWX1dxtDI4w3UFwf3sk329IDotJ1fiBpTeh0Vig
         FPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=LlHtzztzxS4T2OrKG7lTvEsNJe4iqA/i93T5/U6Zcy8=;
        b=E1TBRIRr2frsCnvjbkEaRCwF8aI8BUk4bmaMflMzwbJuBGVu+FH8dv0NcARQJuK+vA
         wqopqyobpMFHf5S0YU/sprovmG2D22uiT5bBfkY5LR62Lc62Sog0MW84NhiNrkhnPrkF
         xO9Tr4V6dv+pyVnwGunKI4SAgL9bMTJumfFvunrRepXHop6ts88WqnHae8R/65C74D2l
         Voo9fHk4kUN/nM98cBr9AIqeVost+ahJoZutIRNo5GHPnmP0IloLXxkmQ3JrKewnQwCQ
         HeUJFc4rjod8XcEik5lvvciTv5f/gOFWXM+QUCLSM8LPPDleEks/Uj318yKLA/6TmYrt
         fS2g==
X-Gm-Message-State: AA+aEWYbJwVgCTtuq6TwkEbza1KwNSGaVJ3NXU8yINhvV5GbNftxbwJj
        3YBY2FwHB+v6098m+zRnzqzCHNdKzbM=
X-Google-Smtp-Source: AFSGD/X8OD+o78rOmWemonaZ85uGywLVRGs4hpASPRWS7xIWFKHvwpol+z23dljmunc/VOLo0wKXBQ==
X-Received: by 2002:a17:902:4623:: with SMTP id o32-v6mr8354854pld.187.1542834855371;
        Wed, 21 Nov 2018 13:14:15 -0800 (PST)
Received: from localhost ([104.129.192.69])
        by smtp.gmail.com with ESMTPSA id g65sm148321164pfa.63.2018.11.21.13.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 13:14:14 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Wed, 21 Nov 2018 13:14:13 -0800 (PST)
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
cc:     Russell King <linux@armlinux.org.uk>, jimw@sifive.com,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>, Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] modpost: skip ELF local symbols during section mismatch
 check
Message-ID: <alpine.DEB.2.21.9999.1811211311410.18372@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

This was verified by compiling the kernel with -fno-section-anchors
and observing that the ".LANCHOR1" ELF local symbol disappeared, and
modpost no longer warned about the section mismatch.  The serial
driver code idiom triggering the warning is standard Linux serial
driver practice that has a specific whitelist inclusion in modpost.c.

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

This third version of the patch implements a suggestion from Masahiro
Yamada <yamada.masahiro@socionext.com> to restructure the code as an
additional pattern matching step inside secref_whitelist(), and
further improves the patch description.

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
  scripts/mod/modpost.c | 12 ++++++++++++
  1 file changed, 12 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0d998c54564d..90bb04b4e166 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1163,6 +1163,14 @@ static const struct sectioncheck *section_mismatch(
   *   fromsec = text section
   *   refsymname = *.constprop.*
   *
+ * Pattern 6:
+ *   Hide section mismatch warnings for ELF local symbols.  The goal
+ *   is to eliminate false positive modpost warnings caused by
+ *   compiler-generated ELF local symbol names such as ".LANCHOR1".
+ *   Autogenerated symbol names bypass modpost's "Pattern 2"
+ *   whitelisting, which relies on pattern-matching against symbol
+ *   names to work.  (One situation where gcc can autogenerate ELF
+ *   local symbols is when "-fsection-anchors" is used.)
   **/
  static int secref_whitelist(const struct sectioncheck *mismatch,
  			    const char *fromsec, const char *fromsym,
@@ -1201,6 +1209,10 @@ static int secref_whitelist(const struct sectioncheck *mismatch,
  	    match(fromsym, optim_symbols))
  		return 0;

+	/* Check for pattern 6 */
+	if (strstarts(fromsym, ".L"))
+		return 0;
+
  	return 1;
  }

-- 
2.19.1


