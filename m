Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C63C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300B62175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvUoliy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300B62175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeKLRyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:54:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44273 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbeKLRyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:54:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so3932829plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4+bHL2bjBr0Hcmu8WwOCTCVUO+0WVnay0OTWbgkT28o=;
        b=UvUoliy6IkDtqDfmirQPPXAfE3fmnOPAgIcYlLfQkhPE8Kk65x1wqZ+++hgk3v+Rms
         tYqJUsvu9G6vhlbr2+U/QTK3WcAeZb4qbKzlSQY9cU7oJUJnd7HEqi6j2dirNJmPbB8f
         DQDpmKUVhJBsZEhYBMNpU7EsnxbEmUfuuanso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4+bHL2bjBr0Hcmu8WwOCTCVUO+0WVnay0OTWbgkT28o=;
        b=jVMJ4AGYwp8bD7y7thrH43yIvw9pDHKFWc2g8sz3kLR1QhAxfTyUP1UxuLBaH3DSfX
         WJnx6eGLgFUfM6e+UwG4pDZj4knnMOQN46BdWYYdyAskBqas6sttDcQY8xje6Qv8NeIn
         8paHLLLJKbugSP0HCJqqVU1cXw/wfEXMFsTTt8gtNQh+BEahR0Y8sdZzKlUX7y9kJwLv
         wbcAVQ+0HZeNr8yTAFqEK9hsje62qOrAstUWzc/KGR/KL4AKuK1+3evIGZrYHvDIYgU5
         kl4+lSLFVmERX/+dfpPgldSJt/kfar5uu2QMzEV7kAHvRyj3RIBdzkpGAP9Vk5VNiot3
         M/vQ==
X-Gm-Message-State: AGRZ1gKh7iX5zU6dAoczMdEuU5Trc0RdXWBxyXocYxnh8jPQ2bvwZXkA
        cEzcXQIrfo4mTNbZYK4kWZRghQ==
X-Google-Smtp-Source: AJdET5drzPuPsfi9G6eCUY4sQyy5U0Vvs2orei+nZFv9JMcikqZqfu/+PmrVSaxMNaGctGeHapMPMg==
X-Received: by 2002:a17:902:7c04:: with SMTP id x4-v6mr11827983pll.60.1542009726730;
        Mon, 12 Nov 2018 00:02:06 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 134sm13590085pgb.78.2018.11.12.00.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 00:02:06 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Qualcomm AOSS QMP side channel binding and driver
Date:   Mon, 12 Nov 2018 00:05:54 -0800
Message-Id: <20181112080557.22698-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding and driver for the QMP based side-channel communication mechanism
to the AOSS, which is used to control resources not exposed through the RPMh
interface.

Currently implemented is a genpd provider, but pending some improvements in the
thermal framework a cooling device will be added at a later point.

Bjorn Andersson (3):
  dt-bindings: soc: qcom: Add AOSS QMP binding
  soc: qcom: Add AOSS QMP communication driver
  soc: qcom: Add AOSS QMP genpd provider

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       |  63 ++++
 drivers/soc/qcom/Kconfig                      |  15 +
 drivers/soc/qcom/Makefile                     |   2 +
 drivers/soc/qcom/aoss-qmp-pd.c                | 135 ++++++++
 drivers/soc/qcom/aoss-qmp.c                   | 313 ++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     |  15 +
 include/linux/soc/qcom/aoss-qmp.h             |  12 +
 7 files changed, 555 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 drivers/soc/qcom/aoss-qmp-pd.c
 create mode 100644 drivers/soc/qcom/aoss-qmp.c
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
 create mode 100644 include/linux/soc/qcom/aoss-qmp.h

-- 
2.18.0

