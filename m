Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA40CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAE5208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbblJRC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAE5208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeG3W1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbeG3W1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:27:40 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1966208A6;
        Mon, 30 Jul 2018 20:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532983854;
        bh=m5HYb+q88lCcYijjxuZAVMpgACr7m5Om3L2fG8BjDBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbblJRC2Y9YouvjOgcZvwHaQxOv0pP0kTr4enCiuB3HJukmwSagFajZYmcKcAc4jJ
         ++sjNlBJsk+UgCRhL033nV2pgfcs999kGR3wKtZHUDUZQRy8A/nue6iIM6aX5+3zQi
         J7bldK0rwwzgGTvL+qc2bB/8uM2VDZoL9bwFNpoU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3/5] tools headers uapi: Refresh linux/bpf.h copy
Date:   Mon, 30 Jul 2018 17:50:29 -0300
Message-Id: <20180730205031.12853-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
References: <20180730205031.12853-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  4c79579b44b1 ("bpf: Change bpf_fib_lookup to return lookup status")

That do not entail changes in tools/perf/ use of it, elliminating the
following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-yei494y6b3mn6bjzz9g0ws12@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/bpf.h | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 59b19b6a40d7..b7db3261c62d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1857,7 +1857,8 @@ union bpf_attr {
  *		is resolved), the nexthop address is returned in ipv4_dst
  *		or ipv6_dst based on family, smac is set to mac address of
  *		egress device, dmac is set to nexthop mac address, rt_metric
- *		is set to metric from route (IPv4/IPv6 only).
+ *		is set to metric from route (IPv4/IPv6 only), and ifindex
+ *		is set to the device index of the nexthop from the FIB lookup.
  *
  *             *plen* argument is the size of the passed in struct.
  *             *flags* argument can be a combination of one or more of the
@@ -1873,9 +1874,10 @@ union bpf_attr {
  *             *ctx* is either **struct xdp_md** for XDP programs or
  *             **struct sk_buff** tc cls_act programs.
  *     Return
- *             Egress device index on success, 0 if packet needs to continue
- *             up the stack for further processing or a negative error in case
- *             of failure.
+ *		* < 0 if any input argument is invalid
+ *		*   0 on success (packet is forwarded, nexthop neighbor exists)
+ *		* > 0 one of **BPF_FIB_LKUP_RET_** codes explaining why the
+ *		*     packet is not forwarded or needs assist from full stack
  *
  * int bpf_sock_hash_update(struct bpf_sock_ops_kern *skops, struct bpf_map *map, void *key, u64 flags)
  *	Description
@@ -2612,6 +2614,18 @@ struct bpf_raw_tracepoint_args {
 #define BPF_FIB_LOOKUP_DIRECT  BIT(0)
 #define BPF_FIB_LOOKUP_OUTPUT  BIT(1)
 
+enum {
+	BPF_FIB_LKUP_RET_SUCCESS,      /* lookup successful */
+	BPF_FIB_LKUP_RET_BLACKHOLE,    /* dest is blackholed; can be dropped */
+	BPF_FIB_LKUP_RET_UNREACHABLE,  /* dest is unreachable; can be dropped */
+	BPF_FIB_LKUP_RET_PROHIBIT,     /* dest not allowed; can be dropped */
+	BPF_FIB_LKUP_RET_NOT_FWDED,    /* packet is not forwarded */
+	BPF_FIB_LKUP_RET_FWD_DISABLED, /* fwding is not enabled on ingress */
+	BPF_FIB_LKUP_RET_UNSUPP_LWT,   /* fwd requires encapsulation */
+	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
+	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
+};
+
 struct bpf_fib_lookup {
 	/* input:  network family for lookup (AF_INET, AF_INET6)
 	 * output: network family of egress nexthop
@@ -2625,7 +2639,11 @@ struct bpf_fib_lookup {
 
 	/* total length of packet from network header - used for MTU check */
 	__u16	tot_len;
-	__u32	ifindex;  /* L3 device index for lookup */
+
+	/* input: L3 device index for lookup
+	 * output: device index from FIB lookup
+	 */
+	__u32	ifindex;
 
 	union {
 		/* inputs to lookup */
-- 
2.14.4

