Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302BD21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbvKFCkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302BD21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbeITHPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:15:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35746 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbeITHPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:15:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2-v6so3497286plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Dw9XD5uaw4SA3kk/JLsVYjuDcdC6ZEvfYLzJBJk0wJY=;
        b=cbvKFCkhQSekV6oH70of6A6ddsD1gXnA6xmwbWL6n/myYVOsdrWnMESM7GhNCVqmdN
         MyB2pPiXtcyo9To9iAjOLwL8Kg6iP4ioQovZZxd4yi9CIF2pxN3CE/H+3bbipe4PRUib
         3rajrLrDPrDnQiJCAGDWx88WPL44LBl9phpY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dw9XD5uaw4SA3kk/JLsVYjuDcdC6ZEvfYLzJBJk0wJY=;
        b=m9U0UXMtLgo4h/OEY+Em1eqh7UZT6jro6HlotujK2497YMqe2sL0cPR/rYCtUNlpho
         MqtsF674IPlLjTN4/TKbxmzL86GXTWfYOX4oP8Peim5v+dWxMik8aDRFtWAUIYa/VNgV
         62uky+Krm8jkV49gO5h4qfCQzPc0ads0XZwyu6bc9ig7LSzVuN7U+XyVIk/kOzHM8o76
         jxtH739JsE9ERF6wDfWSd2xhaAmmp2MONdAZ+IyeCdEFzD4XQO0zpODZ73xY7P68extp
         FXJy/6SnqeODCubpgOl6XTyB8qd9cZ+g4F8fQtTSLCp+0BUXJsFwCOdvnuCf3evftzKW
         21Sw==
X-Gm-Message-State: APzg51C25I70L4at1i4IXiuTpFeiBbiPgRHj8dpMB5Ugq2uB4HLWOmGW
        fgZeamb6hiOHa7B3yVqEUCjLjw==
X-Google-Smtp-Source: ANB0VdbOVvmd2YYKiPN6z9rzSZ3l51Xi/BSCX0tM6AFja726nTXLyWHlPA+ZyS7ggDt2gY2FNB3/NQ==
X-Received: by 2002:a17:902:8ec7:: with SMTP id x7-v6mr37160086plo.336.1537407296051;
        Wed, 19 Sep 2018 18:34:56 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l127-v6sm38753943pfc.55.2018.09.19.18.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:34:55 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Qualcomm QCS404 TLMM pinctrl driver
Date:   Wed, 19 Sep 2018 18:37:08 -0700
Message-Id: <20180920013712.2361-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces register accessor functions and a level of indirection
for these, in order to handle dispersed tiles. It then adds the TLMM binder and
driver for the QCS404 platform.

Avaneesh Kumar Dwivedi (1):
  pinctrl: qcom: Add qcs404 pinctrl driver

Bjorn Andersson (3):
  pinctrl: qcom: Introduce readl/writel accessors
  pinctrl: qcom: Support dispersed tiles
  dt-bindings: pinctrl: qcom: Add QCS404 pinctrl binding

 .../bindings/pinctrl/qcom,qcs404-pinctrl.txt  |  195 +++
 drivers/pinctrl/qcom/Kconfig                  |    8 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c            |  116 +-
 drivers/pinctrl/qcom/pinctrl-msm.h            |    4 +
 drivers/pinctrl/qcom/pinctrl-qcs404.c         | 1523 +++++++++++++++++
 6 files changed, 1804 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
 create mode 100644 drivers/pinctrl/qcom/pinctrl-qcs404.c

-- 
2.18.0

