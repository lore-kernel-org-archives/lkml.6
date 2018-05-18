Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbeERWEL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:04:11 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:40062 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeERWEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:04:08 -0400
X-Google-Smtp-Source: AB8JxZqVUxSSIfLUJzGfVT5CENBOCSmXyG8QGUNyvuQ6AMI/Be/tHWyioUW7SaUPLZJDQI5v9hhxgA==
From: Scott Branden <scott.branden@broadcom.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 0/3] mmc: sdhci-iproc: UHS and 32bit access fixes
Date: Fri, 18 May 2018 15:03:54 -0700
Message-Id: <1526681037-2074-1-git-send-email-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collection of bug fixes for sdhci-iproc driver.
- fix for 32bit writes for TRANSFER_MODE register by correcting shadow
register logic
- fix for deep sleep mode by adding SDHCI_QUIRK2_HOST_OFF_CARD_ON
- remove hard coded mmc capability of 1.8V to allow boards to be supported
that do support 1.8V.


Corneliu Doban (2):
  mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register
  mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus

Srinath Mannam (1):
  mmc: sdhci-iproc: remove hard coded mmc cap 1.8v

 drivers/mmc/host/sdhci-iproc.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

-- 
2.5.0
