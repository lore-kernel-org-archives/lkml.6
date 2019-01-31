Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92101C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FEB20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nfz/Ef/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfAaGGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:06:33 -0500
Received: from ozlabs.org ([203.11.71.1]:60671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfAaGGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:06:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qqVt2ZW4z9sBb;
        Thu, 31 Jan 2019 17:06:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548914790;
        bh=dE6cp5FyzqaEIbMiUYpJlrbOIhqSkmyIGpCcxPIMBfE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nfz/Ef/cpzokLTZPBgPWDLyjFpujRBpw0NeGystnu5136B6gKgSdtw3l2DcZS+r1v
         64eSbelTaPL9UCkq4JQQeK4TjsDOXz83afmCD8VTA54Vd3pqc9tD3dygISkF7H4dUO
         uZNpM6z6Nq1g075aa9LebDr4v1ZelnOvGs/uVUF3WZ5Ybph4LDiucy7xonfgVctyl9
         jqfBap6xYK5ZHXV+705sTr/iWLbtEC9Hk2gDEcX4vd3HTYQ2aEkOP97H6kYYyhwU5N
         MeBMp96Pstt0FsPQM7AgxMu+XattmzDUqlyXepQlzWDtucgC4p1EeZTXng6iPUmY0j
         p/iiP48hDkTAA==
Date:   Thu, 31 Jan 2019 17:06:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: linux-next: powerpc le qemu boot failure after merge of the
 akpm tree
Message-ID: <20190131170629.2cc20600@canb.auug.org.au>
In-Reply-To: <20190131163854.307e17ab@canb.auug.org.au>
References: <20190131163854.307e17ab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2GKmvTs3kSHCJSIEpW/T/5r"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2GKmvTs3kSHCJSIEpW/T/5r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 31 Jan 2019 16:38:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> [I am guessing that is is something in Andrew's tree that has caused
> this.]
>=20
> My qemu boot of the powerpc pseries_le_defconfig config failed like this:
>=20
> htab_hash_mask    =3D 0x1ffff
> -----------------------------------------------------
> numa:   NODE_DATA [mem 0x7ffe7000-0x7ffebfff]
> Kernel panic - not syncing: sparse_buffer_init: Failed to allocate 214748=
3648 bytes align=3D0x10000 nid=3D0 from=3Dfffffffffffffff
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc4 #2
> Call Trace:
> [c00000000105bbd0] [c000000000b1345c] dump_stack+0xb0/0xf4 (unreliable)
> [c00000000105bc10] [c000000000111120] panic+0x168/0x3b8
> [c00000000105bcb0] [c000000000e701c8] sparse_init_nid+0x178/0x550
> [c00000000105bd70] [c000000000e709b4] sparse_init+0x210/0x238
> [c00000000105bdb0] [c000000000e468f4] initmem_init+0x1e0/0x260
> [c00000000105be80] [c000000000e3b9b0] setup_arch+0x354/0x3d4
> [c00000000105bef0] [c000000000e33afc] start_kernel+0x98/0x648
> [c00000000105bf90] [c00000000000b270] start_here_common+0x1c/0x52c

A quick bisect leads to this:

1c3c9328cde027eb875ba4692f0a5d66b0afe862 is the first bad commit
commit 1c3c9328cde027eb875ba4692f0a5d66b0afe862
Author: Mike Rapoport <rppt@linux.ibm.com>
Date:   Thu Jan 31 10:51:32 2019 +1100

    treewide: add checks for the return value of memblock_alloc*()
   =20
    Add check for the return value of memblock_alloc*() functions and call
    panic() in case of error.  The panic message repeats the one used by
    panicing memblock allocators with adjustment of parameters to include o=
nly
    relevant ones.
   =20
    The replacement was mostly automated with semantic patches like the one
    below with manual massaging of format strings.
   =20
    @@
    expression ptr, size, align;
    @@
    ptr =3D memblock_alloc(size, align);
    + if (!ptr)
    +       panic("%s: Failed to allocate %lu bytes align=3D0x%lx\n", __fun=
c__,
    size, align);
   =20
    Link: http://lkml.kernel.org/r/1548057848-15136-20-git-send-email-rppt@=
linux.ibm.com
    Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
    Reviewed-by: Guo Ren <ren_guo@c-sky.com>                [c-sky]
    Acked-by: Paul Burton <paul.burton@mips.com>            [MIPS]
    Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>    [s390]
    Reviewed-by: Juergen Gross <jgross@suse.com>            [Xen]
    Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>  [m68k]
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Cc: Christophe Leroy <christophe.leroy@c-s.fr>
    Cc: Christoph Hellwig <hch@lst.de>
    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: Dennis Zhou <dennis@kernel.org>
    Cc: Greentime Hu <green.hu@gmail.com>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: Guan Xuetao <gxt@pku.edu.cn>
    Cc: Guo Ren <guoren@kernel.org>
    Cc: Mark Salter <msalter@redhat.com>
    Cc: Matt Turner <mattst88@gmail.com>
    Cc: Max Filippov <jcmvbkbc@gmail.com>
    Cc: Michael Ellerman <mpe@ellerman.id.au>
    Cc: Michal Simek <monstr@monstr.eu>
    Cc: Petr Mladek <pmladek@suse.com>
    Cc: Richard Weinberger <richard@nod.at>
    Cc: Rich Felker <dalias@libc.org>
    Cc: Rob Herring <robh+dt@kernel.org>
    Cc: Rob Herring <robh@kernel.org>
    Cc: Russell King <linux@armlinux.org.uk>
    Cc: Stafford Horne <shorne@gmail.com>
    Cc: Tony Luck <tony.luck@intel.com>
    Cc: Vineet Gupta <vgupta@synopsys.com>
    Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Which is just adding the panic we hit.  So, presumably, the bug is in a
preceding patch :-(

I have left the kernel not booting for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/2GKmvTs3kSHCJSIEpW/T/5r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxSkGUACgkQAVBC80lX
0GwU8wf9Fn6s9XvjRxjoTKORPTSxJnh4Uga/d0Yx2h675XLTz5HGkpQ2IsUDehWM
OebE2vxH54ND59Yfb3mgvld8FnGx83tiaw7zqLZtU60AkUE/O48czI4BIUhRFoeb
uVkeAwmf7W+9eHhywrE+omGDvA6RcPNC8owH+1wSZiq3Rt6cVlFbAIYDpwAtXdFm
SWyZBkJOpUQ2coIKKNXOZXpWCGN4QYlryRQtyQIu09bd5MaMJ2/ktbZj/ywnexbN
9Xot9aVWAlIRf1CM+EFBsu+k892e7iIvs19WQIyaKL80CApugq2F+r4auqDAkkQ1
Lu8IyCLcM2MicMXol9O18FDO2XIDBA==
=f2TJ
-----END PGP SIGNATURE-----

--Sig_/2GKmvTs3kSHCJSIEpW/T/5r--
