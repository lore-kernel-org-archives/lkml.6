Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC11AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7363920671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eGde0bPh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LDZfCNnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7363920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeGSKCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:02:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeGSKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:02:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5C1D960B12; Thu, 19 Jul 2018 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531991986;
        bh=KdLNVDkSxNhVn+2PFyM2EtUfOXpjM6S/RFQTecj6AMw=;
        h=From:To:Cc:Subject:Date:From;
        b=eGde0bPhsbYh3yHNKtX2AbMJjJvVlMLBvHg3Pdzq8P7HSYzcOM+tYQkzYZDP2QRNf
         GPJ8pmrAfIZypkJpRDesUIgzNkB9lk5GCUBKbBgPy2u2FUJ2CPKdDjs8o+4zfcPixw
         5wiSRC40CVD2fotqPb7+8Q8btc7IgZD9hTUF74kc=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0600360541;
        Thu, 19 Jul 2018 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531991985;
        bh=KdLNVDkSxNhVn+2PFyM2EtUfOXpjM6S/RFQTecj6AMw=;
        h=From:To:Cc:Subject:Date:From;
        b=LDZfCNnOii6pi9CQbzdg0mS8ELF3rCDkS7BUCo462yT6Y4rOhAlPEI+bhXm+2Kkq1
         hHqyLhiSiCrmSoe4P6pGcUni0SaDoKpkvrTEFrlE9+h0/y+1yD8k6W6VQwMZ5/iC6b
         CtNA+67qBCsQyiak8KoDxN4WtWu2hsH4YtGjMqlI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0600360541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH 0/6] drivers/qcom: add additional functionality to RPMH
Date:   Thu, 19 Jul 2018 14:49:29 +0530
Message-Id: <1531991975-23665-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>

This set of patches add additional functionality to RPMH drivers[1].

PM drivers can choose to disallow idle modes when RSC controller is busy sending
or processing requests. The patches add necesary functions to query the 
controller status.

The controllers may be in 'solver' state, where they could be in autonomous
mode executing low power modes for their hardware and as such are not available
for sending active votes. Functionality to get notified about such state and 
disallow requests for state change in that case is added in these patches.

The Power Domain Controller can be programmed to wakeup the RSC and
setup the resources back in the active state, before the processor is
woken up by a timer interrupt. The wakeup value from the timer hardware
can be copied to the PDC which has its own timer and is in an always-on
power domain. Programming the wakeup value is done through a separate
register on the RSC. Fuctions necessary to program wakeup is added in
the patches.

Please consider reviewing this patchset.

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
 drivers/soc/qcom/rpmh-rsc.c      | 134 ++++++++++++++++++++++++++++++---------
 drivers/soc/qcom/rpmh.c          | 100 +++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h          |  16 +++++
 4 files changed, 227 insertions(+), 29 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

