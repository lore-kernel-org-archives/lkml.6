Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbeDNJvO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 05:51:14 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:22214 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeDNJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 05:51:11 -0400
From: Vignesh R <vigneshr@ti.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Vignesh R <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 0/3] ti_am335x_tsc: Fix suspend/resume
Date: Sat, 14 Apr 2018 15:21:50 +0530
Message-ID: <20180414095153.32060-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes couple of issues wrt suspend/resume with TI AM335x
TSC driver. Disable and clear any pending IRQs before suspend, and
handle case where TSC wakeup would fail, if there were touch events
during suspend.

v2:
Rebase onto latest linux-next.
v1:https://lkml.org/lkml/2016/5/16/150

Grygorii Strashko (2):
  Input: ti_am335x_tsc - Ack pending IRQs at probe and before suspend
  Input: ti_am335x_tsc - Prevent system suspend when TSC is in use

Vignesh R (1):
  Input: ti_am335x_tsc - Mark IRQ as wakeup capable

 drivers/input/touchscreen/ti_am335x_tsc.c | 14 ++++++++++++++
 include/linux/mfd/ti_am335x_tscadc.h      |  1 +
 2 files changed, 15 insertions(+)

-- 
2.17.0
