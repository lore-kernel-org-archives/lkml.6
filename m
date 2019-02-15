Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AC9206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNb4B/fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbfBOFuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:50:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42356 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfBOFuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:50:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so4294510pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 21:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sA+Vvw2lTBR5S/ltw5LqkxhREnc4rL79BcJlCx913Ig=;
        b=JNb4B/fpHLj62Zeod3pjootybp0V8HQEoT/qq4aowBL+QWEDF4twDiYatyOanqFQNn
         2NnB56bN1ltY2kXMdGvM5VRXVfjt3XPnrEThQg8MaNWC1ItF+7jwlDbKDQS4g3nm78Ai
         m6UmRWfPXtMhaDxpi2RkSyi49V84c2W7VnIDywMKjhbkV9xZjOVcjTyPbemeHfr8v3PJ
         qIYPFUpyVCQIMxpGVL9eIjoYEX7z6wPVhccbwmZZNjNH5DVW+O0DGJHurHXawOUpGocc
         6mHqyFBA69+zcGT/IZLz4ljc4oharL11p1J95+BloeUJeIckhyWb8zrUI1LTBmapiAeE
         gXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sA+Vvw2lTBR5S/ltw5LqkxhREnc4rL79BcJlCx913Ig=;
        b=ElJc7Ri1grRjanON6p7Bknkdy80M7JNfJYM010rhIvdpFwCftr61e+WorRT7ynVBCa
         rmkT7le/XvmCwD/sYyQX0I5NlU7MHHne8+pTl3xY0OLS3EfErmFboKvZAVtP1fH4xN9B
         oscqevS43gm03i90gG0lCLuAPuAHozi/M+LZ6MLjXzYfPCyhSwlmV4xDdDE/vf2BS673
         L7jJmhEimxuyh1GoYrAVi4qf3kvBrIVnBPPMr2fQzhPzjD+TiiAxVWdpPSLn4a684jCw
         yTD+EsCxcC2JLc/HXiPh1QGTwJ7o0vp1JKyu7JFPz+WhwSL5+jeIdsIzz4wC++tLkWzY
         DViQ==
X-Gm-Message-State: AHQUAuZOEmtuO+DO8DtHXUox0T5acRS8OQeDefUSo8fSuCjnc+wlF+Qz
        0G85ilPcCF6a+SfXfOyDurBp
X-Google-Smtp-Source: AHgI3IYnhhtSWSqEIIt7sbopij2F37mKuELKqF4CkPI8oU4iCud9g9++vtwPp4r7sf0/1L9ck9QhQw==
X-Received: by 2002:a62:2702:: with SMTP id n2mr8266930pfn.29.1550209808703;
        Thu, 14 Feb 2019 21:50:08 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98a:c91:14c4:f458:9909:7fad])
        by smtp.gmail.com with ESMTPSA id c18sm6160810pfc.63.2019.02.14.21.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 21:50:07 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org,
        john.stultz@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] Add Reset controller support for HI3670 SoC
Date:   Fri, 15 Feb 2019 11:19:53 +0530
Message-Id: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds Reset controller support for HiSilicon HI3670 SoC.
HI3670 SoC is architecturally same as HI3660 SoC, hence the same driver
is reused.

This patchset has been tested on HiKey970 board.

Thanks,
Mani

Changes in v2:

* Used the DT compatible fallback approach instead of adding a new one
  for HI3670

Manivannan Sadhasivam (2):
  dt-bindings: reset: Add HI3670 reset controller binding
  arm64: dts: hisilicon: hi3670: Add reset controller support

 .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt   | 7 ++++---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi                  | 6 ++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.17.1

