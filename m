Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C276C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CFB2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 04:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QTSbCsqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CFB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeJOMSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:18:11 -0400
Received: from ozlabs.org ([203.11.71.1]:35621 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeJOMSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:18:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42YQZk1djXz9s3Z;
        Mon, 15 Oct 2018 15:34:38 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539578078;
        bh=81BVPoVjivVx1Xx8lZw0ONstoW6k9vcwU1UGvQStXBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QTSbCsqIFWaeIELQ+rZkXRGtDcpNIwwOKOJe2q9Rw4rVu8Ya2/XLgK/ZpEtWQeuh3
         Dm01eM87iburuV5g7GIg9CAwJXqOqqNKMbLXwGaBtpC2jTl1GK8iTM49BL/21l/c+l
         F5Y7eJzk7oKBDpmHI4n+BrmVO9OMtBkY+mkB90SHRSJFx6hAGJ2lHLseLl2WkzmMy+
         q13SXNN0FmT49bGG286tiYL6EOa+JDC4Eev5+YMvukpHQCTXah4LPgkNuwihDmHI8y
         WP2Kn/2X8v7XNf+5D1FUoJzm1P93O83dWEU5X2PEMAO4gMbH2fyLE9n25MRbvGj6G0
         MNNvB2AgJpoSw==
Date:   Mon, 15 Oct 2018 15:34:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: linux-next: manual merge of the userns tree with the tip tree
Message-ID: <20181015153437.70179aaf@canb.auug.org.au>
In-Reply-To: <20181015151159.5ce4faa5@canb.auug.org.au>
References: <20181015151159.5ce4faa5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//uPbGZ1o=3dWRqpA95cLJTb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//uPbGZ1o=3dWRqpA95cLJTb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 15 Oct 2018 15:11:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the userns tree got a conflict in:
>=20
>   arch/x86/mm/fault.c
>=20
> between commit:
>=20
>   164477c2331b ("x86/mm: Clarify hardware vs. software "error_code"")
> (and others from that series)
>=20
> from the tip tree and commits:
>=20
>   768fd9c69bb5 ("signal/x86: Remove pkey parameter from bad_area_nosemaph=
ore")
>   25c102d803ea ("signal/x86: Remove pkey parameter from mm_fault_error")
>=20
> from the userns tree.
>=20
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/x86/mm/fault.c
> index c2e3e5127ebc,8d77700a7883..000000000000
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
>  +/* Handle faults in the user portion of the address space */
>  +static inline
>  +void do_user_addr_fault(struct pt_regs *regs,
>  +			unsigned long hw_error_code,
>  +			unsigned long address)
>  +{
>  +	unsigned long sw_error_code;
>  +	struct vm_area_struct *vma;
>  +	struct task_struct *tsk;
>  +	struct mm_struct *mm;
>  +	vm_fault_t fault, major =3D 0;
>  +	unsigned int flags =3D FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
>  +	u32 pkey;

I missed removing the above line.

--=20
Cheers,
Stephen Rothwell

--Sig_//uPbGZ1o=3dWRqpA95cLJTb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvEGN0ACgkQAVBC80lX
0GxieQf/aeK0x25reZH22JcQ6z0FnNQzrBZP+N5NAuDPmnfbZXYmD5znKX+ssN9Q
beel1mQ1k8Ks4mM7VXSUdgQeP8z1VFxoEgRm+oSr3Z1igmmMDoXpdOF0AAkzaCTP
Lxnb9mCC1tuKpeVyiNlgNcXwJgwtQhL8w1Wdkrd6dfqMFohQ53/F7nD2LXPwPCLb
e1jCj8YNeFoSM+0fA52lU/7XZBz+1Try7/3+br46aahhxZPiFeRxrYfZbdFWdJxH
tmzpDe4lxB9HdxXF/hNaHZoD9jEJwSXV2RQqdtIqT419cOP02YSF6WNCSjw3j2S9
uDQClDB5G/BF5b7V7LXsqBIRCCHgaQ==
=NDmc
-----END PGP SIGNATURE-----

--Sig_//uPbGZ1o=3dWRqpA95cLJTb--
