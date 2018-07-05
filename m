Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BA3C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BEC2407B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AydutiPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BEC2407B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeGECrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:47:08 -0400
Received: from ozlabs.org ([203.11.71.1]:33021 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752965AbeGECrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:47:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Lj1d6Jngz9s29;
        Thu,  5 Jul 2018 12:47:01 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530758821;
        bh=m3MyrHsfSaMIP982CYMBKVIzcGuiZatP2SsEJ+0QYXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AydutiPPZkfjram26d9T5+r5yLZ5fkkdS2kNCKyay8jIYMySej/nAPjLPg7zJZNwA
         kq0DxbNFsgn+SPTw3bOQKhesVW6aFjt5e7b4/YthDbznN5Tkcl1S8uP7bxSYYogmLC
         NFtWvLHVrMMCAaixM1ppFK1rBPr3FaHXovulkAX9AoFZTn2ovBHfb5qP+5XeVL3w85
         ZOTVmAZ/Ncn+fNL0NUgxOPOMe8ES6CWwnSgk9Zohs4ytNK2OA4fC8va1xJ1gAcxeYy
         0eUbtVl+FJhs4Mu6wTmP2ksWSLYwm4+8isy9tG74aXCQ51Fv8Y5XOkIv1Ug7ASFjyR
         wajWxvv2KBZ4A==
Date:   Thu, 5 Jul 2018 12:47:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod <vkoul@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Angelo Dureghello <angelo@sysam.it>
Subject: Re: linux-next: build warning after merge of the slave-dma tree
Message-ID: <20180705124701.0454b482@canb.auug.org.au>
In-Reply-To: <20180704042017.GW22377@vkoul-mobl>
References: <20180704133006.4d42d1a6@canb.auug.org.au>
        <20180704042017.GW22377@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Qifk6047KtBFWimBiNkb0x3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Qifk6047KtBFWimBiNkb0x3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

On Wed, 4 Jul 2018 09:50:17 +0530 Vinod <vkoul@kernel.org> wrote:
>
> On 04-07-18, 13:30, Stephen Rothwell wrote:
> >=20
> > After merging the slave-dma tree, today's linux-next build (x86_64
> > allmodconfig) produced this warning:
> >=20
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/fsl-edma-comm=
on.o =20
>=20
> Thanks for the report, I have fixed it by adding this and pushed out.

Unfortunately, my arm multi_v7_defconfig build now gets this failure:

drivers/dma/fsl-edma-common.c:672:16: error: expected declaration specifier=
s or '...' before string constant
 MODULE_LICENSE("GPL v2");  =20
                ^~~~~~~~

presumable a missing include of module.h ...

I have gone back to the slave-dma tree from next-20180704 for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/Qifk6047KtBFWimBiNkb0x3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls9hqUACgkQAVBC80lX
0GzMugf+KsTnYTIgs5Jt+p0VYehF3gBUyQztjbu0wvBpbXcKxP51Gv9os3J9/wZV
HlrsPrPLA+sh7YF7lO+97O/ZZTBEKmN8PpzkWgIEfZot95gmoAoz8i4QnZ4tKsX+
FRsTpXa/GNnBmajM45bj5QUeYiAojXrAVP0sVflk2ltcBT8hfTdWCjLlZwtfh3Qt
Ov5Q627Lke3sXEJzaz2hQ4nfTWyYGQwaLqN7TfuPPyFNScaUkbbfooTTxmiRHgkD
1QlSRmzauWKcSQ95bbbJWHpn4ieQw8CHreWVBvLzzJ+N98jwCDGEBLaLnzVVnxkG
o33pHf95e8+WIueKQ/vqogavYwqfww==
=hO0j
-----END PGP SIGNATURE-----

--Sig_/Qifk6047KtBFWimBiNkb0x3--
