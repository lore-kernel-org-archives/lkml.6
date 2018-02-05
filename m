Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225MwSqszMTINVU7gU0SqcetUVNk1wdE+4oXT3P3/eFTaZh0w2oTFBaSXIYUCnKTJGUbEjoM
ARC-Seal: i=1; a=rsa-sha256; t=1517855073; cv=none;
        d=google.com; s=arc-20160816;
        b=JMPuegA67OEwlDs64C9PNsRw3MR8iSMAg/TvQxnJnr2BQbfUn1YHelj/wnqGwLJit8
         mBn1Ev7mDCYij5gQwRLCCIpRGZxQWeXNLspxnLv0mHI2rpy+zbTVWAouuVQ6A+fpQGTE
         vYmnyQeSXD7NJv10i6KxlrZTEn+jau1l7ClJ46QKkoeUUOMuAfiRECVwjX5OV55CJ2mg
         9IMa8prFY8sWnE01/0G6sDI6os/P+Mz7WaWUE61OxeN44vDqWXFbisvYwa0s3zsHJG/F
         xe/BQ3FcA8DhBqllSp3o867xFo0LuS3YMYCgal+JZDxPCiRZlRa867cC4pLdtrYaZNTK
         CTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gKdcx2UVn79k53srqQtu0Y7zRZOEITvgEmbZeqKxPEY=;
        b=jSDqYO3GWPIRdueTx6ACrO096q+fWDXOjG904LaBhvm33qivZ4onHO4hBT6q/8hH2k
         hJ32e2tIgGdevpVeauA8W6w0E49f4ZrccBeVD4krkNc7BlJEm3rBjPqw8Rn5Jlzx2qro
         gPyImY6pALnL+jrGy9fG9Tl3SDhu1UfKVE+5CwJiEQZnfkAiKQqubkfsBZzlRU1Txfu0
         rnzJNE7SLNdCTshT9TMAb/wc35vo6CXSL5lj3iuy8+okaN3rggXfUCC9yGzsDk3Y0LD/
         EECErbigkbGd7B0hioLj4PWNnQ/E9C4D5ia/VWKb6Il239uMlm+ssSoDk+QkRn1BXNCa
         dGtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	KarimAllah Ahmed <karahmed@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.14 58/64] KVM/x86: Update the reverse_cpuid list to include CPUID_7_EDX
Date: Mon,  5 Feb 2018 10:23:17 -0800
Message-Id: <20180205182140.960125155@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586402222751006?=
X-GMAIL-MSGID: =?utf-8?q?1591586402222751006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed karahmed@amazon.de

commit b7b27aa011a1df42728d1768fc181d9ce69e6911

[dwmw2: Stop using KF() for bits in it, too]
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: kvm@vger.kernel.org
Cc: Radim Krčmář <rkrcmar@redhat.com>
Link: https://lkml.kernel.org/r/1517522386-18410-2-git-send-email-karahmed@amazon.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kvm/cpuid.c |    8 +++-----
 arch/x86/kvm/cpuid.h |    1 +
 2 files changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -67,9 +67,7 @@ u64 kvm_supported_xcr0(void)
 
 #define F(x) bit(X86_FEATURE_##x)
 
-/* These are scattered features in cpufeatures.h. */
-#define KVM_CPUID_BIT_AVX512_4VNNIW     2
-#define KVM_CPUID_BIT_AVX512_4FMAPS     3
+/* For scattered features from cpufeatures.h; we currently expose none */
 #define KF(x) bit(KVM_CPUID_BIT_##x)
 
 int kvm_update_cpuid(struct kvm_vcpu *vcpu)
@@ -392,7 +390,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		KF(AVX512_4VNNIW) | KF(AVX512_4FMAPS);
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
@@ -477,7 +475,7 @@ static inline int __do_cpuid_ent(struct
 			if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
 				entry->ecx &= ~F(PKU);
 			entry->edx &= kvm_cpuid_7_0_edx_x86_features;
-			entry->edx &= get_scattered_cpuid_leaf(7, 0, CPUID_EDX);
+			cpuid_mask(&entry->edx, CPUID_7_EDX);
 		} else {
 			entry->ebx = 0;
 			entry->ecx = 0;
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -54,6 +54,7 @@ static const struct cpuid_reg reverse_cp
 	[CPUID_8000_000A_EDX] = {0x8000000a, 0, CPUID_EDX},
 	[CPUID_7_ECX]         = {         7, 0, CPUID_ECX},
 	[CPUID_8000_0007_EBX] = {0x80000007, 0, CPUID_EBX},
+	[CPUID_7_EDX]         = {         7, 0, CPUID_EDX},
 };
 
 static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
