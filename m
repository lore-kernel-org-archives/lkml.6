Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921AE2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tCaHkc43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921AE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJKJb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:31:26 -0400
Received: from ozlabs.org ([203.11.71.1]:37595 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbeJKJbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:31:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42VvTW5k5Qz9s8F;
        Thu, 11 Oct 2018 13:06:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539223585;
        bh=YCfwt3kMBaCVgD9DyIxkvOP381YPZybdHMi8UVR9y6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tCaHkc43wOEJnNupRIumYSeSaoi6kfbKG2oeB5HzQhwxWSh/j3gdlFRJt47Wz4owG
         xUvWVBvHX3k2lhJvvbPN0zgpj/By5DYWLl5Q3QpHAtzVIVIcdTW4KHqGfsVXQK6AtO
         aoSXSgCYd5vy7Xoepo2qHQKIYaDIKFfSy9W6Kzz20JadHOWXe+CuXcPcV2nOA9ec7I
         NVY+C0M4eIaaPLCFmofXTJEvNTiYee5GfAVxWH+IZkBCyzEn9S1Dco4VCeBQaP0yk3
         LDUVt6rpdeFAcutXwi7nJ/Y25Ixjnk6Wed1w3aQyNCmaaTRcOS6vlcSwUXXetFKJTQ
         InbNYNLUSvGmg==
Date:   Thu, 11 Oct 2018 13:06:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Mackerras <paulus@ozlabs.org>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the kvm-arm
 tree
Message-ID: <20181011130623.59a160f5@canb.auug.org.au>
In-Reply-To: <20181010132224.3bee4dfd@canb.auug.org.au>
References: <20181010132224.3bee4dfd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3w0=xgN3F_mBFfyBq9X7KLx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3w0=xgN3F_mBFfyBq9X7KLx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 10 Oct 2018 13:22:24 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the kvm-ppc tree got a conflict in:
>=20
>   include/uapi/linux/kvm.h
>=20
> between commit:
>=20
>   233a7cb23531 ("kvm: arm64: Allow tuning the physical address size for V=
M")
>=20
> from the kvm-arm tree and commit:
>=20
>   aa069a996951 ("KVM: PPC: Book3S HV: Add a VM capability to enable neste=
d virtualization")
>=20
> from the kvm-ppc tree.
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
> diff --cc include/uapi/linux/kvm.h
> index 95aa73ca65dc,7f2ff3a76995..000000000000
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@@ -962,7 -954,7 +963,8 @@@ struct kvm_ppc_resize_hpt=20
>   #define KVM_CAP_NESTED_STATE 157
>   #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
>   #define KVM_CAP_MSR_PLATFORM_INFO 159
>  -#define KVM_CAP_PPC_NESTED_HV 160
>  +#define KVM_CAP_ARM_VM_IPA_SIZE 160 /* returns maximum IPA bits for a V=
M */
> ++#define KVM_CAP_PPC_NESTED_HV 161
>  =20
>   #ifdef KVM_CAP_IRQ_ROUTING
>  =20

This is now a conflict between the kvm tree and the kvm-arm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/3w0=xgN3F_mBFfyBq9X7KLx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu+sB8ACgkQAVBC80lX
0Gz9lQf+L1a1NBK867v+J5+fc4A8yXfuJtMBrgIvN/YXo4vrqpTmg6PbzYa3BbDB
t86aVjGKXZSI0PhO73+OozBcOhyHVpu4Q0GUsFgEM291wjwJzL/TyT8VQP3eyzzh
A7BKGSY0MJHVNftQLkatr02mlQytVwiQn+AHJxdODZ+bCNbAy92dyFan9DxyAaXX
gGgQRONJ5i023o27UCqjzDSmnoTZ5jMENfVobJoFSFVtwNuo1kx2nuGzU8E3cVpV
iq3cz7EUasMsuZuiNdSOXRCaPAA8tRylyipLiMF4JeXNhX46UmcIpkDYl8QTuQPa
qXH6KmZ6t+seTVm/aX9nq6W1xZDVUg==
=yYQX
-----END PGP SIGNATURE-----

--Sig_/3w0=xgN3F_mBFfyBq9X7KLx--
