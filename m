Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DBCC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F762083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F762083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeJYXnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:43:04 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.211]:12900 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727465AbeJYXnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:43:03 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.us-west-2.aws.symcld.net id C6/D1-11344-8BCD1DB5; Thu, 25 Oct 2018 15:09:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRWlGSWpSXmKPExsXi5LtOQHf7nYv
  RBr2TzC16z51ksph/5ByrxZWv79ksNm6+zWKxaupOFotNj6+xWnT9WslscXnXHDaLpdcvMlm0
  7j3CbvF3+yYWixdbxC1+7prH4sDrsWbeGkaPnbPusntsWtXJ5rH92wNWj/vdx5k8Ni+p99j4b
  geTR/9fA4/Pm+QCOKNYM/OS8isSWDO+zhIumMhZcWfOb+YGxovsXYxcHEICqxglJvVMYIZwtj
  BKXO/bwdrFyMnBJqAjMWX/YRYQW0QgV2L3Y5A4FwezwBQmidPfdrGBJIQFYiX2PD8G1sAioCr
  x4ek7sAZeATeJ7dv2gdkSAnISN891MkPEBSVOznwCFmcWkJA4+OIFWFxIQFliy4oLjBD1ChJr
  D5xnmsDIOwtJyywkLQsYmVYxmiUVZaZnlOQmZuboGhoY6BoaGukaGlvoGuslVukm65UW65anF
  pfoGukllhfrFVfmJuek6OWllmxiBEZHSkEX8w7GDyvSDzFKcjApifImplyMFuJLyk+pzEgszo
  gvKs1JLT7EKMPBoSTByw6MNiHBotT01Iq0zBxgnMKkJTh4lER4z90GSvMWFyTmFmemQ6ROMSp
  KifO2gyQEQBIZpXlwbbDUcIlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO8SkCk8mXklcNNf
  AS1mAlo8Q+ECyOKSRISUVAOj9jruo76zmi8zdpguYctfcdM3alLj9luiEyIiDvLnvbp+U2+Sp
  4uev0eQgNWDyP//vyTrcdyflflXrN/Sah338nm+EZJPDnyUfL/7dnJtxrvbXX//vbCsVC8qqj
  p3+fe0RLOrm8RWKvzsiLI/UGBeKJXzcrP0mbMzLZoz12hvS5+7bfakXDUmJZbijERDLeai4kQ
  AAOAFJAgDAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-10.tower-365.messagelabs.com!1540480182!1262224!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 336 invoked from network); 25 Oct 2018 15:09:43 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-10.tower-365.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Oct 2018 15:09:43 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct 2018
 10:09:42 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 25 Oct 2018 17:09:40 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v1 0/4] ARM: dts: ccimx6ulsbcpro: Add 10" AUO/Goodix LVDS panel accessory kit
Date:   Thu, 25 Oct 2018 17:09:29 +0200
Message-ID: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a LVDS panel accessory kit consisting of:

* AU Optronics G101EVN010 10.1 inches TFT-LCD display
* Goodix GT911 capacitive touch controller

This is used with the ConnectCore 6UL SBC Pro (ccimx6ulsbcpro) board.

Changes in v1 from initial changeset [1]:

* Split configuration change into a different commit
* Provide meaningful commit messages
* Use the new DRM mxsfb driver for the AUO G101EVN010 panel

[1] https://lore.kernel.org/lkml/1540204399-12982-1-git-send-email-alex.gonzalez@digi.com/

Alex Gonzalez (4):
  drm/panel: simple: Add AUO G101EVN010 panel support
  ARM: dts: ccimx6ulsbcpro: Enable AUO G101EVN010 lcdif panel
  ARM: imx_v6_v7_defconfig: Select TOUCHSCREEN_GOODIX
  ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch controller

 .../bindings/display/panel/auo,g101evn010          | 12 +++++++
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts        | 37 ++++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |  1 +
 drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++
 4 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g101evn010

