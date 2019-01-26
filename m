Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198D3C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20C5218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdbdy3F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfAZReO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:34:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42297 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfAZReN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 12:34:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so6107309pfr.9;
        Sat, 26 Jan 2019 09:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=BFicm88r+0qpqh0sISAyMs4S8ExnHqgpaDgIsLuempY=;
        b=tdbdy3F0vhAOYHfBmunr0NcVIecWfHCcWoyQGH3WtHm1bQCnv1RYCpbguuRCXKSkoX
         FmIPLeOkc+sp9FR2zwyY38plTZP0JbpBW/M/n9EcmdADov/oBwovzQdo+x0cndSZ17ah
         jcuCfUBeMViNRpQNo7T24QeZWwFMletuwWfzzZMnECjIEmpPwX0hifAFIgsd5ZagFPtf
         dXsxW0hdXFBdDIQh6NXsJCmGfrJwqW/e+i8raEeWcOZlHMt1ac/ABv6Mda3T2MtYQXlC
         8uLn4zERLeXnfW1OHW6f3hj79Kiq3lrdmY1Kzw+5i7L1AKGaMXiwfuhVUOYPHb16ThvV
         WF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=BFicm88r+0qpqh0sISAyMs4S8ExnHqgpaDgIsLuempY=;
        b=nJQ6DGoxkFM2nIiYrVW49O7UDPnS9OG+Rg2v46VFyAGMQHa4isx2U9t+jMqRh3wivR
         43eK8+dP2nUbFgh4KKz+nGYZzNq9AbMwOZsxtPXxiAGYwW40yNBuHcW8K3CSoH8vjR+7
         iUyy+ToME34p6jbcCvz3XxNw3hgrYPW7pVymO5CeHOCy9eTc0g154R99Rlgh3aa1fYXh
         G0uOTZwKHRB1JJEMthI+AQIdYwoXf17R00wavuRRn4DatrN3Sofp2Vph3R2ZR9EYqehF
         caBtUfvqIdB9hi9ym4psE1IxhoWzHwfVHlumpGoed7CVB/gih5xYh5RkDsaUZ75PHa6n
         mn0A==
X-Gm-Message-State: AJcUukery0NqxAHwYmFGT6sxSeNDUL2ueqe7eCHUKW7ceILXIat/YcLC
        xyDUqCFBIoJlgV92yZ5W9Bg=
X-Google-Smtp-Source: ALg8bN6MFAQ0mYeEKHT158oZEO6SnR9Ex17troe8i1Y1rZwfLFKdG0PPSk0GmL4BDImRS/k+dHygrA==
X-Received: by 2002:a63:e655:: with SMTP id p21mr13913428pgj.70.1548524052683;
        Sat, 26 Jan 2019 09:34:12 -0800 (PST)
Received: from localhost.localdomain ([49.32.227.18])
        by smtp.gmail.com with ESMTPSA id a65sm28745690pge.65.2019.01.26.09.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 09:34:12 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, jeremyfertic@gmail.com,
        shreeya.patel23498@gmail.com
Subject: [PATCH v4 0/3] adt7316 regmap implementation
Date:   Sat, 26 Jan 2019 23:03:59 +0530
Message-Id: <20190126173402.12428-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset consist of some initial patches for heading
towards the regmap implementation and also the final patch
which enables the driver to use regmap API thus removing
the redundant and common code.


Changes in v4
  -Rebase against iio's testing branch. Previous series
was rebased against greg's testing branch.

Changes in v3
  -Fetch the changes from remote and rebase to have it in
the current working directory.

Changes in v2
  -Change the val_bits to 8 and add two more patches
having a different change before the final implemetation
of regmap.

Shreeya Patel (3):
  Staging: iio: adt7316: Remove irq from bus structure
  Staging: iio: adt7316: Remove multi read and write functions
  Staging: iio: adt7316: Add regmap support

 drivers/staging/iio/addac/adt7316-i2c.c |  97 ++-------------
 drivers/staging/iio/addac/adt7316-spi.c |  95 +++------------
 drivers/staging/iio/addac/adt7316.c     | 149 ++++++++++++------------
 drivers/staging/iio/addac/adt7316.h     |  15 +--
 4 files changed, 104 insertions(+), 252 deletions(-)

-- 
2.17.1

