Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BC9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7C822B26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c1kgtPd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7C822B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932925AbeGFV0J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:26:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58066 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932502AbeGFV0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:26:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w66LO51S123122;
        Fri, 6 Jul 2018 21:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=I5eRVOnQuSYM3D+/dkqWxDU4gCzgZJ8WAqOltPo2qkA=;
 b=c1kgtPd1QMYOuYfbdF8mHcor9I2WIqEo+EfmfHneMvWkdyT9yu00t1mgJde1iUPKUu2X
 /HVOCjdc+doB+JWf7nuPCVCJjog5f41KIKC0nrK6o+73OY+vktWjaZ+ZcdvazR7R3u7i
 G+SoEG5lffg3PARfhI0ISApB0BKmXNDa8gMJdnKUCuUOUJi0gHD7TfO4TcQOaTBuoiAf
 UdZpZRwx2Ej5AG3p/0mashZjRzXprxQoMuadt8q7ZZqV+7Ey3CqYPKPEGTPg6cIvWoTA
 SitE3XnptE4b6BZFlcDCx8uL38xHo/r975oXkVpLYPHwZ2AxALz91SS8tHISphto6iuO cw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k0dnju23k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jul 2018 21:25:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w66LPnVr023117
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 21:25:49 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w66LPmoV009428;
        Fri, 6 Jul 2018 21:25:49 GMT
Received: from userv0021.oracle.com (/10.11.23.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Jul 2018 14:25:48 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL 1/3] ARM: Keystone DTS update for v4.19
Date:   Fri,  6 Jul 2018 14:25:40 -0700
Message-Id: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8946 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=533
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807060241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.19

for you to fetch changes up to f7e8a182a41e791cca3d7a9e25adddf2908bddde:

  ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model (2018-06-29 15:57:27 -0700)

----------------------------------------------------------------
ARM: Keystone DTS updates for 4.19

 - K2G NIC drriver support
 - Enbale network support for K2G ICE and EVM boards
 - Hardware Ring driver support for k2hk, k2l and k2e socs
 - Add MMC supply for k2g EVM

----------------------------------------------------------------
Kishon Vijay Abraham I (2):
      ARM: dts: keystone-k2g-evm: Add "vqmmc-supply" property for mmc0/mmc1
      ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model

Murali Karicheri (3):
      ARM: dts: k2g: add dt bindings to support network driver
      ARM: dts: keystone-k2g-evm: Enable netcp network driver
      ARM: dts: keystone-k2g-ice: Enable netcp network driver

Vitaly Andrianov (3):
      ARM: dts: k2hk: add dts node for k2hk hw_rng driver
      ARM: dts: k2l: add dts node for k2l hw_rng driver
      ARM: dts: k2e: add dts node for k2e hw_rng driver

 arch/arm/boot/dts/keystone-k2e-netcp.dtsi  |  20 ++++
 arch/arm/boot/dts/keystone-k2g-evm.dts     |  63 +++++++++++++
 arch/arm/boot/dts/keystone-k2g-ice.dts     |  59 ++++++++++++
 arch/arm/boot/dts/keystone-k2g-netcp.dtsi  | 147 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi        |  25 +++--
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi |  20 ++++
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi  |  20 ++++
 7 files changed, 346 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/keystone-k2g-netcp.dtsi
