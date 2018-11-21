Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0695C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661F3214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2ASWtBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661F3214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbeKVFpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:45:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbeKVFpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:45:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0416B206BB;
        Wed, 21 Nov 2018 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827381;
        bh=5FqKqt9Ejp1iDMhvHvgtkPyxykZ1rA7IvjYyKekisAs=;
        h=From:To:Cc:Subject:Date:From;
        b=r2ASWtBUf+8Hs+XxBxVxWYkQcpu2l4zFZ0QEx7Tw/ijsK/iWRQbODDjGB1oRAmeot
         Ta4WaM8P08EUKF4gfqHzIzUF3bKAaVdkS2wkrI6cDeLkA5de4K94E+6vtKmLMw02sU
         hz9ht05B+KZ4yPvKk7fS8qxRMgpZ1Fe04Dy0TDw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/21] 4.14.83-stable review
Date:   Wed, 21 Nov 2018 20:06:44 +0100
Message-Id: <20181121183422.103826775@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.83-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.83-rc1
X-KernelTest-Deadline: 2018-11-23T18:34+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.83 release.
There are 21 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Nov 23 18:34:13 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.83-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.83-rc1

Chris Paterson <chris.paterson2@renesas.com>
    ARM: dts: r8a7793: Correct critical CPU temperature

Chris Paterson <chris.paterson2@renesas.com>
    ARM: dts: r8a7791: Correct critical CPU temperature

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation"

Eric Dumazet <edumazet@google.com>
    inet: frags: better deal with smp races

Frieder Schrempf <frieder.schrempf@kontron.de>
    usbnet: smsc95xx: disable carrier check while suspending

Stefan Wahren <stefan.wahren@i2se.com>
    net: smsc95xx: Fix MTU range

Shalom Toledo <shalomt@mellanox.com>
    mlxsw: spectrum: Fix IP2ME CPU policer configuration

Xin Long <lucien.xin@gmail.com>
    sctp: not increase stream's incnt before sending addstrm_in request

Martin Schiller <ms@dev.tdt.de>
    net: phy: mdio-gpio: Fix working over slow can_sleep GPIOs

Xin Long <lucien.xin@gmail.com>
    sctp: fix strchange_flags name for Stream Change Event

Tristram Ha <Tristram.Ha@microchip.com>
    net: dsa: microchip: initialize mutex before use

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    net: qualcomm: rmnet: Fix incorrect assignment of real_dev

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Protect stop from timeout

Matthew Cover <werekraken@gmail.com>
    tuntap: fix multiqueue rx

Siva Reddy Kallam <siva.kallam@broadcom.com>
    tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control paths

Xin Long <lucien.xin@gmail.com>
    sctp: not allow to set asoc prsctp_enable by sockopt

Eric Dumazet <edumazet@google.com>
    net-gro: reset skb->pkt_type in napi_reuse_skb()

David Ahern <dsahern@gmail.com>
    ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF

Sabrina Dubroca <sd@queasysnail.net>
    ip_tunnel: don't force DF when MTU is locked

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    ibmvnic: fix accelerated VLAN handling

배석진 <soukjin.bae@samsung.com>
    flow_dissector: do not dissect l4 ports for fragments


-------------

Diffstat:

 Makefile                                        |  4 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |  2 +-
 arch/arm/boot/dts/r8a7793.dtsi                  |  2 +-
 arch/x86/kernel/cpu/bugs.c                      | 57 +++----------------------
 drivers/net/dsa/microchip/ksz_common.c          | 10 ++---
 drivers/net/ethernet/broadcom/bcmsysport.c      | 15 +++----
 drivers/net/ethernet/broadcom/tg3.c             | 18 +++++++-
 drivers/net/ethernet/ibm/ibmvnic.c              |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c  |  1 -
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c |  6 +--
 drivers/net/phy/mdio-gpio.c                     | 10 ++---
 drivers/net/tun.c                               |  6 ++-
 drivers/net/usb/smsc95xx.c                      |  9 ++++
 include/uapi/linux/sctp.h                       |  2 +
 kernel/cpu.c                                    | 11 +----
 net/core/dev.c                                  |  4 ++
 net/core/flow_dissector.c                       |  4 +-
 net/ipv4/inet_fragment.c                        | 28 ++++++------
 net/ipv4/ip_tunnel_core.c                       |  2 +-
 net/ipv6/route.c                                |  7 ++-
 net/sctp/socket.c                               | 26 +++--------
 net/sctp/stream.c                               |  1 -
 22 files changed, 96 insertions(+), 131 deletions(-)


