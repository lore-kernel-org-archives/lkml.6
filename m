Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeE3STD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:19:03 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34542 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeE3STA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:19:00 -0400
Date: Wed, 30 May 2018 21:18:58 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix alignment of netns_dev/netns_ino fields
 in bpf_{map,prog}_info
Message-ID: <20180530181857.GA6744@altlinux.org>
Mail-Followup-To: Eugene Syromiatnikov <esyr@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Lawrence Brakmo <brakmo@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>
References: <20180527112842.GA18204@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20180527112842.GA18204@asgard.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 27, 2018 at 01:28:42PM +0200, Eugene Syromiatnikov wrote:
> Recent introduction of netns_dev/netns_ino to bpf_map_info/bpf_prog info
> has broken compat, as offsets of these fields are different in 32-bit
> and 64-bit ABIs.  One fix (other than implementing compat support in
> syscall in order to handle this discrepancy) is to use __aligned_u64
> instead of __u64 for these fields.
>=20
> Reported-by: Dmitry V. Levin <ldv@altlinux.org>
> Fixes: 52775b33bb507 ("bpf: offload: report device information about
> offloaded maps")
> Fixes: 675fc275a3a2d ("bpf: offload: report device information for
> offloaded programs")

Reviewed-by: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: <stable@vger.kernel.org> # v4.16+

Thanks,


--=20
ldv

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbDusRAAoJEAVFT+BVnCUIXbEP/AwqWZwvcE5kx8KFhZTcPBo3
6N/1OsST+PMv6eNzGSjp6vVNp0n7gLjtT5XMjYP4S30UtG28SEXq0+52KR2dCRuQ
RhzeSEE0Gk95kn98a0q5Fjko0O8+GHhvhMt2MGQ0ZN4x7PGSSTWDTSql853CzdBV
FyDEjl/K5o3D1fmqCPGS+ZjAI2gUbtf1uP4mBCSUoqqpwmTCG17KZUmAbm5C+zyQ
/p4lOhsG0ZLE2AsVwsSvQVLa1ihw2SyawqrFbF3Wi8Jl+AA1qiwl+H+ANPdgLkTK
Rw7UeWdW7wzXsVuahz1tTQyZNkpy26h+bwZYyKPrkRD9zaAxOHNsxmrH88rp/fpP
N3qIOgfIoqOovY2cLy4ghbOAbacSt+nVonhLUYFQIQPFivZFql9jKsMxyNF4kA/0
VLrGH8CJ/MJxQTDM0YVQBsbDZ2JNHJB3zv9Rw5cpVzbC5hYrbfLT/npebV5hrFNk
wk2qTgQoMHXAvsfvNyzowWVxeOzujFZmvlMZmRbBLSXPS+PykgHJHkSn1e03vhYu
CG81W946tGb71TNXWN7dCYNWRTOaSAjzlZyECcbM07ckPJnpZk4QLsFDoDacq9Ls
Tsq9/MNpGrK8YXH7BXqj6G/GYrED7H82Ng/g/CFO4Fon/bTBDYu9Zn8/LlaCtqn4
Nqlas/SFSpgdWBHUxBG3
=gJ61
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
