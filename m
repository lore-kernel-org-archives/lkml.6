Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ED5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 04:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1240C216E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 04:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F2FOkErn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1240C216E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeHOHLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 03:11:06 -0400
Received: from ozlabs.org ([203.11.71.1]:57833 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeHOHLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 03:11:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41qx8k2Cktz9s7Q;
        Wed, 15 Aug 2018 14:20:38 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534306838;
        bh=VhvdYg1b6rE/emDj3j3Y3g29atowTyUzqFkjJWDwvoc=;
        h=Date:From:To:Cc:Subject:From;
        b=F2FOkErns5e65XQTJQtxeqRqa57QZDj0BdcvfyYm5RUulpYt1tAmjuwTQKg8ewEFA
         8W1SCzCcghMVWmlTEfryQrxzpszhWH3GTg/4ZrLxcYs71heooxbF/9dHFOfF2Z+AuN
         JzYfQf7H33qxtcTX71hsFnWvkpXxImIEQwPE603eGQ/EkEJd+KYYs5TMSqrWUM4N2W
         5epVUd5S92bXa1zNOmH2nsdIcXcqMCeH4COdoZYUd7DzsncbBZkwq81KzHvxrNXHSq
         z6qnsietO3x3eDqmgTfV5petcxfZT691TqN07KQep/3u7BJniwVwSLTO2ov95c+pX5
         J4qqfrl+H1t9w==
Date:   Wed, 15 Aug 2018 14:20:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180815142037.7488cb2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/I=IYeKvdCxKC5JbTkMSHsRK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I=IYeKvdCxKC5JbTkMSHsRK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/vmx.c

between commit:

  a399477e52c1 ("x86/KVM/VMX: Add module argument for L1TF mitigation")

from Linus' tree and commit:

  877ad952be3d ("KVM: vmx: Add tlb_remote_flush callback support")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kvm/vmx.c
index 46b428c0990e,16f9373c01de..000000000000
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@@ -188,150 -189,12 +189,156 @@@ module_param(ple_window_max, uint, 0444
 =20
  extern const ulong vmx_return;
 =20
 +static DEFINE_STATIC_KEY_FALSE(vmx_l1d_should_flush);
 +static DEFINE_STATIC_KEY_FALSE(vmx_l1d_flush_cond);
 +static DEFINE_MUTEX(vmx_l1d_flush_mutex);
 +
 +/* Storage for pre module init parameter parsing */
 +static enum vmx_l1d_flush_state __read_mostly vmentry_l1d_flush_param =3D=
 VMENTER_L1D_FLUSH_AUTO;
 +
 +static const struct {
 +	const char *option;
 +	enum vmx_l1d_flush_state cmd;
 +} vmentry_l1d_param[] =3D {
 +	{"auto",	VMENTER_L1D_FLUSH_AUTO},
 +	{"never",	VMENTER_L1D_FLUSH_NEVER},
 +	{"cond",	VMENTER_L1D_FLUSH_COND},
 +	{"always",	VMENTER_L1D_FLUSH_ALWAYS},
 +};
 +
 +#define L1D_CACHE_ORDER 4
 +static void *vmx_l1d_flush_pages;
 +
 +static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 +{
 +	struct page *page;
 +	unsigned int i;
 +
 +	if (!enable_ept) {
 +		l1tf_vmx_mitigation =3D VMENTER_L1D_FLUSH_EPT_DISABLED;
 +		return 0;
 +	}
 +
 +       if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES)) {
 +	       u64 msr;
 +
 +	       rdmsrl(MSR_IA32_ARCH_CAPABILITIES, msr);
 +	       if (msr & ARCH_CAP_SKIP_VMENTRY_L1DFLUSH) {
 +		       l1tf_vmx_mitigation =3D VMENTER_L1D_FLUSH_NOT_REQUIRED;
 +		       return 0;
 +	       }
 +       }
 +
 +	/* If set to auto use the default l1tf mitigation method */
 +	if (l1tf =3D=3D VMENTER_L1D_FLUSH_AUTO) {
 +		switch (l1tf_mitigation) {
 +		case L1TF_MITIGATION_OFF:
 +			l1tf =3D VMENTER_L1D_FLUSH_NEVER;
 +			break;
 +		case L1TF_MITIGATION_FLUSH_NOWARN:
 +		case L1TF_MITIGATION_FLUSH:
 +		case L1TF_MITIGATION_FLUSH_NOSMT:
 +			l1tf =3D VMENTER_L1D_FLUSH_COND;
 +			break;
 +		case L1TF_MITIGATION_FULL:
 +		case L1TF_MITIGATION_FULL_FORCE:
 +			l1tf =3D VMENTER_L1D_FLUSH_ALWAYS;
 +			break;
 +		}
 +	} else if (l1tf_mitigation =3D=3D L1TF_MITIGATION_FULL_FORCE) {
 +		l1tf =3D VMENTER_L1D_FLUSH_ALWAYS;
 +	}
 +
 +	if (l1tf !=3D VMENTER_L1D_FLUSH_NEVER && !vmx_l1d_flush_pages &&
 +	    !boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {
 +		page =3D alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
 +		if (!page)
 +			return -ENOMEM;
 +		vmx_l1d_flush_pages =3D page_address(page);
 +
 +		/*
 +		 * Initialize each page with a different pattern in
 +		 * order to protect against KSM in the nested
 +		 * virtualization case.
 +		 */
 +		for (i =3D 0; i < 1u << L1D_CACHE_ORDER; ++i) {
 +			memset(vmx_l1d_flush_pages + i * PAGE_SIZE, i + 1,
 +			       PAGE_SIZE);
 +		}
 +	}
 +
 +	l1tf_vmx_mitigation =3D l1tf;
 +
 +	if (l1tf !=3D VMENTER_L1D_FLUSH_NEVER)
 +		static_branch_enable(&vmx_l1d_should_flush);
 +	else
 +		static_branch_disable(&vmx_l1d_should_flush);
 +
 +	if (l1tf =3D=3D VMENTER_L1D_FLUSH_COND)
 +		static_branch_enable(&vmx_l1d_flush_cond);
 +	else
 +		static_branch_disable(&vmx_l1d_flush_cond);
 +	return 0;
 +}
 +
 +static int vmentry_l1d_flush_parse(const char *s)
 +{
 +	unsigned int i;
 +
 +	if (s) {
 +		for (i =3D 0; i < ARRAY_SIZE(vmentry_l1d_param); i++) {
 +			if (sysfs_streq(s, vmentry_l1d_param[i].option))
 +				return vmentry_l1d_param[i].cmd;
 +		}
 +	}
 +	return -EINVAL;
 +}
 +
 +static int vmentry_l1d_flush_set(const char *s, const struct kernel_param=
 *kp)
 +{
 +	int l1tf, ret;
 +
 +	if (!boot_cpu_has(X86_BUG_L1TF))
 +		return 0;
 +
 +	l1tf =3D vmentry_l1d_flush_parse(s);
 +	if (l1tf < 0)
 +		return l1tf;
 +
 +	/*
 +	 * Has vmx_init() run already? If not then this is the pre init
 +	 * parameter parsing. In that case just store the value and let
 +	 * vmx_init() do the proper setup after enable_ept has been
 +	 * established.
 +	 */
 +	if (l1tf_vmx_mitigation =3D=3D VMENTER_L1D_FLUSH_AUTO) {
 +		vmentry_l1d_flush_param =3D l1tf;
 +		return 0;
 +	}
 +
 +	mutex_lock(&vmx_l1d_flush_mutex);
 +	ret =3D vmx_setup_l1d_flush(l1tf);
 +	mutex_unlock(&vmx_l1d_flush_mutex);
 +	return ret;
 +}
 +
 +static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
 +{
 +	return sprintf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].option);
 +}
 +
 +static const struct kernel_param_ops vmentry_l1d_flush_ops =3D {
 +	.set =3D vmentry_l1d_flush_set,
 +	.get =3D vmentry_l1d_flush_get,
 +};
 +module_param_cb(vmentry_l1d_flush, &vmentry_l1d_flush_ops, NULL, 0644);
 +
+ enum ept_pointers_status {
+ 	EPT_POINTERS_CHECK =3D 0,
+ 	EPT_POINTERS_MATCH =3D 1,
+ 	EPT_POINTERS_MISMATCH =3D 2
+ };
+=20
  struct kvm_vmx {
  	struct kvm kvm;
 =20
@@@ -937,21 -828,14 +977,13 @@@ struct vcpu_vmx=20
  	 */
  	struct loaded_vmcs    vmcs01;
  	struct loaded_vmcs   *loaded_vmcs;
+ 	struct loaded_vmcs   *loaded_cpu_state;
  	bool                  __launched; /* temporary, used in vmx_vcpu_run */
  	struct msr_autoload {
 -		unsigned nr;
 -		struct vmx_msr_entry guest[NR_AUTOLOAD_MSRS];
 -		struct vmx_msr_entry host[NR_AUTOLOAD_MSRS];
 +		struct vmx_msrs guest;
 +		struct vmx_msrs host;
  	} msr_autoload;
- 	struct {
- 		int           loaded;
- 		u16           fs_sel, gs_sel, ldt_sel;
- #ifdef CONFIG_X86_64
- 		u16           ds_sel, es_sel;
- #endif
- 		int           gs_ldt_reload_needed;
- 		int           fs_reload_needed;
- 		u64           msr_host_bndcfgs;
- 	} host_state;
+=20
  	struct {
  		int vm86_active;
  		ulong save_rflags;
@@@ -10647,37 -10779,12 +11021,39 @@@ free_vcpu
  	return ERR_PTR(err);
  }
 =20
 +#define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possible=
. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/=
l1tf.html for details.\n"
 +#define L1TF_MSG_L1D "L1TF CPU bug present and virtualization mitigation =
disabled, data leak possible. See CVE-2018-3646 and https://www.kernel.org/=
doc/html/latest/admin-guide/l1tf.html for details.\n"
 +
  static int vmx_vm_init(struct kvm *kvm)
  {
+ 	spin_lock_init(&to_kvm_vmx(kvm)->ept_pointer_lock);
+=20
  	if (!ple_gap)
  		kvm->arch.pause_in_guest =3D true;
 +
 +	if (boot_cpu_has(X86_BUG_L1TF) && enable_ept) {
 +		switch (l1tf_mitigation) {
 +		case L1TF_MITIGATION_OFF:
 +		case L1TF_MITIGATION_FLUSH_NOWARN:
 +			/* 'I explicitly don't care' is set */
 +			break;
 +		case L1TF_MITIGATION_FLUSH:
 +		case L1TF_MITIGATION_FLUSH_NOSMT:
 +		case L1TF_MITIGATION_FULL:
 +			/*
 +			 * Warn upon starting the first VM in a potentially
 +			 * insecure environment.
 +			 */
 +			if (cpu_smt_control =3D=3D CPU_SMT_ENABLED)
 +				pr_warn_once(L1TF_MSG_SMT);
 +			if (l1tf_vmx_mitigation =3D=3D VMENTER_L1D_FLUSH_NEVER)
 +				pr_warn_once(L1TF_MSG_L1D);
 +			break;
 +		case L1TF_MITIGATION_FULL_FORCE:
 +			/* Flush is enforced */
 +			break;
 +		}
 +	}
  	return 0;
  }
 =20
@@@ -12164,15 -12375,25 +12644,28 @@@ static int nested_vmx_run(struct kvm_=
vc
  	 */
 =20
  	vmx->nested.nested_run_pending =3D 1;
- 	ret =3D enter_vmx_non_root_mode(vcpu);
+ 	ret =3D enter_vmx_non_root_mode(vcpu, &exit_qual);
  	if (ret) {
+ 		nested_vmx_entry_failure(vcpu, vmcs12, ret, exit_qual);
  		vmx->nested.nested_run_pending =3D 0;
- 		return ret;
+ 		return 1;
  	}
 =20
 +	/* Hide L1D cache contents from the nested guest.  */
 +	vmx->vcpu.arch.l1tf_flush_l1d =3D true;
 +
+ 	/*
+ 	 * Must happen outside of enter_vmx_non_root_mode() as it will
+ 	 * also be used as part of restoring nVMX state for
+ 	 * snapshot restore (migration).
+ 	 *
+ 	 * In this flow, it is assumed that vmcs12 cache was
+ 	 * trasferred as part of captured nVMX state and should
+ 	 * therefore not be read from guest memory (which may not
+ 	 * exist on destination host yet).
+ 	 */
+ 	nested_cache_shadow_vmcs12(vcpu, vmcs12);
+=20
  	/*
  	 * If we're entering a halted L2 vcpu and the L2 vcpu won't be woken
  	 * by event injection, halt vcpu.

--Sig_/I=IYeKvdCxKC5JbTkMSHsRK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltzqhUACgkQAVBC80lX
0Gye4Af9HwFJwbRb1HtMhF6cZnJmuTd6teDZQ1S1vVHTay7hHL07v29HHqXqWxL8
i9l+DCrJQGSt03viReWu57rTSrjIwZ1qqFWOL/kS4vIFLkltU6ThhZr4P4+U1XtG
UVfRPZrtl/WamV443J2d6ll8EVx9p/bJIZRXGtU3MhSl7WouBRlf1RCMZZ54JU8g
2GnUoD8lz3MlND4tvBdV9gp8aLp1u8x+snIjXQ/mfk29JU42NZcuqYZ4lZPicjBi
wLh0wp/fF8boW2IauQ8SCkd6uAV0KpRX/MlWHz/V9em1k4hAs2zViuL0KAua4uUz
eifjeZDnvOttf3mLRxmbGuD4g9OYnA==
=S4CM
-----END PGP SIGNATURE-----

--Sig_/I=IYeKvdCxKC5JbTkMSHsRK--
