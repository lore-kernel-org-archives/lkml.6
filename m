Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E91EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88282086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QU0ppiTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88282086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbeK1D1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:27:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52469 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbeK1D1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:27:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so22383343wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bDtNstNo/ih1kG006IdZCiKXJDG4jGEi/v6510V+8Mc=;
        b=QU0ppiTrR+cTy9+lTxcFHJYCSZu2MlMTLCidEjbNicvBUaqqZnArQb1pbRvJVvQd1S
         BnVlz3FKipeFHB5W0xcrRSN4+dbPA772t8HvCJhvvJmP/JfnHfKh3ce87+Idz6tNsX4K
         TPw8toBGn6b5HrLgIGz6L/xEgy3kEtC5Tynnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bDtNstNo/ih1kG006IdZCiKXJDG4jGEi/v6510V+8Mc=;
        b=e8v9TC23lcvMos64cxGD8BaqCskbhw1IGsDAUSxiUUWbgsuHF3PxmYLEqoUJOJUYnC
         Vyzz3EqEq+OKsrlp+/ttbD6kycz0JEyN7x9788dE2TckJo8pbu8OciLM45Rwa0NaAHSy
         H90j1bgj6s9Jx5h01QwrwPwiP8gOGBl0J8GzNRg8SnVVmHhKzrskNFVN+0EnzY4d7Cc/
         bgig8zQuFku2gix7y03nDRSpSygNEZ8XZ8yAX+eF8MEaXr0DaGd6OH4oB9CxH/K47OU9
         JrLNqYCyAfdATitTQSctI5d6iqf9SIi6fLn0JKVkFNH/GEpxSzC7/ba+gnvc3hD78U/Y
         JDfg==
X-Gm-Message-State: AA+aEWYa0Dm9FhSvkOUl2KoQfBkWI4NVKtkMPaItqawV3c2karkATjmX
        3qcaW6Eo3fYteIQNsl4zGfYRikzRGtE=
X-Google-Smtp-Source: AFSGD/VNDjob5bNghqi338V8x0E5QVANQXfaneJTIPIA3hlll5/lvf4G7h1rBJxTAJZqR2WOZmg6Hg==
X-Received: by 2002:a1c:47:: with SMTP id 68mr11746929wma.89.1543336159659;
        Tue, 27 Nov 2018 08:29:19 -0800 (PST)
Received: from localhost ([49.248.92.105])
        by smtp.gmail.com with ESMTPSA id p6sm3000745wrx.50.2018.11.27.08.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 08:29:18 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        khasim.mohammed@linaro.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH v3 0/4] thermal: tsens: Add support for QCS404 platform
Date:   Tue, 27 Nov 2018 21:59:03 +0530
Message-Id: <cover.1543335819.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Qualcomm QCS404 platform that contains v1 of the TSENS
IP. Introduce a fallback binding to handle "v1" functionality.

These patches have been tested on top of 4.20-rc3 + various qcs404-related
DT patches now in Andy's ci-next branch[1].

Changes since v2:
- Fix a conversion error in the get_temp routine the caused negative
  temperature readings (Reported by Khasim)

Changes since v1:
- Change p1 and p2 to be fixed-size arrays
- Refactor DT entries to be sorted by address, Thanks Vinod
- Added Acks

Amit Kucheria (4):
  dt: thermal: tsens: Add bindings for qcs404
  drivers: thermal: tsens: Add generic support for TSENS v1 IP
  arm64: dts: qcom: qcs404: Add tsens controller
  arm64: dts: qcom: qcs404: Add thermal zones for each sensor

 .../bindings/thermal/qcom-tsens.txt           |   3 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 226 ++++++++++++++++++
 drivers/thermal/qcom/Makefile                 |   2 +-
 drivers/thermal/qcom/tsens-common.c           |   2 +-
 drivers/thermal/qcom/tsens-v1.c               | 196 +++++++++++++++
 drivers/thermal/qcom/tsens.c                  |   3 +
 drivers/thermal/qcom/tsens.h                  |   3 +-
 7 files changed, 432 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c

-- 
2.17.1

