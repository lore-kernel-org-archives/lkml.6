Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437D5C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67B8224D8
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T56eiq5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67B8224D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeGGASt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:18:49 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45465 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753743AbeGGASr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:18:47 -0400
Received: by mail-qt0-f194.google.com with SMTP id y5-v6so11337251qti.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mKC9uPoRX+Zp4qFrqcEdrE7ELJiAJsTIzAH4jy+BtW8=;
        b=T56eiq5BZcPCKfhyR8Q/XsRqCwE7fBL7QDxTenpTYpSywtGApUX3/IToaaLyNwvJyP
         Plz1N6oaK2qYlX3BpFjG3Y726jnWDdlir+Fd84o10m6/w+digUMqPjhjp4+mr+fXYDeO
         7km08yuWt/76lSAEYf0v5BfiVzUXyf/MkFGtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mKC9uPoRX+Zp4qFrqcEdrE7ELJiAJsTIzAH4jy+BtW8=;
        b=jbBsVXXRwFWQ8yQnqsXDIL5Vq5KO0POalZ0URnUiTCzy/sT09G8nftRN1zj6g4qkJn
         95FJAjrmcqDW+HErqnK6M3NnL10MSEISBvP/qNmLH4jKvTAqWP0czTJQxB8bNEWLMl8i
         3UWcbd7IEFP/mJPayieyWFSa0SLAavv2C6iuEuVKbJumB0aahRTn/nzgBlxeMTZsDF6n
         0w03SLhsTAQ3cc3anC4CwjcZDCbm6DtCQNC6IL4JJR7NBiKxO/N8I0lav5G3Q68WCK0e
         0vzGo/+xfbSfQQws1te3bwLZLHfdec17xaB8Dz9HoBHOWIPLE4EdYuoHCH3H61O/A1BS
         jScw==
X-Gm-Message-State: APt69E3gSc544qaC1KViRhYnchrM2//urAlW7kWtSaFkQYyCrL/qQBje
        S6N2XuHrrRj67SSd9dM+4sl+MQ==
X-Google-Smtp-Source: AAOMgpetIO6h54hROxB3OheICPYJs5JorCWDt8cdJa/+11TTTU1GO1mxCdmhFmqJRzOe53l1Vs7T4w==
X-Received: by 2002:ac8:3fcd:: with SMTP id v13-v6mr10996209qtk.250.1530922726626;
        Fri, 06 Jul 2018 17:18:46 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m128-v6sm6385780qkd.33.2018.07.06.17.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 17:18:45 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 0/2] Add Broadcom Stingray PCIe PHY support
Date:   Fri,  6 Jul 2018 17:18:31 -0700
Message-Id: <1530922713-22964-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds PCIe PHY support for both PAXB and PAXC root complex in
Broadcom Stingray SOC

This patch series is based off v4.18-rc3 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-pcie-phy-v4

Changes since v3:
 - Add missing node unit address in binding document
 - Remove redundant dummy PHY callbacks in the driver
 - Other miscellaneous minor fixes based on feedback from Kishon

Changes since v2:
 - Add 'reg' property to the driver so it can access the PCIe SS PHY block
 - Rebase to v4.18-rc3

Changes since v1:
 - Rebase from v4.17-rc5 to v4.18-rc1

Ray Jui (2):
  dt-bindings: phy: Add binding doc for Stingray PCIe PHY
  phy: bcm-sr-pcie: Add Stingray PCIe PHY driver

 .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   |  41 +++
 drivers/phy/broadcom/Kconfig                       |  10 +
 drivers/phy/broadcom/Makefile                      |   2 +
 drivers/phy/broadcom/phy-bcm-sr-pcie.c             | 305 +++++++++++++++++++++
 4 files changed, 358 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-pcie.c

-- 
2.1.4

