Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeEIEtM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:49:12 -0400
Received: from ozlabs.org ([203.11.71.1]:54883 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeEIEtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:49:10 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 14:49:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Ahern <dsahern@gmail.com>
Subject: linux-next: build warning after merge of the bpf-next tree
Message-ID: <20180509144908.179afbc3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/w23Z3wnS7TjxDzPpTq/0fTU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w23Z3wnS7TjxDzPpTq/0fTU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from include/linux/dma-mapping.h:5:0,
                 from include/linux/skbuff.h:34,
                 from include/linux/if_ether.h:23,
                 from include/uapi/linux/bpf.h:13,
                 from include/linux/bpf-cgroup.h:6,
                 from include/linux/cgroup-defs.h:22,
                 from include/linux/cgroup.h:28,
                 from include/linux/perf_event.h:57,
                 from include/linux/trace_events.h:10,
                 from include/trace/trace_events.h:20,
                 from include/trace/define_trace.h:96,
                 from drivers/android/binder_trace.h:387,
                 from drivers/android/binder.c:5702:
include/linux/sizes.h:24:0: warning: "SZ_1K" redefined
 #define SZ_1K    0x00000400
drivers/android/binder.c:116:0: note: this is the location of the previous =
definition
 #define SZ_1K                               0x400
In file included from include/linux/dma-mapping.h:5:0,
                 from include/linux/skbuff.h:34,
                 from include/linux/if_ether.h:23,
                 from include/uapi/linux/bpf.h:13,
                 from include/linux/bpf-cgroup.h:6,
                 from include/linux/cgroup-defs.h:22,
                 from include/linux/cgroup.h:28,
                 from include/linux/perf_event.h:57,
                 from include/linux/trace_events.h:10,
                 from include/trace/trace_events.h:20,
                 from include/trace/define_trace.h:96,
                 from drivers/android/binder_trace.h:387,
                 from drivers/android/binder.c:5702:
include/linux/sizes.h:37:0: warning: "SZ_4M" redefined
 #define SZ_4M    0x00400000
drivers/android/binder.c:120:0: note: this is the location of the previous =
definition
 #define SZ_4M                               0x400000
fs/ecryptfs/miscdev.c:206:0: warning: "PKT_TYPE_OFFSET" redefined
 #define PKT_TYPE_OFFSET  0
In file included from include/linux/if_ether.h:23:0,
                 from include/uapi/linux/bpf.h:13,
                 from include/linux/bpf-cgroup.h:6,
                 from include/linux/cgroup-defs.h:22,
                 from include/linux/cgroup.h:28,
                 from include/linux/writeback.h:183,
                 from include/linux/backing-dev.h:16,
                 from fs/ecryptfs/ecryptfs_kernel.h:41,
                 from fs/ecryptfs/miscdev.c:30:
include/linux/skbuff.h:753:0: note: this is the location of the previous de=
finition
 #define PKT_TYPE_OFFSET() offsetof(struct sk_buff, __pkt_type_offset)

Introduced by commit

  9c38f3c8b153 ("bpf: Provide helper to do forwarding lookups in kernel FIB=
 table")

--=20
Cheers,
Stephen Rothwell

--Sig_/w23Z3wnS7TjxDzPpTq/0fTU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlryfcQACgkQAVBC80lX
0GwQpQgAjz1elfOwEFqBgsw1TkROUBaOO3KutNL/26M/pQkzkS4Hi97a6jWsZ4Gx
y2skq6a6HVGY7+O6U76lPp1Or5OEwZAu00udQbO8qDxucy9664rIOviG1V3VeXAH
YJ0f6+BVyBnY7+AxqDNXssvyQ/4znikYrvbp2+h7WeIcJ+yXqT8/jAX1UK1aoDAT
kdccy+sEfFhmlBqR3eCZwM7lyUlH64Z1IdqjscNEPxi/4hA355NJQ8gxjaYmocIz
ZjSV7PVNxDTTikH7hw9XljtKJw4sJZ5gqFYW6vqsfWpA00XSP+SK5i4kT0foJ/bL
h9ip79eznjk3E3ddOhJtLRzXawVXZQ==
=CUGF
-----END PGP SIGNATURE-----

--Sig_/w23Z3wnS7TjxDzPpTq/0fTU--
