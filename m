Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75826C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8FA2089D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AO7nQLeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8FA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeGDSW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:22:27 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34989 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbeGDSWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:22:25 -0400
Received: by mail-qt0-f194.google.com with SMTP id z6-v6so5196653qti.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A8n55K+Itwh/yOsA89nj1JYQlfMBVZ9ktO1PsIoRMPg=;
        b=AO7nQLegFs++aLLDvmbqQLqMzNFwhav4VxyZpT/1llZ3Ywffqtb6mtvUvEn0eujUXL
         Hle5twxDQMRIYaSm/abmUlTwDpicUvZEoVHlUhSK/Es2C+UfjZzMjhkZXOMi0GvLDb+a
         A/q0GAQDxdxgSoxKNO/UOjjD7YQzTKnsv1k9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A8n55K+Itwh/yOsA89nj1JYQlfMBVZ9ktO1PsIoRMPg=;
        b=OWJs9NfI+2KI80Qs4CVDZFPidv5zeI/sAHGMp3vSKY6MLnlEF8717Ywo+R/mPgVXSr
         eX7Yh/j+t9DO2TsBpTvlUd873MgGKKBwQUz9uR9rJAgEL3/6oR9Vh6SkD3TYDPGoGRiU
         Y4OBAF+tVQXZrQOtAnSViyUIQWquwVyqXxcLHokIe0LWvuDlNbf4ua0n67jfPycaIStX
         OI1wpj6IXroK8hDEV8WLDn5JI3eNmkICoayBrsKLbaAjZ8eGLW0qDsCVSSETK9u/4FXI
         I5he1yGdRlTSX5z99PwoQzXlELcHiXesEh7MXeyfKJj6yUFXerFGM7BR5xDsx6bcrEwK
         6TYw==
X-Gm-Message-State: APt69E2tWhJzkvV13Z2YVAal709r/rlhk7gma59zASoOo3NPo/P599Z2
        w8hzZ1RbveuY42SDtAMUvB/0SA==
X-Google-Smtp-Source: AAOMgpdz658C5Ln8S0yHPe+kN9OxYRxNlV9CIXh5+iruKAXxxusXCfA0ImGFBv4u8ul6ea4skwi+wg==
X-Received: by 2002:a0c:c90d:: with SMTP id r13-v6mr2561856qvj.45.1530728544633;
        Wed, 04 Jul 2018 11:22:24 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p56-v6sm3485249qtc.7.2018.07.04.11.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 11:22:23 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v3 0/2] Add Broadcom Stingray PCIe PHY support
Date:   Wed,  4 Jul 2018 11:22:11 -0700
Message-Id: <1530728533-28770-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds PCIe PHY support for both PAXB and PAXC root complex in
Broadcom Stingray SOC

This patch series is based off v4.18-rc3 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-pcie-phy-v3

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
 drivers/phy/broadcom/phy-bcm-sr-pcie.c             | 327 +++++++++++++++++++++
 4 files changed, 380 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-pcie.c

-- 
2.1.4

