Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BAC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CC8204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOZc1n9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CC8204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeIYETq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:19:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45166 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeIYETp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:19:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so5125086pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LibpY87Nem8smoDo/amUbG45b69wRW87NSn/ngE5KHc=;
        b=NOZc1n9R397H6Aud4LEBCarQ3zxwwr1uyrrcxy8Fp3KFXAvYIqdIQ0BLEThhxTxgbq
         AN/mg7o55Qb3QJEWbsR+srRWRmjCky4rUGz7oT8U4kjfxHulq33g8y34oyyNfr6jYyoC
         YF+KwBkFmozVwZGlC+6ApjE3fdh1NSex8YLvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LibpY87Nem8smoDo/amUbG45b69wRW87NSn/ngE5KHc=;
        b=ksuMXuVpNyism4ffoVNDCsljt1MwGQ1D4/kWATBYmwh/juiM+NVrHbYKQjUjPI3Vuw
         8qAHWOL2UyffCjv8zJLK/uCVKPjxle8DkmdpzUOQQggNNyV5bfad0RSwHQVKNzf5/elH
         Y0sfcfAYOA7orLmZgLdL+YeI7649/NBpOBHqq2qgaodx9qbpdB9uwEOrmc/hN2A3nAD9
         n4BExBw6/bZSABFvWXdoJWYUTX1kyKl9vRZM0jPFyi7jCsjxkv6tkd3nYfNTLo7GJK3r
         TIMGRtdvUJy2Xm706qKYldLB0CGAuSxVJwt4ZAx4Kv0EKfoAAbE3TZMuzJmcJk3cETcs
         iy3w==
X-Gm-Message-State: ABuFfojbKr/QiTwHn7CK8ivW4uliDTvcClMnmjAE3Aoh7qVDyofapG/m
        r1sFCw2ehN6z2BdFTLLpm2h4RA==
X-Google-Smtp-Source: ACcGV63sKlcVttlK37IF6jDGUesu0Bx8CLSskZZuwSMoISSnVBJHO5Q1lcwqeYbN2SMGS/RWY7gM8g==
X-Received: by 2002:a63:d917:: with SMTP id r23-v6mr673562pgg.0.1537827323387;
        Mon, 24 Sep 2018 15:15:23 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w23-v6sm386260pgi.18.2018.09.24.15.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 15:15:22 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Qualcomm QCS404 TLMM pinctrl driver
Date:   Mon, 24 Sep 2018 15:17:44 -0700
Message-Id: <20180924221748.21584-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces register accessor functions and a level of indirection
for these, in order to handle dispersed tiles. It then adds the TLMM binder and
driver for the QCS404 platform.

Changes since v1:
- Rebased series on Linus' "devel" branch
- Dropped leading 0 in node of DT example

Avaneesh Kumar Dwivedi (1):
  pinctrl: qcom: Add qcs404 pinctrl driver

Bjorn Andersson (3):
  pinctrl: qcom: Introduce readl/writel accessors
  pinctrl: qcom: Support dispersed tiles
  dt-bindings: pinctrl: qcom: Add QCS404 pinctrl binding

 .../bindings/pinctrl/qcom,qcs404-pinctrl.txt  |  200 ++
 drivers/pinctrl/qcom/Kconfig                  |    8 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c            |  116 +-
 drivers/pinctrl/qcom/pinctrl-msm.h            |    4 +
 drivers/pinctrl/qcom/pinctrl-qcs404.c         | 1697 +++++++++++++++++
 6 files changed, 1983 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
 create mode 100644 drivers/pinctrl/qcom/pinctrl-qcs404.c

-- 
2.18.0

