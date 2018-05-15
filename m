Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeEOUx4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:53:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40854 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeEOUxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:53:54 -0400
X-Google-Smtp-Source: AB8JxZpsDYV+prF3cvWw1pPcPLqt7ynWSQEKtDbmn969k8aOZbKcbo+ma7tRvzRo4XChm77wsN4FKg==
From: Alex Elder <elder@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] remoteproc: updates for new events
Date: Tue, 15 May 2018 15:53:40 -0500
Message-Id: <20180515205345.8090-1-elder@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series changes the prototype for rproc_add_subdev().  The
caller is now responsible for populating the function pointers
recorded in the rproc_subdev structure, rather than having them be
passed as arguments.  These two existing function pointers have been
renamed ("probe" is now "start" and "remove" is now "stop"), and
they are now optional.  Callback functions may now also be assigned
for two new events (prior to start and after stop).

					-Alex

Alex Elder (1):
  remoteproc: rename subdev probe and remove functions

Bjorn Andersson (4):
  remoteproc: Rename subdev functions to start/stop
  remoteproc: Make start and stop in subdev optional
  remoteproc: Make client initialize ops in rproc_subdev
  remoteproc: Introduce prepare and unprepare for subdevices

 drivers/remoteproc/qcom_common.c     |  26 ++++---
 drivers/remoteproc/qcom_sysmon.c     |   5 +-
 drivers/remoteproc/remoteproc_core.c | 110 ++++++++++++++++++++-------
 include/linux/remoteproc.h           |  19 ++---
 4 files changed, 109 insertions(+), 51 deletions(-)

-- 
2.17.0
