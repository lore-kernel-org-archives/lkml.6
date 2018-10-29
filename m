Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6410BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C4C2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svBx3mWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C4C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbeJ2O6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 10:58:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43901 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeJ2O6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 10:58:54 -0400
Received: by mail-io1-f65.google.com with SMTP id y10-v6so4211841ioa.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 23:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6Wh6N2Vh+R1DFbztUcVSrYCOpuo0Cej4u3l6a8H1ImM=;
        b=svBx3mWeBiz2tgs6G7qF65y0CNUS8mUvUKYKDys0wUkkW6fOeB+UkiYy55HcZJr2Ez
         r0pB0wZ+h5RPQ76gwvniPPr+5+oPxzl6/JDL2ADiSqNAjMdB2PJF29JvOlZ4/HBklGwl
         G8xqIwyTmyTxHTWrMXR/EhQYRrbHM6u2S0ULFYyUXFy+B0gtgYrr2qfo+lvl2FCStqx2
         ifiirsbzjT9xF3DoYYT9TslHzx5ofZ+sCd7/sqT3MDcL6Z/ldY/BNzT5KDwcjdXdqkY2
         O2KQjaxGWzR/mgvaPKGlPan07pgxxeWK4Z0DOIBUnLmUc490mj9DbBAvJic27GBvCn0V
         6MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6Wh6N2Vh+R1DFbztUcVSrYCOpuo0Cej4u3l6a8H1ImM=;
        b=jZo9Bp9Cop9snWFX0zL9iBzAdpWLrqVpSfawd80A0XzChy03f3WrkXK4/YOfkCOy+H
         kwm14XEwgq+bvnFinz1tiPDWTW03tNKKX9yDf0c/INxscgvA0bfIjpXnPVkvwNekfPkG
         zlTx4+wUWLzjilXXAJG+URw6nQSOXhNaWZ9iFkv2bj4RfcjEMWu4f3IU/HhRw1o5cA65
         kLVNpxDM1SdDsH+iWcJxKVY5seJ9QU9KKhhfvwjjxe5M75MaqbUG3Lw9JNUVVvGreAGs
         S1m5+Z8lhxmDMLI+e74VSLrVqIrNZyT82NsZQWVaGukGX2EDADaaXHX5k7O1jrutTued
         Yesg==
X-Gm-Message-State: AGRZ1gLWMA8feqyk4PNlGTkhVfY2yV01EOAR98xbZ2o8KWrml1WzRSB9
        n2ozGRVy/Mqfb0zYyLqurTzHfkO7rHVsdp/LM9c=
X-Google-Smtp-Source: AJdET5cRasHqvIjxmqTsBB4tmLZE68gfS9ujBLj6G4OEoGrbVEDReFev8qtN7N1ajnHb5hcxMBwk+0cWrNmlLrivDYA=
X-Received: by 2002:a6b:1412:: with SMTP id 18-v6mr7609148iou.214.1540793501162;
 Sun, 28 Oct 2018 23:11:41 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 29 Oct 2018 11:41:29 +0530
Message-ID: <CABb+yY3twDWnmzVGitUAXSYdkbZu0EegNRYxOXTaeQFR5QEz4g@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e704966c45e48d0220d1ee5e463034ae493a95b2:

  Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2018-09-28
18:04:50 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.20

for you to fetch changes up to 9f0a0a381c5db56e7922dbeea6831f27db58372f:

  mailbox: mediatek: Add check for possible failure of kzalloc
(2018-09-29 12:42:39 +0530)

----------------------------------------------------------------
- Convert print users to use the %pOFn format specifier
- Enable ti-msgmr driver for the K3 platform as well
- Add QCS404 to compatible list of QCOM's APCS IPC driver
- Minor spelling fixes toogle -> toggle
- kzalloc failure catch in Mediatek driver

----------------------------------------------------------------
Bjorn Andersson (1):
      mailbox: qcom: Add QCS404 APPS Global compatible

Colin Ian King (1):
      mailbox: bcm-flexrm-mailbox: fix spelling mistake "toogle" -> "toggle"

Houlong Wei (1):
      mailbox: mediatek: Add check for possible failure of kzalloc

Nishanth Menon (1):
      drivers: mailbox: Make ti-msgmr driver depend on ARCH_K3

Rob Herring (1):
      mailbox: Convert to using %pOFn instead of device_node.name

 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt         | 1 +
 drivers/mailbox/Kconfig                                           | 8 ++++----
 drivers/mailbox/bcm-flexrm-mailbox.c                              | 6 +++---
 drivers/mailbox/mtk-cmdq-mailbox.c                                | 3 +++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c                           | 1 +
 drivers/mailbox/ti-msgmgr.c                                       | 4 ++--
 6 files changed, 14 insertions(+), 9 deletions(-)
