Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CE7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A282186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iGtMfqPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfBFRdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:33:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45941 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbfBFRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:33:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so3391963plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/h4vNK83R+HluP+28flvhaSsgaoq26HTeBxzyUbsFVo=;
        b=iGtMfqPLkiJnZLYzzKZElwrSNkEkbGhd9FiPZlpqbWoCpMdKTbfLnPqzZW+mpbCxVM
         a3usaSBHahZHDXf+2+owaakBxr2hUZ6BNaH3RLl3HGnIYR6Df+vi02a+O+WxKr7/YWVH
         FmXHhas/KdUws/UKMBTXMvhXFz/HQf8YExNWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/h4vNK83R+HluP+28flvhaSsgaoq26HTeBxzyUbsFVo=;
        b=tqBB2hC/GI7110q2pgneBT06zswZyxvGXe2y7a6dQtM/HbqnErbhaFfnLZhWvA2cAs
         TACxYR+OMqQFMKApNValXYhs5CjVovKmJjzGq416wf0D+CAC2p3moIyZnj+xigdw/0uT
         LLsTPej2ffpplAdBrel6RWhpSOtBq3hurcVIADkffNt3n+1ojI8ym/oCx8SNTOjbRgzh
         qGiuXw6hD9USR0h2B832xpZ8g37BAwECfeT9rIL06TZ089MlZP4sXPW7R82AQVaMhKP1
         ZRTP/sjI9/Jt386Ce5VR7grvTNXSbRkCKj4IZ1zGKaXh4iA+zp58DuX1z+ifc2BNxxGi
         3nZg==
X-Gm-Message-State: AHQUAubKwd8CS2TVpcku0sdR5xfVuTDn2ZY4oqMUq/d8Ol2Ae/yPqWEi
        UTm3JVbhPKOZb6BptB+fb6vf6g==
X-Google-Smtp-Source: AHgI3IYx3x4004EcRu/d/jvwA43wH1a/w2HFnh1i8ws3gyRsW58/k5xe8X2I+8ZbyuWOSkcS1+b29Q==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr11866040plt.85.1549474396760;
        Wed, 06 Feb 2019 09:33:16 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s6sm9270281pgo.4.2019.02.06.09.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 09:33:15 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 0/3] Stingray USB PHY driver support
Date:   Wed,  6 Feb 2019 23:02:24 +0530
Message-Id: <1549474347-7224-1-git-send-email-srinath.mannam@broadcom.com>
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

