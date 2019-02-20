Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7DCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F9021738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kltcFMI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfBTAhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:37:35 -0500
Received: from ozlabs.org ([203.11.71.1]:60251 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfBTAhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:37:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 443zG231p0z9s1l;
        Wed, 20 Feb 2019 11:37:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550623050;
        bh=ozbxTFEDTIKlx+4maMm/cSkShFEx2ccwMEMCc8QBpe4=;
        h=Date:From:To:Cc:Subject:From;
        b=kltcFMI4+MXTSXqeBjHOXSjm1KJbeqZkY4ZJv3vd5S9Wy2m4XHR0yozjOkQJXiSco
         YyQviABUhGioWOgYk93M1JytARNGkIuk5mtqTT0oIoBldYCK4XuDRtRWjcxZNJeoWn
         Z2SmzZUcMcbcLbh9TBJDwfKPH/WT5N3DfiyEAn1hKqPd6hzMfzaE7vqYNX2T7/t0y4
         yQJUt+8I+HsSZUO0nO6bEeyUxHn0UzyUzV22Zhoh0ToGGXqSgIclNgcevKf1N0xOSq
         Jel89QO3kQ6yw/rdCqUpPP7/tuXV323538YEBqLHvX0VIpmPhhxo8TMwdEEf38i/TY
         q/7tcjapVr/gg==
Date:   Wed, 20 Feb 2019 11:37:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: linux-next: manual merge of the net-next tree with the bpf tree
Message-ID: <20190220113729.49f28f73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HQ4TtMTz4IkE.AfPXXU9eLd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HQ4TtMTz4IkE.AfPXXU9eLd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  tools/testing/selftests/bpf/test_progs.c

between commit:

  f6be4d16039b ("selftests/bpf: make sure signal interrupts BPF_PROG_TEST_R=
UN")

from the bpf tree and commits:

  bf0f0fd93945 ("selftests/bpf: add simple BPF_PROG_TEST_RUN examples for f=
low dissector")
  ab963beb9f5d ("selftests/bpf: add bpf_spin_lock C test")
  ba72a7b4badb ("selftests/bpf: test for BPF_F_LOCK")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/bpf/test_progs.c
index 7842e3749b19,c52bd90fbb34..000000000000
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@@ -10,8 -10,8 +10,9 @@@
  #include <string.h>
  #include <assert.h>
  #include <stdlib.h>
+ #include <stdarg.h>
  #include <time.h>
 +#include <signal.h>
 =20
  #include <linux/types.h>
  typedef __u16 __sum16;
@@@ -28,9 -28,8 +29,9 @@@
  #include <sys/ioctl.h>
  #include <sys/wait.h>
  #include <sys/types.h>
 +#include <sys/time.h>
  #include <fcntl.h>
-=20
+ #include <pthread.h>
  #include <linux/bpf.h>
  #include <linux/err.h>
  #include <bpf/bpf.h>
@@@ -1914,47 -1925,189 +1927,230 @@@ out
  	bpf_object__close(obj);
  }
 =20
 +static void sigalrm_handler(int s) {}
 +static struct sigaction sigalrm_action =3D {
 +	.sa_handler =3D sigalrm_handler,
 +};
 +
 +static void test_signal_pending(void)
 +{
 +	struct bpf_insn prog[4096];
 +	struct itimerval timeo =3D {
 +		.it_value.tv_usec =3D 100000, /* 100ms */
 +	};
 +	__u32 duration, retval;
 +	int prog_fd;
 +	int err;
 +	int i;
 +
 +	for (i =3D 0; i < ARRAY_SIZE(prog); i++)
 +		prog[i] =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
 +	prog[ARRAY_SIZE(prog) - 1] =3D BPF_EXIT_INSN();
 +
 +	prog_fd =3D bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER,
 +				   prog, ARRAY_SIZE(prog),
 +				   "GPL", 0, NULL, 0);
 +	CHECK(prog_fd < 0, "test-run", "errno %d\n", errno);
 +
 +	err =3D sigaction(SIGALRM, &sigalrm_action, NULL);
 +	CHECK(err, "test-run-signal-sigaction", "errno %d\n", errno);
 +
 +	err =3D setitimer(ITIMER_REAL, &timeo, NULL);
 +	CHECK(err, "test-run-signal-timer", "errno %d\n", errno);
 +
 +	err =3D bpf_prog_test_run(prog_fd, 0xffffffff, &pkt_v4, sizeof(pkt_v4),
 +				NULL, NULL, &retval, &duration);
 +	CHECK(err !=3D -1 || errno !=3D EINTR || duration > 1000000000,
 +	      "test-run-signal-run",
 +	      "err %d errno %d retval %d\n",
 +	      err, errno, retval);
 +
 +	signal(SIGALRM, SIG_DFL);
 +}
 +
+ #define CHECK_FLOW_KEYS(desc, got, expected)				\
+ 	CHECK(memcmp(&got, &expected, sizeof(got)) !=3D 0,		\
+ 	      desc,							\
+ 	      "nhoff=3D%u/%u "						\
+ 	      "thoff=3D%u/%u "						\
+ 	      "addr_proto=3D0x%x/0x%x "					\
+ 	      "is_frag=3D%u/%u "						\
+ 	      "is_first_frag=3D%u/%u "					\
+ 	      "is_encap=3D%u/%u "						\
+ 	      "n_proto=3D0x%x/0x%x "					\
+ 	      "sport=3D%u/%u "						\
+ 	      "dport=3D%u/%u\n",						\
+ 	      got.nhoff, expected.nhoff,				\
+ 	      got.thoff, expected.thoff,				\
+ 	      got.addr_proto, expected.addr_proto,			\
+ 	      got.is_frag, expected.is_frag,				\
+ 	      got.is_first_frag, expected.is_first_frag,		\
+ 	      got.is_encap, expected.is_encap,				\
+ 	      got.n_proto, expected.n_proto,				\
+ 	      got.sport, expected.sport,				\
+ 	      got.dport, expected.dport)
+=20
+ static struct bpf_flow_keys pkt_v4_flow_keys =3D {
+ 	.nhoff =3D 0,
+ 	.thoff =3D sizeof(struct iphdr),
+ 	.addr_proto =3D ETH_P_IP,
+ 	.ip_proto =3D IPPROTO_TCP,
+ 	.n_proto =3D bpf_htons(ETH_P_IP),
+ };
+=20
+ static struct bpf_flow_keys pkt_v6_flow_keys =3D {
+ 	.nhoff =3D 0,
+ 	.thoff =3D sizeof(struct ipv6hdr),
+ 	.addr_proto =3D ETH_P_IPV6,
+ 	.ip_proto =3D IPPROTO_TCP,
+ 	.n_proto =3D bpf_htons(ETH_P_IPV6),
+ };
+=20
+ static void test_flow_dissector(void)
+ {
+ 	struct bpf_flow_keys flow_keys;
+ 	struct bpf_object *obj;
+ 	__u32 duration, retval;
+ 	int err, prog_fd;
+ 	__u32 size;
+=20
+ 	err =3D bpf_flow_load(&obj, "./bpf_flow.o", "flow_dissector",
+ 			    "jmp_table", &prog_fd);
+ 	if (err) {
+ 		error_cnt++;
+ 		return;
+ 	}
+=20
+ 	err =3D bpf_prog_test_run(prog_fd, 10, &pkt_v4, sizeof(pkt_v4),
+ 				&flow_keys, &size, &retval, &duration);
+ 	CHECK(size !=3D sizeof(flow_keys) || err || retval !=3D 1, "ipv4",
+ 	      "err %d errno %d retval %d duration %d size %u/%lu\n",
+ 	      err, errno, retval, duration, size, sizeof(flow_keys));
+ 	CHECK_FLOW_KEYS("ipv4_flow_keys", flow_keys, pkt_v4_flow_keys);
+=20
+ 	err =3D bpf_prog_test_run(prog_fd, 10, &pkt_v6, sizeof(pkt_v6),
+ 				&flow_keys, &size, &retval, &duration);
+ 	CHECK(size !=3D sizeof(flow_keys) || err || retval !=3D 1, "ipv6",
+ 	      "err %d errno %d retval %d duration %d size %u/%lu\n",
+ 	      err, errno, retval, duration, size, sizeof(flow_keys));
+ 	CHECK_FLOW_KEYS("ipv6_flow_keys", flow_keys, pkt_v6_flow_keys);
+=20
+ 	bpf_object__close(obj);
+ }
+=20
+ static void *test_spin_lock(void *arg)
+ {
+ 	__u32 duration, retval;
+ 	int err, prog_fd =3D *(u32 *) arg;
+=20
+ 	err =3D bpf_prog_test_run(prog_fd, 10000, &pkt_v4, sizeof(pkt_v4),
+ 				NULL, NULL, &retval, &duration);
+ 	CHECK(err || retval, "",
+ 	      "err %d errno %d retval %d duration %d\n",
+ 	      err, errno, retval, duration);
+ 	pthread_exit(arg);
+ }
+=20
+ static void test_spinlock(void)
+ {
+ 	const char *file =3D "./test_spin_lock.o";
+ 	pthread_t thread_id[4];
+ 	struct bpf_object *obj;
+ 	int prog_fd;
+ 	int err =3D 0, i;
+ 	void *ret;
+=20
+ 	err =3D bpf_prog_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
+ 	if (err) {
+ 		printf("test_spin_lock:bpf_prog_load errno %d\n", errno);
+ 		goto close_prog;
+ 	}
+ 	for (i =3D 0; i < 4; i++)
+ 		assert(pthread_create(&thread_id[i], NULL,
+ 				      &test_spin_lock, &prog_fd) =3D=3D 0);
+ 	for (i =3D 0; i < 4; i++)
+ 		assert(pthread_join(thread_id[i], &ret) =3D=3D 0 &&
+ 		       ret =3D=3D (void *)&prog_fd);
+ 	goto close_prog_noerr;
+ close_prog:
+ 	error_cnt++;
+ close_prog_noerr:
+ 	bpf_object__close(obj);
+ }
+=20
+ static void *parallel_map_access(void *arg)
+ {
+ 	int err, map_fd =3D *(u32 *) arg;
+ 	int vars[17], i, j, rnd, key =3D 0;
+=20
+ 	for (i =3D 0; i < 10000; i++) {
+ 		err =3D bpf_map_lookup_elem_flags(map_fd, &key, vars, BPF_F_LOCK);
+ 		if (err) {
+ 			printf("lookup failed\n");
+ 			error_cnt++;
+ 			goto out;
+ 		}
+ 		if (vars[0] !=3D 0) {
+ 			printf("lookup #%d var[0]=3D%d\n", i, vars[0]);
+ 			error_cnt++;
+ 			goto out;
+ 		}
+ 		rnd =3D vars[1];
+ 		for (j =3D 2; j < 17; j++) {
+ 			if (vars[j] =3D=3D rnd)
+ 				continue;
+ 			printf("lookup #%d var[1]=3D%d var[%d]=3D%d\n",
+ 			       i, rnd, j, vars[j]);
+ 			error_cnt++;
+ 			goto out;
+ 		}
+ 	}
+ out:
+ 	pthread_exit(arg);
+ }
+=20
+ static void test_map_lock(void)
+ {
+ 	const char *file =3D "./test_map_lock.o";
+ 	int prog_fd, map_fd[2], vars[17] =3D {};
+ 	pthread_t thread_id[6];
+ 	struct bpf_object *obj;
+ 	int err =3D 0, key =3D 0, i;
+ 	void *ret;
+=20
+ 	err =3D bpf_prog_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
+ 	if (err) {
+ 		printf("test_map_lock:bpf_prog_load errno %d\n", errno);
+ 		goto close_prog;
+ 	}
+ 	map_fd[0] =3D bpf_find_map(__func__, obj, "hash_map");
+ 	if (map_fd[0] < 0)
+ 		goto close_prog;
+ 	map_fd[1] =3D bpf_find_map(__func__, obj, "array_map");
+ 	if (map_fd[1] < 0)
+ 		goto close_prog;
+=20
+ 	bpf_map_update_elem(map_fd[0], &key, vars, BPF_F_LOCK);
+=20
+ 	for (i =3D 0; i < 4; i++)
+ 		assert(pthread_create(&thread_id[i], NULL,
+ 				      &test_spin_lock, &prog_fd) =3D=3D 0);
+ 	for (i =3D 4; i < 6; i++)
+ 		assert(pthread_create(&thread_id[i], NULL,
+ 				      &parallel_map_access, &map_fd[i - 4]) =3D=3D 0);
+ 	for (i =3D 0; i < 4; i++)
+ 		assert(pthread_join(thread_id[i], &ret) =3D=3D 0 &&
+ 		       ret =3D=3D (void *)&prog_fd);
+ 	for (i =3D 4; i < 6; i++)
+ 		assert(pthread_join(thread_id[i], &ret) =3D=3D 0 &&
+ 		       ret =3D=3D (void *)&map_fd[i - 4]);
+ 	goto close_prog_noerr;
+ close_prog:
+ 	error_cnt++;
+ close_prog_noerr:
+ 	bpf_object__close(obj);
+ }
+=20
  int main(void)
  {
  	srand(time(NULL));
@@@ -1982,7 -2135,9 +2178,10 @@@
  	test_reference_tracking();
  	test_queue_stack_map(QUEUE);
  	test_queue_stack_map(STACK);
 +	test_signal_pending();
+ 	test_flow_dissector();
+ 	test_spinlock();
+ 	test_map_lock();
 =20
  	printf("Summary: %d PASSED, %d FAILED\n", pass_cnt, error_cnt);
  	return error_cnt ? EXIT_FAILURE : EXIT_SUCCESS;

--Sig_/HQ4TtMTz4IkE.AfPXXU9eLd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxsoUkACgkQAVBC80lX
0Gw6fgf/d7pu9hxHdI3up8vTMxOdBcPTPjbpGmKZEac95ALwRrWHz8JX6z+Y78ii
6OgwczjdM+bdGUmwWS0LiBK3ATNkLmmFTKzaWQPvI0HN+52DDGk1FgRpKc73Dmxq
qLzqnoCgwQqQoD0cyHZGah4pCU1/JW5+LfviZFZ2rvFLROjpIziySk8bRbC5okVk
77UY/l6G59OmzKWdhKxrXfOmjeEAqCQDN50mjaPRQ41v50aPwm/sS0PIBNkflMDB
j9j0dM2eFSdXtxZrR/Rs6H5EjyfxKdVqCMr31JjE1kOW4cxn7b/wVD7ryk6D7YKH
GITxyHa0wTdU9M4CfmUvXgfoLIIftA==
=5FZl
-----END PGP SIGNATURE-----

--Sig_/HQ4TtMTz4IkE.AfPXXU9eLd--
