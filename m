Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91687C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4318126E4B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrLyFmUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4318126E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753401AbeF1FmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:42:24 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33559 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeF1FmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:42:22 -0400
Received: by mail-qt0-f193.google.com with SMTP id l10-v6so3752261qtj.0;
        Wed, 27 Jun 2018 22:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N2+JlZ43j4xwBEumYH+DAjbKiCc6nuAzavgiVMbvVJg=;
        b=DrLyFmUXtQ3dIktuMqx5PlvPlQWejSGCPciCFrKSYcoI/jfs5LRLDoUfnyzEc0OUPl
         i2dHUNeKhc8X1XbzsuXsO1eq4bJs+E7l5wTDIAmAimNKydxUKUqBw5CHMtk3BFrewkL3
         wKAl5G7kXfqDgoUmkxHiEaO52PE7tzXy3r6XsXT6EU5MlInduYHskxBKJrMBDsNWodDv
         3zloYBsKn18K7Rt94jdopFrUdbWRIAwb/M0cXDI95CyGlYElTh7gWVijgX6UqYXueyeA
         Wk9TbIFwl1r9msmv8/j8LPUZPM3fHbETiIg9PTtZK/yE8S5LRpWnFxfEMd1+RmWTtXBg
         U2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N2+JlZ43j4xwBEumYH+DAjbKiCc6nuAzavgiVMbvVJg=;
        b=rE0E91VLUExEpYi86EKHr+scyhR5nxsyVRv9gj03D85xN2I2epUb4NZfv6V3p1NCDF
         g7etCUtDgZ0X+LNjrRXfBOw+UO0ybATAd0h1JbRQvhy7PwIy+gAskAViTIbjXaQzm9X+
         NknmYvsZXPCNO3nEQG5GMyYLzVUeOaHFHe8uM3BXOyMFseTfe7QDoprGLfgx5efOdLlW
         bOgL/69WDUBd6p1bsE7IaT8HSCZMd9N1oa6eCa4n9E70Bv96YGvJ86iGdIyA4ipsWPSw
         UAq9s7d/37BxRdDlHen2BQ83cd9RMmHiJ0vt39uL96SuvdmVelhnMvMOI8WGE2Qg3xXC
         zB+g==
X-Gm-Message-State: APt69E08YgX3PJhJfdlfz9O7he5mZTVudIe+l2YnYeMlr6XQsqe3TzPq
        IQPYa91o9QQzzSbs51RF06E=
X-Google-Smtp-Source: AAOMgpdqZc/bi6rP5bm95bP29Hljt2winMlPYwVZM88qOm9wCeQr29PSW6Vd7PcyGTG3cHkoUPAgQg==
X-Received: by 2002:aed:3dcb:: with SMTP id j11-v6mr7999121qtf.357.1530164542226;
        Wed, 27 Jun 2018 22:42:22 -0700 (PDT)
Received: from localhost.localdomain (186-106-135-170.baf.movistar.cl. [186.106.135.170])
        by smtp.gmail.com with ESMTPSA id u40-v6sm3410281qth.24.2018.06.27.22.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 22:42:21 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [RFC PATCH 0/5] arm: dts: zynq: improvements and cleanup
Date:   Thu, 28 Jun 2018 01:42:00 -0400
Message-Id: <20180628054205.17737-1-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to standardize device naming and improve
its information for better identification

The values of the "compatible" and "model" device-tree properties
are corrected for some devices, adding complementary information
when necessary

Additionally, a device-tree file is renamed to reflect the real model
of the device

I'm sending the series as an RFC because I don't know if
device-tree files can be renamed and properties be changed
(the last patch in particular)

The patches are sorted (descending) by what I think is
the probability of being accepted

Luis Araneda (5):
  arm: dts: zynq: Set correct manufacturer for ZedBoard and MicroZed
    boards
  dt-bindings: xilinx: Add missing zynq boards
  arm: dts: zynq: correct and improve the model property of dt files
  arm: dts: zynq: rename board zed to zedboard
  arm: dts: zynq: remove "zynq" prefix from compatible property

 .../devicetree/bindings/arm/xilinx.txt        | 34 ++++++++++++++-----
 arch/arm/boot/dts/Makefile                    |  2 +-
 arch/arm/boot/dts/zynq-cc108.dts              |  4 +--
 arch/arm/boot/dts/zynq-microzed.dts           |  4 +--
 arch/arm/boot/dts/zynq-parallella.dts         |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts              |  4 +--
 arch/arm/boot/dts/zynq-zc706.dts              |  4 +--
 arch/arm/boot/dts/zynq-zc770-xm010.dts        |  4 +--
 arch/arm/boot/dts/zynq-zc770-xm011.dts        |  4 +--
 arch/arm/boot/dts/zynq-zc770-xm012.dts        |  4 +--
 arch/arm/boot/dts/zynq-zc770-xm013.dts        |  4 +--
 .../dts/{zynq-zed.dts => zynq-zedboard.dts}   |  4 +--
 arch/arm/boot/dts/zynq-zybo-z7.dts            |  4 +--
 arch/arm/boot/dts/zynq-zybo.dts               |  4 +--
 14 files changed, 50 insertions(+), 32 deletions(-)
 rename arch/arm/boot/dts/{zynq-zed.dts => zynq-zedboard.dts} (89%)

-- 
2.18.0

