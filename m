Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005CFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7AF2152A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsjzIGYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7AF2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeI1PQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:16:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40288 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbeI1PQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:16:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so3860470pfj.7;
        Fri, 28 Sep 2018 01:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nMcn0KbYcfdkWGzS1L2CzuMCAyMTa9nVCc4DzQS94EY=;
        b=ZsjzIGYWdQ7vArTM7ZovKOBYPCcWxC4ykA4lxdB7QAV+nmJ/uu1f0gHWMe2CFxWr6J
         42qbEf+NkFRDUezugQa4Fj8ekKHRknWmC/QxFEkiw+YDsTC/xs6JzQ6JU1KJUui/dS/E
         sQZd9/sOrgF+OY/QdtGNBY5cWL+diTiiaG9f2rNX9Twq6JQOBIsawsAfYxH/ioiTDTio
         PAwO53uPbfh7rgcJe41kRSQDMx71tj3KEl6H5cBQVCTINiCpUgU/YSX1tj3sGNfQ0M6v
         nCh5+UZAYMJeGGvLeopTHC1CqhDnBQLbSyLZh0FZshpwtApmY3DDgPUtQZ4gm5zZ2bQg
         fE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nMcn0KbYcfdkWGzS1L2CzuMCAyMTa9nVCc4DzQS94EY=;
        b=hRq0lmLp6gXgZeGbbNLnHMEgjtJYb/8As7EisgtF1023PXHXMhpCeFV7VQq+evuB8v
         laAcRnZVJ9JYf6rUR2qdNL3kER06PZRp1FXyo5kNUQhcDYZiRODg5coCs8AU3u8vgfjF
         XW0EgmRYx8PC483cQUa0jMDmu7q6e2HRtRJbMYP8F++WLQQ3ziC/bKhFw4MD+QRvrDKz
         g1kuZ7dt2G7Q/G9a9gNgJf/gbwKgWll091OxZs1l65fEXTVJvJKQUp2eLNn5XmKRnsuZ
         pMHLUQMRpF+NKSWi0aQ2Ffd5I9vSlm50HJd/TkfZiNupo+nkqgDR0auw4jjmT5Sr1A0Q
         VKZA==
X-Gm-Message-State: ABuFfogadU5SQByUlTISDY8/nkydmbF+kgjdfaZei9cvZlubkT8nDEc3
        qi5ONyIHNYHSxX8E766txc0=
X-Google-Smtp-Source: ACcGV6094EFp/WjYgbYSpcxEVytKhsQ9e9bWAsKFHCcupL11KnmEN05qr86Tz+ZMT8TBAbV4TL6/ag==
X-Received: by 2002:a62:4799:: with SMTP id p25-v6mr15740854pfi.197.1538124847673;
        Fri, 28 Sep 2018 01:54:07 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:5ff1])
        by smtp.gmail.com with ESMTPSA id r12-v6sm5488826pfh.79.2018.09.28.01.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 01:54:06 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:53:58 +0200
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     netdev@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 10/10] selftests/bpf: cgroup local
 storage-based network counters
Message-ID: <20180928085356.56xe7javtd6cdfz6@ast-mbp.dhcp.thefacebook.com>
References: <20180926113326.29069-1-guro@fb.com>
 <20180926113326.29069-11-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926113326.29069-11-guro@fb.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:33:26PM +0100, Roman Gushchin wrote:
> This commit adds a bpf kselftest, which demonstrates how percpu
> and shared cgroup local storage can be used for efficient lookup-free
> network accounting.
> 
> Cgroup local storage provides generic memory area with a very efficient
> lookup free access. To avoid expensive atomic operations for each
> packet, per-cpu cgroup local storage is used. Each packet is initially
> charged to a per-cpu counter, and only if the counter reaches certain
> value (32 in this case), the charge is moved into the global atomic
> counter. This allows to amortize atomic operations, keeping reasonable
> accuracy.
> 
> The test also implements a naive network traffic throttling, mostly to
> demonstrate the possibility of bpf cgroup--based network bandwidth
> control.
> 
> Expected output:
>   ./test_netcnt
>   test_netcnt:PASS
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile        |   6 +-
>  tools/testing/selftests/bpf/netcnt_common.h |  23 +++
>  tools/testing/selftests/bpf/netcnt_prog.c   |  71 +++++++++
>  tools/testing/selftests/bpf/test_netcnt.c   | 153 ++++++++++++++++++++
>  4 files changed, 251 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/netcnt_common.h
>  create mode 100644 tools/testing/selftests/bpf/netcnt_prog.c
>  create mode 100644 tools/testing/selftests/bpf/test_netcnt.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index fd3851d5c079..5443399dd3a1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -23,7 +23,8 @@ $(TEST_CUSTOM_PROGS): $(OUTPUT)/%: %.c
>  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
>  	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
>  	test_sock test_btf test_sockmap test_lirc_mode2_user get_cgroup_id_user \
> -	test_socket_cookie test_cgroup_storage test_select_reuseport
> +	test_socket_cookie test_cgroup_storage test_select_reuseport \
> +	test_netcnt
>  
>  TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test_obj_id.o \
>  	test_pkt_md_access.o test_xdp_redirect.o test_xdp_meta.o sockmap_parse_prog.o     \
> @@ -35,7 +36,7 @@ TEST_GEN_FILES = test_pkt_access.o test_xdp.o test_l4lb.o test_tcp_estats.o test
>  	test_get_stack_rawtp.o test_sockmap_kern.o test_sockhash_kern.o \
>  	test_lwt_seg6local.o sendmsg4_prog.o sendmsg6_prog.o test_lirc_mode2_kern.o \
>  	get_cgroup_id_kern.o socket_cookie_prog.o test_select_reuseport_kern.o \
> -	test_skb_cgroup_id_kern.o bpf_flow.o
> +	test_skb_cgroup_id_kern.o bpf_flow.o netcnt_prog.o
>  
>  # Order correspond to 'make run_tests' order
>  TEST_PROGS := test_kmod.sh \
> @@ -72,6 +73,7 @@ $(OUTPUT)/test_tcpbpf_user: cgroup_helpers.c
>  $(OUTPUT)/test_progs: trace_helpers.c
>  $(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c
>  $(OUTPUT)/test_cgroup_storage: cgroup_helpers.c
> +$(OUTPUT)/test_netcnt: cgroup_helpers.c
>  
>  .PHONY: force
>  
> diff --git a/tools/testing/selftests/bpf/netcnt_common.h b/tools/testing/selftests/bpf/netcnt_common.h
> new file mode 100644
> index 000000000000..0e10fc276c2a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/netcnt_common.h
> @@ -0,0 +1,23 @@
> +#ifndef __NETCNT_COMMON_H
> +#define __NETCNT_COMMON_H
> +
> +#include <linux/types.h>
> +
> +#define MAX_PERCPU_PACKETS 32
> +
> +struct percpu_net_cnt {
> +	__u64 packets;
> +	__u64 bytes;
> +
> +	__u64 prev_ts;
> +
> +	__u64 prev_packets;
> +	__u64 prev_bytes;
> +};
> +
> +struct net_cnt {
> +	__u64 packets;
> +	__u64 bytes;
> +};
> +
> +#endif
> diff --git a/tools/testing/selftests/bpf/netcnt_prog.c b/tools/testing/selftests/bpf/netcnt_prog.c
> new file mode 100644
> index 000000000000..1198abca1360
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/netcnt_prog.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <linux/version.h>
> +
> +#include "bpf_helpers.h"
> +#include "netcnt_common.h"
> +
> +#define MAX_BPS	(3 * 1024 * 1024)
> +
> +#define REFRESH_TIME_NS	100000000
> +#define NS_PER_SEC	1000000000
> +
> +struct bpf_map_def SEC("maps") percpu_netcnt = {
> +	.type = BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> +	.key_size = sizeof(struct bpf_cgroup_storage_key),
> +	.value_size = sizeof(struct percpu_net_cnt),
> +};
> +
> +struct bpf_map_def SEC("maps") netcnt = {
> +	.type = BPF_MAP_TYPE_CGROUP_STORAGE,
> +	.key_size = sizeof(struct bpf_cgroup_storage_key),
> +	.value_size = sizeof(struct net_cnt),
> +};
> +
> +SEC("cgroup/skb")
> +int bpf_nextcnt(struct __sk_buff *skb)
> +{
> +	struct percpu_net_cnt *percpu_cnt;
> +	char fmt[] = "%d %llu %llu\n";
> +	struct net_cnt *cnt;
> +	__u64 ts, dt;
> +	int ret;
> +
> +	cnt = bpf_get_local_storage(&netcnt, 0);
> +	percpu_cnt = bpf_get_local_storage(&percpu_netcnt, 0);
> +
> +	percpu_cnt->packets++;
> +	percpu_cnt->bytes += skb->len;
> +
> +	if (percpu_cnt->packets > MAX_PERCPU_PACKETS) {
> +		__sync_fetch_and_add(&cnt->packets,
> +				     percpu_cnt->packets);
> +		percpu_cnt->packets = 0;
> +
> +		__sync_fetch_and_add(&cnt->bytes,
> +				     percpu_cnt->bytes);
> +		percpu_cnt->bytes = 0;
> +	}
> +
> +	ts = bpf_ktime_get_ns();
> +	dt = ts - percpu_cnt->prev_ts;
> +
> +	dt *= MAX_BPS;
> +	dt /= NS_PER_SEC;
> +
> +	if (cnt->bytes + percpu_cnt->bytes - percpu_cnt->prev_bytes < dt)
> +		ret = 1;
> +	else
> +		ret = 0;
> +
> +	if (dt > REFRESH_TIME_NS) {
> +		percpu_cnt->prev_ts = ts;
> +		percpu_cnt->prev_packets = cnt->packets;
> +		percpu_cnt->prev_bytes = cnt->bytes;
> +	}
> +
> +	return !!ret;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> +__u32 _version SEC("version") = LINUX_VERSION_CODE;
> diff --git a/tools/testing/selftests/bpf/test_netcnt.c b/tools/testing/selftests/bpf/test_netcnt.c
> new file mode 100644
> index 000000000000..aa424f8db466
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_netcnt.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <assert.h>
> +#include <sys/sysinfo.h>
> +#include <sys/time.h>
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +
> +#include "cgroup_helpers.h"
> +#include "bpf_rlimit.h"
> +#include "netcnt_common.h"
> +
> +#define BPF_PROG "./netcnt_prog.o"
> +#define TEST_CGROUP "/test-network-counters/"
> +
> +static int bpf_find_map(const char *test, struct bpf_object *obj,
> +			const char *name)
> +{
> +	struct bpf_map *map;
> +
> +	map = bpf_object__find_map_by_name(obj, name);
> +	if (!map) {
> +		printf("%s:FAIL:map '%s' not found\n", test, name);
> +		return -1;
> +	}
> +	return bpf_map__fd(map);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct percpu_net_cnt *percpu_netcnt;
> +	struct bpf_cgroup_storage_key key;
> +	int map_fd, percpu_map_fd;
> +	int error = EXIT_FAILURE;
> +	struct net_cnt netcnt;
> +	struct bpf_object *obj;
> +	int prog_fd, cgroup_fd;
> +	unsigned long packets;
> +	int cpu, nproc;
> +	__u32 prog_cnt;
> +
> +	nproc = get_nprocs_conf();
> +	percpu_netcnt = malloc(sizeof(*percpu_netcnt) * nproc);
> +	if (!percpu_netcnt) {
> +		printf("Not enough memory for per-cpu area (%d cpus)\n", nproc);
> +		goto err;
> +	}
> +
> +	if (bpf_prog_load(BPF_PROG, BPF_PROG_TYPE_CGROUP_SKB,
> +			  &obj, &prog_fd)) {
> +		printf("Failed to load bpf program\n");
> +		goto out;
> +	}
> +
> +	if (setup_cgroup_environment()) {
> +		printf("Failed to load bpf program\n");
> +		goto err;
> +	}
> +
> +	/* Create a cgroup, get fd, and join it */
> +	cgroup_fd = create_and_get_cgroup(TEST_CGROUP);
> +	if (!cgroup_fd) {
> +		printf("Failed to create test cgroup\n");
> +		goto err;
> +	}
> +
> +	if (join_cgroup(TEST_CGROUP)) {
> +		printf("Failed to join cgroup\n");
> +		goto err;
> +	}
> +
> +	/* Attach bpf program */
> +	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS, 0)) {
> +		printf("Failed to attach bpf program");
> +		goto err;
> +	}
> +
> +	assert(system("ping localhost -s 500 -c 10000 -f -q > /dev/null") == 0);
> +
> +	if (bpf_prog_query(cgroup_fd, BPF_CGROUP_INET_EGRESS, 0, NULL, NULL,
> +			   &prog_cnt)) {
> +		printf("Failed to query attached programs");
> +		goto err;
> +	}
> +
> +	map_fd = bpf_find_map(__func__, obj, "netcnt");
> +	if (map_fd < 0) {
> +		printf("Failed to find bpf map with net counters");
> +		goto err;
> +	}
> +
> +	percpu_map_fd = bpf_find_map(__func__, obj, "percpu_netcnt");
> +	if (percpu_map_fd < 0) {
> +		printf("Failed to find bpf map with percpu net counters");
> +		goto err;
> +	}
> +
> +	if (bpf_map_get_next_key(map_fd, NULL, &key)) {
> +		printf("Failed to get key in cgroup storage\n");
> +		goto err;
> +	}
> +
> +	if (bpf_map_lookup_elem(map_fd, &key, &netcnt)) {
> +		printf("Failed to lookup cgroup storage\n");
> +		goto err;
> +	}
> +
> +	if (bpf_map_lookup_elem(percpu_map_fd, &key, &percpu_netcnt[0])) {
> +		printf("Failed to lookup percpu cgroup storage\n");
> +		goto err;
> +	}
> +
> +	/* Some packets can be still in per-cpu cache, but not more than
> +	 * MAX_PERCPU_PACKETS.
> +	 */
> +	packets = netcnt.packets;
> +	for (cpu = 0; cpu < nproc; cpu++) {
> +		if (percpu_netcnt[cpu].packets > 32) {

pls use MAX_PERCPU_PACKETS in the above check.
could you also double check that if that #define is changed to 1k or so
the exact "!= 10000" check below still works as expected?

> +			printf("Unexpected percpu value: %llu\n",
> +			       percpu_netcnt[cpu].packets);
> +			goto err;

> +		}
> +
> +		packets += percpu_netcnt[cpu].packets;
> +	}
> +
> +	/* No packets should be lost */
> +	if (packets != 10000) {
> +		printf("Unexpected packet count: %lu\n", packets);
> +		goto err;
> +	}
> +
> +	/* Let's check that bytes counter value is reasonable */
> +	if (netcnt.bytes < packets * 500 || netcnt.bytes > packets * 1500) {

since packet count is accurate why byte count would vary ?

> +		printf("Unexpected bytes count: %llu\n", netcnt.bytes);
> +		goto err;
> +	}
> +
> +	error = 0;
> +	printf("test_netcnt:PASS\n");
> +
> +err:
> +	cleanup_cgroup_environment();
> +	free(percpu_netcnt);
> +
> +out:
> +	return error;
> +}
> -- 
> 2.17.1
> 
