Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AIpwx4/WhTcdi1uwh44Aow0OlOfP88n0HFlkShiJcHxC0RT9cW0Xg0hDDQb49YtTQKsGwoPnhXUD
ARC-Seal: i=1; a=rsa-sha256; t=1523251199; cv=none;
        d=google.com; s=arc-20160816;
        b=OaE0UsFSXrpjjiTttpysVqdF8PQFYBDgnfq3Amw+wS2/9oJbK1PjqNWjZh6kFYiKxs
         g29XIPopGb/7vnY3ViUw03O9t6CJcL2Q8MQ4GA0im/BHuyP4sXJQGE+CCEc09ut+Xkzw
         5h8u8OEr6/XrB+eieySZl6Qv33TfKZ+mEoYkQ/cgf3P81iEJj54dhxeaqU3zKVWanBqJ
         kwOWyNs076FbOzgOTO6oRV/SJRhDn23BsZDz9136RjMpu6q0imTcXsgS8BFdLltnfllb
         FXeNQVWzL3CYQ5k1zxMOb5U4+7qTbVz28WCMdyxyRulGag0aQkI7STZNnAxdhr0wH1gb
         jIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=nYCbTntMuFCr7OhC5m+2v62zWhZaWalFkY21OyKEthg=;
        b=MFnMgA4S1Xykzq9Y7ocGCXCo/ERzcMdUo3ygA8eKwMiUoVaKs3oPlTWildC8lvDR+E
         210UMSC1pKvwpc06FzlvhOqTd1tfl1xkBS1y/jGj9EGlr7iI8aQJws/V3j7ycOrHkdHB
         YLd1X1dJgoSTxrNv6+pbrxS3iJbMZRDxBd/1x7nzPAFx626A6ZvuIOhjlgQJ/JSK4RbN
         lwVmCPX8KqsUejVZjdnFfE6KC4ilXpG4VJ3FxjznFaiA+idprU/Z2fBBVqedDH2lyrLr
         T19YiZwhB7R0cTFpPwQKl4mKp9moCflt97X6D88T+UIP3pzh5Nh/AVqzabqKoJQu4nBC
         dDbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 180.169.121.91 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 180.169.121.91 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<mingo@kernel.org>, <gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>
Subject: Re: [PATCH] x86/Centaur: show more HW features in /proc/cpuinfo
Date: Mon, 9 Apr 2018 13:19:15 +0800
Message-ID: <000001d3cfc2$4dedee00$e9c9ca00$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdPPwhHVO+BlzNqFRbqGOGJvLjphPw==
Content-Language: zh-cn
X-Originating-IP: [10.29.8.18]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597244649472600155?=
X-GMAIL-MSGID: =?utf-8?q?1597244649472600155?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----=D3=CA=BC=FE=D4=AD=BC=FE-----
> =B7=A2=BC=FE=C8=CB: David Wang [mailto:davidwang@zhaoxin.com]
> =B7=A2=CB=CD=CA=B1=BC=E4: 2018=C4=EA4=D4=C28=C8=D5 17:36
> =CA=D5=BC=FE=C8=CB: tglx@linutronix.de; mingo@redhat.com; =
hpa@zytor.com;
> mingo@kernel.org; grehkg@linuxfoundation.org; x86@kernel.org;
> linux-kernel@vger.kernel.org
> =B3=AD=CB=CD: brucechang@via-alliance.com; cooperyan@zhaoxin.com;
> qiyuanwang@zhaoxin.com; benjaminpan@viatech.com; lukelin@viacpu.com;
> timguo@zhaoxin.com; David Wang <davidwang@zhaoxin.com>
> =D6=F7=CC=E2: [PATCH] x86/Centaur: show more HW features in =
/proc/cpuinfo
>=20
> We add this patch to show correct HW features(arch_perfmon, =
tpr_shadow,
> vnmi, flexpriority, ept and vpid) when user execute "cat =
/proc/cpuinfo".
>=20
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/centaur.c | 49
> +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/centaur.c =
b/arch/x86/kernel/cpu/centaur.c
> index e5ec0f1..969fb8f 100644
> --- a/arch/x86/kernel/cpu/centaur.c
> +++ b/arch/x86/kernel/cpu/centaur.c
> @@ -112,6 +112,44 @@ static void early_init_centaur(struct cpuinfo_x86 =
*c)
>  	}
>  }
>=20
> +static void centaur_detect_vmx_virtcap(struct cpuinfo_x86 *c) {
> +#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
> +#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
> +#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
> +#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
> +#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
> +#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
> +
> +	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
> +
> +	clear_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
> +	clear_cpu_cap(c, X86_FEATURE_VNMI);
> +	clear_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
> +	clear_cpu_cap(c, X86_FEATURE_EPT);
> +	clear_cpu_cap(c, X86_FEATURE_VPID);
> +
> +	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
> +	msr_ctl =3D vmx_msr_high | vmx_msr_low;
> +
> +	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
> +		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
> +	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
> +		set_cpu_cap(c, X86_FEATURE_VNMI);
> +	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
> +		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
> +		      vmx_msr_low, vmx_msr_high);
> +		msr_ctl2 =3D vmx_msr_high | vmx_msr_low;
> +		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
> +		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
> +			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
> +		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
> +			set_cpu_cap(c, X86_FEATURE_EPT);
> +		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
> +			set_cpu_cap(c, X86_FEATURE_VPID);
> +	}
> +}
> +
>  static void init_centaur(struct cpuinfo_x86 *c)  {  #ifdef =
CONFIG_X86_32
> @@ -128,6 +166,14 @@ static void init_centaur(struct cpuinfo_x86 *c)
>  	clear_cpu_cap(c, 0*32+31);
>  #endif
>  	early_init_centaur(c);
> +
> +	if (c->cpuid_level > 9) {
> +		unsigned eax =3D cpuid_eax(10);
> +		/* Check for version and the number of counters */
> +		if ((eax & 0xff) && (((eax >> 8) & 0xff) > 1))
> +			set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);
> +	}
> +
>  	switch (c->x86) {
>  #ifdef CONFIG_X86_32
>  	case 5:
> @@ -199,6 +245,9 @@ static void init_centaur(struct cpuinfo_x86 *c)
#ifdef
> CONFIG_X86_64
>  	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);  #endif
> +
> +	if (cpu_has(c, X86_FEATURE_VMX))
> +		centaur_detect_vmx_virtcap(c);
>  }
>=20
>  #ifdef CONFIG_X86_32
> --
> 1.9.1

Sorry to send to wrong email address.
---
David
