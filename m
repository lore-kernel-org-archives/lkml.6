Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893D7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513702175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mn7ol7RN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfA2XU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:20:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34312 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfA2XU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:20:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so10121624plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Z2SNSASdAZ15NY3KjBTvSgcTC5suWDnF30xGCGjNhgM=;
        b=Mn7ol7RNXYICOHCoHmDuvbo7wl/lF4070Pzgb0EupRFrhZq6/MJpJnVBYklrwgcnRh
         lEmcTa+BUherhJCNRylkciwSdIrILcgfxQQ+wYxXXfWPNBQYoZ67wTYjXKMkvVa6szeO
         iU61PE6HjbgHj9JvRTa9RA9+badJ33jk1+HXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z2SNSASdAZ15NY3KjBTvSgcTC5suWDnF30xGCGjNhgM=;
        b=boaspCwB+LqAX/S3/Clp1y+3/vxev0STH8JvKmxzuPvtUvcqz87f/6aUZ83dEgMWoL
         yzkxWKvn2Jz4LSGWiXijMCQ/dhp0NlZ4kezlszWhRBqLTrbAxzA6lnu4+jWbskvTqRqD
         3K9b3j5P5EiuKGuDKBrlvlU9tlkozXrp+Pu3Z6VlK8EpsCLZk1kFuJIyaKPQ7WqAQlEp
         Iosx+5VrIMgV2enZBK2f9ozqmqwpXAc6qReJadwK88aLUmJncv0HFIX2Qp4gxChkJIUb
         hMKm9G6aLFD7aaa3LOyV9ofUWcWOiiwltUe7Zo/7R4tMSid3DobmlOAR8WOyGPcC8OtM
         W1cg==
X-Gm-Message-State: AJcUukeHlFf7cM3dtfpZE82wi1IOyAxTvdtXzgSb+38rCKd4Z/OdTu54
        oBYlHJuynLN01oKuYhqq/lD8ig==
X-Google-Smtp-Source: ALg8bN6MwHSUoHpTqHQr0/dOdxl6qXzQ4DEWJlGbuLNEo8h0QOcS4zqBMaaOU8jfWyTefhzuUMmTCQ==
X-Received: by 2002:a17:902:2887:: with SMTP id f7mr27372517plb.176.1548804027985;
        Tue, 29 Jan 2019 15:20:27 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v70sm51182779pfa.152.2019.01.29.15.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:20:27 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 00/10] Qualcomm AOSS QMP driver and modem dts
Date:   Tue, 29 Jan 2019 15:19:59 -0800
Message-Id: <20190129232009.5033-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the reserved memory map for SDM845, add the ADSP and CDSP nodes,
introduce a communication driver for the AOSS and a PD driver for this and
finally add the modem remoteproc driver.

Bjorn Andersson (8):
  arm64: dts: qcom: sdm845: Update reserved memory map
  arm64: dts: qcom: sdm845: Define rmtfs memory
  arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
  dt-bindings: soc: qcom: Add AOSS QMP binding
  soc: qcom: Add AOSS QMP communication driver
  soc: qcom: Add AOSS QMP genpd provider
  remoteproc: q6v5-mss: Active powerdomain for SDM845
  arm64: dts: qcom: Add AOSS QMP node

Rajendra Nayak (1):
  remoteproc: q6v5-mss: Vote for rpmh power domains

Sibi Sankar (1):
  arm64: dts: qcom: sdm845: Add Q6V5 MSS node

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       |  76 +++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |   8 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 206 +++++++++++-
 drivers/remoteproc/qcom_q6v5_mss.c            | 146 +++++++-
 drivers/soc/qcom/Kconfig                      |  18 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/aoss-qmp-pd.c                | 138 ++++++++
 drivers/soc/qcom/aoss-qmp.c                   | 317 ++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     |  15 +
 include/linux/soc/qcom/aoss-qmp.h             |  14 +
 10 files changed, 932 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 drivers/soc/qcom/aoss-qmp-pd.c
 create mode 100644 drivers/soc/qcom/aoss-qmp.c
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
 create mode 100644 include/linux/soc/qcom/aoss-qmp.h

-- 
2.18.0

