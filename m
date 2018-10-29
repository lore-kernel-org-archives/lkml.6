Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D7C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F5E20827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TGknT0UD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F5E20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbeJ2TSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:18:00 -0400
Received: from ozlabs.org ([203.11.71.1]:57377 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbeJ2TSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:18:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42k9p947MHz9s2P;
        Mon, 29 Oct 2018 21:29:53 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540808993;
        bh=MVY+9Rcb7Oi9lKxWukKEkT0h7P9XA1pYNcA+6ocNHTY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TGknT0UD8ZGZqEmaWEHCwW25H30zJPMifJe2Tt1HhTP/sAq36w1n3QqC6Ye81S/JO
         MattB0ghdx+ixxfE5ihT2JxFSr5P3DmeW6Qu2VGgK7fo99XGd99Ffl6qaZnyvl8ecw
         QgAmBa7UiVHkZnCLLxt52cH4As9kft2+wzrVJTwX87Pue+40a4WtrK3LlqzIbgasRZ
         lma1jUU/JTqH1dkUEZbbx7+cLg+Fi3L2W0YIBIY/x/+1kJkqoBTgHMaQFW4IhRua0H
         8SS7oUp5XakPmHTd1GpF/h1bT4xZyHe7P5jublHvOWNVEjIcGadQtsqrDZ3eNriCXe
         dNrdVyLs2GSTA==
Date:   Mon, 29 Oct 2018 21:29:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs tree
Message-ID: <20181029212952.2d0641fb@canb.auug.org.au>
In-Reply-To: <5183.1540804880@warthog.procyon.org.uk>
References: <20181029200620.75f71e94@canb.auug.org.au>
        <20180910133525.28c5dd20@canb.auug.org.au>
        <20181029153334.7c8d16cc@canb.auug.org.au>
        <5183.1540804880@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/KhcNM3A2bKsRes/np1wT8XW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KhcNM3A2bKsRes/np1wT8XW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 29 Oct 2018 09:21:20 +0000 David Howells <dhowells@redhat.com> wrot=
e:
>
> I think these changes should cover them all.

Yep, that fixes the build for me, thanks.

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
--=20
Cheers,
Stephen Rothwell

--Sig_/KhcNM3A2bKsRes/np1wT8XW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvW4SAACgkQAVBC80lX
0GySjAf+KkLkvzFyqH9eEg6RjjqHE5mW/UNqRpBjM7H8tJGaxT7xlvFF0r6XpKbP
fUOdQ/4/8CV4lfH48k++MyMtKh5risumjjTjzz4xZBFflXih/R1EzptuDP59agrw
+5PtvBp+mgS4fxRgI1esNeOSa+Zu24PrvePaNgM65BnzrkFDSv7UBdrK/IpUTs58
UAvc2uw8eOwmrdmpi54UYyTpQJdQOrYvTJyk0fH61MytuAITH3zp+fnEMutvmW1X
WuKFiMrThEQvwM9uWQ2G0C22T/WDk3HIgNbkYjyg4fftccdRmoZ0QIXhe7kcU7dG
MYKkvoiQuhXw/zKrkquE5NkCkJ341w==
=Vt2o
-----END PGP SIGNATURE-----

--Sig_/KhcNM3A2bKsRes/np1wT8XW--
