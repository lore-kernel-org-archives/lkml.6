Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966803AbeBNDuT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:50:19 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41795 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966671AbeBNDuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:50:17 -0500
X-Google-Smtp-Source: AH8x22600bXYOB0KvFlg6jXIPqS5XRav5BIX7LCWidhCDwuZajOJAm9Tu+21PRSZfZr3DRbi+N/eZw==
From: Leo Yan <leo.yan@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: [PATCH RESEND v5 0/3] Add support for Hi3660 mailbox driver
Date: Wed, 14 Feb 2018 11:49:48 +0800
Message-Id: <1518580191-26451-1-git-send-email-leo.yan@linaro.org>
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
 drivers/mailbox/hi3660-mailbox.c                   | 316 +++++++++++++++++++++
 5 files changed, 385 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
 create mode 100644 drivers/mailbox/hi3660-mailbox.c

-- 
1.9.1
