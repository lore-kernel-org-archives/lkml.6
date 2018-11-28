Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8E8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E748320873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0NdzsIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E748320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeK1PiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:38:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41906 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1PiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:38:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so9533449pfi.8;
        Tue, 27 Nov 2018 20:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhDvbeL/Pp5aJE8VKakCCdCfuRtbM3I0+LvIX5Gb4ag=;
        b=e0NdzsIM7EGOzcNc5pkjoOKSeXxB3n0OcUqn+e7RUhMmi6jzheCn5NmiVfZPSPlV/R
         ZX5j4iU97dTpTPCuv7zOOPrSutHeWNUyyyu0zv+yLPnQPqYRZardaVlClJKc4kNnSmdg
         14CKv76/brt6jLUlV2zW5QNYaG74TqrJdbap5aJ8yT2RPsVEhQNZG7tNVEg5pLtMAn+J
         /+b+o1ESQ2+VQ9WSzENz58GXKsFptDACnmtP1BSzP1bZHaIEQJPZylBmDpg7KuzZuJlc
         323MYcFWgqgxYvFvup/7xBk3PJUZHwYV9bY+CUvvbA1JVXmfMetbT2TO4RRfFRlC8+CA
         tjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zhDvbeL/Pp5aJE8VKakCCdCfuRtbM3I0+LvIX5Gb4ag=;
        b=s3dBS2cTAhw/xYqBn7smBNgwL5HM8Hr8x+ZWhsuCQTsRMV4P14IqQMmJ4FqH9EL9Dz
         GN4EMu17x06wJ5PPamHSLlsxk6behnGkZYAhax5nIOAy7WltzTcAlKuCOicliiK89Wzw
         teLP03B4Rn76YhwFX6J6Fbc8pfKol/pWDW5AzLbnbenc5dFZFrjDOggK2RQPxp9MkzjK
         byRqXNQwqa/1q8sWszAjtjeI0Upt4IqyAsJAX6J2QGbd+V0uKijbXvweTajLL3CU+rK4
         Q62JA7JEOF8W23Ck6gF1rxE3pwz0/MWwejMTUiMz8WrwAfLBu1gbxnnSwWPD+GnRHm2H
         CD9Q==
X-Gm-Message-State: AA+aEWYZS/8wn/gVjp/VYkwR2XFxS6GNxkmzac9g7Jpx/O5KRu83xjop
        3/vJpiwaV2nSXVVn6ZZmlKF4gGis4AI=
X-Google-Smtp-Source: AFSGD/W036FAkdCH5H3SfdSqq9L7IYrvx1QrF38ONnI9P4TOjcIqtubzC2GFO/CPA5wPXCklLEhbcA==
X-Received: by 2002:a62:de06:: with SMTP id h6mr32581968pfg.158.1543379871785;
        Tue, 27 Nov 2018 20:37:51 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v2sm6387369pgs.0.2018.11.27.20.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 20:37:50 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, p.zabel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] Reset controller support for i.MX8MQ
Date:   Tue, 27 Nov 2018 20:37:35 -0800
Message-Id: <20181128043738.12714-1-andrew.smirnov@gmail.com>
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
SoCs (full tree can be found at [github-v1]).

NOTE: This patch depens on CONFIG_ARCH_IMX8MQ introduced in [imx8mq]

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v1]

 - Series re-written to use a per-variant LUT instead of using a
   single table

- Changed driver to use "imx8mq" insead of "imx8m" to match other
  drivers and CONFIG_ARCH_IMX8MQ

- Updated list of exported i.MX8MQ resets, add missing and remove
  bogus ones (hopefully nothing is missing this time)

[v1] lkml.kernel.org/r/20181117181131.9330-2-andrew.smirnov@gmail.com
[github-v1] https://github.com/ndreys/linux/commits/imx8mq-pcie-v1
[imx8mq] https://www.spinics.net/lists/arm-kernel/msg687293.html

Andrey Smirnov (3):
  reset: imx7: Add plubming to support multiple IP variants
  reset: imx7: Add support for i.MX8MQ IP block variant
  dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs

 .../bindings/reset/fsl,imx7-src.txt           |   7 +-
 drivers/reset/Kconfig                         |   2 +-
 drivers/reset/reset-imx7.c                    | 166 ++++++++++++++++--
 include/dt-bindings/reset/imx8mq-reset.h      |  64 +++++++
 4 files changed, 220 insertions(+), 19 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

-- 
2.19.1

