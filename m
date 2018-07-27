Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3489EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2A920897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N8CNBSVr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CS2tD4aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2A920897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbeG0L0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:26:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45090 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbeG0L0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:26:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5063D60B73; Fri, 27 Jul 2018 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685898;
        bh=LGwuAsSSA9mFYW6Xl2IfTsNPIOpith4beacERvtaqwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=N8CNBSVr+Y4p/WAX/6MgRceFFffcdNA+ERCKF1tXr8mWV/rpJ0boG+zsqgejSM2Jb
         4xoKs/1F/tzE+h66gdLqhA2DuNKUkvroik/d9raz1H3AB46x5a5mfRrN2Fn1cAlZY1
         4P5Fn+uubqAF6K2an9eD0eeHE97biDrUKD2fyUCY=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 491FA60594;
        Fri, 27 Jul 2018 10:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685897;
        bh=LGwuAsSSA9mFYW6Xl2IfTsNPIOpith4beacERvtaqwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=CS2tD4aJKbW+XFE6GpkW513hJfKDYrmEV/0q/jBEZsAwLhf6VkU5aiDbzoRHc5ieX
         2+6Wfc2ZjLdjcPRwW9F0nKq/ofQbp5g0PMpmi+KJUQclL/SHT2GjERYft6k3lS6qfD
         pqOv5x+v9NQ1ngL7yTv6UpkiCCHwTmxxtoOM5MLU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 491FA60594
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v2 0/6] drivers/qcom: add additional functionality to RPMH
Date:   Fri, 27 Jul 2018 15:34:43 +0530
Message-Id: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>

Changes in v1:
- Remove unnecessary EXPORT_SYMBOL in rpmh-rsc

This set of patches add additional functionality to RPMH drivers[1].

PM drivers can choose to disallow idle modes when RSC controller is busy
sending or processing requests. The patches add necessary functions to
query the controller status.

The controllers may be in 'solver' state, where they could be in autonomous
mode executing low power modes for their hardware and as such are not
available for sending active votes. Functionality to get notified about
such state and disallow requests for state change in that case is added
in these patches.

The Power Domain Controller can be programmed to wakeup the RSC and
setup the resources back in the active state, before the processor is
woken up by a timer interrupt. The wakeup value from the timer hardware
can be copied to the PDC which has its own timer and is in an always-on
power domain. Programming the wakeup value is done through a separate
register on the RSC. Functions necessary to program wakeup is added in
the patches.

Please consider reviewing this patchset.

v1:https://lkml.org/lkml/2018/7/19/213



[1] https://lkml.org/lkml/2018/6/20/519

Lina Iyer (5):
  drivers: qcom: rpmh-rsc: return if the controller is idle
  drivers: qcom: rpmh: export controller idle status
  drivers: qcom: rpmh: disallow active requests in solver mode
  drivers: qcom: rpmh-rsc: write PDC data
  drivers: qcom: rpmh: write PDC data

Raju P.L.S.S.S.N (1):
  drivers: qcom: rpmh-rsc: clear active mode configuration for waketcs

 drivers/soc/qcom/rpmh-internal.h |   6 ++
 drivers/soc/qcom/rpmh-rsc.c      | 132 ++++++++++++++++++++++++++++++---------
 drivers/soc/qcom/rpmh.c          | 100 +++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h          |  16 +++++
 4 files changed, 225 insertions(+), 29 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

