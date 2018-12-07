Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E7DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BA620838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8vNRBaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BA620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLGRwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:52:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43244 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeLGRwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:52:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so2140009plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3WQAUIWwUS1Bi+GyB1a39vYL4U81m6zfnOqbkyrmYM4=;
        b=c8vNRBaXjU+nTt1dy64HSdflwfCcb/7/CI93XPiSxxeN0wwDnh5T+C/pWo+izwQYED
         MM4xk0KVxUsqGI+VLVA8ES6HRZ+2G6YnByL0LJvqRkPTNNzHwTizFlG+Og+pc+ueytc1
         iYJC+fP5evG7Eo7x5MNP7vuvQhQ3It50skNfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3WQAUIWwUS1Bi+GyB1a39vYL4U81m6zfnOqbkyrmYM4=;
        b=Jy3PmR9rCUihH/acAye9G/MGGD1DBuP6MlmzVbJSF8VMcGSvebgY7UsZ3oRaCrSwaP
         YC25XpZ5wl1x9+esXcJ99HBg0HpIRueinEZiA2lqm/qLDjY38X1YhV4nXjPO+Xs2aeeH
         +iWXcryqVXtxLa8KmhtpUKeTp2+Phd4gMlLQ3972zR8W8PzNwlAzs92ndKzVbfjLRKK7
         JfTQv5IsMfvJvj8Eypmx4ySgK+bXX6Egw3uxY04JfiblMiwvl2MrEG5FpYz0OSAckn8R
         6ymdRtOQ6Ve2Dmakzup+C2dWMashBzTrE9aGr805YUwCVYxQ2GaQ+1H/hOJKxVIlBAqj
         caNw==
X-Gm-Message-State: AA+aEWZdTdETj5ImnbRSdb/HKKk335TWyFsvsT/LlOzGMabYOSGwBGY3
        V+Ft5NUTie9+IMotJacIgJF+
X-Google-Smtp-Source: AFSGD/VjGp3axjCnM/yLlxi03ddcZY3uZimIKJTQpHfyXy19ua6WzuNnxEq/VCyW02B2/nQjU6XgYA==
X-Received: by 2002:a17:902:47aa:: with SMTP id r39mr2981150pld.219.1544205126619;
        Fri, 07 Dec 2018 09:52:06 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7207:e9c8:7189:c4b2:429f:42db])
        by smtp.gmail.com with ESMTPSA id k191sm4611387pgd.9.2018.12.07.09.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 09:52:05 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john.stultz@linaro.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add UFS controller support for HI3670 SoC
Date:   Fri,  7 Dec 2018 23:21:48 +0530
Message-Id: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds UFS controller support for HiSilicon HI3670 SoC.
HI3760 SoC is very similar to HI3660 SoC with almost same IPs, hence
the same driver is extended to provide UFS support. Only major difference
is the PHY. HI3670 has 10nm PHY, hence that parameter is used to
distinguish the difference between two in driver.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: ufs: Add HI3670 UFS controller binding
  arm64: dts: hisilicon: hi3670: Add UFS controller support
  scsi: ufs: Add HI3670 SoC UFS driver support

 .../devicetree/bindings/ufs/ufs-hisi.txt      |   4 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  18 +++
 drivers/scsi/ufs/ufs-hisi.c                   | 127 +++++++++++++++---
 drivers/scsi/ufs/ufs-hisi.h                   |   4 +
 4 files changed, 130 insertions(+), 23 deletions(-)

-- 
2.17.1

