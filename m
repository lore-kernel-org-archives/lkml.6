Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40A3C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78979263EB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEUsTRqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78979263EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935204AbeFZBeO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:34:14 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40059 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934694AbeFZBeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:34:13 -0400
Received: by mail-it0-f67.google.com with SMTP id 188-v6so15157478ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PSh1Rzot3lUzgw3FPECDqaF14PqS2j0O45XALMc+uo0=;
        b=VEUsTRqt9l3VcoDsqGVRGc8w6zCqs8BV/SlPKQmKf+vAOOtDSKmqwOPQXSZEA7ToQY
         TqiEziTEsyRzLLf88NtCEU19A5rppuBtnLQsc8Mnd68GyRsu3zagzcNnzlIcj/4XSApZ
         WzLyIjfwmBv7eELaVWRjsTjU4HYBO9jeZX3UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PSh1Rzot3lUzgw3FPECDqaF14PqS2j0O45XALMc+uo0=;
        b=CQlJImlzPanAs94cf+PvFPlbUa69yDCykDqfRWV6XDf0qR6VrcCB+4M0uguoaHU8NF
         05N6+Kvy7U4Rsv9U2veWxwJMzqzj65m6OSa9cktJYgHxu54t9XKH66K4N+qPWR5m/x8C
         bTdF8lfxCdavMx57MmmgAY41Y7sxBnzxM0MeYSW6Zso6Dmq8ub2laRIbYg6us/RybU9h
         UgUT8p7rSdL1XRQfspZTYd1KnfAsIqVds+XFpivObKatirTx5kI3ZjUIRAqgM9Da/O/T
         XE8gsoEKSaPdWfwqMABGHLlOo1towNsO6xiORmlvwxwtYoNxHPQLhiE2nm39aAQMEtlZ
         v7+A==
X-Gm-Message-State: APt69E0znCf99YCOGgmTPfAYoTDfUCHJtPN8I/546V5+AQScU1mii7TF
        GrAybS32e6GaPjisAZlfG3LV3Q==
X-Google-Smtp-Source: ADUXVKKYkdGlKTvexTye2o+13ITSj8lNtUt6aucIqtWDqmYl298BnEshMwKUQoBChUxP4vbGzUN/lQ==
X-Received: by 2002:a02:4ac3:: with SMTP id s64-v6mr85958jad.93.1529976852404;
        Mon, 25 Jun 2018 18:34:12 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id h62-v6sm184699ioa.22.2018.06.25.18.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 18:34:11 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend 0/5] remoteproc: updates for new events
Date:   Mon, 25 Jun 2018 20:34:04 -0500
Message-Id: <20180626013409.5125-1-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(This is just a rebase of https://lkml.org/lkml/2018/5/15/919)

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
2.17.1

