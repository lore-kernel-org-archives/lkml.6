Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225dbRI56UiZGF+L8RfupKf/zjfPk14UtzmzvjmYCyjEaU0ikiEyR9arH0vngVB9zMhI3SIf
ARC-Seal: i=1; a=rsa-sha256; t=1517855164; cv=none;
        d=google.com; s=arc-20160816;
        b=SE8S4CA9OVu9bhGgXeXxG416Hx5BUiqbMvStG08uNiosNJQ+wDeXZGqkCgfDho/y52
         KpDLYv5u5wRBl2rzoDanbCA7SmO/js4WEfprvFgIohzL1uuldGRUhMsYBxwloFKGWZrU
         5Nglp0AnJtGLNZ+oI+sGd5x0LmDaImK3ig4tGQXBj584UQTSaa00FrSlnP+RdyqImD34
         89HVCi/vjkx+zeK/o4EQn6ZBLNPNTTBlQ2zRqVa1K2dn7HmY/EolHdg1tgL614WJBK/N
         2YzxJWJzkkcBCy349TjwhQ12aYwt3+txzu38IMc43dSLJAtbeg4IzS54hcQoH/nYWbC6
         VWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h/rdjrc8+RfMPFoWTYIa/omhG82VnfSRVg8taDe0MEA=;
        b=dBDoqRepYyHy23HCPW3y52m4Ac1vmTXa1HW4h1ZGa7JN26FEhGSLEqTMR+NFIyIBj1
         EYbi3J7awVG1Vc/j6zjz6uSoaIhZOaLjTLh2ugiaykaTLYne4g1nuknU8x6THAHKHmJ7
         D+438UPSExpY3MMuUvhvdLaguli1apVhuvqKkHZCxMdLOsH1citoTi1HPoNuA6mk5OHb
         5oSpkD0W8p0ZfgphXa+XfoB+B+LtW9Tu40JkgV3UtElrs7eriittAsaKla8HT46OOQ7A
         X4v18FUazghS9+v1EiGiqol1yV1Nlr/fT918TDdBFqW1jd8+vLiiP6G5kf042zdV4KE5
         MlDA==
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
Subject: [PATCH 4.15 54/60] KVM/x86: Update the reverse_cpuid list to include CPUID_7_EDX
Date: Mon,  5 Feb 2018 10:23:27 -0800
Message-Id: <20180205182216.685303637@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586402222751006?=
X-GMAIL-MSGID: =?utf-8?q?1591586497324890781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
