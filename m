Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933141AbeCFWwt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:52:49 -0500
Received: from ozlabs.org ([103.22.144.67]:40393 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933008AbeCFWws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:52:48 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 7 Mar 2018 09:52:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Petr Mladek <pmladek@suse.com>, Greentime Hu <green.hu@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak
 symbol
Message-ID: <20180307095201.3d8ee50b@canb.auug.org.au>
In-Reply-To: <20180306124326.ucom526x6giwp2br@pathway.suse.cz>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
        <20180305144846.3jommv372c73dltt@pathway.suse.cz>
        <20180306042957.GE6713@jagdpanzerIV>
        <20180306124326.ucom526x6giwp2br@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/drl7wfGDxBs.9T/Gxn/cNCV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/drl7wfGDxBs.9T/Gxn/cNCV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 6 Mar 2018 13:43:26 +0100 Petr Mladek <pmladek@suse.com> wrote:
>
> Greentime Hu,
>=20
> the for-4.17 branch in printk.git is based on Linus' tree. Therefore
> I had to remove the hunk against arch/nds32/kernel/traps.c because
> this file is only in linux-next.
>=20
> I think that it might be easier if you remove the EXPORT_SYMBOL()
> in your branch. Is it OK for you, please?

I have added the following as a merge resolution to the linux-next
merge of the printk tree from today (someone will need to mention this
to Linus when the printk and nds32 trees meet in Linus' tree):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 7 Mar 2018 09:47:26 +1100
Subject: [PATCH] nds32: merge fix for dump_stack update

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/nds32/kernel/traps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 8828b4aeb72b..455bb0787367 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -166,8 +166,6 @@ void dump_stack(void)
 	__dump(NULL, base_reg);
 }
=20
-EXPORT_SYMBOL(dump_stack);
-
 void show_stack(struct task_struct *tsk, unsigned long *sp)
 {
 	unsigned long *base_reg;
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/drl7wfGDxBs.9T/Gxn/cNCV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqfG5EACgkQAVBC80lX
0GwnZwf/dilwqwwoLvICdHaJM2d3cW3Ow0E6wQcW7bpfUZqmrpyoTN01+COhCXkb
RzjxwPOpd2+Kz/z42GChTZXjjgpCj9qFj29ZqcLsmHMPX4GkReigEU2nGSoihc3i
ej/dSFrx+BFTr3EE+6BM14+Q7Zgg+7c1Mgr3aZHfd2dgJAbIvPKWsR5pfbHT1Rb9
nIrr1tLAlnqSkaToAEiR4d1VkLYPxTG3yFMBwi8HfDGBhf0Qmd3dcxtf8LemNGnc
N5r5H4ABdQmZvCelrDRI6TxNO8U751GQNze8W8vUWw4HEWeC1dV/rzojWXlCOEGP
nvmaWFGp75AjwX0lGQicj9MNKgIYvA==
=ElDY
-----END PGP SIGNATURE-----

--Sig_/drl7wfGDxBs.9T/Gxn/cNCV--
