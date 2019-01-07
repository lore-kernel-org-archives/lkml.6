Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE33C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EC72085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="QIU0/lpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfAGSoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:44:20 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:33504 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfAGSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:44:20 -0500
Received: by mail-pf1-f177.google.com with SMTP id c123so604743pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=JjDnptXTHHAluFpAln7heOEn16hk+Z0wn1RTapOS78w=;
        b=QIU0/lpgXrnYRJdEVA9qxWormPG3JmedVn9UGzy7ujHfXzvhbKsqW1sasb0p+3jBn1
         gMCQc5IKojckVg7TJVBrIYR7Js3XOOM59hM7SGTk2BTaHMXa6SZzL7avI9Psqbl72knU
         WEi4VUTzO4nhApTROQq7Rd/HHsHI6utogmqRpGvpsoR79GQ+Vhvb67YsyLl7cVLtHbWU
         vIOjx4Zy3TQgMpdqzeDWTPXlZRNkgKT9B59teIlypYHDgY+JApS/8hC+c3ddyrs+Kzou
         FezZQ/+MqQHqkM5BvjN5IyVVjiEkIgq1Lury66W0FGXjnLDsHZSiJRbB8iTFenejI6h7
         X/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=JjDnptXTHHAluFpAln7heOEn16hk+Z0wn1RTapOS78w=;
        b=Cmsltv4pKDzdhzR6StTexVQvZUTYsYotVfSY0y0qjRqQcCABABMetxBx33aHjm+mF9
         l9lPLqNGwYyZ2vKMDu2RluZu9i6ipKiY4VUX9uDtZFNrHwBoVZqpFJNCeh92VqS17NXG
         bw/BnG4u/idv+KURCFniYE3GWULx00ufUBEQrg3FFXU3TDcMVHlsTpLrc9kRLNjjDLoA
         0X7mNf/RVlzWs6WTGJfEgaMS5b8/+ro7cWJ1FiqspyP/7R7hASymLZOQ39Le5rtWaeE1
         D4OJcpjl9kD2LBWYaWm4XzGZOI0Dn73JmPhd8cAkGyYxCVR0xWNNvALzxqhyZVmrXpu4
         dHHg==
X-Gm-Message-State: AJcUukdXJfpebKd5/ZnDtUhjRGyo6btOdA9vgNlOIdCPy//n1ivohhRo
        XHe+b16ILjxX/ZuxJf6qwa1iPw==
X-Google-Smtp-Source: ALg8bN7sbOEJMd6rGWu+3lyS3G2LtGuOGJ7Ng2KOF+OpnmmpnCqowBBilbqlMf1sxfULOtKwVtK+RQ==
X-Received: by 2002:a63:1a4b:: with SMTP id a11mr11879084pgm.254.1546886658663;
        Mon, 07 Jan 2019 10:44:18 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id t87sm216929025pfk.122.2019.01.07.10.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 10:44:18 -0800 (PST)
Date:   Mon, 7 Jan 2019 10:44:16 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 4.20
Message-ID: <20190107104416.450f1ca0@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release of iproute2 for Linux 4.20

Update to iproute2 utility to support new features in Linux 4.20.
This release is mostly small fixes but there are several changes
related to ip neigh support for offloaded entries.

The tarball can be downloaded from:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-4.20.0.tar=
.xz

The upstream repositories for master and net-next branch are now
split. Master branch is at:
  git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

and patches for next release are in (master branch):
  git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Report problems (or enhancements) to the netdev@vger.kernel.org mailing lis=
t.

---
Alex Vesker (1):
      devlink: Add missing region option to devlink man page

Andrea Claudi (1):
      l2tp: Fix printing of cookie and peer_cookie values

Dave Taht (2):
      tc: support conversions to or from 64 bit nanosecond-based time
      q_netem: support delivering packets in delayed time slots

David Ahern (17):
      Update kernel headers
      libnetlink: Convert GETADDR dumps to use rtnl_addrdump_req
      libnetlink: Convert GETROUTE dumps to use rtnl_routedump_req
      libnetlink: Convert GETADDRLABEL dumps to use rtnl_addrlbldump_req
      libnetlink: Convert GETMDB dumps to use rtnl_mdbdump_req
      libnetlink: Convert GETNETCONF dumps to use rtnl_netconfdump_req
      libnetlink: Convert GETRULE dumps to use rtnl_ruledump_req
      libnetlink: Convert GETNEIGH dumps to use rtnl_neighdump_req
      libnetlink: Convert GETNEIGHTBL dumps to use rtnl_neightbldump_req
      libnetlink: Convert GETNSID dumps to use rtnl_nsiddump_req
      libnetlink: Rename rtnl_wilddump_* to rtnl_linkdump_*
      libnetlink: Rename rtnl_wilddump_stats_req_filter to rtnl_statsdump_r=
eq_filter
      Update kernel headers
      Tree wide: Drop sockaddr_nl arg
      iplink: Remove flags argument from iplink_get
      ip rule: Honor filter arguments on flush
      ip rule: Require at least one argument for add

Eelco Chaudron (1):
      tc_util: Add support for showing TCA_STATS_BASIC_HW statistics

Emeric Dupont (1):
      iproute2: Installation errors without libmnl

Eric Dumazet (4):
      ss: add support for delivered and delivered_ce fields
      ss: add support for bytes_sent, bytes_retrans, dsack_dups and reord_s=
een
      tc: add a missing space between rate estimator and backlog
      nstat: fix load_ugly_table() limits

Hangbin Liu (2):
      iplink: add ipvtap support
      ip/geneve: fix ttl inherit behavior

Hoang Le (1):
      tipc: fix misalignment printout in non-JSON output

Jakub Kicinski (1):
      tc: f_u32: allow skip_hw and skip_sw flags to be last

Jesus Sanchez-Palencia (1):
      libnetlink: Add helper for getting a __s32 from netlink msgs

Leon Romanovsky (3):
      rdma: Refresh help section of resource information
      rdma: Fix broken 32-bit compilation
      rdma: Fix incorrectly handled NLA validation

Luca Boccassi (11):
      Use libbsd for strlcpy if available
      Include bsd/string.h only in include/utils.h
      man: ss.8: break and indent long line
      Fix warning in tc-skbprio.8 manpage
      testsuite: build generate_nlmsg with QUIET_CC
      Pass CPPFLAGS to the compiler
      testsuite: correctly use CC macros for generate_nlmsg
      Makefile: have check target depend on all
      testsuite: declare dependency between $(TESTS) and generate_nlmsg
      testsuite: delete dummy interface after default route test
      testsuite: remove gre kmods if the test loads them

Martin Je=C5=99=C3=A1bek (1):
      ip: iplink_can.c: fix json formatting

Masatake YAMATO (1):
      man: ss: fix typos about wscale

Nicolas Dichtel (1):
      ipnetns: parse nsid as a signed integer

Nikolay Aleksandrov (2):
      bridge: fdb: add support for sticky flag
      bridge: add support for backup port

Peter Korsgaard (1):
      utils.h: provide fallback CLOCK_TAI definition

Petr Machata (2):
      libnetlink: Process further iovs on no error
      testsuite: Add a test for batch processing

Petr Vorel (8):
      man: rtpr: Rename s/bash/shell/
      tests: Use /bin/sh shebang
      configure: Remove unused function check_prog()
      configure: Remove non-posix shell expansion
      configure: Minor code cleanup
      examples: Remove dhcp-client-script
      examples: Remove cbq.init-v0.7.3
      testsuite: Fix colorize

Phil Sutter (6):
      man: ip-route.8: Document nexthop limit
      ip-route: Fix nexthop encap parsing
      ip-address: Fix filtering by negated address flags
      man: rdma: Add reference to rdma-resource.8
      man: ip-route.8: Fix ENCAP references in synopsis
      ssfilter: Fix for inverted last expression

Pieter Jansen van Vuuren (1):
      tc: f_flower: add geneve option match support to flower

Quentin Monnet (1):
      bpf: initialise map symbol before retrieving and comparing its type

Roopa Prabhu (5):
      ipneigh: support setting of NTF_ROUTER on neigh entries
      ipneigh: update man page and help for router
      ipneigh: support for NTF_EXT_LEARNED flag on neigh entries
      bridge: fdb: remove redundant dev string in show output
      bridge: make -c match -compressvlans first instead of -color

Shmulik Ladkani (1):
      iproute_lwtunnel: allow specifying 'src' for 'encap ip' / 'encap ip6'

Stefano Brivio (2):
      ss: Actually print left delimiter for columns
      testsuite: ss: Fix spacing in expected output for ssfilter.t

Stephen Hemminger (37):
      uapi: update headers to 4.20-rc1
      uapi: sctp header change
      testsuite: colorize test result output
      testsuite: drop old kernel configs
      lib/ll_addr: whitespace and indent cleanup
      lib/utils: make local functions static
      lib/color: make local functions static
      lib/ll_map: make local function static
      libnetlnk: unused and local functions cleanup
      genl: remove dead code
      bridge: make local variables static
      ip: make flag names const/static
      ipmonitor: make local variable static
      ipxfrm: make local functions static
      tc: drop unused name_to_id function
      tipc: make cmd_find static
      tc/class: make filter variables static
      tc/police: make print_police static
      ss: make local variables static
      tc/pedit: make functions static
      tc/ematch: make local functions static
      tc/util: make local functions static
      tc/meta: make meta_table static and const
      tc/action: make variables static
      tc/pedit: use structure initialization
      rdma: make local functions static
      devlink: don't need to call pkg-config twice
      rdma: align uapi headers with 4.20-rc5
      uapi: update bpf header
      ipmacsec: fix warning on 32bit platform
      lib/bpf: fix build warning if no elf
      fix print_0xhex on 32 bit
      remove redundant long int
      uapi/in.h: Allow class-e address assignment
      uapi/netlink.h: rename NETLINK_DUMP_STRICT_CHK -> NETLINK_GET_STRICT_=
CHK
      uapi/iptunnel: make TUNNEL_FLAGS available
      v4.20.0

Syrone Wong (1):
      tc: fix xtables incorrect usage of LDFLAGS

Tobias Jungel (2):
      bridge: fix vlan show stats formatting
      ipneigh: print dst for AF_BRIDGE

Vinicius Costa Gomes (4):
      utils: Implement get_s64()
      include: Add helper to retrieve a __s64 from a netlink msg
      tc: Add support for configuring the taprio scheduler
      taprio: Add manpage for tc-taprio(8)

Vlad Buslov (1):
      tc: flower: expose hardware offload count

Yonghong Song (1):
      bpf: check map symbol type properly with newer llvm compiler

Yousuk Seung (1):
      q_netem: slotting with non-uniform distribution

wenxu (1):
      iprule: Add tun_id filed in the selector

