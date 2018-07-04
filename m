Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B8BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815F922BCC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l/tauUOk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a26dwUDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815F922BCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeGDTHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:07:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeGDTHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:07:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 19081607EB; Wed,  4 Jul 2018 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530731238;
        bh=cjwaM0wGlcNgXiCUVs9vIX0qmzqwDLGqmxNgazJzhWc=;
        h=From:To:Cc:Subject:Date:From;
        b=l/tauUOklxfIRuXaAosl6kHwX9s7Xfl8B2xre6vnUk1KYpkK3bs4HGbIeY22BWgvq
         QFDmjob4L7uT0XXPoCcoLZ2O4BAWBPH4TVlBajJlNL8B39CtK+ZuoB8/dKHI2OrP+6
         VzthX5aB47wLPcv8YMjQ/WNm6Ryo1kAfRP682wpE=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 086F8607EB;
        Wed,  4 Jul 2018 19:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530731237;
        bh=cjwaM0wGlcNgXiCUVs9vIX0qmzqwDLGqmxNgazJzhWc=;
        h=From:To:Cc:Subject:Date:From;
        b=a26dwUDO5vgNqcysbV3cRsWHHnmNvydEeiiLE+HjmdVNwN8ST9CqCV7OxwbrrfYra
         SyjRy9MZ1rsxAA14hFn1fWpwgaA2neyXWqaMwkf3H4Et9IcFAExblZr68NW+Yx81aQ
         s2F/AOBPIIbmDcxZna0ca2P2e9gHax+QppBU/gOs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 086F8607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH v3 0/4] Venus updates - PIL
Date:   Thu,  5 Jul 2018 00:36:48 +0530
Message-Id: <1530731212-30474-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v3 with following comments addressed:

* merged patch 1 and 4 from v2.
* removed enum for Video CPU state and handled it as a bool.
* introduced a flag to specify if tz is not present.
* add misc code review comments related to better coding ways

There is an ongoing discussion on getting iova in a specified
range. Once concluded, will update the series, if needed.

Comments are welcome!

Vikash Garodia (4):
  venus: firmware: add routine to reset ARM9
  venus: firmware: move load firmware in a separate function
  venus: firmware: add no TZ boot and shutdown routine
  venus: firmware: register separate driver for firmware device

 .../devicetree/bindings/media/qcom,venus.txt       |  17 +-
 drivers/media/platform/qcom/venus/core.c           |  59 +++++-
 drivers/media/platform/qcom/venus/core.h           |   6 +
 drivers/media/platform/qcom/venus/firmware.c       | 203 ++++++++++++++++++---
 drivers/media/platform/qcom/venus/firmware.h       |   7 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
 drivers/media/platform/qcom/venus/hfi_venus_io.h   |   5 +
 7 files changed, 263 insertions(+), 47 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

