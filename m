Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5235C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745E5217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNnMLjbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbeLTRUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44725 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeLTRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so2373802edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NoW84sHcpZ3hWCRY1pN/YEtZ+PH1m/Vupg4+oZVMAU4=;
        b=dNnMLjbCJ7r5+4EECmbZMq4t2gTe9efmtPBHZlsRqfp4XkSl29QgDooN6fxGLFrpJ7
         llsVEgWSGZcE4sG2R99YhPOGxa5cTl9rNGlvPxBs63ZTS19rg6ZiHWN2RozHI3juofUG
         rA2/ZnsQd3MeEMXITS6y48nNuAJioUKwkKmIXZMT55HvHKfeob0kRtjTWC4RdaVLUH5/
         AHJcuIPpovpwNj7eiNt8Z0+AwUPAe1Bjb5G6Ml1GzmYKy8GHDDT9nRDAWeZnx5A4zKGP
         Ma/ZFf0XbXLyb2c50twYrxlLAUzPk5ui38lYjHrBrYT3DBsnHHrKQJZ8m1JtVfwtFjsm
         MqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NoW84sHcpZ3hWCRY1pN/YEtZ+PH1m/Vupg4+oZVMAU4=;
        b=c3QKkGENrFEvE2KGAMWxt5uKtXuxBiI39EONXe7Q7SIcdcTu2m8lt9g5X2uLDpiZQz
         VjOy4um/DaVjFITWawY+GFClNgWCJdpOYbcSFU1uQFiXRkVuKQZeOTc5o2KrU805ZDya
         lY+26Bie+9Cg8ezC8w8HHqRg00f53YrV+xQS0xvt0AJLzKLg2N+BeO1KouEFJ9HhEw5R
         lSTr2v/+YWY9WqCqVpPU3xG8wid1NfzVCRZthEDYlcC3r1iawLlRXk9Ui8Ikk1IgYYFY
         u4ODkdhI1DZ7LJo8dea+Shdz+fgA8JZubR/4jCNWcEiFW5iS+LJcUkYTDGWOo9Bn2Gcq
         aaNQ==
X-Gm-Message-State: AA+aEWaHqZIRfT+UWxUhJ9QJhiM8WkKZfNsJCiq1s1bxgvSlDn2X5rYL
        42Y2q9yKllaO557+HMKDHGU=
X-Google-Smtp-Source: AFSGD/UHPMWI0wXugoDgL16GupRZe1z5oWFRPWiYdU9Vg6n69cUpoCwWlqRXTJgYbOHX/S1Jj14MxQ==
X-Received: by 2002:a17:906:1102:: with SMTP id h2-v6mr10900008eja.18.1545326404790;
        Thu, 20 Dec 2018 09:20:04 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id v14sm5930689edq.74.2018.12.20.09.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:03 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gospodarek <gospo@broadcom.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caesar Wang <wxt@rock-chips.com>, CK Hu <ck.hu@mediatek.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Eric Anholt <eric@anholt.net>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
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
        Scott Branden <scott.branden@broadcom.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v3 00/19] mailbox: Device-managed registration
Date:   Thu, 20 Dec 2018 18:19:43 +0100
Message-Id: <20181220172002.9016-1-thierry.reding@gmail.com>
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

Changes in v3:
- fix the level of indirection in the device-managed pointer
- fix a build error in the OMAP mailbox driver

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

