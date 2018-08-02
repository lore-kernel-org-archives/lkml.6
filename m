Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C472AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7424A20894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JwOAluDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7424A20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbeHBDHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:07:55 -0400
Received: from ozlabs.org ([203.11.71.1]:58063 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbeHBDHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:07:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gslT0s6Qz9s4s;
        Thu,  2 Aug 2018 11:19:17 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533172758;
        bh=+8zFNefek9P1lwvT8ja6n95TTIx5hvK3517AURcWwmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JwOAluDhPnRWhTenRmpKyS8n8yk/PduF3eBxyYut9z+Ihae4yS17GSEjtQSkPZNX3
         boDvWnk95eziszspcN+1dk7RsMJJKYr5dT9HHI/4SOClDQC0FEIIrJAZUrNRJ2QiRW
         Orx7e4m8DoKtdSJpMm1Mza97cX2Foq527VINpW5u0ue+8KWJRp9z6ZLA1BB3jZrjaO
         bC1INYQaN5mCZsZdbTNmgaUHHltATSH6Uypk3f8nVOtXjRIekVzOm63uvFgEfM9hJG
         6+//fOCjNpHN17l9BCCtFTAsqXJ30NT497D8PIcmNie+qollAellMXG8JZy3yXnZ+C
         ZZQGnv8jwol5g==
Date:   Thu, 2 Aug 2018 11:19:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>, Dongjiu Geng <gengdongjiu@huawei.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: linux-next: manual merge of the kvms390 tree with the kvm-arm
 tree
Message-ID: <20180802111916.7435c0ac@canb.auug.org.au>
In-Reply-To: <20180731142339.19b52ce0@canb.auug.org.au>
References: <20180731142339.19b52ce0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sowLDvZxFpDyyG4yo/_Zpig"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sowLDvZxFpDyyG4yo/_Zpig
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 31 Jul 2018 14:23:39 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the kvms390 tree got a conflict in:
>=20
>   include/uapi/linux/kvm.h
>=20
> between commit:
>=20
>   be26b3a73413 ("arm64: KVM: export the capability to set guest SError sy=
ndrome")
>=20
> from the kvm-arm tree and commit:
>=20
>   a449938297e5 ("KVM: s390: Add huge page enablement control")
>=20
> from the kvms390 tree.
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
> index a7d9bc4e4068,b955b986b341..000000000000
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@@ -949,7 -949,7 +949,8 @@@ struct kvm_ppc_resize_hpt=20
>   #define KVM_CAP_GET_MSR_FEATURES 153
>   #define KVM_CAP_HYPERV_EVENTFD 154
>   #define KVM_CAP_HYPERV_TLBFLUSH 155
>  -#define KVM_CAP_S390_HPAGE_1M 156
>  +#define KVM_CAP_ARM_INJECT_SERROR_ESR 156
> ++#define KVM_CAP_S390_HPAGE_1M 157
>  =20
>   #ifdef KVM_CAP_IRQ_ROUTING
>  =20

This is now a conflict between the s390 and kvm-arm trees.

--=20
Cheers,
Stephen Rothwell

--Sig_/sowLDvZxFpDyyG4yo/_Zpig
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiXBQACgkQAVBC80lX
0Gz4Ggf6AvUpu7vkp1HitNDKgycCHY7tEkbPKS76UsQl5wOW23tuKFLmHNMCskyL
/PkalVu/UGgiF5vFG0gtj5zT24xRIFmU+mVYBbPOFSKomJ4mA2HZNELwpJjASPoL
lNq7jG2Vbm3YldX3MwefMwG3FFN1dfihy/WE1KCPenugSPt/9pM8PAJT4rActifT
I1illgcSBxP8hVQDOVvfjMfn8Rzl7AqRayeyI+izxgxRJ85GcU2p/NF9VawIiR3Q
e7DENwy7isbzW8zTlloibMhmohoXtCP7Ud2SOD1ebRflXZ/1YA/nI0XGNvz10/FE
ZAOn2gbTlvIWeU5v5BWDki1SoncmNw==
=Rc+G
-----END PGP SIGNATURE-----

--Sig_/sowLDvZxFpDyyG4yo/_Zpig--
