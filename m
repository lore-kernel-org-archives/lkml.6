Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A6EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F29D2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F29D2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLKIFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:05:23 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:52615 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeLKIFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:05:22 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43DXYW0kmlz1r2RT;
        Tue, 11 Dec 2018 09:05:18 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43DXYV3gQJz1qrnH;
        Tue, 11 Dec 2018 09:05:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id tDFbJxOgN1JA; Tue, 11 Dec 2018 09:05:16 +0100 (CET)
X-Auth-Info: m4Vdig746e9hPkTThlBiw/MmVd7ai+5M3GBXVgsboPo=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 11 Dec 2018 09:05:16 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@cubietech.com, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v3 0/4] Add Actions Semi Owl family S700 I2C support
Date:   Tue, 11 Dec 2018 09:04:44 +0100
Message-Id: <20181211080448.24007-1-pn@denx.de>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Actions Semi Owl SoC family S700
I2C controller. S700 provides 4 I2C masters and with cubieboard7
2 (I2C0 and I2C1) are exposed.

Added pinctrl definition for I2C controllers in cubieboard7. This patch
depends on s700 pinctrl driver support (yet to be merged),
https://lkml.org/lkml/2018/11/19/514
https://lore.kernel.org/patchwork/patch/1012859/

Changelog in v3:
- re-ordering I2C and pinctrl nodes alphabetically in board DTS
- re-orderng of patch
- Typo and nitpick corrections 

Changelog in v2:
- Initial version https://lore.kernel.org/patchwork/patch/1011911/ only
added the I2C nodes using s900 compatible property. Now, new s700
compatiable string is added and used for S700
- Device tree bindings added with s700 compatible string
- pinctrl definition for cubieboard7

Parthiban Nallathambi (4):
  dt-bindings: i2c: Add S700 support for Actions Semi Soc's
  arm64: dts: actions: s700: Add I2C controller nodes
  i2c: Add Actions Semiconductor Owl family S700 I2C support
  arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1

 .../devicetree/bindings/i2c/i2c-owl.txt       |  4 +-
 .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
 arch/arm64/boot/dts/actions/s700.dtsi         | 40 ++++++++++++++
 drivers/i2c/busses/i2c-owl.c                  |  1 +
 4 files changed, 97 insertions(+), 1 deletion(-)

-- 
2.17.2

