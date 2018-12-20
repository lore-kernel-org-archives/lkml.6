Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB88C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E1E2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuuCvJDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbeLTBHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:07:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40485 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbeLTBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:07:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so28511pgp.7;
        Wed, 19 Dec 2018 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Fnlz9d2Srhxso67QeGY6H/NOUQaHJHanzZ1PY2k3RE=;
        b=SuuCvJDwCeikOL5OpjuLKSkyIHLn5+UK727MbIaoNXwHbwgWHP4EQoqlFop0X91T0i
         /mU4HvU1A26gh+jvxrEjfI46hk09c8pk2ak5ePMjmXI82/nLcqqExEZ4AUwFa3Pk36dx
         XC7mxQPqaMU1dI8WntKbOKxOFWQAsBIr+bLDpclfsRkqj8UU0iVUNQFGsPKgu0/QMn1c
         ZpA+tZFrZ8qzZxDre+VlWdIw4fN3ILIdRMSrBzOM1c1v8iI82N5ky+USRYcsyXwStc7C
         dh9DqAkynfEz6YaBO2ONo/vO8htx55fs2qRun8zSZePi6h4EyIAunCH1pAOdxYd6MoQN
         F04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Fnlz9d2Srhxso67QeGY6H/NOUQaHJHanzZ1PY2k3RE=;
        b=W/YglS5wRoNyxAK1thyzxcxnGxXNhXp0Lhvwje/Ei3FfOXXwZ+MTvREe6VBAA4f6L6
         /50tF8gB2dH+Enh+eCpJVnHGaTBXeO5x/lIxKCocXQ3es+8gWT7sMmomZ9KKkeOB7cGA
         1caJ6oR/s1pVgWQUC6rqNgzsmqsSpvf2MWctZ6ovL/0wkxyJYc8nK366gNsM7mfg7wND
         BP4z4nNd9qw2HHkPDGY7LGtx/wpt0uHcY0/H2OKTBYkscrLJKJWHGvK4HZxtcAJr8L/d
         1MkI7nznD7ianRkTe69HhtqGb37Ic+OYJCox8IJNSU3PZXbK4yJVj6Dkk/uztuvdPNe0
         ZBFQ==
X-Gm-Message-State: AA+aEWbz4lLBwb/cce4GWG5hPsOWQ6w0D/clRPF2VE83Sxh4AnihTgJv
        rhz2eNvImZFXyPv2uJbefNU=
X-Google-Smtp-Source: AFSGD/VtLRe7FWiBnDkmUVikPEMICozZCf3bxFg6DhSdTNQxarH/dcKcBBgQLlWGGc6VXAmIgJGMCA==
X-Received: by 2002:a63:7c6:: with SMTP id 189mr21752673pgh.129.1545268038582;
        Wed, 19 Dec 2018 17:07:18 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 83sm29008612pgf.57.2018.12.19.17.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 17:07:17 -0800 (PST)
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
Subject: [PATCH v4 0/3] Reset controller support for i.MX8MQ
Date:   Wed, 19 Dec 2018 17:06:57 -0800
Message-Id: <20181220010700.8598-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This patch contains changes I made in order to add support for i.MX8MQ
to reset-imx7.c in order to enable support of PCIE IP block on i.MX8MQ
SoCs.

Feedback is welcome!

Thanks,
Andrey Smirnov

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

[v3] lkml.kernel.org/r/20181217023827.7947-1-andrew.smirnov@gmail.com
[v2] lkml.kernel.org/r/20181128043738.12714-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20181117181131.9330-2-andrew.smirnov@gmail.com

Andrey Smirnov (3):
  reset: imx7: Add plubming to support multiple IP variants
  dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
  reset: imx7: Add support for i.MX8MQ IP block variant

 .../bindings/reset/fsl,imx7-src.txt           |   7 +-
 drivers/reset/Kconfig                         |   4 +-
 drivers/reset/reset-imx7.c                    | 166 ++++++++++++++++--
 include/dt-bindings/reset/imx8mq-reset.h      |  64 +++++++
 4 files changed, 221 insertions(+), 20 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

-- 
2.19.1

