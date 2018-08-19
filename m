Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A195C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 00:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0686520C51
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 00:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DP1LqS9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0686520C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeHSDn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 23:43:56 -0400
Received: from ozlabs.org ([203.11.71.1]:37075 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbeHSDn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 23:43:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41tHxj0SPtz9s7c;
        Sun, 19 Aug 2018 10:34:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1534638859;
        bh=xVTiVq3uDTtO4S+8tV3HdTpiPwDAvR+xsZrqYhIfd/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DP1LqS9ZIkNS9BRr38o7dsjm7n9dowDXLpmXGHukmYxt4t5bJRqs8WbpWt6y+Fe7e
         Vcbutx/oN5HBzIxdnfM9cHhxdFEIPsO0Ri7ZeQjeR53MAplyQCb/xQzPniaRKQok4T
         q7Kjyfi93nRMfhu98iWYPiiMNi2H56+ls7pdNXN4dV0B1UiPmkNHAdW8OpgROfEiGL
         4BGzzcxulxz2eCdZ43qBXNGw5WDQXPRQRZZOwQj60EMFwivhAwP5AVW93GwZwnJ6uL
         EHZnYYApj5xiH0l3TW8P7wqSa/4KIH7hSn3fbDR4PnhsrcwsJ8xYHD9UwHWS46b/qF
         Aq+6r0DvjiD9w==
Date:   Sun, 19 Aug 2018 10:34:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: linux-next: manual merge of the nvdimm tree with the tip tree
Message-ID: <20180819103415.289e374c@canb.auug.org.au>
In-Reply-To: <20180626121853.0b4ce17c@canb.auug.org.au>
References: <20180626121853.0b4ce17c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j1v.gcgMc3ASQRMddHpCgWP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j1v.gcgMc3ASQRMddHpCgWP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 26 Jun 2018 12:18:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the nvdimm tree got a conflict in:
>=20
>   arch/x86/kernel/cpu/mcheck/mce.c
>=20
> between commit:
>=20
>   d3d6923cd1ae ("x86/mce: Carve out the crashing_cpu check")
>=20
> from the tip tree and commit:
>=20
>   f6785eac562b ("x86/memory_failure: Introduce {set,clear}_mce_nospec()")
>=20
> from the nvdimm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/x86/kernel/cpu/mcheck/mce.c
> index 9a16f15f79eb,a0fbf0a8b7e6..000000000000
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@@ -1076,129 -1070,6 +1072,100 @@@ static int do_memory_failure(struct mc
>   	return ret;
>   }
>  =20
> - #ifndef mce_unmap_kpfn
> - static void mce_unmap_kpfn(unsigned long pfn)
> - {
> - 	unsigned long decoy_addr;
> -=20
> - 	/*
> - 	 * Unmap this page from the kernel 1:1 mappings to make sure
> - 	 * we don't log more errors because of speculative access to
> - 	 * the page.
> - 	 * We would like to just call:
> - 	 *	set_memory_np((unsigned long)pfn_to_kaddr(pfn), 1);
> - 	 * but doing that would radically increase the odds of a
> - 	 * speculative access to the poison page because we'd have
> - 	 * the virtual address of the kernel 1:1 mapping sitting
> - 	 * around in registers.
> - 	 * Instead we get tricky.  We create a non-canonical address
> - 	 * that looks just like the one we want, but has bit 63 flipped.
> - 	 * This relies on set_memory_np() not checking whether we passed
> - 	 * a legal address.
> - 	 */
> -=20
> - 	decoy_addr =3D (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
> -=20
> - 	if (set_memory_np(decoy_addr, 1))
> - 		pr_warn("Could not invalidate pfn=3D0x%lx from 1:1 map\n", pfn);
> - }
> - #endif
> -=20
> -=20
>  +/*
>  + * Cases where we avoid rendezvous handler timeout:
>  + * 1) If this CPU is offline.
>  + *
>  + * 2) If crashing_cpu was set, e.g. we're entering kdump and we need to
>  + *  skip those CPUs which remain looping in the 1st kernel - see
>  + *  crash_nmi_callback().
>  + *
>  + * Note: there still is a small window between kexec-ing and the new,
>  + * kdump kernel establishing a new #MC handler where a broadcasted MCE
>  + * might not get handled properly.
>  + */
>  +static bool __mc_check_crashing_cpu(int cpu)
>  +{
>  +	if (cpu_is_offline(cpu) ||
>  +	    (crashing_cpu !=3D -1 && crashing_cpu !=3D cpu)) {
>  +		u64 mcgstatus;
>  +
>  +		mcgstatus =3D mce_rdmsrl(MSR_IA32_MCG_STATUS);
>  +		if (mcgstatus & MCG_STATUS_RIPV) {
>  +			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
>  +			return true;
>  +		}
>  +	}
>  +	return false;
>  +}
>  +
>  +static void __mc_scan_banks(struct mce *m, struct mce *final,
>  +			    unsigned long *toclear, unsigned long *valid_banks,
>  +			    int no_way_out, int *worst)
>  +{
>  +	struct mca_config *cfg =3D &mca_cfg;
>  +	int severity, i;
>  +
>  +	for (i =3D 0; i < cfg->banks; i++) {
>  +		__clear_bit(i, toclear);
>  +		if (!test_bit(i, valid_banks))
>  +			continue;
>  +
>  +		if (!mce_banks[i].ctl)
>  +			continue;
>  +
>  +		m->misc =3D 0;
>  +		m->addr =3D 0;
>  +		m->bank =3D i;
>  +
>  +		m->status =3D mce_rdmsrl(msr_ops.status(i));
>  +		if (!(m->status & MCI_STATUS_VAL))
>  +			continue;
>  +
>  +		/*
>  +		 * Corrected or non-signaled errors are handled by
>  +		 * machine_check_poll(). Leave them alone, unless this panics.
>  +		 */
>  +		if (!(m->status & (cfg->ser ? MCI_STATUS_S : MCI_STATUS_UC)) &&
>  +			!no_way_out)
>  +			continue;
>  +
>  +		/* Set taint even when machine check was not enabled. */
>  +		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>  +
>  +		severity =3D mce_severity(m, cfg->tolerant, NULL, true);
>  +
>  +		/*
>  +		 * When machine check was for corrected/deferred handler don't
>  +		 * touch, unless we're panicking.
>  +		 */
>  +		if ((severity =3D=3D MCE_KEEP_SEVERITY ||
>  +		     severity =3D=3D MCE_UCNA_SEVERITY) && !no_way_out)
>  +			continue;
>  +
>  +		__set_bit(i, toclear);
>  +
>  +		/* Machine check event was not enabled. Clear, but ignore. */
>  +		if (severity =3D=3D MCE_NO_SEVERITY)
>  +			continue;
>  +
>  +		mce_read_aux(m, i);
>  +
>  +		/* assuming valid severity level !=3D 0 */
>  +		m->severity =3D severity;
>  +
>  +		mce_log(m);
>  +
>  +		if (severity > *worst) {
>  +			*final =3D *m;
>  +			*worst =3D severity;
>  +		}
>  +	}
>  +
>  +	/* mce_clear_state will clear *final, save locally for use later */
>  +	*m =3D *final;
>  +}
>  +
>   /*
>    * The actual machine check handler. This only handles real
>    * exceptions when something got corrupted coming in through int 18.

This is now a conflict between Linus' tree and the nvdimm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/j1v.gcgMc3ASQRMddHpCgWP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlt4uwcACgkQAVBC80lX
0GyBkQf+JJg3jsfDIx+pvxqUaVohTbPobCieYUJwyveqJlicd5QHM+sxBGCqFNHr
+XvTgzu09Xf2ePs/kx5Mvv0VTA5lp0JO3MV30yHdLFr2XzNJ8ZcbuK18RakS7rSM
rezyapYoCqV5Y6X2iMpUeINn5tzp+xAFoV9Bx6MoJE50sI1uzobZPDywn1XACYnw
rteUQBLXFUqQFSTWxNnXCbtMZr3kVnxsyK6Dk0dGvenaZzGeKO5LIxGHARULdqoA
lTET2mRIdeFNwU4IASDyiv1I6yxV2n+Sltk2wFK6givH3bPdS6nW/GuOV4jU6XKE
H4VujE712BOEPC0KKuMInRXP+4vDJQ==
=NVms
-----END PGP SIGNATURE-----

--Sig_/j1v.gcgMc3ASQRMddHpCgWP--
