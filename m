Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEA1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845F72245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c7mlakn7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WK6blVM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845F72245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbeKPD1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:27:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35940 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeKPD1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:27:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 593B660767; Thu, 15 Nov 2018 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542302311;
        bh=RzoBv3tbChuEIXxgRXZcakVP5vSTYgZRIZ06DKbBfTE=;
        h=From:To:Cc:Subject:Date:From;
        b=c7mlakn76jFdZ1iTzqKK0cPJwlvPAYync7w1ednbmhapf8skyAIN6ZRE8Dpv6OsHs
         4RL6/SegxEkyhM0rYdcB2Dn6akxE2wCbG9PtzDZmcmJR/C/iIb0Fl2t7wELwoQmJpS
         kd4PsDgZOIcWDyVHl7qpRGQauAGLdrXTDD3JSiJ4=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 014A26044B;
        Thu, 15 Nov 2018 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542302310;
        bh=RzoBv3tbChuEIXxgRXZcakVP5vSTYgZRIZ06DKbBfTE=;
        h=From:To:Cc:Subject:Date:From;
        b=WK6blVM5dQtJ5H8Ipu/q9hzDi9EctZcfs/k1kc2EotAG0Egb6TzmqpPNsPzrYYGYR
         /RJZSeUcDQ3uetZeRTZqx3CMMan/BLA5O90sWg7xBN3qPDufLrVE+yMFwEhH1EDOWX
         cMm6L9VyBOhrHB6+WviojXkyjCVo7HTmEOmP4IUc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 014A26044B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH 0/4] Enable SD crd slot on msm8998 MTP
Date:   Thu, 15 Nov 2018 10:18:07 -0700
Message-Id: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A short series to enable the SD card slot on the msm8998 MTP so that there
is some storage media to play with.

Jeffrey Hugo (4):
  arm64: dts: qcom: msm8998: correct xo clock name
  arm64: dts: qcom: msm8998: Add SDCC2
  arm64: dts: qcom: msm8998: Add SDC2 control pins
  arm64: dts: qcom: msm8998-mtp: Add external SD

 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi  | 13 +++++
 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi | 78 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi      | 22 ++++++++-
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

