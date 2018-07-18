Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BBCECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527362075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XJo4z7yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527362075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeGREFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:05:42 -0400
Received: from ozlabs.org ([203.11.71.1]:60115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725727AbeGREFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:05:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41VjM76DJdz9s0n;
        Wed, 18 Jul 2018 13:29:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531884596;
        bh=BKr5fN944zM+6gfToomUaJeOocde1hs8yL7gm8d3X0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XJo4z7ySUCAkwLmjLn/xekf5c5EoosFQP0+YqNpSp3QnQh1Wcc/Np+w5ARO0Ajlnc
         ST/aoWPoLxkq5NAN/3Vjj9Os/3d2vPa3tTQXn1pzPgQQozF2DjeyT6Yb/eosqP9CGU
         SkhVOpF77Ez+rAwDBqoLcEid5v3AJobUWJZz5kAuVPqAwSgV1g/BjdoRM1P8Dm7N45
         xzkQv1YRXZyjRO6DFyFD3O2J9kpdXLPsMrjVisi3ma8d8HKjqmJVqelFihQd+cPRf0
         ZXBYQxngcYOOszBgERIXZIxOzaFmWMg8fEVClpE/kzTHoxFPF94SvvqtBjwWEnW+2q
         I+ZBByrYK+diQ==
Date:   Wed, 18 Jul 2018 13:29:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: vfs / overlayfs conflict resolution for linux-next
Message-ID: <20180718132955.2bf185b7@canb.auug.org.au>
In-Reply-To: <20180718025636.GA26175@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
        <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
        <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
        <20180711152555.GR30522@ZenIV.linux.org.uk>
        <20180711161540.GS30522@ZenIV.linux.org.uk>
        <20180712124326.GA19272@ZenIV.linux.org.uk>
        <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
        <20180712155337.GU30522@ZenIV.linux.org.uk>
        <20180718025636.GA26175@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/a1RCDR5.IDO/MuCqW+dAvKR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a1RCDR5.IDO/MuCqW+dAvKR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Wed, 18 Jul 2018 03:56:37 +0100 Al Viro <viro@ZenIV.linux.org.uk> wrote:
>
> ... and now it even builds.  Said that, I would really like to hear somet=
hing
> from you - I can duplicate the entire overlayfs-next and merge it into
> my #for-next and ask Steven to use that instead of your tree, but I very
> much dislike going over your head like that.
>=20
> I realize that you'd been away for a while and probably are digging yours=
elf
> from under the piles of mail, but it's getting late in the cycle and I wa=
nt
> to get #for-next into reasonably sane shape.  Please, look through that
> thing and respond.

Almost everything has been removed from the overlayfs tree in
linux-next today.  The only commit there currently is:

67810693077a ovl: fix wrong use of impure dir cache in ovl_iterate()
--=20
Cheers,
Stephen Rothwell

--Sig_/a1RCDR5.IDO/MuCqW+dAvKR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltOtDMACgkQAVBC80lX
0GzorQf8DLg2TvsUva32v3T0ghQmoIRxMIdE3TJkOYIDnG+qElaXmNLatHo0wBOG
l9z1heXtoHcF8+EU2X+pinhJHrUhVsd15fk6DFMT1AEZSqSr66PpgQthG9l2FSsz
NVZgwlu4zgdE60475esQrZrbLq5FBRB0jqVooXDhRh/E3fcKP+JpT7feQ58fE/M2
gGX+3S7Nkr3LWjmPznj30otZRfuN9n8XAQPoXxa4MZlOyQPH2PtTiumlOJGwmwp8
x3rHuYDcTk72GTX4fqgoTXI9uPdlCEECV6IfXvNkhnQWlFaYkTQ1V07qYlyewqXm
2gqnfZ83zFDXMECHQRc0rGLbN8PpVg==
=mtxB
-----END PGP SIGNATURE-----

--Sig_/a1RCDR5.IDO/MuCqW+dAvKR--
