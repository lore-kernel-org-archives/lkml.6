Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD09C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC42208A0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC42208A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389578AbeG0Ldp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:33:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbeG0Ldp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:33:45 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C4553BB6;
        Fri, 27 Jul 2018 10:12:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/23] 4.4.145-stable review
Date:   Fri, 27 Jul 2018 12:09:01 +0200
Message-Id: <20180727100845.054377089@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.145-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.145-rc1
X-KernelTest-Deadline: 2018-07-29T10:08+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.145 release.
There are 23 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jul 29 10:08:37 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.145-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.145-rc1

Arnd Bergmann <arnd@arndb.de>
    ARM: fix put_user() for gcc-8

Arnd Bergmann <arnd@arndb.de>
    turn off -Wattribute-alias

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix RX overflow interrupt not being enabled

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix incorrect clear of non-processed interrupts

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix device dropping off bus on RX overrun

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix recovery from error states not being propagated

Anssi Hannula <anssi.hannula@bitwise.fi>
    can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    driver core: Partially revert "driver core: correct device's shutdown order"

Jerry Zhang <zhangjerry@google.com>
    usb: gadget: f_fs: Only return delayed status when len is 0

Bin Liu <b-liu@ti.com>
    usb: core: handle hub C_PORT_OVER_CURRENT condition

Lubomir Rintel <lkundrak@v3.sk>
    usb: cdc_acm: Add quirk for Castles VEGA3000

Willem de Bruijn <willemb@google.com>
    ip: in cmsg IP(V6)_ORIGDSTADDR call pskb_may_pull

Eric Dumazet <edumazet@google.com>
    tcp: detect malicious patterns in tcp_collapse_ofo_queue()

Eric Dumazet <edumazet@google.com>
    tcp: avoid collapses in tcp_prune_queue() if possible

Yuchung Cheng <ycheng@google.com>
    tcp: do not delay ACK in DCTCP upon CE status change

Yuchung Cheng <ycheng@google.com>
    tcp: do not cancel delay-AcK on DCTCP special ACK

Yuchung Cheng <ycheng@google.com>
    tcp: helpers to send special DCTCP ack

Yuchung Cheng <ycheng@google.com>
    tcp: fix dctcp delayed ACK schedule

Roopa Prabhu <roopa@cumulusnetworks.com>
    rtnetlink: add rtnl_link_state check in rtnl_configure_link

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapper

Paolo Abeni <pabeni@redhat.com>
    ip: hash fragments consistently

Felix Fietkau <nbd@nbd.name>
    MIPS: ath79: fix register address in ath79_ddr_wb_flush()


-------------

Diffstat:

 Makefile                                           |   5 +-
 arch/arm/include/asm/uaccess.h                     |   2 +-
 arch/mips/ath79/common.c                           |   2 +-
 drivers/base/dd.c                                  |   8 -
 drivers/net/can/xilinx_can.c                       | 323 +++++++++++++++++----
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |   2 +-
 drivers/usb/class/cdc-acm.c                        |   3 +
 drivers/usb/core/hub.c                             |   8 +-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 include/net/tcp.h                                  |   2 +
 net/core/rtnetlink.c                               |   9 +-
 net/ipv4/ip_output.c                               |   2 +
 net/ipv4/ip_sockglue.c                             |   7 +-
 net/ipv4/tcp_dctcp.c                               |  50 +---
 net/ipv4/tcp_input.c                               |  21 +-
 net/ipv4/tcp_output.c                              |  33 ++-
 net/ipv6/datagram.c                                |   7 +-
 net/ipv6/ip6_output.c                              |   2 +
 18 files changed, 357 insertions(+), 131 deletions(-)


