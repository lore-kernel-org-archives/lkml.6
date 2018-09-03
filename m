Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F49C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC71520867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KnKfM0H+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KnKfM0H+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC71520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeICQM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:12:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeICQM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:12:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E18F3607B5; Mon,  3 Sep 2018 11:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535975589;
        bh=MqDYEjb6xiq64j+n6U+fydC0cxT8wuwM5d5hB3M/ksE=;
        h=From:To:Cc:Subject:Date:From;
        b=KnKfM0H++YKiksB7bN2YeWMQj0UEVNMVrUrCaCuENEef5WVNARhmpoZ0qSAOqbv3T
         4X0qjfAASN9pfY7+skct5P/lVv6GqNPIEFWicB8v7wpgozK17Ac29mpDk8TvVCY1tv
         7TzSC47b5ZWB+9dqUbjf447Cz1Vh1WKyrzT9hjMQ=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A301B6053D;
        Mon,  3 Sep 2018 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535975589;
        bh=MqDYEjb6xiq64j+n6U+fydC0cxT8wuwM5d5hB3M/ksE=;
        h=From:To:Cc:Subject:Date:From;
        b=KnKfM0H++YKiksB7bN2YeWMQj0UEVNMVrUrCaCuENEef5WVNARhmpoZ0qSAOqbv3T
         4X0qjfAASN9pfY7+skct5P/lVv6GqNPIEFWicB8v7wpgozK17Ac29mpDk8TvVCY1tv
         7TzSC47b5ZWB+9dqUbjf447Cz1Vh1WKyrzT9hjMQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A301B6053D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org,
        srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v3 0/2] Add ADSP PIL driver for SDM845
Date:   Mon,  3 Sep 2018 17:22:38 +0530
Message-Id: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides initial patchset for ADSP PIL driver for SDM845.

Changes since v2:
	Separated dt-bindings documentation into separate patch.
	Used clk_bulk APIs for adsp clocks.
	Used power domain API and use reference to rpmhd resource.
	Renamed qcom_nonpas_adsp_pil.c to qcom_adsp_pil.c
	Removed smd as sdm845 does not support smd.
	Removed px_supply and aggre2_clk for sdm845 as they are not required.
	Removed reg-names as there is only one register.

This patch is dependent on the rpmh powerdomain driver https://lkml.org/lkml/2018/6/27/7
and renaming of Hexagon v5 PAS driver https://lkml.org/lkml/2018/8/28/129 .

Rohit kumar (2):
  dt-binding: remoteproc: Add QTI ADSP PIL bindings
  remoteproc: qcom: Introduce Non-PAS ADSP PIL driver

 .../bindings/remoteproc/qcom,adsp-pil.txt          | 123 +++++
 drivers/remoteproc/Kconfig                         |  14 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/qcom_adsp_pil.c                 | 500 +++++++++++++++++++++
 4 files changed, 638 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
 create mode 100644 drivers/remoteproc/qcom_adsp_pil.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

