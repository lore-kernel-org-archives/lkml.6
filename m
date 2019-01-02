Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 05:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98080218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 05:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+ElXBWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfABFes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 00:34:48 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44723 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfABFes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 00:34:48 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so23728230iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 21:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xmHhJiiFU2UwX8Cy/78OBGqygh+HdqA99rjMrwCIJrQ=;
        b=l+ElXBWkXPfQcQ+Nx/KZmgRKoKYFvB/AyjBkybG5ZCIua1bc/cAtK9IUqSSI0y4cto
         st1+Nzi/wD1GfAIl4c5i+HekK8aN97yIUx0QSk6vVJrS2rey5PTbmNJ7YFMggylPtVaN
         6kzPcRWUA8voCpwURGw0x4XBJhy+bVNTyt+uTdsRtK99GmN9iab6q0R8ytPheqDufaoi
         GFn4rSfibl4C9IyZxNRCdiftiZ1wVahvVQOMNt512MEmHSWA7+uUTstU8UyLIVMGZXQo
         e0cti/JTwoPOV7/zC/NRKpYMnqcb0kQoy2UN58PARfVIEudhEWD7e7fHIF8D46UBzbn/
         U8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xmHhJiiFU2UwX8Cy/78OBGqygh+HdqA99rjMrwCIJrQ=;
        b=H14gI1Ci+rZXzI/Rx1q6zrZg++KX7G12f5yjVz6snz4EGX3VDIp7x7CkWCZlfvhHWv
         bwHhZ6er/XhAXAYPS934ibC78TqEVYfTJMblXYSj+HuQIcV0FkOlzJrNpA8+O9k9H2ho
         bkZ/ZFByh7Qu6PwvR2uwNI1tsURCMahFkabiikG7LnoQh5qAxm3egYoDlzMSJEb5McQy
         6cnk8U3nVIG/AEBMF13tjzpLnNytdv39qd787XnvwIcBwywQJzSVgJd4CqfHi0sGMpP+
         7uj6Lr3gCLOu4enqxkW01wZ7T04kAPpPk0k4aNrwRAoNBcmg7h6x6mgtGxL+VpXVKst8
         PkLw==
X-Gm-Message-State: AJcUukeuMTEs3R9BQKLG5AJmSN+lfpN8oMqWcgy/R7kU+DUGqkNN4jg+
        1qdHSRvqvWqzsW72lC1Q8wg5Ylpt9Wokd3QjVKgHzWuU
X-Google-Smtp-Source: ALg8bN71ybRKGYihVZr29MlYf9WN3nXTv//OkYxtHxU+AYlNoZQH+HPslCN0ix083qO53XM/DDfG4SiICvaiyujY928=
X-Received: by 2002:a6b:640d:: with SMTP id t13mr30177252iog.25.1546407286894;
 Tue, 01 Jan 2019 21:34:46 -0800 (PST)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 1 Jan 2019 23:34:36 -0600
Message-ID: <CABb+yY1ZO8pCuN4o3ja-Lyr0G6CVSUJfotcJcEmfJ9MHEAneSA@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v4.21
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit f5d582777bcb1c7ff19a5a2343f66ea01de401c6:

  Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid (2018-12-10
11:04:41 -0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.21

for you to fetch changes up to d69e11648e486ee0f21cb246f687b083f0d4e124:

  mailbox: tegra-hsp: Use device-managed registration API (2018-12-21
22:31:26 -0600)

----------------------------------------------------------------
- Introduce device-managed registration
devm_mbox_controller_un/register and convert drivers to use it
- Introduce flush api to support clients that must busy-wait in atomic context
- Support multiple controllers per device
- Hi3660: a bugfix and constify ops structure
- TI-MsgMgr: off by one bugfix.
- BCM: switch to spdx license
- Tegra-HSP: support for shared mailboxes and suspend/resume.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      mailbox: tegra-hsp: use devm_kstrdup_const()

Dan Carpenter (1):
      mailbox: ti-msgmgr: Off by one in ti_msgmgr_of_xlate()

Julia Lawall (1):
      mailbox: hi3660: constify mbox_chan_ops structure

Kevin Wangtao (1):
      mailbox: Hi3660: Fixup mailbox state machine malfunction issue

Mikko Perttunen (2):
      mailbox: Allow multiple controllers per device
      dt-bindings: tegra186-hsp: Add shared mailboxes

Stefan Wahren (1):
      mailbox: bcm2835: Switch to SPDX identifier

Thierry Reding (23):
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
      mailbox: Support blocking transfers in atomic context
      mailbox: tegra-hsp: Add support for shared mailboxes
      mailbox: tegra-hsp: Add suspend/resume support
      mailbox: tegra-hsp: Use device-managed registration API

 .../bindings/mailbox/nvidia,tegra186-hsp.txt       |  30 +-
 drivers/mailbox/arm_mhu.c                          |  12 +-
 drivers/mailbox/bcm-flexrm-mailbox.c               |   4 +-
 drivers/mailbox/bcm-pdc-mailbox.c                  |   4 +-
 drivers/mailbox/bcm2835-mailbox.c                  |  18 +-
 drivers/mailbox/hi3660-mailbox.c                   |  35 +-
 drivers/mailbox/hi6220-mailbox.c                   |  11 +-
 drivers/mailbox/imx-mailbox.c                      |   3 +-
 drivers/mailbox/mailbox-altera.c                   |  15 +-
 drivers/mailbox/mailbox-sti.c                      |  13 +-
 drivers/mailbox/mailbox-xgene-slimpro.c            |  11 +-
 drivers/mailbox/mailbox.c                          | 101 +++-
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  11 +-
 drivers/mailbox/omap-mailbox.c                     |   4 +-
 drivers/mailbox/platform_mhu.c                     |  12 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   3 +-
 drivers/mailbox/rockchip-mailbox.c                 |  15 +-
 drivers/mailbox/stm32-ipcc.c                       |   4 +-
 drivers/mailbox/tegra-hsp.c                        | 517 +++++++++++++++++----
 drivers/mailbox/ti-msgmgr.c                        |  15 +-
 include/dt-bindings/mailbox/tegra186-hsp.h         |  11 +
 include/linux/mailbox_client.h                     |   1 +
 include/linux/mailbox_controller.h                 |   9 +
 23 files changed, 612 insertions(+), 247 deletions(-)
