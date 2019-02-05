Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59C5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28202080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o0vczFf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfBEMpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:45:30 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44966 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:45:30 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x15CjQPM121588;
        Tue, 5 Feb 2019 06:45:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549370727;
        bh=tegAcGr5jNT+pzfG2jbu6Xo+DepOFefepzxKS98iz7Y=;
        h=From:To:CC:Subject:Date;
        b=o0vczFf4jzs1XPZ8YtDQIxrJDuPzNUpKlqi3ID8P4cTK7DsZDLPK8gRpjRlBHKlJs
         ppwjF2rv6JzD69WG/OQTa9eM0XMxQuD2j/9EROxs9K7I82AY4VHssCU+bLTn+iyAF2
         WsyzXMtzz7V6oXd/BB1M3PVFr8ovjciCbUzsEGdY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x15CjQW5053425
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 06:45:26 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Feb 2019 06:45:26 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Feb 2019 06:45:26 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x15CjOVM012216;
        Tue, 5 Feb 2019 06:45:24 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <nm@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/3] arm64: ti: k3-am654: USB support
Date:   Tue, 5 Feb 2019 14:45:19 +0200
Message-ID: <1549370722-414-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The AM654 SoC supports 2 DWC3 USB controller instances. The
AM654 base board supports the 2nd (USB1) instance in high-speed.

This series enables support for USB1 instance on the AM654-base-board.

The series depends on [1] and [2]. Both are in the -next branch of their
respective maintainer trees.

To test you can apply on top of linux-next. As usb/next was just pushed
today, it might have not reached linux-next yet. If so please pull that from [3].

If using arm64 defconfig, you need to enable
	CONFIG_USB_DWC3_KEYSTONE=y
	CONFIG_OMAP_USB2=y
and the necessary USB drivers that you want to test. e.g. USB network adapter.

[1] AM654 USB2 PHY support https://lkml.org/lkml/2018/12/5/908
[2] AM654 DWC3 support https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1896101.html
[3] usb-next https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/log/?h=next

Changelog:
v2
- usb & phy nodes are not kept disabled in k3-am65-main.dtsi.
  Unused ones are disabled in board dts instead.

cheers,
-roger


Jyri Sarha (1):
  arm64: dts: ti: am654: Add Main System Control Module node

Roger Quadros (2):
  arm64: dts: ti: k3-am6: add USB support
  arm64: dts: ti: k3-am654-base-board: enable USB1

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 84 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 28 +++++++++
 2 files changed, 112 insertions(+)

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

