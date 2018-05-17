Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeEQJA7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:00:59 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40404 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeEQJA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:00:57 -0400
X-Google-Smtp-Source: AB8JxZr8Zrc8bMiQY9mzU/AwEWKMPLXyiZfErbC2iN/4TJYzh2bogCiuzayP/RYd8LyrIwsCKBQdOw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH v2 0/8] slimbus: fixes and some helpers
Date: Thu, 17 May 2018 09:58:42 +0100
Message-Id: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is set of patches for slimbus, there are 6 fixes and
two helper functions.
Most of these issues were found while testing QCOM NGD SLIMBus
controller with WCD9335 codec.


Changes since v1 (https://lkml.org/lkml/2018/5/16/436):
- add need_tid to documentation reported by 0 day test.
- remove redundant kconfig for qcom slim controller.

thanks,
Srini

Srinivas Kandagatla (8):
  slimbus: core: add of_slim_device_get() helper
  slimbus: core: rearrange slim_eaddr structure
  slimbus: core: add need_tid flag to slim_msg_txn
  slimbus: messaging: pass correct wbuf
  slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
  slimbus: messaging: add slim_prepare_txn() helper function
  slimbus: messaging: initialize completion correctly
  slimbus: qcom: remove redundant depends in Kconfig

 drivers/slimbus/Kconfig     |  1 -
 drivers/slimbus/core.c      | 39 +++++++++++++++++++
 drivers/slimbus/messaging.c | 92 ++++++++++++++++++++++++++++++---------------
 drivers/slimbus/qcom-ctrl.c |  7 +++-
 drivers/slimbus/slimbus.h   |  4 ++
 include/linux/slimbus.h     | 14 ++++---
 6 files changed, 119 insertions(+), 38 deletions(-)

-- 
2.16.2
