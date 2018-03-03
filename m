Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935829AbeCCCo1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 21:44:27 -0500
Received: from ozlabs.org ([103.22.144.67]:36037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935762AbeCCCoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 21:44:25 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 3 Mar 2018 13:43:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Petr Mladek <pmladek@suse.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <20180303134326.26b89eec@canb.auug.org.au>
In-Reply-To: <20180302155454.eme5gplxdcltvwkw@pathway.suse.cz>
References: <20180302160732.12691fbc@canb.auug.org.au>
        <20180302155454.eme5gplxdcltvwkw@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kdN1EfT/IxrlU6CnHa8saOE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kdN1EfT/IxrlU6CnHa8saOE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Fri, 2 Mar 2018 16:54:54 +0100 Petr Mladek <pmladek@suse.com> wrote:
>
> It is a mistery to me. The error appears when I move any of
> dump_stack_print_info() or show_regs_print_info() function
> definitions from kernel/printk/printk.c to lib/dump_stack.c.
> All the other changes seems unrelated.

Presumably because the Blackfin dumpstack() calls
dump_stack_print_info() so if you move that into lib/dumpstack.o, then
that file is dragged in and it contains another copy of dumpstack().

--=20
Cheers,
Stephen Rothwell

--Sig_/kdN1EfT/IxrlU6CnHa8saOE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqaC84ACgkQAVBC80lX
0Gyp8wf8DKNBSaFXIDJPIrmjMVSL26G6uaz0Kr8RSfMoyI/HS5CwR3m5OELHVFto
8ONR6RIz6Td9kMMrL3+e0n7Xc26v4itEMRFSaXz2hjT8R+IgU+uhNVJxjqaiJm5y
PXwNfJxw3bnLoMSQjCJTQ46h8u+ENFV7/BBW7efpC9Q0ugDvK2cTe1HRHPGZaahU
VYCFK5/BeI9q5nZeK7Lr5xR3O4VX5DdBkySXz2LKDeoVeuzbWTcyvImNqBkdbzHo
J/GVvGCbUPyeg9+LsoXBMuR7oFQ+AJMZguG4HuK7W+7ai88s8SxwsIk2leBDO7y/
GVEzRv3AOKUakJZniJZDYkyw/Xt5wQ==
=+FSk
-----END PGP SIGNATURE-----

--Sig_/kdN1EfT/IxrlU6CnHa8saOE--
