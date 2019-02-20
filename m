Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E203C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4268220700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F/46hAzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfBTKeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:34:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33066 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:34:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id h11so9310261pgl.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 02:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LoXJbACm4qfpJVK0QcioZOmYMzbJaa02/fLx4G+wqrA=;
        b=F/46hAzy+34sl3xZayCBuuR45S2kedLKyv8f4jRWZe/kMpWcxPD1kMyYb588x2d2vI
         9SIKURdT9fkwhQTIfs/3HIPm2tGnZGceivjbt8sts7v31cE5z0T7bVnfZrxeW0cZpQTV
         IyNh214XvGR8l8mfOBirlemNsjRbdZPaJiNBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LoXJbACm4qfpJVK0QcioZOmYMzbJaa02/fLx4G+wqrA=;
        b=M/AOQyBHYcJ0TTpUEzKH7xQ1qZCPtovywAXw5vZQzl4+4XV6fi1QGjWp1BYKRanJBb
         qpFO7po+qRJMz/Cwt/5T0XpPDJU5dwH8oZplExEnrg8NDmO1dIkKfvnv43E+DMi4zV9E
         LEgtrCtQHO3uqNkJMjqSku4SnwZ9qLhGzBqw/EGB0dCI/VdYAWwwRrTLT7nRIHff2r64
         20kN+8OL9nYAe7XTsDgHLjIwIdp+DPovMw5ocqn6otsfvc2QdYlgTkoYrn0M0U464MAw
         OOVIVzPiodqMnP/DhCmCJY3EGpEGS4eIOIrLQKyzM2CMMoReGgK6j6fcd3+1v+wq6vZa
         3VrQ==
X-Gm-Message-State: AHQUAuaFBHNcUrYm1kEoKBGiRAcOKcdSNv5ku41OKBbQnMIkdxbSO/Lw
        22nHU3N8GZBuhZzpFHYHzMtDSA==
X-Google-Smtp-Source: AHgI3IYrZ5V3/Pz29IE9H1hw5qYTiencEKEK8aZsHS3dq2K5THujSu1XgO993BkxNPCtKDtqToQ0bA==
X-Received: by 2002:a62:138f:: with SMTP id 15mr34097963pft.219.1550658874522;
        Wed, 20 Feb 2019 02:34:34 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i71sm57426796pfi.170.2019.02.20.02.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 02:34:33 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 0/3] Stingray USB PHY driver support
Date:   Wed, 20 Feb 2019 16:03:59 +0530
Message-Id: <1550658842-19167-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add Stingray USB PHY driver and its corresponding
DT nodes with documentation.

This patch set is based on Linux-5.0-rc2.

Changes from v3:
  - Addressed Rob Herring review comments
     - Changed compatible strings.
     - updated driver based on new compatible strings.

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

