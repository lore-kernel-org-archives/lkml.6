Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CA6C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92D820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA+15C45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfAVCLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:11:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32849 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfAVCLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:11:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so10987636pfb.0;
        Mon, 21 Jan 2019 18:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyQi28qf9wAUEZJKJnhkwEaY0GUEmCMYRyGVAGowGy4=;
        b=hA+15C45UMjSctOBqciGbDQLJIOq6QZr1lpUgx5j5IQztlfkMOiOSUQOcEGM7rsoxw
         2uq9ixGO3nh8yg0jSQ35xbcPV/bwww4+rmL5plJ26hYEQvn+SzLgtb94kI/sfxheYNaf
         s+qY73YZAl6ZhYTsSA9nCGFJDm4ygWLrWd6yNyjPJHJ9ETeLqXyUv3Ix27AVx2dLwS0B
         6xmSV4n9EqFEZN5GlxDArRGb5mK70/TU2kDyHshB3xQ8BEI8+nZ7afzULqyZcKkVeKvC
         wKTS7zXOkzPdSmtEsDJl3McYOOtlwGPxdzhNKIbUb4FujHShHpeXA8OHYHW4QKC2c14z
         cTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YyQi28qf9wAUEZJKJnhkwEaY0GUEmCMYRyGVAGowGy4=;
        b=e3OYP7oB26up1v9v8vycK4a0dOVQcFGbbU2NkwbtAMyCaOKdfErXgL4a/kK7mev/+I
         LjC/PRq9btOecoL9KQpfUtvsInFrf97vlwwNjYMPEMVJN+9j6vueA2ByXpt/oDY5HQYq
         xd3B07eKOtgr1Ycy+RFiH2B7FvUDQx8ywX5nkojfyGgtjyWU3aCPZ5oc2gHpWmU+G6if
         0dQZaca4Xo8VWdhesCe12M9xmCTxBU5wCATuwljmBlXNQPbsWdJZmOrp7bAyCKH4+pVF
         MNaPiNnBfg/rEceF0G2YjXwSvFETO/xDjRKxNIaS/T/C9kMyKpsl8zn/LJ/hR2oZDSCH
         1iww==
X-Gm-Message-State: AJcUukc06lSuRcsnGvt6gOo/PFtjYxb+dbD/gk5pYS2xBkeeNaCFlZTl
        HCOJIiYY88WI6cbveiMVOtXCdzFK
X-Google-Smtp-Source: ALg8bN7vfNmJqfHLS+Hs/0UspmC7Rsw1uBCWJ+kwFXIuYLsRfJzEZkK4dVX+njUvprR2Avj6AAuJYw==
X-Received: by 2002:a65:624c:: with SMTP id q12mr30286444pgv.379.1548123063099;
        Mon, 21 Jan 2019 18:11:03 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c7sm19907267pfh.18.2019.01.21.18.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 18:11:02 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     p.zabel@pengutronix.de
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/3] Reset controller support for i.MX8MQ
Date:   Mon, 21 Jan 2019 18:10:40 -0800
Message-Id: <20190122021043.25449-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains changes I made in order to add support for i.MX8MQ
to reset-imx7.c in order to enable support of PCIE IP block on i.MX8MQ
SoCs.

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v4]

 - Reset driver reworked to support different IP variants by providing
   different struct reset_control_ops instead of having a .prepare
   callback

Changes since [v3]

 - Kconfig entry is converted to use ARCH_MXC

 - Collected Reviewed-by from Rob Herring

Changes since [v2]

 - Constified "variant" field in struct imx7_src

 - Moved dt-bindings/reset/imx8mq-reset.h to be a part of the patch
   documenting DT bindings

Changes since [v1]

 - Series re-written to use a per-variant LUT instead of using a
   single table

 - Changed driver to use "imx8mq" insead of "imx8m" to match other
   drivers and CONFIG_ARCH_IMX8MQ

 - Updated list of exported i.MX8MQ resets, add missing and remove
   bogus ones (hopefully nothing is missing this time)

[v4] lkml.kernel.org/r/20181220010700.8598-1-andrew.smirnov@gmail.com
[v3] lkml.kernel.org/r/20181217023827.7947-1-andrew.smirnov@gmail.com
[v2] lkml.kernel.org/r/20181128043738.12714-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20181117181131.9330-2-andrew.smirnov@gmail.com

Andrey Smirnov (3):
  reset: imx7: Add plubming to support multiple IP variants
  dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
  reset: imx7: Add support for i.MX8MQ IP block variant

 .../bindings/reset/fsl,imx7-src.txt           |   7 +-
 drivers/reset/Kconfig                         |   4 +-
 drivers/reset/reset-imx7.c                    | 172 ++++++++++++++++--
 include/dt-bindings/reset/imx8mq-reset.h      |  64 +++++++
 4 files changed, 229 insertions(+), 18 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

-- 
2.20.1

