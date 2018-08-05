Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC4BC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80525217B4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80525217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeHEJvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 05:51:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33610 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHEJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 05:51:35 -0400
Received: from localhost (unknown [172.58.41.13])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 159D713F390AD;
        Sun,  5 Aug 2018 00:47:54 -0700 (PDT)
Date:   Sun, 05 Aug 2018 00:47:44 -0700 (PDT)
Message-Id: <20180805.004744.1043412275329854518.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Networking
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 Aug 2018 00:47:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Handle frames in error situations properly in AF_XDP, from Jakub
   Kicinski.

2) tcp_mmap test case only tests ipv6 due to a thinko, fix from
   Maninder Singh.

3) Session refcnt fix in l2tp_ppp, from Guillaume Nault.

4) Fix regression in netlink bind handling of multicast
   gruops, from Dmitry Safonov.

Please pull, thanks a lot!

The following changes since commit e30cb13c5a09ff5f043a6570c32e49b063bea6a1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-08-02 10:12:02 -0700)

are available in the Git repository at:

  gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git 

for you to fetch changes up to 91874ecf32e41b5d86a4cb9d60e0bee50d828058:

  netlink: Don't shift on 64 for ngroups (2018-08-04 17:52:51 -0700)

----------------------------------------------------------------
Colin Ian King (1):
      drivers: net: lmc: fix case value for target abort error

David S. Miller (2):
      Merge branch 'mlxsw-Fix-ACL-actions-error-condition-handling'
      Merge git://git.kernel.org/.../bpf/bpf

Dmitry Safonov (1):
      netlink: Don't shift on 64 for ngroups

Guillaume Nault (1):
      l2tp: fix missing refcount drop in pppol2tp_tunnel_ioctl()

Jakub Kicinski (1):
      net: xsk: don't return frames via the allocator on error

Maninder Singh (1):
      selftest/net: fix protocol family to work for IPv4.

Mathieu Xhonneux (1):
      selftests/bpf: update test_lwt_seg6local.sh according to iproute2

Nir Dotan (4):
      mlxsw: core_acl_flex_actions: Return error for conflicting actions
      mlxsw: core_acl_flex_actions: Remove redundant resource destruction
      mlxsw: core_acl_flex_actions: Remove redundant counter destruction
      mlxsw: core_acl_flex_actions: Remove redundant mirror resource destruction

Ursula Braun (1):
      net/smc: no cursor update send in state SMC_INIT

Yonghong Song (1):
      tools/bpftool: fix a percpu_array map dump problem

 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c | 51 +++++++++++++++++++++++++++++----------------------
 drivers/net/wan/lmc/lmc_main.c                              |  2 +-
 net/l2tp/l2tp_ppp.c                                         | 13 +++++++++----
 net/netlink/af_netlink.c                                    |  4 ++--
 net/smc/smc_cdc.c                                           |  3 ++-
 net/xdp/xsk.c                                               |  4 +---
 tools/bpf/bpftool/map.c                                     | 14 +++++++++-----
 tools/testing/selftests/bpf/test_lwt_seg6local.sh           |  6 +++---
 tools/testing/selftests/net/tcp_mmap.c                      |  2 +-
 9 files changed, 57 insertions(+), 42 deletions(-)
