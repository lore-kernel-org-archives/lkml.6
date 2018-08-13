Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ABBC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A20C2177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="FxQLtv83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A20C2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbeHMWAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:00:48 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:36209 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbeHMWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:00:48 -0400
Received: by mail-pl0-f46.google.com with SMTP id e11-v6so7294317plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 12:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=hZOpmvSMyOsfMuwoqa62Xt4162cm/RcS629mHDWOx9s=;
        b=FxQLtv833UA7P0I9LXHBKgIoyMr6zF3Dmz7yYMepUXTE26KeREp1gndDvrM/voAOnl
         WXEbqVQvFfmaXS0Bhc2wPANgq9WHuNsSVdPKApGzOyb+kwcX8iX3b+cWbB/DyZAxu3TK
         NVAPWmS/hUpIIVWZ8NTvsTwX/SkDZAMRg2o4UWYfombjJj0HJpuVnaBGwcmuwH1z3rDU
         oHOivdI/W9pLP7At+el6ZjDcuz5ImpbVXnl11a4u70KjZrsxMql9vI7jb+Xi3G7oiaJh
         DEAZ1pd5At9Cz+NsbUoNkaLEVHh5ydgqEqMvAvdKvtokDeM8WrpdxbU6la9YpFSq0ZJc
         WKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=hZOpmvSMyOsfMuwoqa62Xt4162cm/RcS629mHDWOx9s=;
        b=CkSDGnUrRrJTXBD+ZENdKACD4qFdJK4h8kYLSZmXRQ+aLiZFcD9dPMOCLcRb+BbDn1
         bexfX4GhzG05fj9IR+59UyXunJ6e2VEAYXWeUw3+K/sOwkSJY4AbOf77Ofd5KL5LBtPw
         jsuwDoyP+j/iAioeaNLFR1aN8A3cao99i/qZBWQrJ+Suqv0igNARnzYyphTS8SF4YMf6
         +xyUdYDHgvR6ztpHGILlYnRu9vEuh87dddDitcX4CuayFuJ+buwaFq4TRKGaJq0oz0ZN
         bH8HHAD+Eq4azEa7O8e62seOYnH8M980JgYondlWXj8goizawopvfh3gmzx54fY/6iTt
         /0Hg==
X-Gm-Message-State: AOUpUlG/hU07oOtc5/DDLfmM2chUxrnzoObxhUslYhr/z4V9uH/XawRR
        zI4FCvp9vOOzUTclbv3oBJznh+MutVA=
X-Google-Smtp-Source: AA+uWPwM1leDYqUII/mysC7RXfG3N209YiZb3F2npjGSef+KRAYBcf9+nv9PQNKrn9rJACqhyO76jQ==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr18045035plo.100.1534187835152;
        Mon, 13 Aug 2018 12:17:15 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id q25-v6sm36783916pfk.96.2018.08.13.12.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:17:15 -0700 (PDT)
Date:   Mon, 13 Aug 2018 12:17:12 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 4.18.0
Message-ID: <20180813121712.19d3c21a@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release of iproute2 for Linux 4.18

Latest version iproute2 utility to support new features in Linux 4.18.
Most of the updates are related to BPF and JSON.

The tarball can be downloaded from:
  https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-4.18.0.tar.gz

The upstream repositories for master and net-next branch are now
split. Master branch is at:
  git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

and patches for next release are in (master branch):
  git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Report problems (or enhancements) to the netdev@vger.kernel.org mailing list.

---
Daniele Palmas (1):
      ip: add rmnet initial support

David Ahern (8):
      Update kernel headers
      Update kernel headers
      Update kernel headers
      Update kernel headers
      Update kernel headers
      ipaddress: Add support for address metric
      ip route: print RTA_CACHEINFO if it exists
      devlink: CTRL_ATTR_FAMILY_ID is a u16

Donald Sharp (1):
      iproute2: Add support for a few routing protocols

Eric S. Raymond (1):
      devlink.8, translate unparseable callout syntax to parseable form.

GhantaKrishnamurthy MohanKrishna (1):
      tipc: Add support to set and get MTU for UDP bearer

Hangbin Liu (2):
      vxlan: fix ttl inherit behavior
      vxlan: add ttl auto in help message

Hoang Le (1):
      rdma: sync some IP headers with glibc

Jakub Kicinski (1):
      bpf: don't offload perf array maps

Jesus Sanchez-Palencia (2):
      man: Fix typos on tc-cbs
      tc: Do not use addattr_nest_compat on mqprio and netem

Jiri Pirko (1):
      devlink: introduce support for showing port flavours

Jon Maloy (1):
      tipc: fixed node and name table listings

Keara Leibovitz (1):
      tc: add json support in csum action

Leon Romanovsky (1):
      rdma: Print net device name and index for RDMA device

Lubomir Rintel (1):
      lib/namespace: avoid double-mounting a /sys

Marcelo Ricardo Leitner (2):
      tc-netem: fix limit description in man page
      tc: flower: add support for verbose logging

Mathieu Xhonneux (1):
      ip: add support for seg6local End.BPF action

Matteo Croce (1):
      ip link: don't stop batch processing

Patrick Talbert (1):
      ipaddress: strengthen check on 'label' input

Roi Dayan (1):
      tc: Fix output of ip attributes

Roman Mashak (5):
      tc: jsonify connmark action
      tc: jsonify tunnel_key action
      tc: jsonify skbedit action
      tc: jsonify ife action
      tc: add missing space symbol in ife output

Roopa Prabhu (1):
      iproute: ip route get support for sport, dport and ipproto match

Sabrina Dubroca (2):
      man: ip link: document GRE tunnels
      gre/gre6: allow clearing {,i,o}{key,seq,csum} flags

Serhey Popovych (1):
      ipaddress: Fix and make consistent label match handling

Stephen Hemminger (8):
      uapi: update headers from linux-net
      uapi: update bpf.h
      tc: don't double print rate
      uapi: fix tcp.h repair
      rdam: uapi update ib_user_verbs.h
      ip/address: fix bracketing in help message
      tc: flush after each command in batch mode
      v4.18.0

Steve Wise (3):
      rdma: update rdma_netlink.h to get new driver attributes
      rdma: print driver resource attributes
      rdma: update man pages

Tobias Klauser (1):
      tc: bpf: update list of archs with eBPF support in manpage

Vlad Buslov (1):
      tc: fix batch force option

fumihiko kakuma (1):
      tc: Fix the bug not to display prio and quantum options of htb

