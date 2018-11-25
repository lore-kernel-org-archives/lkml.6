Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5755EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1629920672
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytheb-org.20150623.gappssmtp.com header.i=@bytheb-org.20150623.gappssmtp.com header.b="KWEg5NfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1629920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bytheb.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeKZFBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:01:14 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40028 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKZFBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:01:14 -0500
Received: by mail-io1-f66.google.com with SMTP id n9so12144611ioh.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 10:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytheb-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSzU6y+7Cr4y8l5NqtcY8oW5aRMNQI/xkHEv7vHQqD8=;
        b=KWEg5NfSwZe0A12jbVBPmINKlF30VCzBFAVBmdSwYImnsNnEqbwFqcz83dXTWjg8Ax
         t/OMnJ5ypt7v0RytUZc6IvjGHyyKrpd4d6jt3eGkocaZhpYsLEHV0DVDQd4MKPsqQwp/
         r9EB0XGz8gUiyMIUal+er2Id84CZMQAqq+TTIEpgMGZFPPsgvfEqnTV/C+Kp5888utI+
         v4V1Km2edDTmL7XUtJhSzx6OzXsaejskRsqOlrvcWzdV/6q0Ya3te26W6lkq+k3XJCeD
         xfERUlcRCOnGnAUp1wOSXzO1Khg/Bi/9QVqJ4EZ8hYgpKxVUWt3dn/8+EARQdXW6k2iY
         nFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSzU6y+7Cr4y8l5NqtcY8oW5aRMNQI/xkHEv7vHQqD8=;
        b=GTreSsvqqGT24q1D36TO9e0GuPv1CuNZgdd6yyYj07Hd7gJuQFzScfEbbY98ZOiptS
         88y09/K6Wm1nQJbmH11r1XSbPNN9HCP/JEqU1Z7QJEHjwhFHLfy1hXWbRqymlfavx0Pk
         ptk/JlaZrUMckmAlKmX9Qs1oIOcnDSuVgASB+7PagnNdT7QcFA6cAL0ZKs3Far5HuuXM
         Le6K7PJjTqzUFXuD6Dxu85AGCVwmyaYKzMdZ3n4JqsMbKoaXAK5WyZTHIpqbpuJWUF57
         Rga7YVcVVta2ayqJ8gFUtjRxlC/UO9mZEbKm96ZBKdPiJQh5fAwc7a2zJ9OFit9CRIA2
         o2hg==
X-Gm-Message-State: AA+aEWbpGdr6iUZEk6p/ynPmQqkmjCMLlGulTlq+dnCeIIgFtnU5yYvs
        IHqdeY+kv5K8SU/wUAg5oWGWXA==
X-Google-Smtp-Source: AFSGD/UkvSt0GEb1HC0B04rWiMFgndW40KmweA4VQWYvFWpPvDse6P4p7ZE575+pRnq6E8xX/0yrew==
X-Received: by 2002:a6b:c583:: with SMTP id v125-v6mr18252478iof.149.1543169375710;
        Sun, 25 Nov 2018 10:09:35 -0800 (PST)
Received: from dhcp-25.97.bos.redhat.com (047-014-005-015.res.spectrum.com. [47.14.5.15])
        by smtp.gmail.com with ESMTPSA id y8sm5959768ita.5.2018.11.25.10.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 10:09:34 -0800 (PST)
From:   Aaron Conole <aconole@bytheb.org>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        Rony Efraim <ronye@mellanox.com>,
        Simon Horman <horms@verge.net>,
        Marcelo Leitner <marcelo.leitner@gmail.com>
Subject: [RFC -next v0 0/3] netfilter: expose flow offload tables as an ebpf map
Date:   Sun, 25 Nov 2018 13:09:16 -0500
Message-Id: <20181125180919.13996-1-aconole@bytheb.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an alternate approach to exposing connection tracking data
to the XDP + eBPF world.  Rather than having to rework a number of
helper functions to ignore or rebuild metadata from an skbuff data
segment, we reuse the existing flow offload hooks that expose conntrack
tuples directly based on a flow tuple.  As this is an early-version RFC,
the API behavior is definitely going to change.  I'll be working on this
unless the flames grow so high that there's no choice but to bail and
let it burn down.

The goal of this work is to integrate the flow offload infrastructure
from netfilter, in a similar way to the approach that flow hw offload
has taken (ie: the 'slowpath' of netfilter does the heavy lifting for
lots of the required functions, like port allocations, helper parsing,
etc).  The advatange of building a series like this is two-fold:

 1.  We can get the advantages of the netfilter infrastructure today,
     and pull in functionality via various map types or operations (TBD).
     I think the next thing to add to this would be NAT support (so that
     we could actually forward end-to-end and watch things go).

 2.  For the hw offload folks, this gives a way to test out some of the
     proposed conntrack API changes without need hardware available
     today.  In fact, this might let the hardware vendors prototype their
     conntrack offload, see where the proposed APIs are lacking (or where
     they need reworking), and turn around changes quickly.

It's not all sunshine and roses, though.  The first patch in the series is
definitely controversial.  It would allow kernel subsystems to register
their own map types at module load time, rather than being compiled in to
the kernel at run-time.  I think there is a worry about this kind of
functionality enabling the eBPF ecosystem to fracture.  I don't know if
I understand the concern enough.  If that's dead in the water, there might
be an alternate approach with out patch 1 (I have a rough sketch in my
head, but haven't coded it up).

I have only done some rudimentary testing with this.  Just enough to prove
that I wasn't breaking anything existing.  I'm sending this out just as
it matched the first packet (and I'm re-running the build and retesting so
that I didn't forget to save something).  So I don't have any benchmark
data, and I don't even have support yet to do anything useful (NAT would
be needed for my IPv4 testing to to proceed, so that's my next task).

I have a small (and hacky) test program at:
  https://github.com/orgcandman/conntrack_bpf

It is only used to exercise the lookup call - it doesn't actually prevent
connections from eventually succeeding.  I eventually hope to flesh that
out into a bpf implementation of hardware offload (with various features,
like window tracking, flag validation, etc).

Aaron Conole (3):
  bpf: modular maps
  netfilter: nf_flow_table: support a new 'snoop' mode
  netfilter: nf_flow_table_bpf_map: introduce new loadable bpf map

 include/linux/bpf.h                       |   6 +
 include/linux/bpf_types.h                 |   2 +
 include/net/netfilter/nf_flow_table.h     |   5 +
 include/uapi/linux/bpf.h                  |   7 +
 include/uapi/linux/netfilter/nf_tables.h  |   2 +
 init/Kconfig                              |   8 +
 kernel/bpf/syscall.c                      |  57 +++++-
 net/netfilter/Kconfig                     |   9 +
 net/netfilter/Makefile                    |   1 +
 net/netfilter/nf_flow_table_bpf_flowmap.c | 202 ++++++++++++++++++++++
 net/netfilter/nf_flow_table_core.c        |  44 ++++-
 net/netfilter/nf_tables_api.c             |  13 +-
 12 files changed, 351 insertions(+), 5 deletions(-)
 create mode 100644 net/netfilter/nf_flow_table_bpf_flowmap.c

-- 
2.19.1

