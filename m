Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65892C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D132075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pTiU18K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D132075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933340AbeFUNqx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:46:53 -0400
Received: from ozlabs.org ([203.11.71.1]:38501 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933219AbeFUNqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:46:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41BNKM4kgBz9s19;
        Thu, 21 Jun 2018 23:46:47 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529588808;
        bh=TbTl3SSzyWBcrHng5jFVCNv5aZ3aeKO9eCcxeSxRS+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pTiU18K5byUrEXzVlVBDP2zYXAXje8uixCkl+tgz5k6kK283BTnOQqjpIOklYWwzw
         W7lnv2GA/sN8nUggJRxJ61Szmb2vCphPknRc7fkZFPLmBBu1A5X/LoddHbCFCUZKTu
         +gAyBg+bwLlqChCOX0hq74Z8lBwKGb9+0Tvql5RWUNpxqJvVxKFlTSMMBNmJ0VxnX7
         undLL1Oh3lsB+iMturyNupgZe+wGXmawv2U05buDh54s2AFavXV5U7QejufI9i0sUs
         VRY1r+ZMMN7Kr++nJCVQFfXvklzCHkbQReKclEptGG+04u5ttXpbTjTeF5F3kzwZil
         ZJW7AsVym7/tA==
Date:   Thu, 21 Jun 2018 23:46:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     mingo@kernel.org, "David S . Miller" <davem@davemloft.net>,
        alexei.starovoitov@gmail.com, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [GIT] Networking
Message-ID: <20180621234646.3aed20b9@canb.auug.org.au>
In-Reply-To: <CAGnkfhxGAYZNhJp7eyg+_j3LY31w7muFqerhQp7jGqQ02iFxkg@mail.gmail.com>
References: <20180620.213540.214945910722071226.davem@davemloft.net>
        <20180621084510.GA22870@gmail.com>
        <CAGnkfhxGAYZNhJp7eyg+_j3LY31w7muFqerhQp7jGqQ02iFxkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xv6CjjNrjE7bD6EFJGZCKU1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xv6CjjNrjE7bD6EFJGZCKU1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matteo,

On Thu, 21 Jun 2018 13:40:43 +0000 Matteo Croce <mcroce@redhat.com> wrote:
>
> On Thu, Jun 21, 2018 at 8:46 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * David Miller <davem@davemloft.net> wrote:
> > =20
> > > 1) Fix crash on bpf_prog_load() errors, from Daniel Borkmann. =20
> > =20
> > > Daniel Borkmann (4):
> > >       Merge branch 'bpf-misc-fixes'
> > >       bpf: fix panic in prog load calls cleanup
> > >       bpf: reject any prog that failed read-only lock
> > >       bpf, xdp, i40e: fix i40e_build_skb skb reserve and truesize =20
> >
> > JFYI, I'm still seeing this BPF build error upstream, on a 32-bit allye=
sconfig I'm
> > getting:
> >
> >   LD      vmlinux.o
> >   ld: i386:x86-64 architecture of input file `net/bpfilter/bpfilter_umh=
.o' is incompatible with i386 output
> >   Makefile:1010: recipe for target 'vmlinux' failed
> >   make: *** [vmlinux] Error 1
> >
> > A similar looking build bug was reported by sfr three weeks ago:
> > =20
> > > Subject: linux-next: build failure after merge of the net-next tree
> > >
> > > ...
> > >
> > > x86_64-linux-ld: unknown architecture of input file `net/bpfilter/bpf=
ilter_umh.o'
> > > is incompatible with i386:x86-64 output
> > >
> > > Caused by commit
> > >
> > >  d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
> > >
> > > In my builds, the host is PowerPC 64 LE ...
> > >
> > > I have reverted that commit along with
> > >
> > >  61a552eb487f ("bpfilter: fix build dependency")
> > >  13405468f49d ("bpfilter: don't pass O_CREAT when opening console for=
 debug")
> > >
> > > for today. =20
> >
> > Is there a fix I could try?
>=20
> are you compiling a 32 bit kernel on an x86_64 host? I tried to
> compile an i386 bit kernel on an i386 host and I have no issue,
> running objdump by hand produces correct output:
>=20
> $ uname -a
> Linux debian32 4.16.0-2-686-pae #1 SMP Debian 4.16.16-1 (2018-06-19)
> i686 GNU/Linux
> $ objdump -f net/bpfilter/bpfilter_umh |awk -F' |,' '/file
> format/{print "-O",$NF} /^architecture:/{print "-B",$2}'
> -O elf32-i386
> -B i386
>=20
> then I tried to compile an i386 kernel on an x86_64 host and I get the
> same error:
>=20
> $ make -j8 ARCH=3Di386
> ...
>   LD      vmlinux.o
> ld: i386:x86-64 architecture of input file
> `net/bpfilter/bpfilter_umh.o' is incompatible with i386 output
> make: *** [Makefile:1015: vmlinux] Error 1
>=20
> the problem seems to be that bpfilter_umh is compiled with host flags,
> and so it's a 64 bit binary in my case:
>=20
> gcc  -static -o net/bpfilter/bpfilter_umh net/bpfilter/main.o
> objcopy -I binary `LC_ALL=3DC objdump -f net/bpfilter/bpfilter_umh |awk
> -F' |,' '/file format/{print "-O",$NF} /^architecture:/{print
> "-B",$2}'` --rename-section .data=3D.init.rodata
> net/bpfilter/bpfilter_umh net/bpfilter/bpfilter_umh.o
> ld -m elf_i386 -r -o vmlinux.o --whole-archive built-in.a
> --no-whole-archive --start-group lib/lib.a arch/x86/lib/lib.a
> --end-group
> ld: i386:x86-64 architecture of input file
> `net/bpfilter/bpfilter_umh.o' is incompatible with i386 output
>=20
> Any idea how to fix it without building it twice, for host and target?

This presumably has the same root cause that means I can't build a big
endian PowerPC version on a little endian host ...

Either I have to have CONFIG_BPFILTER turned off (or maybe just
CONFIG_BPFILTER_UMH) or build with a compiler that cannot link user
mode programs (which effectively does the same).
--=20
Cheers,
Stephen Rothwell

--Sig_/xv6CjjNrjE7bD6EFJGZCKU1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsrrEYACgkQAVBC80lX
0GzjQQf9F/JrmeUq3TMYazH9gCuP27sSvCKKVXegO7ryCef/zEH7Vk+DOsi2IMYD
jfu57WtRSoH/QStFIq3UG2x2V8uhIgjyrXTukHQEsjYW0bwZdLeBMldBH7dCdOMk
8x+9TFZQ9Ya37JeQfF3AG7++7Cob0n/74V8fzNdC7UEMd9sSmCZfhVGDpvUb7q3U
wwZt5qvCmd2hueHLBzOrKORG1dSu1DBX/0yNyhdpC65LF2+XCLwUMwkdKWF5ODxE
OjqT7wqVmoE1QwgexJxdhItAbbGfHbxZD5jJVokJg2W49+U+4Y++YEIRuBnF+2Vh
OTP3ZbzdrWaTWajoLT0r4UV9b/DKYw==
=Qfuh
-----END PGP SIGNATURE-----

--Sig_/xv6CjjNrjE7bD6EFJGZCKU1--
