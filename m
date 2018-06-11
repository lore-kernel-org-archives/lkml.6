Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pYK9JhSaHls/UAAAmS7hNA
	; Mon, 11 Jun 2018 15:50:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E57EF607E4; Mon, 11 Jun 2018 15:50:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBVPjlre"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 67C7560385;
	Mon, 11 Jun 2018 15:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67C7560385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933084AbeFKPuN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:50:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33272 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932840AbeFKPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:50:10 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so20957047wro.0;
        Mon, 11 Jun 2018 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IqrF5xQZL9cGzVsE3jN0+cvBorfbxRMWbM4y1oFNTTs=;
        b=vBVPjlreT4XLdt1BiYIIW33Wbyn0FEiz4u1IZFEhsg4cphqwMa5wmnW/7pVXAQ8jO1
         sZ7r0cCuQlQrLue6pu7YqDHQnoksVnMcnF/ocSh8CYa9h0D9BNNXAlZYteIi91RAhI6K
         6nAVqThNZcydqws1euVH8qMVcQ2fxkjupEyBEIHxImXBVjwNYxLctMFfNy1eJ5peC7e8
         7xJlHuBIlWq6qpFwU9xlBSQO2RC6VYaHBTul0hZmRhlLQdJWu+vEidl5ZKOkpEChdXEY
         mbwh601EC0YQcziLCEFlPhxQIWyi4nW5ekW7q005JjjlYnJMxVmDQqn3jaSIB7Qo7lwe
         ynJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IqrF5xQZL9cGzVsE3jN0+cvBorfbxRMWbM4y1oFNTTs=;
        b=QaZrs8vPTLcdccX2hzTH36fFdlFuoPEDDZIE7a50eUMFdgbulBXzVuFlAlTrBh+Bsx
         c5l2vrk/zNwRPgnQ+zlnqDIO4yqO8B9d7qgy7MbdfCaT+dCL1oTXsWY41pTW8GwSAsO1
         RhpeI+vQ96AESmSOGz56WgEBI/eBt5aU8lev//luBXg7xGAtN7EZwL0gfWYatGlZGItb
         k6Sf+i70VAJ0Dt4NSWgeI7qICc9aILS2vnXyRFzjXBmDLcPEv2iafkXkkK6WbZbn+TuG
         w9k7Wgw6Cg9hC8OecKC/QsEy8hnmvk2UM973lM07ihe1eeWdbQXmvzSDCvTgn5EWgDPG
         DT5Q==
X-Gm-Message-State: APt69E1NBRn4yMMrcjktqjljZJ7bGHji27kwYwuyd3vHGdW1/0W56Cb+
        DrFN/2SvcasQIuGr6wThrSo=
X-Google-Smtp-Source: ADUXVKLYVwvoY1KKNdvwVReIM20hAyC3GiKHkBP1fgy1cJgUIGF1+xRyxh65/beulJYxs4bDC9KwKg==
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr12673525wre.268.1528732208796;
        Mon, 11 Jun 2018 08:50:08 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id n11-v6sm30308862wro.13.2018.06.11.08.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 08:50:08 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Stefan Agner <stefan@agner.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v7 0/5] Reintroduce i.MX EPIT Timer
Date: Mon, 11 Jun 2018 17:49:56 +0200
Message-Id: <20180611155001.3506-1-peron.clem@gmail.com>
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

Changes since v6:
-fix indent

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
