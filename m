Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE2BC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7742F21908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="vIDeLZ6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390867AbeLUCgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:36:24 -0500
Received: from ozlabs.org ([203.11.71.1]:51077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbeLUCgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:36:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43LXnH5Jrwz9s9G;
        Fri, 21 Dec 2018 13:36:18 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545359779;
        bh=v99VvRjDFX8BRk4xVvqx9ePPsuYfX6pBOMhn3xSf4FU=;
        h=Date:From:To:Cc:Subject:From;
        b=vIDeLZ6SZi3SAqwojtAcPphXK/SNxCCK/m/bV5whQUrMcQ0wOPc7tqLqFtdnDGkcN
         jXpuAaDn9KW+vISaTtA4GsaH+Oe3KuhD5ttEOL87z9D+/PKMc7OwPrSyShHhoKaKIT
         uAvKAipYzYbBzkQ88kdqB3qUJ+yl66vUItZwzVS6hFjba6J9zyAOlOml7EjuEkDJUi
         spUWZwNXLTA82VeR290rJRf1+txJqzfEs9JshE9aZNagI5WnO00oV/Mqk9lUUoEEaq
         YA52zrnTymLKAPqPt7e+u5A3jIFHiRNkK8mNTGZoVBatuko2Sf+QDIzkBx6Q2YPXg0
         z50PoOvusG6LQ==
Date:   Fri, 21 Dec 2018 13:36:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: linux-next: manual merge of the bpf-next tree with Linus' tree
Message-ID: <20181221133617.43e01372@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/D7ZQ8GWlc5zloykB2GMgfOH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/D7ZQ8GWlc5zloykB2GMgfOH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/test_verifier.c

between commits:

  7640ead93924 ("bpf: verifier: make sure callees don't prune with caller d=
ifferences")
  14507e35bd9d ("selftests: bpf: verifier: add tests for JSET interpretatio=
n")

from Linus' tree and commit:

  5a8d5209ac02 ("selftests: bpf: add trivial JSET tests")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/bpf/test_verifier.c
index c3b799c1ee97,dbd31750b214..000000000000
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@@ -14098,34 -14169,198 +14169,225 @@@ static struct bpf_test tests[] =3D=
=20
  		.errstr =3D "invalid bpf_context access",
  		.errstr_unpriv =3D "R1 leaks addr",
  		.result =3D REJECT,
 +	},
 +		"calls: cross frame pruning",
 +		.insns =3D {
 +			/* r8 =3D !!random();
 +			 * call pruner()
 +			 * if (r8)
 +			 *     do something bad;
 +			 */
 +			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 +				     BPF_FUNC_get_prandom_u32),
 +			BPF_MOV64_IMM(BPF_REG_8, 0),
 +			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 +			BPF_MOV64_IMM(BPF_REG_8, 1),
 +			BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
 +			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
 +			BPF_JMP_IMM(BPF_JEQ, BPF_REG_8, 1, 1),
 +			BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_1, 0),
 +			BPF_MOV64_IMM(BPF_REG_0, 0),
 +			BPF_EXIT_INSN(),
 +			BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 0),
 +			BPF_EXIT_INSN(),
 +		},
 +		.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER,
 +		.errstr_unpriv =3D "function calls to other bpf functions are allowed f=
or root only",
 +		.result_unpriv =3D REJECT,
 +		.errstr =3D "!read_ok",
 +		.result =3D REJECT,
  	},
+ 	{
+ 		"jset: functional",
+ 		.insns =3D {
+ 			/* r0 =3D 0 */
+ 			BPF_MOV64_IMM(BPF_REG_0, 0),
+ 			/* prep for direct packet access via r2 */
+ 			BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+ 				    offsetof(struct __sk_buff, data)),
+ 			BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+ 				    offsetof(struct __sk_buff, data_end)),
+ 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
+ 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
+ 			BPF_JMP_REG(BPF_JLE, BPF_REG_4, BPF_REG_3, 1),
+ 			BPF_EXIT_INSN(),
+=20
+ 			BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_2, 0),
+=20
+ 			/* reg, bit 63 or bit 0 set, taken */
+ 			BPF_LD_IMM64(BPF_REG_8, 0x8000000000000001),
+ 			BPF_JMP_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
+ 			BPF_EXIT_INSN(),
+=20
+ 			/* reg, bit 62, not taken */
+ 			BPF_LD_IMM64(BPF_REG_8, 0x4000000000000000),
+ 			BPF_JMP_REG(BPF_JSET, BPF_REG_7, BPF_REG_8, 1),
+ 			BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+ 			BPF_EXIT_INSN(),
+=20
+ 			/* imm, any bit set, taken */
+ 			BPF_JMP_IMM(BPF_JSET, BPF_REG_7, -1, 1),
+ 			BPF_EXIT_INSN(),
+=20
+ 			/* imm, bit 31 set, taken */
+ 			BPF_JMP_IMM(BPF_JSET, BPF_REG_7, 0x80000000, 1),
+ 			BPF_EXIT_INSN(),
+=20
+ 			/* all good - return r0 =3D=3D 2 */
+ 			BPF_MOV64_IMM(BPF_REG_0, 2),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+ 		.result =3D ACCEPT,
+ 		.runs =3D 7,
+ 		.retvals =3D {
+ 			{ .retval =3D 2,
+ 			  .data64 =3D { (1ULL << 63) | (1U << 31) | (1U << 0), }
+ 			},
+ 			{ .retval =3D 2,
+ 			  .data64 =3D { (1ULL << 63) | (1U << 31), }
+ 			},
+ 			{ .retval =3D 2,
+ 			  .data64 =3D { (1ULL << 31) | (1U << 0), }
+ 			},
+ 			{ .retval =3D 2,
+ 			  .data64 =3D { (__u32)-1, }
+ 			},
+ 			{ .retval =3D 2,
+ 			  .data64 =3D { ~0x4000000000000000ULL, }
+ 			},
+ 			{ .retval =3D 0,
+ 			  .data64 =3D { 0, }
+ 			},
+ 			{ .retval =3D 0,
+ 			  .data64 =3D { ~0ULL, }
+ 			},
+ 		},
+ 	},
+ 	{
+ 		"jset: sign-extend",
+ 		.insns =3D {
+ 			/* r0 =3D 0 */
+ 			BPF_MOV64_IMM(BPF_REG_0, 0),
+ 			/* prep for direct packet access via r2 */
+ 			BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+ 				    offsetof(struct __sk_buff, data)),
+ 			BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+ 				    offsetof(struct __sk_buff, data_end)),
+ 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
+ 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
+ 			BPF_JMP_REG(BPF_JLE, BPF_REG_4, BPF_REG_3, 1),
+ 			BPF_EXIT_INSN(),
+=20
+ 			BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_2, 0),
+=20
+ 			BPF_JMP_IMM(BPF_JSET, BPF_REG_7, 0x80000000, 1),
+ 			BPF_EXIT_INSN(),
+=20
+ 			BPF_MOV64_IMM(BPF_REG_0, 2),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+ 		.result =3D ACCEPT,
+ 		.retval =3D 2,
+ 		.data =3D { 1, 0, 0, 0, 0, 0, 0, 1, },
+ 	},
+ 	{
+ 		"jset: known const compare",
+ 		.insns =3D {
+ 			BPF_MOV64_IMM(BPF_REG_0, 1),
+ 			BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
+ 			BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER,
+ 		.retval_unpriv =3D 1,
+ 		.result_unpriv =3D ACCEPT,
+ 		.retval =3D 1,
+ 		.result =3D ACCEPT,
+ 	},
+ 	{
+ 		"jset: known const compare bad",
+ 		.insns =3D {
+ 			BPF_MOV64_IMM(BPF_REG_0, 0),
+ 			BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
+ 			BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER,
+ 		.errstr_unpriv =3D "!read_ok",
+ 		.result_unpriv =3D REJECT,
+ 		.errstr =3D "!read_ok",
+ 		.result =3D REJECT,
+ 	},
+ 	{
+ 		"jset: unknown const compare taken",
+ 		.insns =3D {
+ 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+ 				     BPF_FUNC_get_prandom_u32),
+ 			BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
+ 			BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+ 			BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER,
+ 		.errstr_unpriv =3D "!read_ok",
+ 		.result_unpriv =3D REJECT,
+ 		.errstr =3D "!read_ok",
+ 		.result =3D REJECT,
+ 	},
+ 	{
+ 		"jset: unknown const compare not taken",
+ 		.insns =3D {
+ 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+ 				     BPF_FUNC_get_prandom_u32),
+ 			BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 1, 1),
+ 			BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER,
+ 		.errstr_unpriv =3D "!read_ok",
+ 		.result_unpriv =3D REJECT,
+ 		.errstr =3D "!read_ok",
+ 		.result =3D REJECT,
+ 	},
+ 	{
+ 		"jset: half-known const compare",
+ 		.insns =3D {
+ 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+ 				     BPF_FUNC_get_prandom_u32),
+ 			BPF_ALU64_IMM(BPF_OR, BPF_REG_0, 2),
+ 			BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 3, 1),
+ 			BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
+ 			BPF_MOV64_IMM(BPF_REG_0, 0),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER,
+ 		.result_unpriv =3D ACCEPT,
+ 		.result =3D ACCEPT,
+ 	},
+ 	{
+ 		"jset: range",
+ 		.insns =3D {
+ 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+ 				     BPF_FUNC_get_prandom_u32),
+ 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+ 			BPF_MOV64_IMM(BPF_REG_0, 0),
+ 			BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xff),
+ 			BPF_JMP_IMM(BPF_JSET, BPF_REG_1, 0xf0, 3),
+ 			BPF_JMP_IMM(BPF_JLT, BPF_REG_1, 0x10, 1),
+ 			BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
+ 			BPF_EXIT_INSN(),
+ 			BPF_JMP_IMM(BPF_JSET, BPF_REG_1, 0x10, 1),
+ 			BPF_EXIT_INSN(),
+ 			BPF_JMP_IMM(BPF_JGE, BPF_REG_1, 0x10, 1),
+ 			BPF_LDX_MEM(BPF_B, BPF_REG_8, BPF_REG_9, 0),
+ 			BPF_EXIT_INSN(),
+ 		},
+ 		.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER,
+ 		.result_unpriv =3D ACCEPT,
+ 		.result =3D ACCEPT,
+ 	},
  };
 =20
  static int probe_filter_length(const struct bpf_insn *fp)

--Sig_/D7ZQ8GWlc5zloykB2GMgfOH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwcUaEACgkQAVBC80lX
0GxHLQf/VZFb5/hhlWjKBgiX7OSP7nN7GwE0XKLFwE72jy3XOGiK2/uaQf+3hT8Y
U8sKVeDym2bnDTKnofi7U8j4uPe21C//+7TD/tuNNocinwh5P6BezJfg5GgtXqlQ
2Wpmhry2bXbYy6/dADpmaweistft4oYEbMhPvAeJ7BBGXaP4W2+L1HQXtlBpIOyf
AuoqYutbakvBhBGsW/141LL/3w+me83bmO9jMj6Xy4GG9iFPHEZEXWgovIcw+ucw
1/WP2RPOGQksVtCGSji4CeYHVryY2K+C1ucrzDqkRZHxprFjtP9ak8Np0aX2zsmT
f3E/HiTeeWzippdjlE97MdSeint3Ww==
=sDdo
-----END PGP SIGNATURE-----

--Sig_/D7ZQ8GWlc5zloykB2GMgfOH--
