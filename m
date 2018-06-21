Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F094C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FF120837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q2/cf5E0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J1uGkAe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FF120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933393AbeFUMYD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:24:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933186AbeFUMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:24:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B54160274; Thu, 21 Jun 2018 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529583841;
        bh=8DD6kpkxDFj25XbdJQ4prce+nA6rv1zwPndNIRjMSzQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Q2/cf5E0szXbHOop/Nt3WVf89gEF5U+Aj/g14fXSUi+M6IJS8vgD/W9HcSyNmJibR
         2XKW8cX90/6E0ulWo9SI40HrMLLqPYRqjjKarPnsfE3DWpKLgjzLUwAE5ewVIaxvnA
         xsRl0IoE5bUnidMgZ5YwiyXNNzBbyBsHa1BoNGz4=
Received: from hydcbspbld03.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vviswana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B9B060274;
        Thu, 21 Jun 2018 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529583840;
        bh=8DD6kpkxDFj25XbdJQ4prce+nA6rv1zwPndNIRjMSzQ=;
        h=From:To:Cc:Subject:Date:From;
        b=J1uGkAe++2KSQ6DjxG5rUxuBlsehxaJSB1Z+PqkEzAvhaAbs5tjRFjfkpm9k0ElQv
         OYvqt8NpxlWUPDTTbfKLsDK0q4oebg79JGdVH8Vq6L1YjeA4LoHcIVBC98Df20u4ZX
         SrI/5BSAI8W9a11uKh6f+KrN/T6nLKkcX2exhjNo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B9B060274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
From:   Vijay Viswanath <vviswana@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        dianders@google.com, sayalil@codeaurora.org
Subject: [PATCH RFC 0/2] Internal voltage control for platform drivers 
Date:   Thu, 21 Jun 2018 17:53:44 +0530
Message-Id: <1529583826-42020-1-git-send-email-vviswana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain SDHC controllers may require that voltage switching happen after
sepcial conditions. Added a QUIRK for such controllers to use.

For SDHCI-MSM controllers, power irq is a signal from controller to SW
that it is ready for voltage switch. So added support to register
voltage regulators from the msm driver and use them.
Voltage switching from core layer is causing CRC/cmd timeout errors in
some chipsets.

Tested on: sdm845, db410c
Requies patch series:"[PATCH V3 0/4] Changes for SDCC5 version"

Vijay Viswanath (2):
  mmc: sdhci: Allow platform controlled voltage switching
  mmc: sdhci-msm: Use internal voltage control

 drivers/mmc/host/sdhci-msm.c | 99 ++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci.c     | 20 ++++++---
 drivers/mmc/host/sdhci.h     |  2 +
 3 files changed, 104 insertions(+), 17 deletions(-)

-- 
 Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

