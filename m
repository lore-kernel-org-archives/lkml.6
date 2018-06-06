Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFQ34tMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92626606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933672AbeFFRTU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:19:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55021 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbeFFRTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:19:18 -0400
X-Google-Smtp-Source: ADUXVKIEWwvBmGFwQrdszNt9P0F9k5W9oQm4DeS1Y4+BNMHZemajBVh+k9Sv2PQNHxM9FI5GpexgiNNr0F11WTh8jU4=
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Wed, 6 Jun 2018 22:49:17 +0530
Message-ID: <CABb+yY2MLfH4a+AKQfQw6fm2_Ej7F-m64RJTBb813o=_R5cxuQ@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v4.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 7fbb6157630f2ba6ee355689061f9596b84373ef:

  Merge tag 'armsoc-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-05-26
14:05:16 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.18

for you to fetch changes up to f83d1cfc8bcddf93bb6f55940fd59f5b047863e5:

  mailbox/drivers/hisi: Consolidate the Kconfig for the MAILBOX
(2018-06-06 22:21:59 +0530)

----------------------------------------------------------------
- Remove HAS_DMA config dependencies
- New STMicroelectronics STM32 IPCC driver
- Enable QCom driver to run more controllers
- Fixed return code from null to ptr-err for Brcm driver
- Fix kconfig dependencies for the HiSilicon driver

----------------------------------------------------------------
Bjorn Andersson (1):
      mailbox: qcom: Add msm8998 hmss compatible

Daniel Lezcano (1):
      mailbox/drivers/hisi: Consolidate the Kconfig for the MAILBOX

Fabien Dessenne (2):
      dt-bindings: mailbox: add STMicroelectronics STM32 IPCC binding
      mailbox: add STMicroelectronics STM32 IPCC driver

Geert Uytterhoeven (1):
      mailbox: Remove depends on HAS_DMA in case of platform dependency

Sibi Sankar (2):
      dt-bindings: mailbox: Add APSS shared binding for SDM845 SoCs
      mailbox: Add support for Qualcomm SDM845 SoCs

Stefan Wahren (1):
      mailbox: bcm2835: Fix of_xlate return value

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     |   2 +
 .../devicetree/bindings/mailbox/stm32-ipcc.txt     |  47 +++
 drivers/mailbox/Kconfig                            |  22 +-
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/bcm2835-mailbox.c                  |   2 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   2 +
 drivers/mailbox/stm32-ipcc.c                       | 402 +++++++++++++++++++++
 7 files changed, 472 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
 create mode 100644 drivers/mailbox/stm32-ipcc.c
