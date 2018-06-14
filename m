Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AD56DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63342208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XbkS7id4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HN9S7UR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63342208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754884AbeFNHjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:39:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44020 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbeFNHjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:39:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63CA1606DB; Thu, 14 Jun 2018 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528961955;
        bh=8BcSmYbkSco81pH7h6/WX5E6pVBgjJ9nC4YbPNpCDdk=;
        h=From:To:Cc:Subject:Date:From;
        b=XbkS7id4zFJUOF1rjBrPPSfWtupmHkzVL1H0tEuGaFo06Oew80RdpeRMrEP1qiO6D
         3WuXm0hgRJdLGQo+1MvaEeXlrUtPGdmFIiGSc+nOBFzSxwLHkj8i8NhS9WK78iW7cL
         vL1E398d9MUewrdVtId16bUJF1YEKIBCE6RBFfnk=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63B48601D2;
        Thu, 14 Jun 2018 07:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528961954;
        bh=8BcSmYbkSco81pH7h6/WX5E6pVBgjJ9nC4YbPNpCDdk=;
        h=From:To:Cc:Subject:Date:From;
        b=HN9S7UR87xe0UjSWDPWycvzYzI4J1rgF6rnZQLZ7LVe7JWUNx7LAMT69pYA5g3TyS
         43+Z5q/7BOfO71AL15RBC7aU5rJhKTfSxVP0YJe3uQLKqHGmJuKruDiSq40PKgmqfc
         EZ/8+hY7U3XLDbVfLPRjn79SmG0cLOyFCeAdgCrU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63B48601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, robh@kernel.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rohit Kumar <rohitkr@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 0/2] Add support for LPASS clock controller for SDM845
Date:   Thu, 14 Jun 2018 13:09:01 +0530
Message-Id: <1528961943-12506-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the lpass clock controller found on SDM845 based devices.
This would allow lpass peripheral loader drivers to control the clocks to
bring the subsystem out of reset.

Taniya Das (2):
  dt-bindings: clock: Introduce QCOM LPASS clock bindings
  clk: qcom: Add lpass clock controller driver for SDM845

 .../devicetree/bindings/clock/qcom,lpasscc.txt     |  46 ++++
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/lpasscc-sdm845.c                  | 248 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,lpass-sdm845.h      |  18 ++
 5 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
 create mode 100644 drivers/clk/qcom/lpasscc-sdm845.c
 create mode 100644 include/dt-bindings/clock/qcom,lpass-sdm845.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

