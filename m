Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484762087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZwUXMUhO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cffhoSbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484762087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeJKEpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:45:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeJKEpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:45:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2C3546063F; Wed, 10 Oct 2018 21:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206480;
        bh=alawkV4mNgt03iNMU+2r477Gr/WSC7YIUOD3jZJFIAo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZwUXMUhOG8v33S9vIRJzol63PsEyZgtDNwz/a4HVbxUX8O4/r1kYH6jDJr2e0q7Xq
         J/MmSon4f5c1qMqQ7s+EbUUwEpvsnNwNNTyOrbhwbQmqSlrFVYS9Wv54TOFapuRPFh
         LIjW5991YNmJSoekg+bJw5CEI1kVuPvtFGvcMt/Q=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 755506063F;
        Wed, 10 Oct 2018 21:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539206479;
        bh=alawkV4mNgt03iNMU+2r477Gr/WSC7YIUOD3jZJFIAo=;
        h=From:To:Cc:Subject:Date:From;
        b=cffhoSbdhwTcpRTHWlRuUpVbNj2kOXdPkyByp9sOn72PUAe8BDPRtO6+PsjqScfIc
         4ZDDJAiXlHRecNGaZ+0FSfZXP/fYorHbe1jZYOQjrbSEhKl83DdTa/BzaLi2riZ62h
         1nqjIkCDJ+cS4U/ECJqMBUqzjO1WvYjSgKzKLSrU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 755506063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 0/8] drivers: qcom: Add cpu power domain  for SDM845
Date:   Thu, 11 Oct 2018 02:50:47 +0530
Message-Id: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Create a cpu pm domain for CPUs based on Ulf Hansson's patches[5][6].
   The reference count to determine the last CPU in the system to enter
   low power mode would be taken care by genpd. The domain power off
   callback is used to perform the last-man activities.

Please note: the first three patches in this series  are taken from Ulf
Hansoon's series[8] and included here for context and completeness of
present series. They would be merged as part of their series[8].

Hi,

This is an attempt at a solution to perform activities necessary while
entering deeper low power modes supported by firmware for QCOM SoCs which
have hardened IP (Resource Power Manager Hardened - RPMH) for shared
resource management.

The shared resources that are no longer used, when processor enters deep
idle states, can be turned off or put to lower state via sleep requests.
Clients vote for lower resource state when application processor is asleep.
These votes need to be flushed only during entry to low power modes.

In addition to this, an always-on power domain wake-up timer present in PDC
(Power Domain Controller)  needs to be programmed so that RSC is up and
running by the time CPU has to wake-up. 

The kernel does not notify that the CPU powering down is the last CPU.
Therefore, in this version, we are using genpd framework based on Ulf
Hansoon's approach for reference counting to determine the last CPU in
the system to enter idle and use that to perform the last-man activities.
It would be optimal to do this than to flush whenever a core enters idle.
The current approach can be revisited in future if OS-initiated support
becomes available that enables certain actions to be taken when last core
enters deepest low power mode.

Please review these patches. Your inputs would be greatly appreciated.

Thanks,
Raju

---
Dependencies:

The current series depends on patches[1][2][3][4], which add RPMH
communication support, to send shared resource request votes by clients.
The patches[1][2][3][4] also provide functions that are expected to be
called by domain manager during low power mode entry. Apart from RPMH
related patches, the current series depends on attaching CPU devices to
genpd framework[5][6] & knowing the next wake up timer of a CPU[7] for
programing the always-on timer present in PDC


[1]. https://patchwork.kernel.org/patch/10589385/
[2]. https://patchwork.kernel.org/patch/10575721/
[3]. https://patchwork.kernel.org/project/linux-arm-msm/list/?series=26079
[4]. https://patchwork.kernel.org/project/linux-arm-msm/list/?series=28381
[5]. https://patchwork.kernel.org/patch/10478167/
[6]. https://patchwork.kernel.org/patch/10478153/
[7]. https://patchwork.kernel.org/patch/10478021/
[8]. https://lkml.org/lkml/2018/6/20/807

Lina Iyer (1):
  timer: Export next wakeup time of a CPU

Raju P.L.S.S.S.N (5):
  drivers: qcom: cpu_pd: add cpu power domain support using genpd
  dt-bindings: introduce cpu power domain bindings for Qualcomm SoCs
  drivers: qcom: cpu_pd: program next wakeup to PDC timer
  drivers: qcom: cpu_pd: Handle cpu hotplug in the domain
  arm64: dtsi: sdm845: Add cpu power domain support

Ulf Hansson (2):
  PM / Domains: Add helper functions to attach/detach CPUs to/from genpd
  kernel/cpu_pm: Manage runtime PM in the idle path for CPUs

 .../bindings/soc/qcom/cpu_power_domain.txt         |  39 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  13 ++
 drivers/base/power/domain.c                        |  70 ++++++++
 drivers/soc/qcom/Kconfig                           |   9 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/cpu_pd.c                          | 200 +++++++++++++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/pm_domain.h                          |   9 +
 include/linux/tick.h                               |   8 +
 kernel/cpu_pm.c                                    |  11 ++
 kernel/time/tick-sched.c                           |  10 ++
 11 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
 create mode 100644 drivers/soc/qcom/cpu_pd.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.

