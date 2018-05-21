Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqxFY7PuVnOawzxl/cFPnrTDtb+tJ1KNGv0mUjAnZYN1ohWw35VDd4uELWCZPpenDvZR6MX
ARC-Seal: i=1; a=rsa-sha256; t=1526937445; cv=none;
        d=google.com; s=arc-20160816;
        b=QhZJ85ld6iPtppGwhwuctudASjG5WCz51LrLONmb8E29Rw/H/1ISkKETd6itSU2/Ii
         jN4hnSCMyF4JTG3a1hoi9WOz8mDyCFODjIkfX9It53o9UycuV03gwp9a2toNgB22lmOr
         TwkGFptkg+9Wpq4ZzYPNKHcrBdcyh/O0XGl0sUz7rD/Lo7kDidkUTCs1tmBBXM7rRDHH
         toRnZYTMwTzIEHJrTQuFePHq5sA78BuhRg4Zt+CVoaVw+BylYOnGbiu7Z0D744eBSSu4
         rT6Ht8SddeHAdNdL9sbYabEVQ3mXg01oze99Tnkvo9WzBapFpomFGK/CrSOtPDDuBZz4
         YKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=aYxMk2FRAE0BbR6c8JxanDX7+G/2bDOHnLS19xUFAm8=;
        b=o625eSkwFPJuDUG7/RCrJVlprXHh8LTWncqGoxtnoQqeCgzOsAHBhfqLrM+Zau4OrC
         XHAmuVbBcQzo5mpFjKt7u/oa5E2dj+jrOeHb+jL3qSX2AKs2B1xNe0ACo8Ck3J4qqQQE
         qzC75OWMJXRSHobuK9rqwfNeh2fPInVEufMsH9GWrtOMjLUuOEUF0mo/eFc704m/XCMB
         S6zgD+Fl53SIK+cF2CL4Maic06eXrmfYAQeSX3vlqSfJSJFE4wHIEcjxFsSoyRICdPcN
         DhsjojkhHrchFO2ktyOR7Wh7s1wiXzURVsdq1R9FJcUHWr1lKHd7I9IiJFdvQ00rQwBW
         hyjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fBx8L6Eg;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fBx8L6Eg;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 83/87] x86/bugs: Remove x86_spec_ctrl_set()
Date: Mon, 21 May 2018 23:11:59 +0200
Message-Id: <20180521210427.077924191@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109958602156561?=
X-GMAIL-MSGID: =?utf-8?q?1601109958602156561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 4b59bdb569453a60b752b274ca61f009e37f4dae upstream

x86_spec_ctrl_set() is only used in bugs.c and the extra mask checks there
provide no real value as both call sites can just write x86_spec_ctrl_base
to MSR_SPEC_CTRL. x86_spec_ctrl_base is valid and does not need any extra
masking or checking.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    2 --
 arch/x86/kernel/cpu/bugs.c           |   13 ++-----------
 2 files changed, 2 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -217,8 +217,6 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS,
 };
 
-extern void x86_spec_ctrl_set(u64);
-
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -132,15 +132,6 @@ static const char *spectre_v2_strings[]
 static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 	SPECTRE_V2_NONE;
 
-void x86_spec_ctrl_set(u64 val)
-{
-	if (val & x86_spec_ctrl_mask)
-		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
-	else
-		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
-}
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
-
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
@@ -502,7 +493,7 @@ static enum ssb_mitigation __init __ssb_
 		case X86_VENDOR_INTEL:
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask &= ~SPEC_CTRL_SSBD;
-			x86_spec_ctrl_set(SPEC_CTRL_SSBD);
+			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 			break;
 		case X86_VENDOR_AMD:
 			x86_amd_ssb_disable();
@@ -614,7 +605,7 @@ int arch_prctl_spec_ctrl_get(struct task
 void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 
 	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
 		x86_amd_ssb_disable();
