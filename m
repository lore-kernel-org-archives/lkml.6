Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F093C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6176E20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwE8XoGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfAaAjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:39:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33163 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfAaAjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:39:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so649184plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TvcOv50ZrviAAsaGNEWgQnRGCqneanNmxH+LKdKicfM=;
        b=LwE8XoGau1g5pJDZGoYhUd7a+2IEaem4ZkGlURXCVBgNcyPMDqQ733nupbu9Oc0RjD
         MRcjW6SaG3ES2R8OPFs1tsbBry7KfbajqyEolOJjIgJVfiNsPK+DYMjazmXdAgZlwG1A
         Tcib+GRsOBATlB6IwltICCqRxbOuAHE/uEhao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TvcOv50ZrviAAsaGNEWgQnRGCqneanNmxH+LKdKicfM=;
        b=ugikhRgoHheIUuRImBAYFyxqAWVDWe+70W/Q3fs9CWFaYluAuyAb25SUs1wJAXhdew
         C5xbgyfyp7XKhNllLoIqtnl9pcmqN54j+pNJqijlY5q3VyEwshaKjTRjaGbmxICeY3kI
         Ut6teP7PqNSTYyEmu9qSrEKPLZq+WmoF/xlbvOzVvDBYPpgTZvBzvLwzmk+j9Ctxyb4k
         VDqCVOD2H2PXLegZnLemJbPuL2220t7oXwamyVpW9c7LsKcMdDT31hD3BKimF2liE7CH
         ptei2BptxADLOuQ3IYIcF+53tqP1nfZGnueRaSlw4SzN23uebq3poap0A/ed79ovq1Bz
         vEkw==
X-Gm-Message-State: AJcUukeWKbcyQOyDAuZbDPZg9vtCPkDfZ2lyVsdac7a/fl9bq2WNCQEP
        t6EtlliZfR11mknt96XFdG0ZyA==
X-Google-Smtp-Source: ALg8bN5supjTIqoFe/HEGDWil0u7TDmuIiiL24RpOox1LF8qd6I8qYCMh+4/2lm55FmrxmBxwdjvNw==
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr32692423plj.116.1548895190381;
        Wed, 30 Jan 2019 16:39:50 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k15sm4357928pfb.147.2019.01.30.16.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:39:49 -0800 (PST)
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
Subject: [PATCH v5 00/10] Qualcomm AOSS QMP driver and modem dts
Date:   Wed, 30 Jan 2019 16:39:23 -0800
Message-Id: <20190131003933.11436-1-bjorn.andersson@linaro.org>
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 207 +++++++++++-
 drivers/remoteproc/qcom_q6v5_mss.c            | 146 +++++++-
 drivers/soc/qcom/Kconfig                      |  18 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/aoss-qmp-pd.c                | 138 ++++++++
 drivers/soc/qcom/aoss-qmp.c                   | 317 ++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     |  15 +
 include/linux/soc/qcom/aoss-qmp.h             |  14 +
 10 files changed, 930 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 drivers/soc/qcom/aoss-qmp-pd.c
 create mode 100644 drivers/soc/qcom/aoss-qmp.c
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
 create mode 100644 include/linux/soc/qcom/aoss-qmp.h

-- 
2.18.0

