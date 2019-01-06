Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFCC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF40A217F4
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuvjWdyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfAFIKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:10:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43084 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfAFIKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:10:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so19396652plb.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 00:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dPiiaWehUrq94ufOyYplYiuNrtl08JEFNYI5j0bCy2I=;
        b=iuvjWdyo8w2g4L2VyNiHIZ+81jIFZS90adRYswQZ7EnI0TLwDzFFEiYYdoUpoV55gO
         BxVEQK3XWFlXwKPDpUu06A2bzqpKTgssJBqX6+C1XSWa4vhtMaiA67QWTOSqktJl7qlF
         MdNdm/Xg4cEIfUFqTDlDvcEiEaErvfF4XkNJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dPiiaWehUrq94ufOyYplYiuNrtl08JEFNYI5j0bCy2I=;
        b=B7LLFNgEYdy4+97G2Jmhwl8LCE2Ijjr53fvvMnnbdKuhwgxuqiNi9prXunECt5id28
         T+Gw/FOwe06ghct/VFVr2IOHHYOJtmAL0z/gjRy5xboMEwnxyOkqfY8ztWYhz/CZCqc7
         iUdD5Sa/wWufrWW+MGv3xNZE5G0sPIw4MFcLiWsl2S1T0DJEvmaIPy+/bfpO7AfFG3LR
         3K1EsvSsIA00Z6MdKzMyuCUpa808UddI/ZnxyUuQTCLQKb9XLmlimz5T0dxK8lgY2pLh
         hxRWICrd2jfMFAjc0wKVGohVMRHZHfKoctVgWjQyqdOr9wAe29DCGzXeROn36jX9lMXm
         vaYg==
X-Gm-Message-State: AJcUukekdS83poJ7o70N62p6fYMk17GXcq2JGgj2fOyYeG9mIvD75Er7
        AQu259+h1ILzpXuMNkP9S5svBQ==
X-Google-Smtp-Source: ALg8bN6v2/v6XqA9aNmv/A0UBZYB0wjWq+i3IcXBdTt4ylzHaREuxTnHhpnrp52cUTIp3o22hS4Cjg==
X-Received: by 2002:a17:902:3064:: with SMTP id u91mr56125810plb.325.1546762216816;
        Sun, 06 Jan 2019 00:10:16 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v190sm90763364pfv.26.2019.01.06.00.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 00:10:16 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Qualcomm AOSS QMP side channel binding and driver
Date:   Sun,  6 Jan 2019 00:09:08 -0800
Message-Id: <20190106080915.4493-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding and driver for the QMP based side-channel communication mechanism
to the AOSS, which is used to control resources not exposed through the RPMh
interface.

Currently implemented is a genpd provider, but pending some improvements in the
thermal framework a cooling device will be added at a later point. Patch 7 is
an "RFC" for how we define and probe these cooling devices.

The remoteproc patches updates the MSS driver to vote for the necessary genpd
corners on SDM845.

Lastly patch 6 makes it possible to have a device on the amba bus where the
apb_pclk is controlled as part of a power-domain.

Bjorn Andersson (6):
  dt-bindings: soc: qcom: Add AOSS QMP binding
  soc: qcom: Add AOSS QMP communication driver
  soc: qcom: Add AOSS QMP genpd provider
  remoteproc: q6v5-mss: Active powerdomain for SDM845
  amba: Allow pclk to be controlled by power domain
  soc: qcom: aoss-qmp: Add cooling device support

Rajendra Nayak (1):
  remoteproc: q6v5-mss: Vote for rpmh power domains

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       |  75 ++++
 drivers/amba/bus.c                            |   9 +-
 drivers/remoteproc/qcom_q6v5_mss.c            | 142 ++++++-
 drivers/soc/qcom/Kconfig                      |  18 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/aoss-qmp-pd.c                | 135 +++++++
 drivers/soc/qcom/aoss-qmp.c                   | 349 ++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     |  15 +
 include/linux/soc/qcom/aoss-qmp.h             |  12 +
 9 files changed, 751 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 drivers/soc/qcom/aoss-qmp-pd.c
 create mode 100644 drivers/soc/qcom/aoss-qmp.c
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
 create mode 100644 include/linux/soc/qcom/aoss-qmp.h

-- 
2.18.0

