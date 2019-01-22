Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FBAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EA920879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OkOI2kJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfAVFvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:51:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44125 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAVFvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:51:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so11199231pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 21:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DnASuYbZ9HpzLMMCQVxmNPzgYUuz/6hY/XOMLV4gBJ0=;
        b=OkOI2kJF5oKGiYIZdKWNBPiX+c2p7A1LSzrUu6YKoja0bpZqyIr8op4JKlf/+U/34+
         ml/RRiRw9TWTEHaCxY7ybnXLaBoFh/+u+WFDjHn6AuDOPEv05Rw0qdpihcUkTQuBs3nu
         cnGdZZAE5VeevAe7tz/m2DAIyhL4EIrI3PlQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DnASuYbZ9HpzLMMCQVxmNPzgYUuz/6hY/XOMLV4gBJ0=;
        b=gldM0oZ6OvWc+j4cy0s947Ss9Ayvar0b1v3dD0p48eaGg11KKksAp7IJVRFJjoLXyW
         mMRBqqnW5IVuH1aJMokoxUVfmQAZobwfrirXqlokUiDoH8xyxdrlxAgwZRrJ1B/sycZr
         5WSXRDBvWj8k8WOO1JB4sL9J+rQ+o0FSzZobYWnWSnP4HQPnWZqQ0/A/RVDqz80QygJG
         tdWYmIZuQS3EVN4TwD/+zcEdqz5n+EAMgPflEMkogF7GukPMYPJOZRwn/2nXPlfTIKN+
         KMprNDddS/9nG4ci2TRRkjLX0BlzAYfIOaRrxU9CXpSXUEiS5rF0yWF8O8uacaa826Kl
         FoVg==
X-Gm-Message-State: AJcUukciP6tKY85RalFzjBHepJlZCdWgpJWFsmPwfSMNvkiqevGNoiqm
        ArMs1h1zw5qhwT5F39AJxzLYbw==
X-Google-Smtp-Source: ALg8bN6m0iMaSJsmQ1nXkoSBl4Ezmwa7fpGSavqzSvd4cEsFFVwQZwQX3NgnOW1OSynKCN3YLv+OWA==
X-Received: by 2002:a62:4549:: with SMTP id s70mr32004560pfa.233.1548136305147;
        Mon, 21 Jan 2019 21:51:45 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z62sm23771572pfl.33.2019.01.21.21.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 21:51:44 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] Qualcomm AOSS QMP driver and modem dts
Date:   Mon, 21 Jan 2019 21:51:02 -0800
Message-Id: <20190122055112.30943-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the reserved memory map for SDM845, add the ADSP and CDSP nodes,
introduce a communication driver for the AOSS and a PD driver for this and
finally add the modem remoteproc driver.

Bjorn Andersson (8):
  arm64: dts: qcom: sdm845: Update PIL region memory map
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

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       |  75 +++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |   8 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 196 ++++++++++-
 drivers/remoteproc/qcom_q6v5_mss.c            | 144 +++++++-
 drivers/soc/qcom/Kconfig                      |  18 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/aoss-qmp-pd.c                | 138 ++++++++
 drivers/soc/qcom/aoss-qmp.c                   | 317 ++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     |  15 +
 include/linux/soc/qcom/aoss-qmp.h             |  14 +
 10 files changed, 920 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 drivers/soc/qcom/aoss-qmp-pd.c
 create mode 100644 drivers/soc/qcom/aoss-qmp.c
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
 create mode 100644 include/linux/soc/qcom/aoss-qmp.h

-- 
2.18.0

