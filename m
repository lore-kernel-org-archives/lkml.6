Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEB2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DAB20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRaGdIRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DAB20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeKRE3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:29:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37023 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKRE3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:29:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so6235685plr.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 10:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7QD3rFcJ5UVSOOADVgOnt7kzLV9zol3EBmTWLNTK6A=;
        b=GRaGdIRXUZGGo9QPDCl2p3ajxud6I7B2lBe/oGcJCFSA56iy0f0O1Q0jLafAwCJpJL
         hmxdVPvmaDV3brECNu0hTjLd98fkCUFw7VCa8eXCU/M8ZZ2fz7YyWZ90O3wB1ZGE+7Vl
         s3NOKGgYIraM2lANIVFjy/j32WQNYT5ah4z6dYVtMUfsuSxTzVBVesDxoqxt33sOQqgE
         YB53hjsP4dITCLbGceV6mc14IWN6j8hM+222NSELay8oqBsGKP44uQa4acGHH/wYLZgh
         c40RN0ILM1F+B8IYReN54hPsiZlxvbsQ0nLkf1irvpPPhgwEPFBbVswc1w/VQwNK5lXw
         Xapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v7QD3rFcJ5UVSOOADVgOnt7kzLV9zol3EBmTWLNTK6A=;
        b=H/KBjiYXwW1eAskdFlsc120ixb3Ob/Ab2L8+V9DpqEE+B606swIlYcZoDUGj6RPgwt
         sYnbU5TeEmanH4ig+VLcfd1R/VVQ8KM3KG1FH7MLcZNU1L/xG3Pbkh9PeJChlEaF1aR6
         jc698pJkN4+OpFNBk14d0ZQETN0Yfb6h5/EwO4EL30+1Re3u0OlMDpI6D6SrYCRtRrW5
         Whx3kHMat21pI0T6sssQHir1djJNl8b9kXpAJcM7cwdcHJDk/WAKaAgnCwI/+2PHTmbg
         7/t96ez/1VlSVWIHaee23bfL2PFB4sT0xAC6pDO4p9Yzw2O6K8INxBFhv6GfS9zuDhpJ
         7CWQ==
X-Gm-Message-State: AGRZ1gLyxj0hEFdmS5rjcsvPQP7LbTah09aqp9LnRevUrAoOblGCr6IT
        92nmdkaesKjP82CZJhV1umg5k1y/kN8=
X-Google-Smtp-Source: AJdET5ffVTLySnV+hSWCfrJ/P1COtwoMMChSSzMuF87SBxnidJ6AwBlfa/50M/WwAerDzZ6t87I+gQ==
X-Received: by 2002:a17:902:28e7:: with SMTP id f94-v6mr16007170plb.297.1542478332151;
        Sat, 17 Nov 2018 10:12:12 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g190sm34634026pgc.28.2018.11.17.10.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 10:12:11 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] GPCv2 support for i.MX8MQ
Date:   Sat, 17 Nov 2018 10:12:03 -0800
Message-Id: <20181117181206.10267-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains changes I made to add support for i.MX8MQ to
GPCv2 driver in order to enable support of PCIE IP block on i.MX8MQ
SoCs (full tree can be found at [github-v0]). This series is _very_
preliminary and by no means is ready for inclusion (it also has some
unmet dependencies).  However is should be in OK enough shape to get
some early feedback on, which is the intent of this submission.

All other feedback is appreciated as well!

Thank you,
Andrey Smirnov

[github-v0] https://github.com/ndreys/linux/commits/imx8mq-pcie-v0

Andrey Smirnov (3):
  soc: imx: gpcv2: Remove static qualifier from domain_data
  soc: imx: gpcv2: Make regmap access table variant specific.
  soc: imx: gpcv2: Add support for i.MX8MQ

 drivers/soc/imx/Kconfig |   4 +-
 drivers/soc/imx/gpcv2.c | 238 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 219 insertions(+), 23 deletions(-)

-- 
2.19.1

