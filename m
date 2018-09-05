Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716C4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134EF2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gvEF+Z8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134EF2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeIEUvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:51:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37392 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEUvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:51:47 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w85GKP3H069880;
        Wed, 5 Sep 2018 11:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536164425;
        bh=UB8LIRggqceEEc01/qLVfGoEan/Q7wVVD+0QlLlyg5M=;
        h=From:To:CC:Subject:Date;
        b=gvEF+Z8qvo74gHLsahuNGAmBRBX+FxlvFJnsD+jMbgr3Qhuxm3SiFjF4C5aQ4oSNP
         RkkQZ/Ikg4iexrCwxMjTQqfSJVvVaZsrt0ke9djXjGDY8dQKWDYsSRntAdQQG5cXoR
         rowJI+1VzN+wfly09dKgvt8V49tsnx0m25bICcZ0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85GKP6D025472;
        Wed, 5 Sep 2018 11:20:25 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 5 Sep
 2018 11:20:25 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 5 Sep 2018 11:20:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85GKPdZ029050;
        Wed, 5 Sep 2018 11:20:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] arm64: dts: ti: am654: Enable additional nodes
Date:   Wed, 5 Sep 2018 11:20:21 -0500
Message-ID: <20180905162024.28243-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Series based on: v4.19-rc1 + https://patchwork.kernel.org/patch/10588769/
For v4.20

Boot log: https://pastebin.ubuntu.com/p/c5XGVp85bs/ (MMC is pending).
Boot log integrated with:
	https://patchwork.kernel.org/patch/10577731/ (uart Kconfig update)
	https://patchwork.kernel.org/patch/10577723/ (message manager Kconfig update)
	https://patchwork.kernel.org/patch/10577729/ (TISCI - in linux-next)
        https://patchwork.kernel.org/patch/10577727/ (TISCI - in linux-next)
	https://patchwork.kernel.org/patch/10577721/ (TISCI Clk Kconfig update)

Nishanth Menon (3):
  arm64: dts: ti: am654: Add uart nodes
  arm64: dts: ti: am654: Add secure proxy instance for main domain
  arm64: dts: ti: k3-am6: Add Device Management Security Controller
    support

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 41 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        | 18 ++++++++++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi     | 46 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi            | 10 ++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts |  5 +++
 5 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi

-- 
2.15.1

