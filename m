Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F12C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59946207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="hyQgFVXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59946207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeJXCOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:14:03 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:34070 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeJXCOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:14:02 -0400
Received: by mail-pl1-f182.google.com with SMTP id f10-v6so990711plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSE3uwnrA9egAzYb2eiP0hwR0RrfD9psVH6Wvzn+FhQ=;
        b=hyQgFVXHHqaZUafcLAid2QaNuCtVXVUKmFoMkNDzsoE8n5HMbQ/FzWHDzTQSe16cgl
         8yaeRJPEjoEYhKvSSGoXfl0eBs0rR+9F6AY6JaQTTmuY1Cw/l+2nxhHoowGBAOKKpiiJ
         sJPpJy3UEUNcTlsi8VgNalTlX8AK8YnK3ZBFL4256C74KZRNNknt99PVC0GB9jnIvzVV
         MpYDDCCkLu198tKr/9PnGa7x+NqYKx5vEmPW83Co65ANB0rRMp7u+I8faUyJf3r3wXuR
         t9lcIALw6HT8adf27v7/nzPfB8hJvai40YSIsz02UP7sYa0pinikjcSuDA/KVN2k1PwK
         aLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSE3uwnrA9egAzYb2eiP0hwR0RrfD9psVH6Wvzn+FhQ=;
        b=NR7IYS/VFktcx56veMxMu1BMao7FcUmuWr9uIM9IDSBdbkR49A+JAshJq093ikZ/q9
         RR1+43V6C4ZRS1pUuYO9XXLHxLlBSSItYQcFaQn84eFm61kJJ+3rg5nL0zv8Sh1yPt8c
         7eXuNq8FmPHBFNOhtUs7ci2bx123pxCQfjf0y0FSOvR8ieyWdbtztt3VX2i1jIE0jc/J
         ayVmfyxOwHRhwi0nnd/PgLPqP8S2kTrlvK+YkCD+TUo2J+EethgMeH081OIJezf+5sDd
         IdQ4jSakoCHWuSCJLJ0rv6bl5/w/60PzW2z/mVGpoTsUtf40hVfxfNCPEO5qEgxqRy2l
         LmxA==
X-Gm-Message-State: ABuFfojqnjLwkZvStiSG+4F1Ldd79Ld7bYtuSK6kGgLuaIQppXGOiHpQ
        5daXVAUTtMxvf1NQrW6yUEyoVEBpUNg=
X-Google-Smtp-Source: ACcGV633Yj40iDttIpbv5Bgiy0FCwMc2QHhXntUoGJtXcdZ/9gxqGlDmupPQ/OS42xLs7o20mYR5Gw==
X-Received: by 2002:a17:902:9b84:: with SMTP id y4-v6mr50179636plp.332.1540316978677;
        Tue, 23 Oct 2018 10:49:38 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id z129-v6sm3304572pfb.40.2018.10.23.10.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 10:49:38 -0700 (PDT)
Date:   Tue, 23 Oct 2018 10:49:35 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 4.19
Message-ID: <20181023104935.282ff4ec@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release of iproute2 for Linux 4.19

Lastest version iproute2 utility to support new features in Linux 4.19
such as CAKE qdisc. In addition to the usual manual page fixes and
other cleanups.

The tarball can be downloaded from:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-4.19.0.tar=
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
      devlink: Add support for devlink-region access

Caleb Raitto (2):
      man: Change numtc to num_tc
      tc/mqprio: Print extra info on invalid args.

Cong Wang (1):
      ss: add UNIX_DIAG_VFS and UNIX_DIAG_ICONS for unix sockets

Daniel Borkmann (4):
      bpf: move bpf_elf_map fixup notification under verbose
      bpf: remove strict dependency on af_alg
      bpf: implement bpf to bpf calls support
      bpf: implement btf handling and map annotation

David Ahern (6):
      Update kernel headers
      Update kernel headers
      Import btf.h from kernel headers
      Update kernel headers
      Update kernel headers
      Update kernel headers

Eran Ben Elisha (1):
      ip: Add violation counters to VF statisctics

Florent Fourcot (1):
      tc/htb: remove unused variable

Guillaume Nault (3):
      l2tp: drop data_seq
      l2tp: drop mtu
      l2tp: drop lns_mode

Hangbin Liu (3):
      bridge/mdb: fix missing new line when show bridge mdb
      iplink: fix incorrect any address handling for ip tunnels
      vxlan: show correct ttl inherit info

Hoang Le (2):
      tipc: JSON support for showing nametable
      tipc: JSON support for tipc link printouts

Jakub Kicinski (2):
      iplink: add support for reporting multiple XDP programs
      tc: jsonify output of q_fifo

Jesus Sanchez-Palencia (1):
      man: Add initial manpage for tc-etf(8)

Jianbo Liu (1):
      tc: flower: Add support for QinQ

Jiri Pirko (1):
      tc: introduce support for chain templates

Keara Leibovitz (2):
      tc: jsonify nat action
      tc: fix bugs for tcp_flags and ip_attr hex output

Leon Romanovsky (1):
      rdma: Fix representation of PortInfo CapabilityMask

Lorenzo Bianconi (3):
      iplink_vxlan: take into account preferred_family creating vxlan device
      uapi: add snmp header file
      utils: fix get_rtnl_link_stats_rta stats parsing

Luca Boccassi (3):
      testsuite: remove all temp files and implement make clean
      testsuite: let make compile build the netlink helper
      testsuite: run dmesg with sudo

Mahesh Bandewar (2):
      ipmaddr: use preferred_family when given
      iproute: make clang happy

Moshe Shemesh (1):
      devlink: Add param command support

Nikolay Aleksandrov (1):
      bridge: add support for isolated option

Nishanth Devarajan (1):
      Add SKB Priority qdisc support in tc(8)

Or Gerlitz (2):
      tc/act_tunnel_key: Enable setup of tos and ttl
      tc/flower: Add match on encapsulating tos/ttl

Petr Vorel (5):
      testsuite: Fix missing generate_nlmsg
      testsuite: Generate generate_nlmsg when needed
      testsuite: Warn about empty $(IPVERS)
      Makefile: Add check target
      testsuite: Fix make check when need build generate_nlmsg

Phil Sutter (30):
      tc: Fix typo in check for colored output
      bridge: Fix check for colored output
      Merge common code for conditionally colored output
      man: ip-route: Clarify referenced versions are Linux ones
      ss: Review ssfilter
      testsuite: Prepare for ss tests
      testsuite: Add a first ss test validating ssfilter
      man: bridge.8: Document -oneline option
      bridge: trivial: Make help text consistent
      devlink: trivial: Make help text consistent
      man: devlink.8: Document -verbose option
      genl: Fix help text
      man: ifstat.8: Document --json and --pretty options
      man: rtacct.8: Fix nstat options
      rtmon: List options in help text
      man: ss.8: Describe --events option
      ip: Add missing -M flag to help text
      Make colored output configurable
      lib: Make check_enable_color() return boolean
      ip-route: Fix segfault with many nexthops
      bridge: fdb: Fix for missing keywords in non-JSON output
      ip-addrlabel: Fix printing of label value
      devlink: Fix error reporting in cmd_resource_set()
      rdma: Fix for ineffective check in add_filter()
      ip-route: Fix for memleak in error path
      rdma: Don't pass garbage to rd_check_is_filtered()
      ip-route: Fix parse_encap_seg6() srh parsing
      tipc: Drop unused variable 'genl'
      tc: Remove pointless assignments in batch()
      tc: htb: Print default value in hex

Qiaobin Fu (1):
      net:sched: add action inheritdsfield to skbedit

Roopa Prabhu (1):
      ipneigh: exclude NTF_EXT_LEARNED from default filter

Sabrina Dubroca (2):
      json: make 0xhex handle u64
      macsec: fix off-by-one when parsing attributes

Simon Horman (1):
      tc: m_tunnel_key: Add tunnel option support to act_tunnel_key

Stefan Bader (2):
      testsuite: Handle large number of kernel options
      iprule: Fix destination prefix output

Stephen Hemminger (30):
      ip: show min and max mtu
      ip: show min and max mtu
      ip: convert monitor to switch
      ipmonitor: decode DELNETCONF message
      genl: code cleanup
      ip: drop extern from function prototype
      bridge: drop extern from function prototypes
      genl: drop extern from function prototypes
      tc: drop extern from function prototypes
      uapi: update bpf headers
      uapi: update ib_verbs
      bridge: minor change to mdb print
      bridge: use print_json for some outputs
      bridge: fix vlan show formatting
      tc/fifo: remove unnecessary prototype
      genl: remove unnecessary extern
      lib: introduce print_nl
      libnetlink: fix leak and using unused memory on error
      Makefile: add help target
      testsuite: add libmnl
      libnetlink: don't return error on success
      libnetlink: use local variable
      doc/man: spelling fixes
      examples: fix spelling errors
      config: spelling fixes
      tc: spelling fixes
      ip: spelling fixes
      tipc: spelling fix
      util: spelling fix
      v4.19.0

Subash Abhinov Kasiviswanathan (1):
      ip-xfrm: Add support for OUTPUT_MARK

Toke H=C3=B8iland-J=C3=B8rgensen (6):
      Add support for CAKE qdisc
      q_cake: Rename autorate_ingress parameter to use dash as word separat=
or
      sch_cake: Make gso-splitting configurable
      q_cake: Add description of the tc filter override mechanism to man pa=
ge
      q_cake: Add printing of no-split-gso option
      q_cake: Also print nonat, nowash and no-ack-filter keywords

Vinicius Costa Gomes (1):
      tc: Add support for the ETF Qdisc

Vlad Buslov (1):
      libnetlink: fix use-after-free of message buf

