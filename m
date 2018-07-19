Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3FDC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB6A2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NpZQwIFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB6A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeGSGLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:11:02 -0400
Received: from ozlabs.org ([203.11.71.1]:39009 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbeGSGLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:11:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41WMys3sDHz9s21;
        Thu, 19 Jul 2018 15:29:41 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531978182;
        bh=KKlRm6xhEnyl93ZAeHL07LuDs1IokhIrdfdh5T57Aak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NpZQwIFYn4X0B7mOaac8li3vHj/jxCiAjJUE9D/uZINe1tLhapWzYgNehFmKyDW4o
         jigQFjQ59n6xfA9xXBdrST9ixwbP6EVUVchc9dvZxCD/phFZOFBwyveo0ergmXBRm1
         DfdNmWWv1zZfZVeMGLaaonqcLKqrJvsvmXDAv0kinM3Zg8TyfFaOuVSEHLqJa2beax
         bZ67jxmogMV/X9/qsvnX54VzcGcq2/Pgw692dHUSdEj7H/JHafswVgop9pvkGOqYoB
         Mrl6t2YRCE5rBBWNeH/xRXWzM6a8TKU61fQXjNuM4n9FiDvH8jVZK4i4A9GK/ZJ14g
         rcUSSjKiAQDlA==
Date:   Thu, 19 Jul 2018 15:29:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20180719152940.0720e9c1@canb.auug.org.au>
In-Reply-To: <cbc20089-6847-c0eb-5b5a-735245986be1@roeck-us.net>
References: <20180719120447.6e7ba23d@canb.auug.org.au>
        <cbc20089-6847-c0eb-5b5a-735245986be1@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e5+CAYMH.q6.iaa5Y3=EoUM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e5+CAYMH.q6.iaa5Y3=EoUM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Wed, 18 Jul 2018 20:52:56 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 07/18/2018 07:04 PM, Stephen Rothwell wrote:
> >=20
> > After merging the net-next tree, today's linux-next build (x86_64
> > allmodconfig) produced this warning:
> >=20
> > *
> > * Restart config...
> > *
> > ....
> >=20
> > This is output by my "make allmodconfig" and only started after merging
> > the net-next tree today.  It has continued for further merges/builds.
> >=20
> > I suspect commit
> >=20
> >    1323061a018a ("net: phy: sfp: Add HWMON support for module sensors")
> >=20
> > which added an "imply" clause.
> >  =20
> I thought "imply" was better than "depends on HWMON || HWMON=3Dn", but ma=
ybe
> not. Is that a caveat when using "imply", and does it mean that "imply"
> should better not be used ?

I don't know, sorry.  It was just my best guess from what I could see
had changed.

I wonder if it makes a difference that I am doing my "make
allmodconfig" on top of a previous "make allmodconfig" and some symbols
are marked as "NEW" (though they are not symbols related to the changes
that happened during the net-next tree merge)?
--=20
Cheers,
Stephen Rothwell

--Sig_/e5+CAYMH.q6.iaa5Y3=EoUM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltQIcQACgkQAVBC80lX
0GzSKAf/SqgxH+7fFTpXpnEb2ktajazR10djW9e7DzRsXrIJdJfKzF1SDfaQdF25
nop/mi1x3+Jsh0canYsqgUJ53ZUSN4hE2FabIxBBCHOOXDn7cpP6so0RkZ883KTt
6jaWMiYV9kKCpkMpz9yTyk2AUKFXvMQmXs4DC5OrSEtt6XXVTP29aLVqyePC+i5x
Vi9krLj1JMd8cNDgdvkfu43uUJjdErcO385rKg8PtLSy28ufmVZJ7XxdN6dp+NpB
WYqWZrzTqdZ02ymq/UW/dzWGQ4JeNNLfrmaArNQm4M2YWu25jfiNCV426919SkYi
XsDKezYl435FqSQxrA/ErFqRGpG4HA==
=YjxC
-----END PGP SIGNATURE-----

--Sig_/e5+CAYMH.q6.iaa5Y3=EoUM--
