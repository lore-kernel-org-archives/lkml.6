Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2342C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB8920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gryDcrZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB8920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeLMFhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:37:33 -0500
Received: from ozlabs.org ([203.11.71.1]:38123 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbeLMFhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:37:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43FjB138yCz9s9h;
        Thu, 13 Dec 2018 16:37:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544679450;
        bh=fALxO2tRF/wGijO8YR5wmcvlkNkv0tJYnIgXVRQ6eFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gryDcrZ8aaxj/pduWRU3E9T1AEWWlciNuPUbZ1MPNyO8i2g4vygUG5+xWVispgsu0
         oNmEQLs2Su1ZqDTDSnrmOSgtummxtr0+7xj5eXwpp6PQGA2m0On3ba6Vb04MFXZiRi
         +2/pFHBvyP/aA8jsd8Wvdy3QEDT+G90JGjwSXATQmxonOnuo9hpCIfBgqjfXSbeejW
         yoaJ7SbueU5z/nThF5G4DkLst/G+8YkY+05KM9pnjw5reYC83wxMPm9VDz8149gwFD
         vtaNH0gH2L8KMCWU1IEdsfgLH0ZSCtCsT2q9AUg/61LQ/82k07JuAk3gC3u16pmm8n
         l+9pBhm/60jFQ==
Date:   Thu, 13 Dec 2018 16:37:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>, daniel@iogearbox.net,
        ast@kernel.org, netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next: Signed-off-by missing for commits in the bpf-next
 tree
Message-ID: <20181213163728.037ac535@canb.auug.org.au>
In-Reply-To: <20181213043339.znj2674c2povyl2n@ast-mbp.dhcp.thefacebook.com>
References: <20181212205253.d3reuxcyjhnwh3ul@ast-mbp.dhcp.thefacebook.com>
        <20181213094820.62d26354@canb.auug.org.au>
        <20181212233909.hhf5q4vpi3mmi37u@ast-mbp.dhcp.thefacebook.com>
        <20181212.164526.189502766995329983.davem@davemloft.net>
        <20181213043339.znj2674c2povyl2n@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7H3qB79KrcrLaNaQNx2AHBj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7H3qB79KrcrLaNaQNx2AHBj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Wed, 12 Dec 2018 20:33:41 -0800 Alexei Starovoitov <alexei.starovoitov@g=
mail.com> wrote:
>
> If Stephen's scripts can recognize SOB anywhere in the log then
> --signoff can theoretically solve it.

My script just grabs all the Signed-off-by lines in the commit message.

> Unfortunately it's "Incompatible with the --interactive option"
> So we have to do things manually
> or fix scripts
> or fix git.

My version (2.19.1 and 2.20.0) of git does not say it is incompatible
with --interactive, so maybe the last is true :-)  It says:

           Note that
           if --interactive is given then only commits marked to be picked,
           edited or reworded will have the trailer added.

--=20
Cheers,
Stephen Rothwell

--Sig_/7H3qB79KrcrLaNaQNx2AHBj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwR8BgACgkQAVBC80lX
0GwZPgf/UmHtBKwEHKlzvpGEysPSw6VMw8TpQ7WHhm+KNsZI++FdVlIKZeE3+79F
zImch/oZHecj4UOWESGJkFKcxvOO0frnadh9twhYTnzPudiGevNWSq/ZxKpv/3yO
GBEq1BbiY9NV4EYsAHWkaEFcsFWNLT0t9K4n6mFqKd1sVcYGfhikD5rlj7qcDhnh
Xer6O63kB+r3DhF+vkl9ydYe1tV7A8uu+/w2YNbSW0/g+OLZEefyngZjb/MLbrsX
YNlgz0/zdxM/kQHBAgJQhnx4H52CzUMUNDE1yTozgvZJI2fJpbqdF67KZ3H/EAlO
CsTmjihZ0/AyaaUxKyLlTwkYpjlL/A==
=hjO7
-----END PGP SIGNATURE-----

--Sig_/7H3qB79KrcrLaNaQNx2AHBj--
