Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D039C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AB8214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KEV5fu46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AB8214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeLFGVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:21:34 -0500
Received: from ozlabs.org ([203.11.71.1]:36905 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbeLFGVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:21:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439QV13LBRz9s1c;
        Thu,  6 Dec 2018 17:21:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544077289;
        bh=0PVPOgH2XFvrZqZM3Xik7TIgD7pG911g0wieXwx+T4E=;
        h=Date:From:To:Cc:Subject:From;
        b=KEV5fu46Gwtut4jVlvzVjQG61Lp0hNghbgPxOOALegwSju1bxvW4s1KTq0JsbWbEK
         xsY9kPFfDlYykhh3OR5vmlh4k9JH+aC5ohMNbPjmDaKRCFwxZDulSO+qIe3g319yyO
         my6QW0Yy/Afxa+nt/PrfbuMG5r71DCth+Jg1viRiPyQQSby19VRdJrv3SVhmF66rQe
         TQKdRvcRJrhESKqzAzLIgc4GnWcmdkutEd6Jl4hZ695WLhT69CDJNnEGwHVBaTe1t9
         ZpJtQm3Ihd8SH9+w7hk/T0J1Tf7kKS2JKhdXC7TWTYScC/oFZZpnSdHfqY6TutBdcQ
         1D7pNkdMZZB2Q==
Date:   Thu, 6 Dec 2018 17:21:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: linux-next: build failure after merge of the device-mapper tree
Message-ID: <20181206172128.71293ced@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2iD5IIBb4V8tL44Zu29DhN3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2iD5IIBb4V8tL44Zu29DhN3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the device-mapper tree, today's linux-next build (powerpc
ppc44x_defconfig) failed like this:

In file included from arch/powerpc/include/asm/local.h:144,
                 from include/linux/genhd.h:20,
                 from block/genhd.c:7:
block/genhd.c: In function 'part_inc_in_flight':
include/linux/percpu-defs.h:219:52: error: invalid operands to binary + (ha=
ve 'struct disk_stats' and 'int')
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                              ~~~~~ ^
include/asm-generic/local.h:31:40: note: in definition of macro 'local_inc'
 #define local_inc(l) atomic_long_inc(&(l)->a)
                                        ^
include/linux/percpu-defs.h:259:2: note: in expansion of macro '__verify_pc=
pu_ptr'
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:56:13: note: in expansion of macro 'per_cpu_ptr'
  local_inc(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
             ^~~~~~~~~~~
include/linux/percpu-defs.h:260:10: error: invalid type argument of unary '=
*' (have 'struct disk_stats')
  (typeof(*(__p)) __kernel __force *)(__p);   \
          ^~~~~~
include/asm-generic/local.h:31:40: note: in definition of macro 'local_inc'
 #define local_inc(l) atomic_long_inc(&(l)->a)
                                        ^
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:56:13: note: in expansion of macro 'per_cpu_ptr'
  local_inc(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
             ^~~~~~~~~~~
include/linux/percpu-defs.h:219:52: error: invalid operands to binary + (ha=
ve 'struct disk_stats' and 'int')
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                              ~~~~~ ^
include/asm-generic/local.h:31:40: note: in definition of macro 'local_inc'
 #define local_inc(l) atomic_long_inc(&(l)->a)
                                        ^
include/linux/percpu-defs.h:259:2: note: in expansion of macro '__verify_pc=
pu_ptr'
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:58:14: note: in expansion of macro 'per_cpu_ptr'
   local_inc(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_fligh=
t[rw]);
              ^~~~~~~~~~~
include/linux/percpu-defs.h:260:10: error: invalid type argument of unary '=
*' (have 'struct disk_stats')
  (typeof(*(__p)) __kernel __force *)(__p);   \
          ^~~~~~
include/asm-generic/local.h:31:40: note: in definition of macro 'local_inc'
 #define local_inc(l) atomic_long_inc(&(l)->a)
                                        ^
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:58:14: note: in expansion of macro 'per_cpu_ptr'
   local_inc(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_fligh=
t[rw]);
              ^~~~~~~~~~~
block/genhd.c: In function 'part_dec_in_flight':
include/linux/percpu-defs.h:219:52: error: invalid operands to binary + (ha=
ve 'struct disk_stats' and 'int')
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                              ~~~~~ ^
include/asm-generic/local.h:32:40: note: in definition of macro 'local_dec'
 #define local_dec(l) atomic_long_dec(&(l)->a)
                                        ^
include/linux/percpu-defs.h:259:2: note: in expansion of macro '__verify_pc=
pu_ptr'
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:69:13: note: in expansion of macro 'per_cpu_ptr'
  local_dec(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
             ^~~~~~~~~~~
include/linux/percpu-defs.h:260:10: error: invalid type argument of unary '=
*' (have 'struct disk_stats')
  (typeof(*(__p)) __kernel __force *)(__p);   \
          ^~~~~~
include/asm-generic/local.h:32:40: note: in definition of macro 'local_dec'
 #define local_dec(l) atomic_long_dec(&(l)->a)
                                        ^
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:69:13: note: in expansion of macro 'per_cpu_ptr'
  local_dec(&per_cpu_ptr(part->dkstats, cpu)->in_flight[rw]);
             ^~~~~~~~~~~
include/linux/percpu-defs.h:219:52: error: invalid operands to binary + (ha=
ve 'struct disk_stats' and 'int')
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                              ~~~~~ ^
include/asm-generic/local.h:32:40: note: in definition of macro 'local_dec'
 #define local_dec(l) atomic_long_dec(&(l)->a)
                                        ^
include/linux/percpu-defs.h:259:2: note: in expansion of macro '__verify_pc=
pu_ptr'
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:71:14: note: in expansion of macro 'per_cpu_ptr'
   local_dec(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_fligh=
t[rw]);
              ^~~~~~~~~~~
include/linux/percpu-defs.h:260:10: error: invalid type argument of unary '=
*' (have 'struct disk_stats')
  (typeof(*(__p)) __kernel __force *)(__p);   \
          ^~~~~~
include/asm-generic/local.h:32:40: note: in definition of macro 'local_dec'
 #define local_dec(l) atomic_long_dec(&(l)->a)
                                        ^
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:71:14: note: in expansion of macro 'per_cpu_ptr'
   local_dec(&per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_fligh=
t[rw]);
              ^~~~~~~~~~~
block/genhd.c: In function 'part_in_flight':
include/linux/percpu-defs.h:219:52: error: invalid operands to binary + (ha=
ve 'struct disk_stats' and 'int')
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                              ~~~~~ ^
include/asm-generic/local.h:29:42: note: in definition of macro 'local_read'
 #define local_read(l) atomic_long_read(&(l)->a)
                                          ^
include/linux/percpu-defs.h:259:2: note: in expansion of macro '__verify_pc=
pu_ptr'
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:85:27: note: in expansion of macro 'per_cpu_ptr'
   inflight +=3D local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0])=
 +
                           ^~~~~~~~~~~
include/linux/percpu-defs.h:260:10: error: invalid type argument of unary '=
*' (have 'struct disk_stats')
  (typeof(*(__p)) __kernel __force *)(__p);   \
          ^~~~~~
include/asm-generic/local.h:29:42: note: in definition of macro 'local_read'
 #define local_read(l) atomic_long_read(&(l)->a)
                                          ^
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:85:27: note: in expansion of macro 'per_cpu_ptr'
   inflight +=3D local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[0])=
 +
                           ^~~~~~~~~~~
include/linux/percpu-defs.h:219:52: error: invalid operands to binary + (ha=
ve 'struct disk_stats' and 'int')
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                              ~~~~~ ^
include/asm-generic/local.h:29:42: note: in definition of macro 'local_read'
 #define local_read(l) atomic_long_read(&(l)->a)
                                          ^
include/linux/percpu-defs.h:259:2: note: in expansion of macro '__verify_pc=
pu_ptr'
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:86:17: note: in expansion of macro 'per_cpu_ptr'
     local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
                 ^~~~~~~~~~~
include/linux/percpu-defs.h:260:10: error: invalid type argument of unary '=
*' (have 'struct disk_stats')
  (typeof(*(__p)) __kernel __force *)(__p);   \
          ^~~~~~
include/asm-generic/local.h:29:42: note: in definition of macro 'local_read'
 #define local_read(l) atomic_long_read(&(l)->a)
                                          ^
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:86:17: note: in expansion of macro 'per_cpu_ptr'
     local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[1]);
                 ^~~~~~~~~~~
block/genhd.c: In function 'part_in_flight_rw':
include/linux/percpu-defs.h:219:52: error: invalid operands to binary + (ha=
ve 'struct disk_stats' and 'int')
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                              ~~~~~ ^
include/asm-generic/local.h:29:42: note: in definition of macro 'local_read'
 #define local_read(l) atomic_long_read(&(l)->a)
                                          ^
include/linux/percpu-defs.h:259:2: note: in expansion of macro '__verify_pc=
pu_ptr'
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:107:30: note: in expansion of macro 'per_cpu_ptr'
   inflight[0] +=3D local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[=
0]);
                              ^~~~~~~~~~~
include/linux/percpu-defs.h:260:10: error: invalid type argument of unary '=
*' (have 'struct disk_stats')
  (typeof(*(__p)) __kernel __force *)(__p);   \
          ^~~~~~
include/asm-generic/local.h:29:42: note: in definition of macro 'local_read'
 #define local_read(l) atomic_long_read(&(l)->a)
                                          ^
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:107:30: note: in expansion of macro 'per_cpu_ptr'
   inflight[0] +=3D local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[=
0]);
                              ^~~~~~~~~~~
include/linux/percpu-defs.h:219:52: error: invalid operands to binary + (ha=
ve 'struct disk_stats' and 'int')
  const void __percpu *__vpp_verify =3D (typeof((ptr) + 0))NULL; \
                                              ~~~~~ ^
include/asm-generic/local.h:29:42: note: in definition of macro 'local_read'
 #define local_read(l) atomic_long_read(&(l)->a)
                                          ^
include/linux/percpu-defs.h:259:2: note: in expansion of macro '__verify_pc=
pu_ptr'
  __verify_pcpu_ptr(__p);      \
  ^~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:108:30: note: in expansion of macro 'per_cpu_ptr'
   inflight[1] +=3D local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[=
1]);
                              ^~~~~~~~~~~
include/linux/percpu-defs.h:260:10: error: invalid type argument of unary '=
*' (have 'struct disk_stats')
  (typeof(*(__p)) __kernel __force *)(__p);   \
          ^~~~~~
include/asm-generic/local.h:29:42: note: in definition of macro 'local_read'
 #define local_read(l) atomic_long_read(&(l)->a)
                                          ^
include/linux/percpu-defs.h:263:47: note: in expansion of macro 'VERIFY_PER=
CPU_PTR'
 #define per_cpu_ptr(ptr, cpu) ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
                                               ^~~~~~~~~~~~~~~~~
block/genhd.c:108:30: note: in expansion of macro 'per_cpu_ptr'
   inflight[1] +=3D local_read(&per_cpu_ptr(part->dkstats, cpu)->in_flight[=
1]);
                              ^~~~~~~~~~~

Caused by commit

  3a657cf59109 ("block: switch to per-cpu in-flight counters")

This build does not have CONFIG_SMP set and part->dkstats is not a
pointer in this case.

I have reverted the device-mapper tree changes for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/2iD5IIBb4V8tL44Zu29DhN3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwIv+gACgkQAVBC80lX
0GzxcQgAokWkGRcssRyDFC6ojyPb9RygJfoGmKSTgnXkGxaevXEeN35HhECJbeiX
KgjCohj2orE/S6I629cKxyuOgH3XP3hOkXtvHO8mRaJdE+dMDKEI23IC2ZckJn13
u9iqciCWLY12y9fTYuB8pdQnG6Ra981E+T4aIRH9YOIEDcfPcSHNCcZxKU/kQnCn
dZobFbOZSLFIa0TW2ejO+UfE73brbegg1dkqnsuo0PIwIvVSINQHssxJAdvWLbTp
47UqGcy0gboFot0jR0xNqGqWehDDkB0kODtyU8Bw2dwssDU8mgW2pAm26HQ/y5eP
8NHE/O8BFVbuKjgoZ+Te7xJnagWTnA==
=UQX8
-----END PGP SIGNATURE-----

--Sig_/2iD5IIBb4V8tL44Zu29DhN3--
