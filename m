Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B051C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E534220652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FgJElBwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E534220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754332AbeFUASr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:18:47 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43255 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754139AbeFUASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:18:45 -0400
Received: by mail-qk0-f196.google.com with SMTP id s190-v6so821771qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 17:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UrzLg+6RVFpK6jwX9Scti/NOcxssuPIsruN42GlrMaw=;
        b=FgJElBwzvheflk/LOG1L/TJ2fgxbdxj75NE2wPUNrvP87yRu+u8uDYkesDDmaTQqzY
         +U9mkwh4q79PeaQ+YaieK0x7IjFaXPb+Al+ddjwfxxBTGoW/zJQLEq4W0MLAeVbIrgbz
         tooC+c6rCO7jM4/NVxb7Lb8scAzpvhgM+r3v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UrzLg+6RVFpK6jwX9Scti/NOcxssuPIsruN42GlrMaw=;
        b=TXjYGFxhAki5L/DCHFucV1Qi5luxa5mepfZtjmnrspBEtFKE5BmcFdZpxBRvSWqH7q
         937RZo0bGS4fVSdIRn4CykkPGSWIF6tYWYPi50xMnm8nD6MygQdpp3Ic8jDU1sLtMRSy
         5GiRfVLI9QN4zlW7fA9ZVxzzDfa9W6+D1f1G4/ck1B1sxgeRc8sn6Kgox3Z1M+uMdVLc
         7Kq5u+9n1EWUM/Vul+MY6i7t3hY/Shp+sKDcVimqsIl+P/TpT7eybyu8GdaXyGdlNK+5
         BGGYE6LSUqkR7xunyQPk+uc8ffJj4cd5s4eiXRogSr8cq+BRE1Qt1CgpI3zAxl02u8vU
         kFtQ==
X-Gm-Message-State: APt69E3cZixaq7U7k5Cug9vB7RmydEkSIQjmWajTuKvHnXpNBq5BwHMg
        XuGm7m855uTpQBHmbJoaCJQ6XA==
X-Google-Smtp-Source: ADUXVKJsgfC8fXBpm2eknRKGschQ1nZDgxXue2huh5EOwzf2Tc/G+eNOoAkaxma4uzlPfBe2rLd4/g==
X-Received: by 2002:a37:8705:: with SMTP id j5-v6mr19333512qkd.140.1529540325041;
        Wed, 20 Jun 2018 17:18:45 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t13-v6sm2778156qkt.53.2018.06.20.17.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 17:18:43 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 0/2] Add Broadcom Stingray PCIe PHY support
Date:   Wed, 20 Jun 2018 17:18:34 -0700
Message-Id: <1529540316-21706-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds PCIe PHY support for both PAXB and PAXC root complex in
Broadcom Stingray SOC

This patch series is based off v4.18-rc1 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-pcie-phy-v2

Changes since v1:
 - Rebase from v4.17-rc5 to v4.18-rc1

Ray Jui (2):
  dt-bindings: phy: Add binding doc for Stingray PCIe PHY
  phy: bcm-sr-pcie: Add Stingray PCIe PHY driver

 .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   |  39 +++
 drivers/phy/broadcom/Kconfig                       |  10 +
 drivers/phy/broadcom/Makefile                      |   2 +
 drivers/phy/broadcom/phy-bcm-sr-pcie.c             | 306 +++++++++++++++++++++
 4 files changed, 357 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-pcie.c

-- 
2.1.4

