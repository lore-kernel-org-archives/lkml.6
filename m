Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC58C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9600021529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9600021529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbeITSah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:30:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387791AbeITSag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:30:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B4ACFCAE3B815;
        Thu, 20 Sep 2018 20:47:11 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 20:47:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <dmitry.tarnyagin@lockless.no>,
        <wg@grandegger.com>, <mkl@pengutronix.de>,
        <michal.simek@xilinx.com>, <hsweeten@visionengravers.com>,
        <madalin.bucur@nxp.com>, <pantelis.antoniou@gmail.com>,
        <claudiu.manoil@nxp.com>, <leoyang.li@nxp.com>,
        <linux@armlinux.org.uk>, <sammy@sammy.net>, <ralf@linux-mips.org>,
        <nico@fluxnic.net>, <steve.glendinning@shawell.net>,
        <f.fainelli@gmail.com>, <grygorii.strashko@ti.com>,
        <w-kwok2@ti.com>, <m-karicheri2@ti.com>, <t.sailer@alumni.ethz.ch>,
        <jreuter@yaina.de>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
        <arvid.brodin@alten.se>, <pshelar@ovn.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        <linux-omap@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <devel@linuxdriverproject.org>, <linux-usb@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <dev@openvswitch.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 00/22] net: fix return type of ndo_start_xmit function
Date:   Thu, 20 Sep 2018 20:32:44 +0800
Message-ID: <20180920123306.14772-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

YueHaibing (22):
  net: micrel: fix return type of ndo_start_xmit function
  net: freescale: fix return type of ndo_start_xmit function
  net: seeq: fix return type of ndo_start_xmit function
  net: cirrus: fix return type of ndo_start_xmit function
  net: sgi: fix return type of ndo_start_xmit function
  net: wiznet: fix return type of ndo_start_xmit function
  net: i825xx: fix return type of ndo_start_xmit function
  net: apple: fix return type of ndo_start_xmit function
  net: smsc: fix return type of ndo_start_xmit function
  net: ti: fix return type of ndo_start_xmit function
  net: faraday: fix return type of ndo_start_xmit function
  net: ovs: fix return type of ndo_start_xmit function
  net: xen-netback: fix return type of ndo_start_xmit function
  net: caif: fix return type of ndo_start_xmit function
  net: hamradio: fix return type of ndo_start_xmit function
  usbnet: ipheth: fix return type of ndo_start_xmit function
  hv_netvsc: fix return type of ndo_start_xmit function
  can: xilinx: fix return type of ndo_start_xmit function
  net: plip: fix return type of ndo_start_xmit function
  rionet: fix return type of ndo_start_xmit function
  l2tp: fix return type of ndo_start_xmit function
  net: hsr: fix return type of ndo_start_xmit function

 drivers/net/caif/caif_hsi.c                           | 10 +++++-----
 drivers/net/caif/caif_serial.c                        |  7 +++++--
 drivers/net/caif/caif_spi.c                           |  6 +++---
 drivers/net/caif/caif_virtio.c                        |  2 +-
 drivers/net/can/xilinx_can.c                          |  2 +-
 drivers/net/ethernet/apple/bmac.c                     |  4 ++--
 drivers/net/ethernet/apple/mace.c                     |  4 ++--
 drivers/net/ethernet/apple/macmace.c                  |  4 ++--
 drivers/net/ethernet/cirrus/ep93xx_eth.c              |  2 +-
 drivers/net/ethernet/cirrus/mac89x0.c                 |  4 ++--
 drivers/net/ethernet/faraday/ftgmac100.c              |  4 ++--
 drivers/net/ethernet/faraday/ftmac100.c               |  7 ++++---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c        |  3 ++-
 drivers/net/ethernet/freescale/fec_mpc52xx.c          |  3 ++-
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c |  3 ++-
 drivers/net/ethernet/freescale/gianfar.c              |  4 ++--
 drivers/net/ethernet/freescale/ucc_geth.c             |  3 ++-
 drivers/net/ethernet/i825xx/ether1.c                  |  5 +++--
 drivers/net/ethernet/i825xx/lib82596.c                |  4 ++--
 drivers/net/ethernet/i825xx/sun3_82586.c              |  6 ++++--
 drivers/net/ethernet/micrel/ks8695net.c               |  2 +-
 drivers/net/ethernet/micrel/ks8851_mll.c              |  4 ++--
 drivers/net/ethernet/seeq/ether3.c                    |  5 +++--
 drivers/net/ethernet/seeq/sgiseeq.c                   |  3 ++-
 drivers/net/ethernet/sgi/ioc3-eth.c                   |  4 ++--
 drivers/net/ethernet/sgi/meth.c                       |  2 +-
 drivers/net/ethernet/smsc/smc911x.c                   |  3 ++-
 drivers/net/ethernet/smsc/smc91x.c                    |  3 ++-
 drivers/net/ethernet/smsc/smsc911x.c                  |  3 ++-
 drivers/net/ethernet/ti/cpmac.c                       |  2 +-
 drivers/net/ethernet/ti/davinci_emac.c                |  2 +-
 drivers/net/ethernet/ti/netcp_core.c                  |  8 ++++----
 drivers/net/ethernet/wiznet/w5100.c                   |  2 +-
 drivers/net/ethernet/wiznet/w5300.c                   |  2 +-
 drivers/net/hamradio/baycom_epp.c                     |  3 ++-
 drivers/net/hamradio/dmascc.c                         |  4 ++--
 drivers/net/hyperv/netvsc_drv.c                       | 10 +++++++---
 drivers/net/plip/plip.c                               |  4 ++--
 drivers/net/rionet.c                                  |  3 ++-
 drivers/net/usb/ipheth.c                              |  2 +-
 drivers/net/xen-netback/interface.c                   |  3 ++-
 net/caif/chnl_net.c                                   |  3 ++-
 net/hsr/hsr_device.c                                  |  2 +-
 net/l2tp/l2tp_eth.c                                   |  3 ++-
 net/openvswitch/vport-internal_dev.c                  |  5 +++--
 45 files changed, 100 insertions(+), 74 deletions(-)

-- 
1.8.3.1


