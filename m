Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752718AbeDBOhv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:37:51 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:45653 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeDBOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:35:49 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [net-next PATCH v3 00/11] Add support for netcp driver on K2G SoC
Date: Mon, 2 Apr 2018 10:37:50 -0400
Message-ID: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K2G SoC is another variant of Keystone family of SoCs. This patch
series add support for NetCP driver on this SoC. The QMSS found on
K2G SoC is a cut down version of the QMSS found on other keystone
devices with less number of queues, internal link ram etc. The patch
series has 2 patch sets that goes into the drivers/soc and the
rest has to be applied to net sub system. Please review and merge
if this looks good.

K2G TRM is located at http://www.ti.com/lit/ug/spruhy8g/spruhy8g.pdf

Thanks

The boot logs on K2G ICE board (tftp boot over Ethernet)
is at https://pastebin.ubuntu.com/p/VQTv3c2XBS/

The boot logs on K2G GP board (tftp boot over Ethernet)
is at https://pastebin.ubuntu.com/p/6Vh55DW8vT/

Also regressed boot on K2HK and K2L EVMs as we have modified GBE
version detection logic.

This series applies to net-next master branch.

Change history:
  v3 - Addressed comments from Andrew Lunn and Grygorii Strashko
       against v2. 
  v2 - Addressed following comments on initial version
       - split patch 3/5 to multiple patches from Andrew Lunn

Murali Karicheri (11):
  soc: ti: K2G: enhancement to support QMSS in K2G NAVSS
  soc: ti: K2G: provide APIs to support driver probe deferral
  net: netcp: ethss: use macro for checking ss_version consistently
  net: netcp: ethss: make call to gbe_sgmii_config() conditional
  net: netcp: ethss: add support for handling sgmii link interface
  net: netcp: ethss: use rgmii link status for 2u cpsw hardware
  net: netcp: ethss: map vlan priorities to zero flow
  net: netcp: ethss: re-use stats handling code for 2u hardware
  net: netcp: ethss: use of_get_phy_mode() to support different RGMII
    modes
  Revert "net: netcp: remove dead code from the driver"
  net: netcp: support probe deferral

 .../bindings/soc/ti/keystone-navigator-qmss.txt    |   9 +-
 drivers/net/ethernet/ti/netcp.h                    |   2 +
 drivers/net/ethernet/ti/netcp_core.c               |  13 +++
 drivers/net/ethernet/ti/netcp_ethss.c              | 113 ++++++++++++++++-----
 drivers/soc/ti/knav_dma.c                          |   8 ++
 drivers/soc/ti/knav_qmss.h                         |   6 ++
 drivers/soc/ti/knav_qmss_queue.c                   |  98 ++++++++++++++----
 include/linux/soc/ti/knav_dma.h                    |  12 +++
 include/linux/soc/ti/knav_qmss.h                   |   1 +
 9 files changed, 212 insertions(+), 50 deletions(-)

-- 
1.9.1
