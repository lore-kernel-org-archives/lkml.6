Return-Path: <prvs=56348445f=karahmed@amazon.de>
X-Google-Smtp-Source: AH8x226by//eh4ZFb544Joh+RPvW/aEmyyAU83qbFFQYO/F+JDM7ybpvc8UHNQn3mzC2eZqe7bnF
ARC-Seal: i=1; a=rsa-sha256; t=1517444714; cv=none;
        d=google.com; s=arc-20160816;
        b=iA6wxFYOwrKJVkwCgBbFulQ9UrR5Wss7XKBWQktuqTCNeMcikWVtDZbF8W5lJo4PKD
         Q5QIf7ZYIU+34W57hhGKmIxPB4k+pqTWJ0EyTHhzd8sNzdV78ThyeRvTeg9taIBrZI8l
         9D2BVcFjE3nVTn+hXSp4B5BaN3ugQUNc0pR8ie89EcyhIboRUivHUzNnYIzjXIUSgzui
         k554zxYtmmVBu5Y3UJ7+viev/KNMOvvTrNgUlIgz5bx3mQSaKoVDwkDAjrIyFo6FMWNU
         3SAsWl1gXwWcSM5/zmdv18OItsFyc+XYXPYgV/BfYbrK9fzSzJkECqJN5pRU0b6tChpx
         emNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-language:in-reply-to:mime-version:user-agent
         :date:message-id:references:cc:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=snER60efwfxmdCsTIuGRhTxuoQ0Y7bqWkPJGaSAfjdY=;
        b=fJfbcbyO97lGmVFKZgOFMQ/zjEQvtsUbonoKfohjEymtKIeu5UdUXpd75/UBcKXBxV
         jmjZ/mVuJRjMkKjEvR056pa1VLpicsjdcz35uKgb4OYQth14ldZT33Eu6o8B/sLg93Kd
         qat6vgW/Dl6V7nERXIHkyOsM4KiZaZjlfUaNDaCxXsr8XRgxrOu2FLdEa2ZIxZLAcoyZ
         UcKKpoP/xEZddhJthl5fWrzO78LUCqXXt7tM+qstyvT1XDjzaNiItm3YCHG535bZR1tB
         f4Hq0mWMQGnyJrXsTFI1ltOIMDltALscSFIQFFJrR304yo4U8607FbJRjlQgC/Xx4WN1
         mOoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=OFmc83hi;
       spf=pass (google.com: domain of prvs=56348445f=karahmed@amazon.de designates 207.171.184.29 as permitted sender) smtp.mailfrom=prvs=56348445f=karahmed@amazon.de;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=OFmc83hi;
       spf=pass (google.com: domain of prvs=56348445f=karahmed@amazon.de designates 207.171.184.29 as permitted sender) smtp.mailfrom=prvs=56348445f=karahmed@amazon.de;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.com
X-Amazon-filename: 0004-KVM-VMX-Allow-direct-access-to-MSR_IA32_SPEC_CTRL.patch
X-IronPort-AV: E=Sophos;i="5.46,442,1511827200";
   d="scan'208,223";a="591878803"
Subject: Re: [PATCH v5 4/5] KVM: VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
From: KarimAllah Ahmed <karahmed@amazon.com>
To: Jim Mattson <jmattson@google.com>
CC: KarimAllah Ahmed <karahmed@amazon.de>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers
	<x86@kernel.org>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan Van De Ven
	<arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, Andi Kleen
	<ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams
	<dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        "Paolo
 Bonzini" <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg KH
	<gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>, Ashok Raj
	<ashok.raj@intel.com>
References: <1517427467-28567-1-git-send-email-karahmed@amazon.de>
 <1517427467-28567-5-git-send-email-karahmed@amazon.de>
 <CALMp9eRgc-qKS5CDTvqoUDdnAXu8xqy9ZB-rew=P9NgE5AfXWA@mail.gmail.com>
 <06cb88da-f355-41ed-380f-7daa8ddf6159@amazon.com>
 <CALMp9eS9LAJz+u3ujKZ5kLHihHMZ68LHajn3ri7sRPPEgFbHfA@mail.gmail.com>
 <a8f25ab3-0b1d-a248-9564-238e3dca3da4@amazon.com>
Message-ID: <e28c13c4-4a04-8a41-2a5c-16509e1bad0e@amazon.com>
Date: Thu, 1 Feb 2018 01:24:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <a8f25ab3-0b1d-a248-9564-238e3dca3da4@amazon.com>
Content-Type: multipart/mixed;
	boundary="------------E06A5B468C37FA90DF9CFCD3"
Content-Language: en-US
X-Originating-IP: [10.43.160.237]
X-ClientProxiedBy: EX13D01UWA001.ant.amazon.com (10.43.160.60) To
 EX13D01EUB003.ant.amazon.com (10.43.166.248)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591113692084885209?=
X-GMAIL-MSGID: =?utf-8?q?1591156109447494735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--------------E06A5B468C37FA90DF9CFCD3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMDEvMzEvMjAxOCAxMTo1MiBQTSwgS2FyaW1BbGxhaCBBaG1lZCB3cm90ZToKPiBPbiAwMS8z
MS8yMDE4IDA5OjE4IFBNLCBKaW0gTWF0dHNvbiB3cm90ZToKPj4gT24gV2VkLCBKYW4gMzEsIDIw
MTggYXQgMTI6MDEgUE0sIEthcmltQWxsYWggQWhtZWQgCj4+IDxrYXJhaG1lZEBhbWF6b24uY29t
PiB3cm90ZToKPj4KPj4+IGJ1dCBzYXZlX3NwZWNfY3RybF9vbl9leGl0IGlzIGFsc28gc2V0IGZv
ciBMMiB3cml0ZS4gU28gb25jZSBMMiB3cml0ZXMKPj4+IHRvIGl0LCB0aGlzIGNvbmRpdGlvbiB3
aWxsIGJlIHRydWUgYW5kIHRoZW4gdGhlIGJpdG1hcCB3aWxsIGJlIHVwZGF0ZWQuCj4+Cj4+IFNv
IGlmIEwxIG9yIGFueSBMMiB3cml0ZXMgdG8gdGhlIE1TUiwgdGhlbiBzYXZlX3NwZWNfY3RybF9v
bl9leGl0IGlzCj4+IHNldCB0byB0cnVlLCBldmVuIGlmIHRoZSBNU1IgcGVybWlzc2lvbiBiaXRt
YXAgZm9yIGEgcGFydGljdWxhciBWTUNTCj4+ICpkb2Vzbid0KiBhbGxvdyB0aGUgTVNSIHRvIGJl
IHdyaXR0ZW4gd2l0aG91dCBhbiBpbnRlcmNlcHQuIFRoYXQncwo+PiBmdW5jdGlvbmFsbHkgY29y
cmVjdCwgYnV0IGluZWZmaWNpZW50LiBJdCBzZWVtcyB0byBtZSB0aGF0Cj4+IHNhdmVfc3BlY19j
dHJsX29uX2V4aXQgc2hvdWxkIGluZGljYXRlIHdoZXRoZXIgb3Igbm90IHRoZSAqY3VycmVudCoK
Pj4gTVNSIHBlcm1pc3Npb24gYml0bWFwIGFsbG93cyB1bmludGVyY2VwdGVkIHdyaXRlcyB0byBJ
QTMyX1NQRUNfQ1RSTC4KPj4gVG8gdGhhdCBlbmQsIHBlcmhhcHMgc2F2ZV9zcGVjX2N0cmxfb25f
ZXhpdCByaWdodGZ1bGx5IGJlbG9uZ3MgaW4gdGhlCj4+IGxvYWRlZF92bWNzIHN0cnVjdHVyZSwg
YWxvbmdzaWRlIHRoZSBtc3JfYml0bWFwIHBvaW50ZXIgdGhhdCBpdCBpcwo+PiBhc3NvY2lhdGVk
IHdpdGguIEZvciB2bWNzMDIsIG5lc3RlZF92bXhfbWVyZ2VfbXNyX2JpdG1hcCgpIHNob3VsZCBz
ZXQKPj4gdGhlIHZtY3MwMiBzYXZlX3NwZWNfY3RybF9vbl9leGl0IGJhc2VkIG9uIChhKSB3aGV0
aGVyIEwwIGlzIHdpbGxpbmcKPj4gdG8geWllbGQgdGhlIE1TUiB0byBMMSwgYW5kIChiKSB3aGV0
aGVyIEwxIGlzIHdpbGxpbmcgdG8geWllbGQgdGhlIE1TUgo+PiB0byBMMi4KPiAKPiBJIGFjdHVh
bGx5IGdvdCByaWQgb2YgdGhpcyBzYXZlX3NwZWNfY3RybF9vbl9leGl0IHZhcmlhYmxlIGFuZCBy
ZXBsYWNlZAo+IGl0IHdpdGggYW5vdGhlciB2YXJpYWJsZSBsaWtlIHRoZSBvbmUgc3VnZ2VzdGVk
IGZvciBJQlBCLiBKdXN0IHRvIGF2b2lkCj4gZG9pbmcgYW4gZXhwZW5zaXZlIGd1ZXN0X2NwdWlk
X2hhcy4gTm93IEkgcGVhayBpbnN0ZWFkIGluIHRoZSBNU1IgYml0bWFwCj4gdG8gZmlndXJlIG91
dCBpZiB0aGlzIE1TUiB3YXMgc3VwcG9zZWQgdG8gYmUgaW50ZXJjZXB0ZWQgb3Igbm90LiBUaGlz
Cj4gdGVzdCBzaG91bGQgcHJvdmlkZSBhIHNpbWlsYXIgc2VtYW50aWNzIHRvIHNhdmVfc3BlY19j
dHJsX29uX2V4aXQuCj4gCj4gQW55d2F5LCBjbGVhbmluZyB1cC90ZXN0aW5nIG5vdyBhbmQgd2ls
bCBwb3N0IGEgbmV3IHZlcnNpb24uCgpJIHRoaW5rIHRoaXMgcGF0Y2ggc2hvdWxkIGFkZHJlc3Mg
YWxsIHlvdXIgY29uY2VybnMuCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJI
CkJlcmxpbiAtIERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZpY2U6IEtyYXVzZW5zdHIuIDM4LCAx
MDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBSYWxmIEhlcmJyaWNoLCBDaHJpc3Rp
YW4gU2NobGFlZ2VyClVzdC1JRDogREUyODkyMzc4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmlj
aHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==

--------------E06A5B468C37FA90DF9CFCD3
Content-Type: text/x-patch;
	name="0004-KVM-VMX-Allow-direct-access-to-MSR_IA32_SPEC_CTRL.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0004-KVM-VMX-Allow-direct-access-to-MSR_IA32_SPEC_CTRL.patch"

>From 9c19a8ac3f021efba6f70ad7e28f7ad06bb97e43 Mon Sep 17 00:00:00 2001
From: KarimAllah Ahmed <karahmed@amazon.de>
Date: Mon, 29 Jan 2018 19:58:10 +0000
Subject: [PATCH] KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL

[ Based on a patch from Ashok Raj <ashok.raj@intel.com> ]

Add direct access to MSR_IA32_SPEC_CTRL for guests. This is needed for
guests that will only mitigate Spectre V2 through IBRS+IBPB and will not
be using a retpoline+IBPB based approach.

To avoid the overhead of atomically saving and restoring the
MSR_IA32_SPEC_CTRL for guests that do not actually use the MSR, only
add_atomic_switch_msr when a non-zero is written to it.

No attempt is made to handle STIBP here, intentionally. Filtering STIBP
may be added in a future patch, which may require trapping all writes
if we don't want to pass it through directly to the guest.

[dwmw2: Clean up CPUID bits, save/restore manually, handle reset]

Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
v6:
- got rid of save_spec_ctrl_on_exit
- introduce spec_ctrl_intercepted
- introduce spec_ctrl_used
v5:
- Also check for X86_FEATURE_SPEC_CTRL for the msr reads/writes
v4:
- Add IBRS to kvm_cpuid_8000_0008_ebx_x86_features
- Handling nested guests
v3:
- Save/restore manually
- Fix CPUID handling
- Fix a copy & paste error in the name of SPEC_CTRL MSR in
  disable_intercept.
- support !cpu_has_vmx_msr_bitmap()
v2:
- remove 'host_spec_ctrl' in favor of only a comment (dwmw@).
- special case writing '0' in SPEC_CTRL to avoid confusing live-migration
  when the instance never used the MSR (dwmw@).
- depend on X86_FEATURE_IBRS instead of X86_FEATURE_SPEC_CTRL (dwmw@).
- add MSR_IA32_SPEC_CTRL to the list of MSRs to save (dropped it by accident).
---
 arch/x86/kvm/cpuid.c |  9 +++--
 arch/x86/kvm/vmx.c   | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c   |  2 +-
 3 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 1909635..13f5d42 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -367,7 +367,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(IBPB);
+		F(IBPB) | F(IBRS);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
@@ -394,7 +394,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(ARCH_CAPABILITIES);
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
+		F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
@@ -630,9 +631,11 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			g_phys_as = phys_as;
 		entry->eax = g_phys_as | (virt_as << 8);
 		entry->edx = 0;
-		/* IBPB isn't necessarily present in hardware cpuid */
+		/* IBRS and IBPB aren't necessarily present in hardware cpuid */
 		if (boot_cpu_has(X86_FEATURE_IBPB))
 			entry->ebx |= F(IBPB);
+		if (boot_cpu_has(X86_FEATURE_IBRS))
+			entry->ebx |= F(IBRS);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
 		break;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6a9f4ec..bfc80ff 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -594,6 +594,14 @@ struct vcpu_vmx {
 #endif
 
 	u64 		      arch_capabilities;
+	u64 		      spec_ctrl;
+
+	/*
+	 * This indicates that:
+	 * 1) guest_cpuid_has(X86_FEATURE_IBRS) == true &&
+	 * 2) The guest has actually initiated a write against the MSR.
+	 */
+	bool spec_ctrl_used;
 
 	/*
 	 * This indicates that:
@@ -946,6 +954,8 @@ static void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 					    u16 error_code);
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
+static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+							  u32 msr, int type);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -1917,6 +1927,22 @@ static void update_exception_bitmap(struct kvm_vcpu *vcpu)
 	vmcs_write32(EXCEPTION_BITMAP, eb);
 }
 
+/* Is SPEC_CTRL intercepted for the currently running vCPU? */
+static bool spec_ctrl_intercepted(struct kvm_vcpu *vcpu)
+{
+	unsigned long *msr_bitmap;
+	int f = sizeof(unsigned long);
+
+	if (!cpu_has_vmx_msr_bitmap())
+		return true;
+
+	msr_bitmap = is_guest_mode(vcpu) ?
+			to_vmx(vcpu)->nested.vmcs02.msr_bitmap :
+			to_vmx(vcpu)->vmcs01.msr_bitmap;
+
+	return !!test_bit(MSR_IA32_SPEC_CTRL, msr_bitmap + 0x800 / f);
+}
+
 static void clear_atomic_switch_msr_special(struct vcpu_vmx *vmx,
 		unsigned long entry, unsigned long exit)
 {
@@ -3246,6 +3272,14 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_TSC:
 		msr_info->data = guest_read_tsc(vcpu);
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
+			return 1;
+
+		msr_info->data = to_vmx(vcpu)->spec_ctrl;
+		break;
 	case MSR_IA32_ARCH_CAPABILITIES:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
@@ -3359,6 +3393,34 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr_info);
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
+			return 1;
+
+		vmx->spec_ctrl_used = true;
+
+		/* The STIBP bit doesn't fault even if it's not advertised */
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+			return 1;
+
+		vmx->spec_ctrl = data;
+
+		/*
+		 * When it's written (to non-zero) for the first time, pass
+		 * it through. This means we don't have to take the perf
+		 * hit of saving it on vmexit for the common case of guests
+		 * that don't use it.
+		 */
+		if (cpu_has_vmx_msr_bitmap() && data &&
+		    spec_ctrl_intercepted(vcpu) &&
+		    is_guest_mode(vcpu))
+			vmx_disable_intercept_for_msr(
+					vmx->vmcs01.msr_bitmap,
+					MSR_IA32_SPEC_CTRL,
+					MSR_TYPE_RW);
+		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB) &&
@@ -5678,6 +5740,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	u64 cr0;
 
 	vmx->rmode.vm86_active = 0;
+	vmx->spec_ctrl = 0;
 
 	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
 	kvm_set_cr8(vcpu, 0);
@@ -9349,6 +9412,15 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 
 	vmx_arm_hv_timer(vcpu);
 
+	/*
+	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
+	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
+	 * is no need to worry about the conditional branch over the wrmsr
+	 * being speculatively taken.
+	 */
+	if (vmx->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
 		/* Store host registers */
@@ -9467,6 +9539,19 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
 	      );
 
+	/*
+	 * We do not use IBRS in the kernel. If this vCPU has used the
+	 * SPEC_CTRL MSR it may have left it on; save the value and
+	 * turn it off. This is much more efficient than blindly adding
+	 * it to the atomic save/restore list. Especially as the former
+	 * (Saving guest MSRs on vmexit) doesn't even exist in KVM.
+	 */
+	if (!spec_ctrl_intercepted(vcpu))
+		rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+
+	if (vmx->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
@@ -10092,7 +10177,8 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
 
 	if (!nested_cpu_has_virt_x2apic_mode(vmcs12) &&
-	    !to_vmx(vcpu)->pred_cmd_used)
+	    !to_vmx(vcpu)->pred_cmd_used &&
+	    !to_vmx(vcpu)->spec_ctrl_used)
 		return false;
 
 	page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->msr_bitmap);
@@ -10126,6 +10212,12 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
 		}
 	}
 
+	if (to_vmx(vcpu)->spec_ctrl_used)
+		nested_vmx_disable_intercept_for_msr(
+					msr_bitmap_l1, msr_bitmap_l0,
+					MSR_IA32_SPEC_CTRL,
+					MSR_TYPE_R | MSR_TYPE_W);
+
 	if (to_vmx(vcpu)->pred_cmd_used)
 		nested_vmx_disable_intercept_for_msr(
 					msr_bitmap_l1, msr_bitmap_l0,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4ec142e..ac38143 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1009,7 +1009,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_ARCH_CAPABILITIES
+	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES
 };
 
 static unsigned num_msrs_to_save;
-- 
2.7.4


--------------E06A5B468C37FA90DF9CFCD3--
