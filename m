Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFE1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9937D2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQxvzcB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9937D2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392257AbeHPTLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:11:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36875 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbeHPTL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:11:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so2982451eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hhwqjwEScaeL5xaedZPs90ti3VEVxm0RNH2CzA1mlws=;
        b=VQxvzcB24jsh2E1McbEystVy4XRgv3Z5xew0+nItBA3HCtU1wZCtFjis/MXsdCUDBA
         qdfjyX3LMD77HM1NyPacNIAFALXb+r4wFV19B2AOtSqvoHZRwIdeVJU6B8EytYLw4a+F
         XTo2bTnz6/6zhINzIwolVc5JvXvEDu9PK558ApcKHYaDNrgUzXIHizJkg3nMXhg1S8zy
         FONUkrWu8JbnehXRpeXsZ5hv35aL46ezkGl0PQV75lBQWJyxPsINwV4e6L/FClEE83KF
         KAKybW9l9eeyFlHyeMimsqMrrxJgalzxllbb8hfVQYVXffIBqNyHN53CjWcgT+G8jCWC
         wetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hhwqjwEScaeL5xaedZPs90ti3VEVxm0RNH2CzA1mlws=;
        b=ZWYb6hcI0DJb4eLeIBKIWrxidDq+kI1fgQjkZl6/t2vASoMz5YG0567fecTnsn9UcU
         C8UTriedi3XwkxkiSnmeU6JuHXuGvNPyD/jpjCbTlzjokmQKVYs3tMhIZrIqltZ/Rwxz
         tQvyaVMkaohjZ/O8p3El0v9GEwpF4YR+pDuBmquMMODDcUf/Y9SBjeix3t2UXmm+uv61
         JsNMmhOe/p7EvpREId92CDf+/opD76RNioWdzyZUk0YHGIEJu5Fn6PHAkMUdxVEobXKL
         XJ3XyknVMnK3rROtgMGGIyog+rsC2sxDqhTNprZF1+PHObuYrwOJb7WRgsqhuDSrbwmW
         5PJQ==
X-Gm-Message-State: AOUpUlG5Gaf1P+UIDPoYi/pU6jjtVGWWsAwUqWdtYWTL6fnAxY1uqHva
        3+TY5TH3Y4NeZcjsMz3rseRxzbTAWGgPRn2GsgKzUA==
X-Google-Smtp-Source: AA+uWPykSSmt9vaa9LpyesytXhYQjhXEoDiG/MCyKCcwmbmAASHYfl/fWLbPyp2msxStzIPPw7RHrqOCAJ3v6Vjand4=
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr37931069ede.213.1534435923856;
 Thu, 16 Aug 2018 09:12:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f68b:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 09:12:03
 -0700 (PDT)
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 16 Aug 2018 21:42:03 +0530
Message-ID: <CABb+yY10OBQaidRYXrGfi=n-PaaJU+sb6J3dJjZ0rjP+6AXB5w@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 0585df468e8f4481b78256a2bf09449290bfcbf3:

  Merge tag 'media/v4.18-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
(2018-08-02 16:55:42 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.19

for you to fetch changes up to 2bb7005696e2246baa88772341ca032ff09a63cb:

  mailbox: Add support for i.MX messaging unit (2018-08-15 09:53:07 +0530)

----------------------------------------------------------------
- xgene : potential null pointer fix

- omap : switch to spdx license and use of_device_get_match_data() to match data

- ti-msgmgr : cleanup and optimisation. New TI specific feature -
secure proxy thread.

- mediatek : add driver for CMDQ controller.

- nxp : add driver for MU controller

----------------------------------------------------------------
Dong Aisheng (1):
      dt-bindings: arm: fsl: add mu binding doc

Gustavo A. R. Silva (1):
      mailbox: xgene-slimpro: Fix potential NULL pointer dereference

Houlong Wei (2):
      dt-bindings: soc: Add documentation for the MediaTek GCE unit
      mailbox: mediatek: Add Mediatek CMDQ driver

Nishanth Menon (6):
      mailbox: ti-msgmgr: Get rid of unused structure members
      mailbox: ti-msgmgr: Allocate Rx channel resources only on request
      mailbox: ti-msgmgr: Change message count mask to be descriptor based
      mailbox: ti-msgmgr: Move the memory region name to descriptor
      dt-bindings: mailbox: Add support for secure proxy threads
      mailbox: ti-msgmgr: Add support for Secure Proxy

Oleksij Rempel (2):
      dt-bindings: mailbox: imx-mu: add generic MU channel support
      mailbox: Add support for i.MX messaging unit

Randy Dunlap (1):
      mailbox: add MODULE_LICENSE() for mtk-cmdq-mailbox.c

Suman Anna (2):
      mailbox/omap: switch to SPDX license identifier
      mailbox/omap: use of_device_get_match_data() to get match data

 .../devicetree/bindings/mailbox/fsl,mu.txt         |  54 ++
 .../devicetree/bindings/mailbox/mtk-gce.txt        |  57 ++
 .../bindings/mailbox/ti,secure-proxy.txt           |  50 ++
 drivers/mailbox/Kconfig                            |  16 +
 drivers/mailbox/Makefile                           |   4 +
 drivers/mailbox/imx-mailbox.c                      | 358 +++++++++++++
 drivers/mailbox/mailbox-xgene-slimpro.c            |   6 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 | 571 +++++++++++++++++++++
 drivers/mailbox/omap-mailbox.c                     |  31 +-
 drivers/mailbox/ti-msgmgr.c                        | 353 ++++++++++---
 include/dt-bindings/gce/mt8173-gce.h               |  44 ++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |  77 +++
 include/linux/omap-mailbox.h                       |   5 +-
 13 files changed, 1536 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
 create mode 100644
Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
 create mode 100644 drivers/mailbox/imx-mailbox.c
 create mode 100644 drivers/mailbox/mtk-cmdq-mailbox.c
 create mode 100644 include/dt-bindings/gce/mt8173-gce.h
 create mode 100644 include/linux/mailbox/mtk-cmdq-mailbox.h
