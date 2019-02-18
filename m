Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F0920661
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZapF4onS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfBRUdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:33:54 -0500
Received: from ozlabs.org ([203.11.71.1]:55485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfBRUdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:33:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443FvM13Jrz9s5c;
        Tue, 19 Feb 2019 07:33:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550522031;
        bh=pxkqWnXUoUL3f/jLaWgCdHqjuSzACKXSAdnD8x1kKFc=;
        h=Date:From:To:Cc:Subject:From;
        b=ZapF4onSeXJSBr1iwX172aT989qrqdE9TrqadcHn5+BtuIJTxXWR4BYT1zEnindvD
         7qj2PAhiAJkIm9KNTT67qA1esMdfwa21AEAm9ecMlUryaHpsjvI7o0C8tdDS1oXL6D
         ywVZ2YE7CY+kUUz4gCVwNGgUooX6vWO4evfT0t4lDOVgKlUcANs7QKp4bPX6I+sA3/
         rV9KRYC99v2TdRO9Qv2jImQMOu+m0aKqHllsWXVNnG9X/uOCJs4QjXytGkpGNTxC3f
         Kf2M+IXbJ6t/UC9TNsTrq1lmEzcYZh/4OpY4US9rdEj5pbuD0J4ivClEeuOdKFMY9H
         o3F/xcSg5iSkw==
Date:   Tue, 19 Feb 2019 07:33:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: linux-next: Fixes tag needs some work in Linus' tree
Message-ID: <20190219073345.11c39f70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GrZ9A5Fh=N39xhpfbTOTBXT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GrZ9A5Fh=N39xhpfbTOTBXT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Just a note for some future improvement]

In commit

  2c4f1fcbef0b ("kprobe: Do not use uaccess functions to access kernel memo=
ry that can fault")

Fixes tag

  Fixes: 9da3f2b7405 ("x86/fault: BUG() when uaccess helpers fault on kerne=
l addresses")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/GrZ9A5Fh=N39xhpfbTOTBXT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxrFqkACgkQAVBC80lX
0GytoggAmdtCOewmkX4T/+YLuM3ht7rrRxO8ZXYdA2klMVBHRvFklwcSVlcNsLrz
wK0o4tlhQqNWNlaAnhWeCiqjW1p0igykRDW9nqwwl/jL85x1TY2hY8ivXaWrBOZ+
ue9N5gZEE1vmQUXSjkzY+J8OFqnAwEBDRl9vxVRpIYrWRWmg9GaTi+4D7hDvYJQD
x9rZu45Nb+CL1DU5AaLhq65OipPqP1f6imuzB9gPD54OZCFBXW4KijU42IJemXiV
Pp1jDkyNvMsXifJkQrla4RmAsuAtM4SE/2WurCKWNMVrJC4Kg2FrqYMfgsLXOYIr
q0xdHukZqo907nQV8pzqduLL49y7LQ==
=daug
-----END PGP SIGNATURE-----

--Sig_/GrZ9A5Fh=N39xhpfbTOTBXT--
