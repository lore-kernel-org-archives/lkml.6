Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0527EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82A2222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZqUogImA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfBMJ0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:26:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47053 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfBMJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:26:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so864952pfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zUr8SWKldEF6gVUMQuEkEMpWrr/VC2B6XExLDaAwFwU=;
        b=ZqUogImAXCzLKe4cs58noWJkKNaGdzd/69cpyY4r9RHJthIsBQIfouss8IF+Xn3hre
         0hyQnrWP1Tk5imN2x+bZBzjxLaCd1Ut/gkbp/36YkfpJOzklj4rfNhQO5/0yo+Zq65Xo
         77Rt/VCEpj3p8iGGHaM7YqfK5rggn/sSwCz6vNIgBwiaffZ6Kar9djzuIEaN5wWubxda
         df15Iv55eAhvjnFX86zqhWAPg4ZGejEU2T0TuLn3vIZ6qkwuKQQACLPOgXdaAi8i8Wp5
         wOGUtHhFDXFxiMgnr1fonQwt8urdaC7BqNN0RUZ21Jktf/TEwAPA3jzatwW4Z+eo2ViV
         LZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zUr8SWKldEF6gVUMQuEkEMpWrr/VC2B6XExLDaAwFwU=;
        b=J03O26n01jBR813HaAaAte8lILBOP4PQPb7UT3grVr5aahu2JpYvyINBtOaac0bEW0
         I+KFxdHJ/xZ4Irm/oVJr6uvfnx+efExBY53238rsu32cRRSNmwkNjYI+/QFfPYVy8MOS
         bXrnHZKN+DCzDXSgXPb8wG3yMvkOI+QONGPIbONTPcYmtjM8weKuP50S0nK23m+gARgq
         +6IwooC250Z4ZfQr/l9mrPUqmMtHaL/WXwmvfnyvK/11V1wiL6qvNDZIhoe1grSgFNQ+
         MPKVUsG7xH7/rJBqEAzR9mSuiSpshB84P5MIvZcUYz6ZrXtzZfPBdENct97Cr1KPTjct
         l1hg==
X-Gm-Message-State: AHQUAuZScX1Y37gJOenW4RJFQccbctyGr1n+Ar/xs3+akXabYJJJTzll
        qioXlnrycq7E2VIL/adwys+33A==
X-Google-Smtp-Source: AHgI3IYtqFQlc45qRacptA2GmN/OvEGXDFwKydbdzUjqhBVbu8YCMriSH9gNJ7NvsLkmLOBDd/IHeA==
X-Received: by 2002:a63:3541:: with SMTP id c62mr8016429pga.191.1550049991254;
        Wed, 13 Feb 2019 01:26:31 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id v75sm188875pfa.164.2019.02.13.01.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 01:26:30 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v6 0/2] PWM support for HiFive Unleashed
Date:   Wed, 13 Feb 2019 14:56:16 +0530
Message-Id: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

v6
- Remove the global property 'sifive,period-ns'
- Implement free and request callbacks to maintain user counts.
- Add user_count member to struct pwm_sifive_ddata
- Allow period change only if user_count is one
- Add pwm_sifive_enable function to enable/disable PWM
- Change calculation logic of frac (in pwm_sifive_apply)
- Remove state correction
- Remove pwm_sifive_xlate function
- Clock to be enabled only when PWM is enabled
- Other minor fixes

v5
- Correct the order of compatible string properties
- PWM state correction to be done always
- Other minor fixes based upon feedback on v4

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

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  30 ++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 311 +++++++++++++++++++++
 4 files changed, 353 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1

