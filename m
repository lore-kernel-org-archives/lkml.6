Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9E2C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0367026A4D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pgkza05w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0367026A4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935383AbeFZMMT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:12:19 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46689 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934518AbeFZMMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:12:10 -0400
Received: by mail-io0-f193.google.com with SMTP id u23-v6so12034574ioc.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PXQzNArJfkxCBSg3EF8tKApL19MftY9aSg0RoaQmDJc=;
        b=Pgkza05wtZ0S8TJs8qI5X3/ca2h1J9d+Db0vJTdmJXPS8aEmpRlKuVAUR6s42LBbCT
         yJ+RjEpzqkKyxVQ+266LfOcWiKyi82sC4peqzHqG0i0ZA/qqCLbBpvZ3rxz41WQQLPp+
         VLYjX4br0LXMXqI2F0rbLkrqPSJwJ0GMpudog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PXQzNArJfkxCBSg3EF8tKApL19MftY9aSg0RoaQmDJc=;
        b=eMdzPqqt7ZLwS8cX3EA8+TbzoLLLK/rlQI58rVhwOmNVFcaGXOEBY4F2FX/twuiWTW
         bPnTNgisjwUnWM0CFjw/WUk1/ouRsZ7B04WALSXnAZ3twNTPKfh44Bs/aOFp/KNJMO+T
         bO+b0xIqipoWep6XB6Vt0eMrVbSCUAcrJ20uxt0wQADQpGLY80pfMKs5X6gnAxuWc4eg
         n7etcSeyqW+ActwUe0vV0iCUh1xipwmcZxOgyMMidxUO06MtnPAzAZV85Z8f1qQgHxlY
         wncokCNACvJffEOwsqAAkYQeLkFc3emsY+pGqBPgLvY+3N0fx8cHkhP8swuIXNmt1XPi
         1UIw==
X-Gm-Message-State: APt69E1o/5NiGNLM6L5/W2mX30pgvlmlVa+n1D2eZQqZ3X/IAT2ZSADM
        E93M6lCZJHkP+FmJPsFTSrlDzw==
X-Google-Smtp-Source: AAOMgpdDjVeqwtM6atSbRqB3vHSYPJRCj9T4dTbAqlK6M+d1qfZAyTOrHrm1PfUY6rHb/i+Tec1E9g==
X-Received: by 2002:a5e:8c15:: with SMTP id n21-v6mr968875ioj.217.1530015129332;
        Tue, 26 Jun 2018 05:12:09 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id y62-v6sm902309ioy.88.2018.06.26.05.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 05:12:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] remoteproc: updates for new events
Date:   Tue, 26 Jun 2018 07:11:54 -0500
Message-Id: <20180626121159.7267-1-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

v2: Adjusted signoff sections of patches as requested by Bjorn.

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
2.17.1

