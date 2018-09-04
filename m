Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CE8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDAA2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UB+pZ05S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDAA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeIDJW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:22:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43041 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIDJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:22:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so1021168pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 21:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SX6tEWZKoWeE6nRzXQ10cca3lv0FvOb/0jbrk3nfRVo=;
        b=UB+pZ05SKsHy4EnrxnjKs1mqHtoeViJNnN90gSbyCM0kWBDiYx11iifGVszw5SIpJb
         sjENHjSxhUu/1O5wp80Hz8sC22fmSqTh+aSrwb1z7THx4K4p73L8awkQwtVKZBy9sxHw
         lAmf2ysovxYfK0newitoKbJswTFCV4FBElNNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SX6tEWZKoWeE6nRzXQ10cca3lv0FvOb/0jbrk3nfRVo=;
        b=YzYKAwD2VOw5DRvY2RAzryAibmzs8O+zNs5LpRfDyMh4xYrM+Pl2hTDZNKIQaPZ+65
         Sh5Uz+dMP7+7WaprCqxe3OFChANiyz0cGDfY0sHOEPToI4lLtvHIAruk6t6JbvfqpJdf
         O8lReX5cASCy24qA80I3FnUUm+Q5d0ICYn0TrJr/0gE+Fkud7iptSW0uFcgjPKdS0yk/
         ogKM6eKfxUwbwgu1Ao0Qt78Ck8/KDysh7nY+lvwg5nHfx5MwkrU3S6zxvViKgooQtO29
         XkiPXjJ8RUkCtD5EM9LAQgkg+25RbHyoalrbWjnVw8Brk7zmyLehiPJSBSK2QHw2DXVJ
         1Jiw==
X-Gm-Message-State: APzg51DqGpyZb8EDdmZ6E0AQQTsu8I5itLtmDna9pqHVJyM+jtXO/q/f
        wByq4hhC7LQXJ10UJR7R8OOxfA==
X-Google-Smtp-Source: ANB0VdZi/TLoTtBIMekZxtLJe7Djp0QZmPl+s9mEz7bQR3Y81yP8AVG3siXHaCcp2pDDuhRvd46tZw==
X-Received: by 2002:a63:c44a:: with SMTP id m10-v6mr29678073pgg.416.1536037174347;
        Mon, 03 Sep 2018 21:59:34 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v72-v6sm41180378pfj.22.2018.09.03.21.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 21:59:33 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] MSM8998 and MTP dts
Date:   Mon,  3 Sep 2018 22:01:15 -0700
Message-Id: <20180904050123.26601-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the MSM8998 platform and the MTP device for this
platform. Including additional 6 patches that has been waiting for the initial
submission to be accepted.

Bjorn Andersson (7):
  arm64: dts: qcom: msm8998: Add RPM and regulators for MTP
  arm64: dts: qcom: msm8998: Add tsens and thermal-zones
  arm64: dts: qcom: msm8998: Add pmi8998 file
  arm64: dts: qcom: msm8998: Add smem related nodes
  arm64: dts: qcom: msm8998: Add firmware node
  arm64: dts: qcom: msm8998: Add the qfprom node
  arm64: dts: qcom: msm8998: Add smp2p nodes

Joonwoo Park (1):
  arm64: dts: Add msm8998 SoC and MTP board support

 arch/arm64/boot/dts/qcom/Makefile         |   1 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts  |  13 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 243 ++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi     | 692 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi     |  40 ++
 5 files changed, 989 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmi8998.dtsi

-- 
2.18.0

