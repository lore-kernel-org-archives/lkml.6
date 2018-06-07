Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ags/J9A7GVvbLwAAmS7hNA
	; Thu, 07 Jun 2018 14:06:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DA9766089E; Thu,  7 Jun 2018 14:06:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pW/7ie5P"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9285E6063F;
	Thu,  7 Jun 2018 14:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9285E6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932919AbeFGOGI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:06:08 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44223 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932578AbeFGOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:06:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id x4-v6so1854139wro.11;
        Thu, 07 Jun 2018 07:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sOdQ8EKFhBNFMw+E82LuxazXgc68KbcyrpKVqSRtUQ4=;
        b=pW/7ie5PTTLF0RYWk8ZNTkJtxMVP/vfXxJEXevzOLpcPK8YspshbwddkCVjuvm2Etj
         K9Zj3N5FEVYyuoOet9o/QB6FY0nEUKW6+fmy5FLhv3dDSX0aczazbrH0qcvhRZ5/ECYR
         ZtRD9c0CqnsbDzoGHkBmepVlJbgjlKw+gGk0syNOEW+Et33cS4+17oPk5mSGUfSlx2uS
         PPqcq5ooO+J07ZzQlOqV7QYbhQgj0+OIfWz9JFrhGD+c1pDxCP8qf6Bm3AUNTBEWGl3N
         FXOs+Qc8luUX5VprpbT7+uhugAQb4/r+Eggst+3G7KAfq0gPvokJPfMyuYYy/Yc2PlSm
         8PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sOdQ8EKFhBNFMw+E82LuxazXgc68KbcyrpKVqSRtUQ4=;
        b=LnVg7dLfKL1ur0hPcoH6YHgtY/mhbbz01lDLtrq8ugagKnHKy3KePT5byJUf2XmkDX
         bGK7NaXcdsYu8kEcMz8ztFmPQAA7nXZm1/u40ohbwVKWGedkxDcF7QAz4PWSknmiIAv9
         KOoUkGSnCpm2kqAWndnZk0ZIs8HtkjenbFjvmcE5rMCM28pm48gwxY5QGFTB33BkwubK
         O6HSAZKYnQCple6/BPIvP6mxZ7FrMketl8Hm8QYf3E4ewxsVODQChquq9C7BSH7tpcnR
         QgV7s8Q0GJyJb99Hvpz/8agKu+qDQ1uM5KTt92Jt3YoiTeZ3I5apCwxQYSxWw2/hov00
         GZlQ==
X-Gm-Message-State: APt69E12H6FRH2IXX9QewbeVjbWcpWR7FQ7nwS69801jSfkSAf3if43z
        SKzeIDEq9p5db+L9VXcfzcE=
X-Google-Smtp-Source: ADUXVKIpn2lx+mIp3aqLWtKtVvBpzPQfioYs+a1ssDEBiG8g3FQlN9cMqddliy++ULEVqfH7McnaRQ==
X-Received: by 2002:adf:b92d:: with SMTP id k42-v6mr1887592wrf.116.1528380364277;
        Thu, 07 Jun 2018 07:06:04 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id 135-v6sm2032331wmx.21.2018.06.07.07.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:06:03 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v6 0/5] Reintroduce i.MX EPIT Timer
Date: Thu,  7 Jun 2018 16:05:39 +0200
Message-Id: <20180607140544.22268-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Peron <clement.peron@devialet.com>

As suggested in the commit message we have added the device tree support,
proper bindings and we moved the driver into the correct folder.

Moreover we made some changes like use of relaxed IO accesor,
implement sched_clock, delay_timer and reduce the clockevents min_delta.

Changes since v5:
- change epit to timer in doc example
- fix typo in imx6sl.dtsi

Changes since v4:
- removed ipg clk
- change in dt epit to timer
- add introduction in doc
- add all compatibles in doc
- update epit entry for other i.MX device-trees

Changes since v3:
- Clean Kconfig
- Rename imx6q-epit to imx31-epit
- Update doc and bindings
- Indent and fix

Changes since v2 (Thanks Fabio Estevam):
- Removed unused ckil clock
- Add out_iounmap
- Check and handle if clk_prepare_enable failed
- Fix comment typo

Changes since v1 (Thanks Vladimir Zapolskiy):
- Add OF dependency in Kconfig
- Sort header
- Use BIT macro
- Remove useless comments
- Fix incorrect indent
- Fix memory leak
- Add check and handle possible returned error

Clément Peron (2):
  ARM: imx: remove inexistant EPIT timer init
  dt-bindings: timer: add i.MX EPIT timer binding

Colin Didier (3):
  clk: imx6: add EPIT clock support
  clocksource: add driver for i.MX EPIT timer
  ARM: dts: imx: add missing compatible and clock properties for EPIT

 .../devicetree/bindings/timer/fsl,imxepit.txt |  21 ++
 arch/arm/boot/dts/imx25.dtsi                  |   8 +-
 arch/arm/boot/dts/imx6qdl.dtsi                |  10 +-
 arch/arm/boot/dts/imx6sl.dtsi                 |  10 +-
 arch/arm/boot/dts/imx6sx.dtsi                 |  10 +-
 arch/arm/boot/dts/imx6ul.dtsi                 |  10 +-
 arch/arm/mach-imx/common.h                    |   1 -
 drivers/clk/imx/clk-imx6q.c                   |   2 +
 drivers/clocksource/Kconfig                   |  11 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-imx-epit.c          | 265 ++++++++++++++++++
 include/dt-bindings/clock/imx6qdl-clock.h     |   4 +-
 12 files changed, 341 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt
 create mode 100644 drivers/clocksource/timer-imx-epit.c

-- 
2.17.1
