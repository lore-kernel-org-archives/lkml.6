Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30634ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B522083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B522083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJYXnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:43:07 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.210]:13072 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727454AbeJYXnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:43:05 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.us-west-2.aws.symcld.net id 74/F1-08862-0CCD1DB5; Thu, 25 Oct 2018 15:09:52 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRWlGSWpSXmKPExsXi5LtOQPfAnYv
  RBu1rFSx6z51ksph/5ByrxZWv79ksNm6+zWKxaupOFotNj6+xWnT9WslscXnXHDaLpdcvMlm0
  7j3CbvF3+yYWixdbxC1+7prH4sDrsWbeGkaPnbPusntsWtXJ5rH92wNWj/vdx5k8Ni+p99j4b
  geTR/9fA4/Pm+QCOKNYM/OS8isSWDO63zYyFqxnq7jzoYG9gfEJaxcjF4eQwGpGie8LzjNCOG
  sYJX7fPs4G4WxhlDj+s5Opi5GTg01AR2LK/sMsILaIQK7E7sc7wNqZBaYwSZz+tosNJCEs4C3
  xauMmZhCbRUBVovt6H1ADBwevgJvE1VMRIGEJATmJm+c6wUo4BdwlrkydzwpiCwGVLLj0jx3E
  5hUQlDg58wnYLmYBCYmDL14wQ9QoS2xZcYERYo6CxNoD55kmMArMQtIyC0nLAkamVYzmSUWZ6
  RkluYmZObqGBga6hoZGuobG5rrmhnqJVbrJeqXFuuWpxSW6RnqJ5cV6xZW5yTkpenmpJZsYgZ
  GWUtDpvoOxbWn6IUZJDiYlUd7ElIvRQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4k24D5QSLUtN
  TK9Iyc4AxD5OW4OBREuENA0nzFhck5hZnpkOkTjEqSonztoMkBEASGaV5cG2wNHOJUVZKmJeR
  gYFBiKcgtSg3swRV/hWjOAejkjDvPZApPJl5JXDTXwEtZgJaPEPhAsjikkSElFQDI5/XrVaFl
  Olxv1tmzlVI9ZFgkry24AB/l0qP+CLDZf9Xnt0U8X6RIp9DtIXjpkge4+BznyIjbdedLHrjVv
  RvbffUzfs9rIXnBx3quZ3+xZL111znFSmPK9xWPE2VtuXTvXLxzT2fWkVms8MKAtkTy163uCo
  v3+04T+CBc9ryii/K9v8PL349T4mlOCPRUIu5qDgRADF1IE8uAwAA
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-14.tower-365.messagelabs.com!1540480191!1259833!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16741 invoked from network); 25 Oct 2018 15:09:52 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-14.tower-365.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Oct 2018 15:09:52 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct 2018
 10:09:51 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH04.digi.com
 (10.10.8.198) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct
 2018 10:09:50 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 25 Oct 2018 17:09:49 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v1 3/4] ARM: imx_v6_v7_defconfig: Select TOUCHSCREEN_GOODIX
Date:   Thu, 25 Oct 2018 17:09:32 +0200
Message-ID: <1540480173-12009-4-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_TOUCHSCREEN_GOODIX so that we can have functional touch
screen by default on Digi International's AUO/Goodix LCD accessory kit used
with the ConnectCore 6UL SBC Pro (ccimx6ulsbcpro) board.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 7eca43ff69bb..d6e947307d67 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -170,6 +170,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_EGALAX=y
+CONFIG_TOUCHSCREEN_GOODIX=y
 CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_EDT_FT5X06=y
