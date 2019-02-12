Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCEBC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261A5222C5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwWWi/6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfBLSXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:23:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42104 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfBLSXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:23:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so1619617pga.9;
        Tue, 12 Feb 2019 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nxsq3mYQfT8TSMKFYDwSPeWmp3gy8uwIjz9pCZKxPZU=;
        b=PwWWi/6z/KLx8kp9wjrAUlk1y9SQcQBpzqLI155xbQuh2NASaJrqCN5SSi//wUVc1t
         m3IZF6bQ0tcP181OqJfOC4PP5/jFvvVbmxqDrfbignDy8hOUrbxl+8jnwbZeoolbLdL4
         XEz0GAUuJKq9evlAyfWx2172mzsxDQi2dKwmA/IQe/S8JkBksQoSmUGVq1jtWhmSgJc0
         S24uEzPuL1T0dRYazHcnumWpjkpZRALizgsdThj7fKm4E8IDJyI3bRVvVr7yy3kI1ZNG
         wlVU/cnXIyVdyyBk6OVe0QBKrhyRc6Vl+YvVzbEghLWC6V5qmdIl7zdcaTSyrxQzEDjh
         Jqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nxsq3mYQfT8TSMKFYDwSPeWmp3gy8uwIjz9pCZKxPZU=;
        b=P/bd0EdRsXTR+lhdf0yWHki3hPcE5/2zPyRhcCN6Y96mXFHp4mzvn0UTW83tb6zvNY
         cXGqhdZpWIKRhpyOmun7FdvhlUYYddj3ITo5HCBouWTLLbrcDYyGBo314yyTPAeGeDt3
         M4ky03GP92nDqfh08vjp24dcHOrMPt7GhWxddLwMR8HdxtBY6WztyaBGnl4tAJIYJkIB
         VcdlZYpf5jKlG5hlUweLPcipyoqfCc/aFcFos200j3XevcFJHBa4CI20XMiOOtDSehdp
         8fonrBbBWQBMNyqHCVUEpzyU5mPA7vXbGkHq32QeUoVbpMtg7B3J+TuumirunduKA51L
         CI3Q==
X-Gm-Message-State: AHQUAubWZdxhnzOy6JT3lnSZifXL/9pKTPcpCUFMywKKLyVOopxl9RDj
        E21r0SYLXcEZwD+L9mJmAa4=
X-Google-Smtp-Source: AHgI3IaRR3twVY25CJj/D8rBGyc9tBMWkA30qmXX+UKb5QbpMaxH737L2/uz8wJqnvc1p4BG6pttIw==
X-Received: by 2002:a63:d052:: with SMTP id s18mr4726523pgi.11.1549995817579;
        Tue, 12 Feb 2019 10:23:37 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n72sm22979040pfg.13.2019.02.12.10.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 10:23:36 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 05/20] x86/alternative: initializing temporary mm for
 patching
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrXE0n4BrkX2ZLDJjdLqD-N_WwSZHt=S2KKBrTV6Zt5Teg@mail.gmail.com>
Date:   Tue, 12 Feb 2019 10:23:35 -0800
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <570C76C6-DDD2-49C4-8DAF-E8CFEAA21081@gmail.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-6-rick.p.edgecombe@intel.com>
 <162C6C29-CD81-46FE-9A54-6ED05A93A9CB@gmail.com>
 <00649AE8-69C0-4CD2-A916-B8C8F0F5DAC3@amacapital.net>
 <6FE10C97-25FF-4E99-A96A-465CBACA935B@gmail.com>
 <CALCETrVaBaorbOA8QE=Pk=C+PfXZAz0-aX_3O8Y=nJV4QKELbw@mail.gmail.com>
 <3EA322C6-5645-4900-AEC6-97FC05716F75@gmail.com>
 <CALCETrXE0n4BrkX2ZLDJjdLqD-N_WwSZHt=S2KKBrTV6Zt5Teg@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 11, 2019, at 2:47 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Mon, Feb 11, 2019 at 11:18 AM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>>=20
>> +
>> +       /*
>> +        * If breakpoints are enabled, disable them while the =
temporary mm is
>> +        * used - they do not belong and might cause wrong signals or =
crashes.
>> +        */
>=20
> Maybe clarify this?  Add some mention that the specific problem is
> that user code could set a watchpoint on an address that is also used
> in the temporary mm.
>=20
> Arguably we should not disable *kernel* breakpoints a la perf, but
> that seems like quite a minor issue, at least as long as
> use_temporary_mm() doesn't get wider use.  But a comment that this
> also disables perf breakpoints and that this could be undesirable
> might be in order as well.

I think that in the future there may also be security benefits for =
disabling
breakpoints when you are in a sensitive code-block, for instance when =
you
poke text, to prevent the control flow from being hijacked (by =
exploiting a
bug in the debug exception handler). Some additional steps need to be =
taken
for that to be beneficial so I leave it out of the comment for now.

Anyhow, how about this:

-- >8 --

From: Nadav Amit <namit@vmware.com>
Date: Mon, 11 Feb 2019 03:07:08 -0800
Subject: [PATCH] x86/mm: Save DRs when loading a temporary mm

Prevent user watchpoints from mistakenly firing while the temporary mm
is being used. As the addresses that of the temporary mm might overlap
those of the user-process, this is necessary to prevent wrong signals
or worse things from happening.

Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/mmu_context.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h =
b/arch/x86/include/asm/mmu_context.h
index d684b954f3c0..0d6c72ece750 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -13,6 +13,7 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/mpx.h>
+#include <asm/debugreg.h>
=20
 extern atomic64_t last_mm_ctx_id;
=20
@@ -358,6 +359,7 @@ static inline unsigned long =
__get_current_cr3_fast(void)
=20
 typedef struct {
 	struct mm_struct *prev;
+	unsigned short bp_enabled : 1;
 } temp_mm_state_t;
=20
 /*
@@ -380,6 +382,22 @@ static inline temp_mm_state_t =
use_temporary_mm(struct mm_struct *mm)
 	lockdep_assert_irqs_disabled();
 	state.prev =3D this_cpu_read(cpu_tlbstate.loaded_mm);
 	switch_mm_irqs_off(NULL, mm, current);
+
+	/*
+	 * If breakpoints are enabled, disable them while the temporary =
mm is
+	 * used. Userspace might set up watchpoints on addresses that =
are used
+	 * in the temporary mm, which would lead to wrong signals being =
sent or
+	 * crashes.
+	 *
+	 * Note that breakpoints are not disabled selectively, which =
also causes
+	 * kernel breakpoints (e.g., perf's) to be disabled. This might =
be
+	 * undesirable, but still seems reasonable as the code that runs =
in the
+	 * temporary mm should be short.
+	 */
+	state.bp_enabled =3D hw_breakpoint_active();
+	if (state.bp_enabled)
+		hw_breakpoint_disable();
+
 	return state;
 }
=20
@@ -387,6 +405,13 @@ static inline void =
unuse_temporary_mm(temp_mm_state_t prev)
 {
 	lockdep_assert_irqs_disabled();
 	switch_mm_irqs_off(NULL, prev.prev, current);
+
+	/*
+	 * Restore the breakpoints if they were disabled before the =
temporary mm
+	 * was loaded.
+	 */
+	if (prev.bp_enabled)
+		hw_breakpoint_restore();
 }
=20
 #endif /* _ASM_X86_MMU_CONTEXT_H */
--=20
2.17.1=
