Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B6EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF452229F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvVF7Po4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbfBKTS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:18:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34655 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbfBKTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:18:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so24144plz.1;
        Mon, 11 Feb 2019 11:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U6QTzJmyKky3utGjaHrGeaTnG1UolmYGOzcU+sH5Y+4=;
        b=TvVF7Po4LRk8+UgMyGoXm30CgOd2P6lLmVQn5RZpI5wUzIIoXXtfNAIuqOawTWBGPz
         fS8pjD5cnntQXdELvDLrmIhIFRbp16FQ9xPi/oZa9wRP2NsSsk0ZeyiZlhdJ7Q6TWS9p
         B/lWPUJG7L51x8P3v11HCJuoAlMo5Cxh6bqt53b7xu5PEh2sbNjmF4hY8sZSsijX50TG
         z9qwZ9yHnDkkM/UvCy1vFaOs16f61CnxVKCy2cLC/H939Gke2R+uKpDmLiFm/rkL5Wmt
         ULnZbBqh7G3JPu66P9osymbRJoRcdI/lfk173jGzpMMFkFolagtGay4aT+8Gc3jvSfLT
         izzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U6QTzJmyKky3utGjaHrGeaTnG1UolmYGOzcU+sH5Y+4=;
        b=W5UGQmDli0Z9oI0kF2Wm5DCcj7/WWLMwmCOU4QH7wKt3GjZKd3NeOwmW+bZCvoHvBp
         upa3XMY9XdoV9LqyX7cgnktOs9P7tiS7tBbYAWvpKrI8b7+f0olYNl1zhM8hib1RfHvj
         t/L7OGGiiz9FxOiVCrjEZwJVietpC/gBVh5wOE2ZN+6wVP/NN0l5EzQ3uMCmVyJeW7aP
         ONXTi8YijJgrg8ImlBgO6KF3nJ6yOmXPph50vUWCrzt6QpBFDvjWH1On8sKwF3KcPXl5
         gtRki/b9N36H/8/V1ltz2AtoxxchdXgRfJXr5fc/10U7QlaVz+I6M/2tr3vO3U6vrDrZ
         EhzQ==
X-Gm-Message-State: AHQUAuaB6z4QWC+ZmbtsssgoMIEEcqRRHkkV4JOPRtQt5R4TIOSlFhEC
        UN3eWo3Od/A0m5gDHZnUfcY=
X-Google-Smtp-Source: AHgI3IanC/OTNWPI8Kzdg7h23REmR+aXWc9nczhB8ikk5z0mmrBH5R/gEZhhv/eMlxu6ih5oZqdkJQ==
X-Received: by 2002:a17:902:32c3:: with SMTP id z61mr38926435plb.114.1549912737334;
        Mon, 11 Feb 2019 11:18:57 -0800 (PST)
Received: from [10.33.115.182] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id z7sm14168103pga.6.2019.02.11.11.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:18:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 05/20] x86/alternative: initializing temporary mm for
 patching
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CALCETrVaBaorbOA8QE=Pk=C+PfXZAz0-aX_3O8Y=nJV4QKELbw@mail.gmail.com>
Date:   Mon, 11 Feb 2019 11:18:54 -0800
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
Message-Id: <3EA322C6-5645-4900-AEC6-97FC05716F75@gmail.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-6-rick.p.edgecombe@intel.com>
 <162C6C29-CD81-46FE-9A54-6ED05A93A9CB@gmail.com>
 <00649AE8-69C0-4CD2-A916-B8C8F0F5DAC3@amacapital.net>
 <6FE10C97-25FF-4E99-A96A-465CBACA935B@gmail.com>
 <CALCETrVaBaorbOA8QE=Pk=C+PfXZAz0-aX_3O8Y=nJV4QKELbw@mail.gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 11, 2019, at 11:07 AM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> I'm certainly amenable to other solutions, but this one does seem the
> least messy.  I looked at my old patch, and it doesn't do what you
> want.  I'd suggest you just add a percpu variable like cpu_dr7 and rig
> up some accessors so that it stays up to date.  Then you can skip the
> dr7 writes if there are no watchpoints set.
>=20
> Also, EFI is probably a less interesting example than rare_write.
> With rare_write, especially the dynamically allocated variants that
> people keep coming up with, we'll need a swath of address space fully
> as large as the vmalloc area. and getting *that* right while still
> using the kernel address range might be more of a mess than we really
> want to deal with.

As long as you feel comfortable with this solution, I=E2=80=99m fine =
with it.

Here is what I have (untested). I prefer to save/restore all the DRs,
because IIRC DR6 indications are updated even if breakpoints are =
disabled
(in DR7). And anyhow, that is the standard interface.


-- >8 --

From: Nadav Amit <namit@vmware.com>
Date: Mon, 11 Feb 2019 03:07:08 -0800
Subject: [PATCH] mm: save DRs when loading temporary mm

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/mmu_context.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h =
b/arch/x86/include/asm/mmu_context.h
index d684b954f3c0..4f92ec3df149 100644
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
@@ -380,6 +382,15 @@ static inline temp_mm_state_t =
use_temporary_mm(struct mm_struct *mm)
 	lockdep_assert_irqs_disabled();
 	state.prev =3D this_cpu_read(cpu_tlbstate.loaded_mm);
 	switch_mm_irqs_off(NULL, mm, current);
+
+	/*
+	 * If breakpoints are enabled, disable them while the temporary =
mm is
+	 * used - they do not belong and might cause wrong signals or =
crashes.
+	 */
+	state.bp_enabled =3D hw_breakpoint_active();
+	if (state.bp_enabled)
+		hw_breakpoint_disable();
+
 	return state;
 }
=20
@@ -387,6 +398,13 @@ static inline void =
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
2.17.1


