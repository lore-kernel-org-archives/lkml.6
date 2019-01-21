Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CACC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E772087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MvuzBS9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAUKVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:21:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32867 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfAUKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:21:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so9637344plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ussECRD/mXUu7sFZh4zdG6qGENVe+0LQr/6NdK4aNFs=;
        b=MvuzBS9fsHQhKFhUsIbgcHA0g9NYkwADSoW/GdcjVY3MyuK8ELLT20OkWBbyNsivGW
         sJvbbS/J9mYzYVzgzzpnmrBJNIcu8o/nU1w4OizPlK34cxaeRQGPWIIRlRxidalaVS68
         Aq8WDYTkcXg3xj00KfHtRfF1XgzEXN0ExwG5z8dCqO64Z/6G8Qdg+7kpi47aIce6BHpu
         5APBEgChmmVylj1IqM7FMdSij7tt0nslWtBsaXstZ5yNDxwpjlVEcnYcmulEvrCG1kdC
         xOIpmXO4u0PoO42ZO09QhIRVSHbhXMqqXHOP30Ntx8lI3JW70uyTs8E4MegeL4WbB8Mo
         Biog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ussECRD/mXUu7sFZh4zdG6qGENVe+0LQr/6NdK4aNFs=;
        b=D3Nre6jpwKNjKSObdrqEUCSwALqujQ5uFPxtqw1Ka23GTOEi3dvn3PzqQj8tMAH9qo
         1dlhgKFz46NDUgbOWZkYpBHLGYuPA2qea0xbvARPRxoZjcl7vLCLDrtFTtBAQRa9brq3
         VXzIOvbBr2f6JxqEs0c+rMGGKEA2FmyspFL9fCimwPfdY3214LiRBKloU2XFj9GVcmLU
         T1C5L+ETSwcEIxd7HUKCLPPboMrpcBBwq7bvuqxi56Duwh0lmjaLkg6PpAf+L/Z3d1Aq
         3qutTrzEGg/HPWxh8zejrsHWIrFd6SsJ7A9Q/KL78dk0qIw/8n9iHUMgXSmNblWGD/+I
         cKTw==
X-Gm-Message-State: AJcUukcsIg5yjANDs+eJ5ZXbzvPq8VNgKIpsRmbjiaZH9Tka+VP6C4A3
        7pZ4YqnkSEYBCMSh9Axdg/mB7Q==
X-Google-Smtp-Source: ALg8bN4F8SM0jOq9s8SrKkgl8Cfqe/F6xesVwzUODKS0dHpf7Ue4iUk0mcvIRfAWTM/6ANm+h+a4Gg==
X-Received: by 2002:a17:902:7e44:: with SMTP id a4mr29604824pln.338.1548066063955;
        Mon, 21 Jan 2019 02:21:03 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id m85sm20048874pfj.171.2019.01.21.02.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 02:21:03 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v4 0/2] PWM support for HiFive Unleashed
Date:   Mon, 21 Jan 2019 15:50:41 +0530
Message-Id: <1548066043-1252-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

v4
- Rename the property sifive,approx-period-ns to sifive,period-ns
- Rename macros with appropriate names
- Remove unused macros
- Rename struct sifive_pwm_device to struct pwm_sifive_ddata
- Rename function prefix as per driver name
- Set deglitch bit before changing output waveform.
- Other minor fixes based upon feedback on v3

v3
- Add a link to the reference manaul
- Use appropriate apis for division operation
- Add check for polarity
- Enable clk before calling clk_get_rate
- Other minor fixes based upon feedback on v2

V2 changed from V1:
- Remove inclusion of dt-bindings/pwm/pwm.h
- Remove artificial alignments
- Replace ioread32/iowrite32 with readl/writel
- Remove camelcase
- Change dev_info to dev_dbg for unnecessary log
- Correct typo in driver name
- Remove use of of_match_ptr macro
- Update the DT compatible strings and Add reference to a common
  versioning document

Yash Shah (2):
  pwm: sifive: Add DT documentation for SiFive PWM Controller
  pwm: sifive: Add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  37 +++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 262 +++++++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1

