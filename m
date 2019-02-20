Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0460C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5F62146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8ey+LPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfBTB7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:59:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42540 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTB7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:59:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id s1so11346234plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AhAkdD5gUkatrgiNywh2j86mG6voK+vMLb21Nz6l14=;
        b=g8ey+LPaM/bLLOK/8rDS4SpWU8T3BIIz3s2kWJLlgYxtaNJEV7DlDx0tKwJA0zJZeE
         7oJ/fZOGx8JYOLZRjyXVwIXfKDDOaoRhYuDxTssG9EA4hRxH09zb5BGX9Fr+/APACBJ5
         EpezqnLoHwVby2FjvuHQ1nOknq7Wq51qcsqE/KlbfCnv9njXr18M7ucS5dgJay3DdoyK
         JBf3x7sPyNOCrCR6lxfRcxN7uBT+PZHMSyE/or652QCkvR++KDAEifd4HzwYev7907z6
         4PMyHuQy6JuUU6mq7D/68ZrwHL40CXJpcv2692AjRwJ6d2U6Fqu3AWXd0Tnkq9QQ9CvQ
         t16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0AhAkdD5gUkatrgiNywh2j86mG6voK+vMLb21Nz6l14=;
        b=eJzULpCNkWSVIsLw5TyfCuskVuuwJ200oEcAwa3qxUa1qmTtVegInx9+Ts3sQUgT0h
         Xpt+ewTDfFr0GJTaWg+dvqEpPs5azRJWVDZhRtZpFNW/A5y7fL0zeepSPPY/yFwm9L/X
         +lNB6nJfWQRKN1IaFBzciRzCdawVZX5P+lJgaJz6R+MXj2tZjHldX0+GhrBezpiGnS/5
         vT8Lfqjd7BuM1rzX5nGOhg6yaibhnMQS71j5B448G+/X6jOhXfPhiacM2ov8eAT7c6wM
         6b8rZUwbG6dVumQFpYVxPoJlnF6jA7omQ/LSbPtCgrtunj8vMg8g8W5BGw9wO7NN/65p
         m5mQ==
X-Gm-Message-State: AHQUAuZ4yPBg0wiT/eDz4Uf8R41wQMA2X2j8yusYX6WJj9QbjI+Gsl2V
        ZuIIWrG3zd7RBX5Gpn9VBS8=
X-Google-Smtp-Source: AHgI3IarupgyVmOC5WCvUDeU76ra+IXRYsp11Idz32OislVJe2GyEFOsd/Z1NZ304VFlHrlZu+O+Jg==
X-Received: by 2002:a17:902:6681:: with SMTP id e1mr33612362plk.98.1550627948547;
        Tue, 19 Feb 2019 17:59:08 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:59:07 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] PCIE support for i.MX8MQ (DT changes)
Date:   Tue, 19 Feb 2019 17:58:52 -0800
Message-Id: <20190220015857.7136-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains all of the i.MX Device Tree changes I made to
enable support of PCIe on i.MX8MQ EVK.

NOTE: Immutable brach containing imx8mq-reset.h used in "arm64: dts:
Add nodes for PCIe IP blocks" is availible in [reset-imx8mq]

Feedback is welcome!

Changes since [v2]:

    - Fixed various nits pointed out by Lucas

    - Collected Acked-by and Reviewed-by from Lucas

    - Moved EVK's WiFi reset pin configuration into a separate pinmux
      entry.

Changes since [v1]:

    - Dropped unsupported IRQ from PCIe nodes (a leftover from vendor tree)

    - Added "pcie_aux" clock and moved clock configuration to board
      file since "pcie_bus" clock is now board specific

Thanks,
Andrey Smirnov

[reset-imx8mq] git://git.pengutronix.de/pza/linux reset/imx8mq
[v1] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com/
[v2] https://lore.kernel.org/lkml/20190208002941.30343-1-andrew.smirnov@gmail.com

Andrey Smirnov (5):
  arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
  arm64: dts: imx8mq: Add a node for SRC IP block
  arm64: dts: imx8mq: Combine PCIE power domains
  arm64: dts: imx8mq: Add nodes for PCIe IP blocks
  arm64: dts: imx8mq-evk: Enable PCIE0 interface

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 42 ++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 84 +++++++++++++++++++-
 2 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.20.1

