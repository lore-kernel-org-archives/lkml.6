Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2624C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFCC2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o65ujatD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFCC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbeGSNhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:37:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44049 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeGSNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:37:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so3676541pgp.11;
        Thu, 19 Jul 2018 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P6HQcAyahz1ho8/lhWUA4Qi64gqdoR7TrRjI+gxpkx0=;
        b=o65ujatDJKSYScEnUThtN3JmC/0PZkema93/ngSrDXre4aw2aNGmelWZaeMmiFLZG7
         2EhiVgFzPqXwSuF56beJKqMeTP3Xw2ipWgk7kp8FYavho5JERtC5I6V9+8HuPNrJm7la
         SWW8XrhXHiVqN6zBYowLs24XEiPXWHsc5FhuWkTZ3nMqbUfJ+5bOgE5v06e14L9vQOQ7
         vhY7RjHO5Ak0a6worcxxsCrqvdu2g2iBEXMyHPV8bmdDITBjsnJKa4XmSZx8wI0zhjh1
         OuMmhxt2Bm+ICXp23V6mDDqQoeXXsRvyPvAhKo2ASIjR5Jx8icMUzougsb6HByhXkAbU
         OGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P6HQcAyahz1ho8/lhWUA4Qi64gqdoR7TrRjI+gxpkx0=;
        b=Wl6SzrkYRTr3TjlNFf6lpQs8JqvbXGrjVqR3enDk7CXAK7AGuZotvdflddYpyHEDma
         Yw+JbUpHw0N9e7RCTPTiEZdihVTIIR4j3tUDV6RSK1QxC1AltbDDvDfzEQnysdJHNgp/
         MwCLREXWG2Ffcy6JCC9jtqlRR/yyHqXp4Zzd2GrZr6SnhDMyA46crD+9xBW/B2AVEh7x
         YCXjW5Ngb/oKbjdq+F9NpQNOnt5EHAV1oZ6hrlVvzAYZ/fu5mAFTaBI0OFDuYaVOJeqp
         8IvkdnRGRWnLLwJfD9FdalmxpJ1cIpE16stBU3H9MNlseFAEpO8XVP0Q578Toy43rP2Y
         OAbw==
X-Gm-Message-State: AOUpUlEORoO7gKlrVkiDMG5fz0wOlgGGtmRcPGeRK9A8L+EeyWH0AAPH
        G3lR1qddBMffaWjKCWP09vo=
X-Google-Smtp-Source: AAOMgpfCKU3x6v6vqXRwvy3047ewWkim2HBTbh0QBUVFru+IhaZ1WAWl5L+0zq1krsHmbSJ74D1CBQ==
X-Received: by 2002:a62:c4c3:: with SMTP id h64-v6mr9424381pfk.39.1532004853575;
        Thu, 19 Jul 2018 05:54:13 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id h10-v6sm18141853pfj.78.2018.07.19.05.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 05:54:12 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH] bpf: synchronize bpf uapi header with tools
Date:   Thu, 19 Jul 2018 21:53:55 +0900
Message-Id: <20180719125355.26441-1-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick the change in:

  4c79579b44b1 ("bpf: Change bpf_fib_lookup to return lookup status")

This bpftool build warning occurs:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
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
2.17.1

