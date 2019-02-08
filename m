Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58891C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261E92080D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djkzee7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfBHA35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:29:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43386 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBHA35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:29:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so753741pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvKYzIXrc6EWu7dGE6oPMlu2MVBMRNsjV1h+Z0dn2TU=;
        b=djkzee7IYtTa1/ecxtM3tKYtPMEEUm0M5c8WlKmB13/9CUivkYqps2+OROfExObpxl
         ceuuktpwobG/1itfQj5UbzrvJR3Ed96kZvE5uYXeIpwKgLjgSWthoA28uvL7D5d29IUL
         ZXPBEoxwuaEkvMwDr43gXuY0MqDajxpvmopTdKT5o/Nna0QTFOuuj/Zf/1FwDI2DNX3j
         f79Nzq0fhd2RbhLwgatg9N1NttgmDswWQRsG5WK7E/rd3gtPMQgZ6DA6sY841TKbvHVK
         MuoZwlyqdZh1ASGm+u7R4AnwWlJVJ3kEZvncdRYbrd6A/D3NeogK3QWDKON2Rc7XPTBd
         YcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvKYzIXrc6EWu7dGE6oPMlu2MVBMRNsjV1h+Z0dn2TU=;
        b=fmsyVDi54P4/Ne3OikNDkpnTi+XpoWSMjlNMevihLyhDiByim0HkoiJEINyK3Udsfr
         BfCfo2CAIimKaS5heEGLg5gHfGKthj/9CysBNV0lXoEfykBsHWJMbi09o+chzZEUlbT1
         okZtC4w7CRfurFPV+C0nPp5RDB6l6BbvgBaomcn/oRt+sg/mHlrUT7dqzBYvhiTpEBZy
         0R+qd0wGdjU1sXWUp81lA43js/QAXati5MADE8F6+guz4nBK9gTCUrBGYgp4x5tUiOJD
         E95/Q5//L/8WKQj2sMDFYySfrNJR47sjG54LEyk4JAmk9byhb0JQ0wjmhoKLCalw4dAo
         /YjA==
X-Gm-Message-State: AHQUAubKJaN7hJ/TsV9qFWhHL2Nne3WEDTl1cuJ+KQeSG/UwleuRO8xU
        qfzOnMZzV48R0/XjBow/cKs=
X-Google-Smtp-Source: AHgI3IYOt7O8HUcXtRzHPrk9cV4X3PXvHzlomx/ok846UDy9gvtwtHtcQTrtfvEfBpk2YxgwLgRXsg==
X-Received: by 2002:aa7:8503:: with SMTP id v3mr6244163pfn.255.1549585795808;
        Thu, 07 Feb 2019 16:29:55 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:29:54 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 0/5] PCIE support for i.MX8MQ (DT changes)
Date:   Thu,  7 Feb 2019 16:29:36 -0800
Message-Id: <20190208002941.30343-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains all of the i.MX Device Tree changes I made to
enable support of PCIe on i.MX8MQ EVK. Marked as RFC since "arm64:
dts: imx8mq-evk: Enable PCIE0 interface" contains proposed AUX clock
binding that is not part of the PCI tree yet (to be submitted once we
agree on this RFC).

NOTE: Immutable brach containing imx8mq-reset.h used in "arm64: dts:
Add nodes for PCIe IP blocks" is availible in [reset-imx8mq]

Feedback is welcome!

Changes since [v1]:

    - Dropped unsupported IRQ from PCIe nodes (a leftover from vendor tree)

    - Added "pcie_aux" clock and moved clock configuration to board
      file since "pcie_bus" clock is now board specific

Thanks,
Andrey Smirnov

[reset-imx8mq] git://git.pengutronix.de/pza/linux reset/imx8mq
[v1] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com/

Andrey Smirnov (5):
  arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
  arm64: dts: imx8mq: Add a node for SRC IP block
  arm64: dts: imx8mq: Combine PCIE power domains
  arm64: dts: imx8mq: Add nodes for PCIe IP blocks
  arm64: dts: imx8mq-evk: Enable PCIE0 interface

 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 34 ++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 87 +++++++++++++++++++-
 2 files changed, 119 insertions(+), 2 deletions(-)

-- 
2.20.1

