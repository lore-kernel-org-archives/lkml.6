Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA4AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE67320823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbByv07T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfBUPqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:46:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43818 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfBUPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:46:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so16699958wre.10;
        Thu, 21 Feb 2019 07:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grwC6F8sr2P6wH0qmFUinXdEXp0uA7VFQw6edDCnX8s=;
        b=pbByv07TK3LXe7RaFLLZSYFoyKgfBy1/EwZBqH5qj+sykrd8IrfgoKZtD6d5/b5JL2
         gYOZ5h3Sn5eD/PAZXiLrzbLTZBz65O3zdsLAxSB3ZmtmAM2RgncD0VvzO3P2DtaLQ4ma
         kjfeIAW8eZO70VFtfC6RDzXOPseyACW0glVKJYsJcsQIj/FdTHGV3XS8FrmZ83p6Llqq
         wsvJCEcbkIMfRgRru7bDqwcw+l/qkf73ZCG1iblEy+xWNkYPGAqDcnDVjjEa4tkA1DGq
         TXpIS4sRWSH0fz+689cdg42CvWVqyL178KbLafWzwCOId/xODJpLSZDq8x/6fEOUFjv5
         ifvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grwC6F8sr2P6wH0qmFUinXdEXp0uA7VFQw6edDCnX8s=;
        b=TUKJOpEZdMJs7ReW7IrRVzUtHPN6WwNxwN1b603OJty+jTd7I6k6Wfw1f9Sk3rkByo
         BPGnfBlJS7JV/hcg4hciRFSyQ9FKD6p2J574OBDWgnGa1u2cv1Itol232U6c+O+GqB4/
         u3gsCzVy5XXmVv2RxVB9U+6zBKkTYoSABr1G60vcFB1xzEBsoA3ydmitt5wTd/GCR5UZ
         D5TW2ZgDQmYMMSdHIYMbm2aGdnt8cg5GzmrhMeULlpswmUvQErMbDvKQy7x53ymZyXOu
         RtmsublGwQx4Vl91ArLfezGBe5pRH/22ZEVVGidI3mniz1SDUaW2tEclu0frj0jI2wR9
         DBwQ==
X-Gm-Message-State: AHQUAuZBe1LD6Q1C45wt7g69qVStiW+ocj2D/Ea6nR93dOs2ZpX1AVem
        7jnZeBL9G3n/vmFC5BsJo/I=
X-Google-Smtp-Source: AHgI3Ia310xWNlHYgOXpCvIkKImsvcjzzzK0jJ9UuXTBK/cHlrEVjGR2ICLA1CVkxJdjbTth4bqqsw==
X-Received: by 2002:a5d:6b43:: with SMTP id x3mr9394055wrw.76.1550763995843;
        Thu, 21 Feb 2019 07:46:35 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id z15sm31898974wrh.18.2019.02.21.07.46.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:46:35 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] phy: tegra: xusb: Add Tegra186 support
Date:   Thu, 21 Feb 2019 16:46:29 +0100
Message-Id: <20190221154634.10684-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This series adds support for Tegra186 to the XUSB pad controller driver.
Patch 1 extends the device tree bindings with support for Tegra186 while
patches 2-4 are preparatory work for the final patch 5 that adds the
Tegra186 specific programming for the UPHY blocks.

Changes in v2:
- address review comments from Kishon
- added Reviewed-by tags from JC

Thierry

JC Kuo (2):
  phy: tegra: xusb: Skip single function lane programming
  phy: tegra: xusb: Add Tegra186 support

Thierry Reding (3):
  dt-bindings: phy: tegra: Add Tegra186 support
  phy: tegra: xusb: Parse dual-role mode property
  phy: tegra: xusb: Add support for power supplies

 .../phy/nvidia,tegra124-xusb-padctl.txt       |   9 +
 MAINTAINERS                                   |   5 +
 drivers/phy/tegra/Makefile                    |   1 +
 drivers/phy/tegra/xusb-tegra186.c             | 899 ++++++++++++++++++
 drivers/phy/tegra/xusb.c                      |  67 +-
 drivers/phy/tegra/xusb.h                      |  35 +
 6 files changed, 1014 insertions(+), 2 deletions(-)
 create mode 100644 drivers/phy/tegra/xusb-tegra186.c

-- 
2.20.1

