Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rwC7A8f3G1t0BwAAmS7hNA
	; Sat, 09 Jun 2018 15:52:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 30CEB608C1; Sat,  9 Jun 2018 15:52:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjFh5Jhl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E34AD608B8;
	Sat,  9 Jun 2018 15:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E34AD608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbeFIPwe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753578AbeFIPb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:31:26 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE5820896;
        Sat,  9 Jun 2018 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558285;
        bh=faX8bLO+jioK6Fdx2xjdv9ccUl4sd6bsRmrH1nGKYPU=;
        h=From:To:Cc:Subject:Date:From;
        b=HjFh5JhlwiSPAQvtTMjy0VGLEs1MCz/Q7uWUaRBazIMC3P3/lt9NjNaLARQCeEGwV
         YlBIangFiMFTfpwxWo6bigJkG8s3EkWx5757x0H75AwFs2+I3o2OCt6XCKd42MeoX1
         5hUupfE6MtPdAVm0ZspZ9fmT2XRBgBTlFKtcv3tc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.17 00/15] 4.17.1-stable review
Date: Sat,  9 Jun 2018 17:29:35 +0200
Message-Id: <20180609150000.746833461@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.17.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.17.1-rc1
X-KernelTest-Deadline: 2018-06-11T15:00+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.17.1 release.
There are 15 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Jun 11 14:59:48 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.1-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.17.1-rc1

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Do not wait forever on a device that has disappeared

Sabrina Dubroca <sd@queasysnail.net>
    ipmr: fix error path when ipmr_new_table fails

Arun Parameswaran <arun.parameswaran@broadcom.com>
    net: dsa: b53: Fix for brcm tag issue in Cygnus SoC

Stephen Suryaputra <ssuryaextr@gmail.com>
    vrf: check the original netdevice for generating redirect

Dan Carpenter <dan.carpenter@oracle.com>
    team: use netdev_features_t instead of u32

Xin Long <lucien.xin@gmail.com>
    sctp: not allow transport timeout value less than HZ/5 for hb_timer

Eric Dumazet <edumazet@google.com>
    rtnetlink: validate attributes in do_setlink()

Eric Dumazet <edumazet@google.com>
    net/packet: refine check for priv area size

Eric Dumazet <edumazet@google.com>
    net: metrics: add proper netlink validation

Cong Wang <xiyou.wangcong@gmail.com>
    netdev-FAQ: clarify DaveM's position for stable backports

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: fix refcount leakage on PPPoL2TP sockets

Michal Kubecek <mkubecek@suse.cz>
    ipv6: omit traffic class when calculating flow hash

Sabrina Dubroca <sd@queasysnail.net>
    ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succeeds

Julia Lawall <Julia.Lawall@lip6.fr>
    bnx2x: use the right constant

Jason A. Donenfeld <Jason@zx2c4.com>
    netfilter: nf_flow_table: attach dst to skbs


-------------

Diffstat:

 Documentation/networking/netdev-FAQ.txt          |  9 +++++
 Makefile                                         |  4 +--
 drivers/net/dsa/b53/b53_common.c                 | 15 +++++++-
 drivers/net/dsa/b53/b53_priv.h                   |  2 ++
 drivers/net/dsa/b53/b53_srab.c                   |  4 +--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c |  2 +-
 drivers/net/team/team.c                          |  3 +-
 drivers/pci/host/pci-hyperv.c                    | 46 +++++++++++++++++-------
 include/linux/mroute_base.h                      | 10 ------
 include/net/ipv6.h                               |  5 +++
 net/core/flow_dissector.c                        |  2 +-
 net/core/rtnetlink.c                             |  8 ++---
 net/ipv4/fib_semantics.c                         |  4 +++
 net/ipv4/ipmr_base.c                             |  8 +++--
 net/ipv4/netfilter/nf_flow_table_ipv4.c          |  5 +--
 net/ipv6/ip6_output.c                            |  3 +-
 net/ipv6/ip6mr.c                                 | 21 +++++++----
 net/ipv6/ndisc.c                                 |  6 ++++
 net/ipv6/netfilter/nf_flow_table_ipv6.c          |  1 +
 net/ipv6/route.c                                 |  4 +--
 net/l2tp/l2tp_ppp.c                              | 35 +++++++++---------
 net/packet/af_packet.c                           |  2 +-
 net/sctp/transport.c                             |  2 +-
 23 files changed, 132 insertions(+), 69 deletions(-)
