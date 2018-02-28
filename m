Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeB1Ezg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 23:55:36 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36528 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeB1Eze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 23:55:34 -0500
X-Google-Smtp-Source: AG47ELsDRrOxY9gleamDDMhAXVSoNDJYELcAPKB6L0AzA3jjFyVRL2fr6tF8auImHC3+iwrAcQ3/Sg==
From: Leo Yan <leo.yan@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 0/3] Add support for Hi3660 mailbox driver
Date: Wed, 28 Feb 2018 12:54:52 +0800
Message-Id: <1519793695-20198-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi3660 mailbox controller is used to send message within multiple
processors, MCU, HIFI, etc. This patch series is to implement an
initial version for Hi3660 mailbox driver with "automatic
acknowledge" mode.

The patch set have been verified with Hi3660 stub clock driver, so
we can send message to MCU to execute CPU frequency scaling. This is
tested on 96boards Hikey960.

Changes from v5:
* Changed to use writel()/readl() to replace {writel|readl}_relaxed()
  to make safe for memory ordering;

Changes from v4:
* According to Jassi suggestion, refactored mailbox driver and removed
  "inline" for function declaration;

Changes from v3:
* According to Jassi suggestion, refined structure name to
  "struct hi3660_chan_info";
* According to Jassi suggestion, moved channel 'lock'+'acquire'
  operations into .startup();

Changes from v2:
* According to Mark Rutland suggestions, removed sev()/wfe() from
  driver, the system has no two masters sharing the same channel for
  data transferring so we don't need these instructions;
* Refined DT binding and doc according to Rob suggestions;
* Refined driver according to Julien suggestions;

Changes from v1:
* Added cover letter to track the changelog;
* Added document for DT binding;
* Refactored and simplized mailbox driver with "automatic ack" mode;
* Refined commit logs for patches;

Kaihua Zhong (2):
  mailbox: Add support for Hi3660 mailbox
  dts: arm64: Add mailbox binding for hi3660

Leo Yan (1):
  dt-bindings: mailbox: Introduce Hi3660 controller binding

 .../bindings/mailbox/hisilicon,hi3660-mailbox.txt  |  51 ++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   8 +
 drivers/mailbox/Kconfig                            |   8 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/hi3660-mailbox.c                   | 312 +++++++++++++++++++++
 5 files changed, 381 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
 create mode 100644 drivers/mailbox/hi3660-mailbox.c

-- 
1.9.1
