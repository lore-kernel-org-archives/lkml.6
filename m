Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr+4/FLKXcZ17gxL6TJ7JLbv8wuWWEiOaeMNkc61espk6a5bRFHth0n1D5PBI/Dc164f1CY
ARC-Seal: i=1; a=rsa-sha256; t=1526937705; cv=none;
        d=google.com; s=arc-20160816;
        b=PTd7CdLPZBplZdp2WYlUg6z3xlkzLIs3E24CgTjtynoVKrcj0sabbFDtxZv0mWjMcF
         74Gb6x11zsmyVbOpb7OJKTPnbIyE58fkDd7hLD+wlL0V3tsjG3XT4dUz1jFJQ3fG2esU
         0v2B2QWxK2qQGH4BZ8shVO+Y5WE/kxitUQVLj8iIX3k2oq0DMhCO1acT2QEfMlHF3W8H
         O7q5buLUo4K2klWhvmPuxRxbIfddpzJXVHlCd1D58wKUCJdE41nCHVr2w19ZJuJFlCxe
         PSDS/gfa7K0CZFVJGzd2Khd3WmHDwvuiC8u4kngq8gKffLjggI8E5vIpPFvkgN68Xnnp
         pe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=DD2rGL0wauJcKtvPBalXImBuVdLqaflB52TW3r+mUTs=;
        b=vwvfFxsbR+rKXYiR+cNw7UZ13WpWgctxbQm2DcA3YLw1CGt9T9TZdzk+g2HWRXp18p
         JQcSiuz6PQKK8xZ05KMqPqikI1fB+lhw1O7vjnXaCid/fmcFlcu9RIccLeXv4XSoWbJD
         ZHgWjlFHQdkvDqv1PdpNcYKcAksHuz3DspqtsUcByJn1HYwSt0OnSHdo6AwzTIhWl+1d
         FYeuGNW6J6bGzW68FNQJXnKAIBO7UUyzLnY2SCSBaAuO9KdcJKM6ZaUCF1eynwMm7FbI
         1X3DqmN1/qRXQEYlpjDfjHHGHK//85Uzk7aL0i9iOocieA3KZRAlXIM06kRxXJ2L2XNU
         NsYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=waRvOV6D;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=waRvOV6D;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 91/95] x86/bugs: Remove x86_spec_ctrl_set()
Date: Mon, 21 May 2018 23:12:21 +0200
Message-Id: <20180521210503.232306563@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109958602156561?=
X-GMAIL-MSGID: =?utf-8?q?1601110231423206205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -133,15 +133,6 @@ static const char *spectre_v2_strings[]
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
@@ -503,7 +494,7 @@ static enum ssb_mitigation __init __ssb_
 		case X86_VENDOR_INTEL:
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask &= ~SPEC_CTRL_SSBD;
-			x86_spec_ctrl_set(SPEC_CTRL_SSBD);
+			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 			break;
 		case X86_VENDOR_AMD:
 			x86_amd_ssb_disable();
@@ -615,7 +606,7 @@ int arch_prctl_spec_ctrl_get(struct task
 void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 
 	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
 		x86_amd_ssb_disable();
