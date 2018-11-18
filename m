Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2C4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0772075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKCLWOIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0772075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeKSGZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:25:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38061 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeKSGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:25:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so3489202plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xgxsNvWtkfQX9HIqcXd0Jkey2NcEr58H83uKN9Nv6xc=;
        b=NKCLWOIRrwyU1l/yYWj+prDWoQ0S3Md0SuoI8KU1Krn+PxiHl6y3uocHFJMSVp5TcE
         T1Y6n170q1OPwc1cdEpagPe2+9IJu5mjLH9xSyVSiYizeVqH5ee1SB0KZIYc7XZbVD9p
         n+2E94+4WB8JBeJyq+qU4IaFhnX7hcr7W1gNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xgxsNvWtkfQX9HIqcXd0Jkey2NcEr58H83uKN9Nv6xc=;
        b=l59i4f0wi6EOv0ZOI7wdAmeRZNgL7vzCFbI3Dj3Xf962gzXzeSUQ32cEtVLap1NnNJ
         DKGDBrTyDPIxupG0HV3boBK/wEQofn1sE2vnxBiUwYUedA3JbEe+/UNBt9md0SrvCf+D
         Xo5lwup37OTyUvSsVMIJe5VQyoTKaDIgLkEb086SgYNg3N+PCoE5Dd3IAmaxpyZmdUbp
         cRZOOBetL/sGZIkrlLwox4oOFbxCK0pdtgjLtHKXswKZOpfqkuVCm11K9Lzh9r7s0g/0
         UaI1xmeHF+R+3q1oiQd9qK8e7zysNfftYv1H6V4W+rmd/a5JeCfXQYD7qc4YfyYjq7+M
         8owg==
X-Gm-Message-State: AGRZ1gIZU8TjI8q/8gWTIx/QLo4p0vsIDzHD0X2AKg5NwI3dVzB/cW9N
        1Zm+oCy2bIlKtq3GnrlguGs54vUFFx8=
X-Google-Smtp-Source: AJdET5fyQB7SqbX4iYUatVu0OgGRDvhTzw3kaomB/Y1yuXw5CzGq8WTDQn88Y/5HrPcj8DWfwFVYLw==
X-Received: by 2002:a17:902:3fe4:: with SMTP id a91-v6mr19317954pld.295.1542571445172;
        Sun, 18 Nov 2018 12:04:05 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p15-v6sm64102434pfj.72.2018.11.18.12.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 12:04:04 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: qcom: QCS404 BLSP nodes
Date:   Sun, 18 Nov 2018 12:01:32 -0800
Message-Id: <20181118200135.25258-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This finalizes the definition of the BLSP UART, I2C and SPI devices found in
the QCS404 SoC.

Bjorn Andersson (3):
  arm64: dts: qcom: qcs404: Specify pinctrl state for UART
  arm64: dts: qcom: qcs404: Define remaining UARTs
  arm64: dts: qcom: qcs404: Add QUP I2C and SPI nodes

 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi |  14 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi     | 333 +++++++++++++++++++++++
 2 files changed, 347 insertions(+)

-- 
2.18.0

