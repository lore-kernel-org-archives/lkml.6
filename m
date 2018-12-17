Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F17C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9078C2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO8+exGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbeLQPCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:02:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37112 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733109AbeLQPCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:21 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so11015965edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ev3GTT5E4Yb9mnqV0ZG7wNOtALXW+dJ8C54g8xdUNk=;
        b=hO8+exGAwbQEFdJvjmQMDMGKHRRnzc0wY7p9AD8cqqXEJ2/PyJ4hYaNxhayEdQDWP2
         LzZxwWi06bKOWaEwcwhLa7o8lZDPXuxigmgPV7rBTbq5LH1lXAURx+9NU2LfU7l8g4vB
         CK3TTsyLlXcLnrOSOi+QTviTE59HxPA4f8VopRP64EvdIhDcHHUauhqflw9hPdL/A2ee
         hUtqmB7h2c+L+o1kKFg44Q61sXLA7QW2cWz0fiFJB5iAbF5ZDQx0wCdNNuKBhlvc74Hu
         ZulC6YatE0JiJSGTiVt39+JeKplKcn3Uxva6kc1Nc1+Sw4ETHP2ni7E21JJ6kv+GnVKp
         T5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ev3GTT5E4Yb9mnqV0ZG7wNOtALXW+dJ8C54g8xdUNk=;
        b=jYUYZqNbSUdV6DXn0biE57ujRuBMuzYd9teUA9vlErB6/GHMfVZ0TUYd0dlw77vgeJ
         UVC1Ob5BwAxS8d3uyJ4avH7aw5yUb7zuWlxlmTF0t0rOthQ4nDUWzN2gr7XOMciA6VVP
         SEBbTniFe8YuloOGziezOvxpgBDpEM8g6uvYKd8ulRDUC/UMFMxgrzogX1RO7bd1zDui
         RXCz/L6/Og9Q01xhMoze59Wo+zkqDUGorU1th7Gy6GZQoHylNM5mHlAYPP+kjvYwbFM1
         OwIXNKf5rL8PTrQd+k6KWkgmGLFlkRx4avncD96WwqVfVJv3n8AQ1Y3eAkasKnbnn+P2
         UQ1g==
X-Gm-Message-State: AA+aEWYhQ3dPGLx+M3D1SQxnD6tyVN6TvdbuPEKfGsHnRAajq3kx2I+j
        sRwOqL6F2jJd6e2+qsri9mU=
X-Google-Smtp-Source: AFSGD/VhuoYBCrdKz5pmpneWQ/DQqJqXbghS6a0FDgIZLaP7YhzdWBiVu3+dMHZYu2x20u7x76qnnw==
X-Received: by 2002:a17:906:798e:: with SMTP id c14-v6mr4596910ejo.123.1545058939928;
        Mon, 17 Dec 2018 07:02:19 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id r51sm3960343eda.64.2018.12.17.07.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:18 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gospodarek <gospo@broadcom.com>,
        Anup Patel <anup.patel@broadcom.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caesar Wang <wxt@rock-chips.com>, CK Hu <ck.hu@mediatek.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, Duc Dang <dhdang@apm.com>,
        Eric Anholt <eric@anholt.net>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Feng Kan <fkan@apm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Jon Mason <jon.mason@broadcom.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        Lee Jones <lee.jones@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Ley Foon Tan <lftan@altera.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ray Jui <ray.jui@broadcom.com>,
        Rob Rice <rob.rice@broadcom.com>,
        Ruyi Wang <wangruyi@huawei.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Steve Lin <steven.lin1@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v2 00/19] mailbox: Device-managed registration
Date:   Mon, 17 Dec 2018 16:01:58 +0100
Message-Id: <20181217150217.32435-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

This series of patches adds device-managed registration functions for
mailbox controllers. A number of drivers can be simplified by making use
of this new API both in the error cleanup paths in their probe functions
and in the driver remove implementation.

In addition to adding the new API this series converts all drivers to
use it. There is also an additional cleanup patch for the mtk-cmdq
driver that removes some calls to devm_kfree() that are not needed.

Thierry

Thierry Reding (19):
  mailbox: Add device-managed registration functions
  mailbox: arm-mhu: Use device-managed registration API
  mailbox: bcm2835: Use device-managed registration API
  mailbox: bcm-flexrm: Use device-managed registration API
  mailbox: bcm-pdc: Use device-managed registration API
  mailbox: hi3660: Use device-managed registration API
  mailbox: hi6220: Use device-managed registration API
  mailbox: imx: Use device-managed registration API
  mailbox: altera: Use device-managed registration API
  mailbox: sti: Use device-managed registration API
  mailbox: xgene-slimpro: Use device-managed registration API
  mailbox: mtk-cmdq: Use device-managed registration API
  mailbox: mtk-cmdq: Remove needless devm_kfree() calls
  mailbox: omap: Use device-managed registration API
  mailbox: platform-mhu: Use device-managed registration API
  mailbox: qcom-apcs: Use device-managed registration API
  mailbox: rockchip: Use device-managed registration API
  mailbox: stm32-ipcc: Use device-managed registration API
  mailbox: ti-msgmgr: Use device-managed registration API

 drivers/mailbox/arm_mhu.c               | 12 +----
 drivers/mailbox/bcm-flexrm-mailbox.c    |  4 +-
 drivers/mailbox/bcm-pdc-mailbox.c       |  4 +-
 drivers/mailbox/bcm2835-mailbox.c       | 10 +---
 drivers/mailbox/hi3660-mailbox.c        | 11 +---
 drivers/mailbox/hi6220-mailbox.c        | 11 +---
 drivers/mailbox/imx-mailbox.c           |  3 +-
 drivers/mailbox/mailbox-altera.c        | 15 +-----
 drivers/mailbox/mailbox-sti.c           | 13 +----
 drivers/mailbox/mailbox-xgene-slimpro.c | 11 +---
 drivers/mailbox/mailbox.c               | 70 +++++++++++++++++++++++++
 drivers/mailbox/mtk-cmdq-mailbox.c      | 11 +---
 drivers/mailbox/omap-mailbox.c          |  4 +-
 drivers/mailbox/platform_mhu.c          | 12 +----
 drivers/mailbox/qcom-apcs-ipc-mailbox.c |  3 +-
 drivers/mailbox/rockchip-mailbox.c      | 15 +-----
 drivers/mailbox/stm32-ipcc.c            |  4 +-
 drivers/mailbox/ti-msgmgr.c             | 13 +----
 include/linux/mailbox_controller.h      |  5 ++
 19 files changed, 92 insertions(+), 139 deletions(-)

-- 
2.19.1

