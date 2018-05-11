Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZq1A3y8mg0MDaynYsq5gAGXyXklb7NeIHA19zElnZuud47VeUQtiLFcqHCiNOS8RcOPyxhs
ARC-Seal: i=1; a=rsa-sha256; t=1526010497; cv=none;
        d=google.com; s=arc-20160816;
        b=n4O3HKRExMFxDcE8c10J2N5KCkvMNHpjZ5RdYcS+0u6Hp5uZwaV2AWvIZjZcszUNvh
         9DmJ1f3usWlWjqh5BNdUWzkUajU3hdCQpTe6AtiGziDLudrzu5ZwxgEf2kiHRwXoUhHv
         K9DIn/2tzZ6ztkTTVjgno6uyI/q2EOltwuJQAc6y8Ge8Erczd+S6Ef7d8CZeRk6v2qId
         3po1HVnNsfIwZAaOdGJZeY/mWsh09YmUpctNKmhCU4V/6ywCEcz+wWp13Zyk+VyDxIna
         miJ1WGBvytdQT+GAUH6NVRdQpmsX1m2tNzvO/z5cd93sK3wjbCBHUkscUOEB4o3i9r/O
         JNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=4JGyyrcEMUWxC+gXsv1gyspWVnEWT9eaqgq4Zvylytc=;
        b=LYSCxvULWdHBMV620j6SI/7qShRh4TkqBfu2AamhEi3mw3WBF4z2Vff34OMU3fJnDo
         bW9MlnYQ67HH+SdxR3lSJ//gcc2piY/7Q3/bs+X1UYY/DT2PTozzuSg9HsfhewBAmxt7
         Yf2U3Ye9wg5JSiuB2MZBkPF3kvgIpMh4kW9IqA/1hPguzt2xs6+HV27WP7kapVn+c6SO
         Gja1k75LU7WqB5y+ncnxq2MyAvPsPFJO8ZJOw1vrmNE07l15ZPd+kTK3HBC3FUbK3zhs
         fzrUm5ocAgPtXmUeTCH2L9KX2wIndNrx0EW5jNGR0Ui8zfjeLb9tcGV1Ty6a8tpx1Rck
         woow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=TRR/zCxx;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=TRR/zCxx;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w4B3la06024073
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
        x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] um: remove unused vdso-syms.lds
Date: Fri, 11 May 2018 12:47:24 +0900
Message-Id: <1526010444-4305-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600137983171121849?=
X-GMAIL-MSGID: =?utf-8?q?1600137983171121849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This file contains symbol values, and was originally linked into
vmlinux, but I have no idea what it was actually used for.

Since commit 827880ec260b ("x86/um: thin archives build fix"), it is
not even linked.  Now it is completely orphan, and no problem has
been reported.  It is a proof that this file was not needed in the
first place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/um/vdso/.gitignore |  1 -
 arch/x86/um/vdso/Makefile   | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/arch/x86/um/vdso/.gitignore b/arch/x86/um/vdso/.gitignore
index 9cac6d0..f8b69d8 100644
--- a/arch/x86/um/vdso/.gitignore
+++ b/arch/x86/um/vdso/.gitignore
@@ -1,2 +1 @@
-vdso-syms.lds
 vdso.lds
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 1000335..426681e 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -53,22 +53,6 @@ $(vobjs): KBUILD_CFLAGS += $(CFL)
 CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
 CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
 
-targets += vdso-syms.lds
-extra-$(VDSO64-y)			+= vdso-syms.lds
-
-#
-# Match symbols in the DSO that look like VDSO*; produce a file of constants.
-#
-sed-vdsosym := -e 's/^00*/0/' \
-	-e 's/^\([0-9a-fA-F]*\) . \(VDSO[a-zA-Z0-9_]*\)$$/\2 = 0x\1;/p'
-quiet_cmd_vdsosym = VDSOSYM $@
-define cmd_vdsosym
-	$(NM) $< | LC_ALL=C sed -n $(sed-vdsosym) | LC_ALL=C sort > $@
-endef
-
-$(obj)/%-syms.lds: $(obj)/%.so.dbg FORCE
-	$(call if_changed,vdsosym)
-
 #
 # The DSO images are built using a special linker script.
 #
-- 
2.7.4
