Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532DBC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AF12080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gC24tWTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfBFPRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:17:05 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39148 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfBFPRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:17:05 -0500
Received: by mail-yw1-f65.google.com with SMTP id k188so3258491ywa.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/h4vNK83R+HluP+28flvhaSsgaoq26HTeBxzyUbsFVo=;
        b=gC24tWTb3wbrdF538Ay3vQ3eFxWFiTDK6OJUvWSRrqD6KL4E2PJ3ZdAsQmYCOmwU+y
         gkTCtHtEa98m3Lme5l0p/yZYl4weGsF/gLvB0NbTJ5GzOY/e2b9QyN/Qvu9jkIyzEYi/
         hZZAx9VNlhWixGBYstsSIgkvr+twRZjkgGJyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/h4vNK83R+HluP+28flvhaSsgaoq26HTeBxzyUbsFVo=;
        b=Zp811EcYe1rUrVnL+uIFpofK5sF77hZsLnQeHmZIltsawV5O5g7aY4tbSdou4NHyNh
         QbsXDoGVWHOaSHFpdnR0FwbFQYN59QHP0mf5kD2n19bn8CMKXYr+J42kRSsILPT9qCrD
         Q0TGwCNHCdbuO6b2nE4RdsQR/sRCiZKB3b98kY1BlvWoqIl6+cPoLgc3MSwthJ/8Oasg
         ubHdsU+flll/qS8qSbN9EMEkNYfoC9kATrA7IYmWQjOyvrYAdU2fVDXYLkHUtOS8B99p
         UwFPXKXYLHhH27uSUCaKekoYBXNgITl9V+CFKs8x2U6XGu7DJju3JTsyGwXbCBUxJyxc
         AJyA==
X-Gm-Message-State: AHQUAuZbn27D/UVTKqOskUdiSdeU589gg1ztIDVf03zRGltaqONtjX0S
        C0A9vok3SpSwyZjf7u8frfohnQ==
X-Google-Smtp-Source: AHgI3IYVUOZXPiyLEOvzVX6F+GedPkaIuh/rzBDTR689DiBSn6dkd08vk6WonJ1L4AznG3ivlfZ3Sw==
X-Received: by 2002:a81:28c3:: with SMTP id o186mr8576587ywo.309.1549466224009;
        Wed, 06 Feb 2019 07:17:04 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r124sm557617ywb.39.2019.02.06.07.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 07:17:02 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Jayachandran C --cc=devicetree @ vger . kernel . org" 
        <jnair@caviumnetworks.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 0/3] Stingray USB PHY driver support
Date:   Wed,  6 Feb 2019 20:46:44 +0530
Message-Id: <1549466207-3190-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add Stingray USB PHY driver and its corresponding
DT nodes with documentation.

This patch set is based on Linux-5.0-rc2.

Changes from v2:
  - Addressed Kishon review comments
  - Updated patchset to Linux-5.0-rc2

Changes from v1:
  - Addressed Kishon review comments
  - phy init call return value handle
  
Srinath Mannam (3):
  dt-bindings: phy: Add Stingray USB PHY binding document
  phy: sr-usb: Add Stingray USB PHY driver
  arm64: dts: Add USB DT nodes for Stingray SoC

 .../bindings/phy/brcm,stingray-usb-phy.txt         |  62 ++++
 .../boot/dts/broadcom/stingray/stingray-usb.dtsi   |  95 ++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   1 +
 drivers/phy/broadcom/Kconfig                       |  11 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm-sr-usb.c              | 371 +++++++++++++++++++++
 6 files changed, 541 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c

-- 
2.7.4

