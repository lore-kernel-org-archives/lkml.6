Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34715C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68BF2170D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V7AYanmI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G5OY3mMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68BF2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbeHCQHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:07:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39144 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbeHCQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:07:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 58B4A6035F; Fri,  3 Aug 2018 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305439;
        bh=Ih0+th6/Q/RF74vb3ahUDEISHNtw4/GUUkGltLA5ur4=;
        h=From:To:Cc:Subject:Date:From;
        b=V7AYanmI/RhSzX3bFo28t2KjPVeOA0jEnDjuqlxHDzee0HwsVyY4dYcWh/4b4O958
         t7a5TyYjXwk4yWyfNHhJ79wnGJ9UztVt9Jfmzy0aSnYg0es8ve8GX1luxO/Nx8HgKZ
         MEHTU1gyP/DOKirtc9FHEV5liPM1Vu4TIw57mjQE=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E9F060117;
        Fri,  3 Aug 2018 14:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533305438;
        bh=Ih0+th6/Q/RF74vb3ahUDEISHNtw4/GUUkGltLA5ur4=;
        h=From:To:Cc:Subject:Date:From;
        b=G5OY3mMrsQ/BsRutW0rSw9IrUOwJPaex7pPEqorStLHzl3gw3WBMZKllbcEv6JkLm
         +oRJKY2gO12r8UC9a1UUmuFIrdUK85pAqhPx6jJhlvrfHw1yOr4gIFpQHiexGvrpia
         wzOW81ldD46V/p/0uvWEcBDNc9Umt0nBNiPB5ZII=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E9F060117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH 0/5] arm: dts: qcom: Few updates for ipq8064
Date:   Fri,  3 Aug 2018 19:40:14 +0530
Message-Id: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding pcie,sdcc nodes and a new board file ipq8064-ap161

Sricharan R (5):
  arm: dts: qcom: Add pcie nodes for ipq8064
  arm: dts: qcom: Add sdcc nodes for ipq8064
  arm: dts: qcom: Move common nodes to ipq8064-v.1.0.dtsi
  arm: dts: qcom: Add ipq8064-ap161.dts
  arm: dts: qcom: Add led and gpio-button nodes to ipq8064 boards

 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts |  83 +--------
 arch/arm/boot/dts/qcom-ipq8064-ap161.dts |   7 +
 arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi | 125 ++++++++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi      | 286 +++++++++++++++++++++++++++++++
 5 files changed, 426 insertions(+), 76 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-ap161.dts

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

