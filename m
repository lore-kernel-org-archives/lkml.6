Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F09C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D38620870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MNJd4e17";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qtbwh91E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D38620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeLLNg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:36:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45752 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeLLNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:36:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 66F5360128; Wed, 12 Dec 2018 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544621817;
        bh=BheGTW0b+DEHEo/IUu+MaKVW3Ho9iWeXNXFZQQghZmU=;
        h=From:To:Cc:Subject:Date:From;
        b=MNJd4e17xRRm9BX5DAIa0rtORW6g0tNDWZd+j4nM/R3GN0QFCPKioPnsfcRYsEw+k
         qWwiIFiuxWEQh8Qr8UqKCU/1bexdcWW80GuVk/c+DGWEQZGrhCi9b6DfLXaPcb+/fZ
         k87Tt5GbmALqaCtadYvBwzbwr/xurw2eUThI8Zvc=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CA3760128;
        Wed, 12 Dec 2018 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544621816;
        bh=BheGTW0b+DEHEo/IUu+MaKVW3Ho9iWeXNXFZQQghZmU=;
        h=From:To:Cc:Subject:Date:From;
        b=Qtbwh91E6DBOcEw6H3w7IUt2m0yx+OCXuMlFBsSnXRjhDPrxj1P1TMsNaL+ULMdk3
         eM9k93tgc1QPkXv5ZqFArDxQiQhHwSUuunLU8C39LUxFT6R359DGV8NZ1bzikz+syM
         Lr2Rn5rIjywPx4tb+Vm94Q0HehaOw9jc11BPA5ho=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CA3760128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 0/2] arm64: dts: msm8996: Add display and graphics smmu
Date:   Wed, 12 Dec 2018 19:06:45 +0530
Message-Id: <20181212133647.9692-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver side patches are now pulled in [1]. So, we can now enable
these smmu's used by display and graphics.
This has been lying in my test trees [2] for a while, and work well with
display and gpu enabled on msm8996.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates
[2] https://github.com/vivekgautam1/linux/tree/origin/v4.20-rc5/db820c

Archit Taneja (1):
  arm64: dts: msm8996: Add display smmu node

Jordan Crouse (1):
  arm64: dts: msm8996: Add graphics smmu node

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

