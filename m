Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB70C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8AC214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9udGMxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8AC214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbeKVB3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35258 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeKVB3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so5133701edx.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ev3GTT5E4Yb9mnqV0ZG7wNOtALXW+dJ8C54g8xdUNk=;
        b=a9udGMxM8J8ik0kNYiQ0ZLXMclgDJVYlkO/xYesGfDtLeSIMSS1BAtNG8X3LbX1JMw
         kkP1lvpKvs9JLrCP7eUeK9Gf7VWEr6/o44NwM1glyEcBMtQJ0iVdyHADTQWwAm0U6PgP
         Xtk1xnP/Wczo72VBC2cOfN9rnXlP787W18atr2Qwk9KsteeMeSWAv3EZWBN8IoeoVhwv
         Zf0t1jGJGh9qQoWrhxZVKGJ9R+z0ol3xv9RT4Wl9fk0JRmxerjNdkZnwaGY8Jyh3KSyZ
         26Cn4TDZNkEwn92mgQJAzMb+gU/3jBL4DxWAkP/sskjQrtm8GbpWboGaWwUySaAJpzk9
         5Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ev3GTT5E4Yb9mnqV0ZG7wNOtALXW+dJ8C54g8xdUNk=;
        b=K1MTA1eeK0CDTwozz3pVkJ5FywQk291I7FXuQTTYKLo61janutEu1X/qQkJF3SDm9C
         531JfMiIzLvkM05JasIFGZXhoFkn1q074PUyIjD2A1fLwWkQvLLhwdduoDKgtegw0tZZ
         SJoQHZdzOj5AVxYCf3WvLkfwgsnyy2TwLjLDqdt0ZG0y9Gl58oMG8rnYYCcpir6khdqE
         EJGjFya0coWbskb7K8s778b2YjdTJh0CnDJYDQl/gDJhRrFAWQjftgBcjhQOjZnQGlZf
         22kbMBCXuQnWFVqbA+jFfm9PS29iL37VSI3GGmGyH1mfo+5mcRfv17KLoLH7GceQvFfH
         5MHA==
X-Gm-Message-State: AA+aEWb/1e1xWDTGXsuaaB8l6NLPtVdqdW6BU+V8iJQCSv4HCDrQ967V
        nJqif7epeC5EPoTQtK7NG1wQP766
X-Google-Smtp-Source: AFSGD/Vqov/jgSItgeyWuuVmUcjD6Sa9w+qHmj5e9+1x0HQIlG1D/ghax7nwub68BtKZftiGfQjvZQ==
X-Received: by 2002:a50:8163:: with SMTP id 90mr6039514edc.174.1542812070864;
        Wed, 21 Nov 2018 06:54:30 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id c11-v6sm5650397ejz.70.2018.11.21.06.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:30 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 00/19] mailbox: Device-managed registration
Date:   Wed, 21 Nov 2018 15:54:10 +0100
Message-Id: <20181121145429.7582-1-thierry.reding@gmail.com>
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

