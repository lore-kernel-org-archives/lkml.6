Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01062C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF894222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vB1VWDvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395355AbfBNDlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:41:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37113 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389764AbfBNDlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:41:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so2300884pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 19:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hdLRKsT0cs+98+3MV9OcAfaAjHpVtLRfYHo+ZXFC1FA=;
        b=vB1VWDviEvygcYmbEjWdkjXokIpawvpYVPirQPjJUbXUuxPNOceumKiKDL9f91L/rx
         WOlAo+y6VyW1Z+KzDCVQaum/ZevRH2IFISE6WNuzfWsm686/7KhZfKT1NfRT9fTdR6Hq
         EQKfuvQ65vpibOMFzeh8E6vaQfh0V+xBILGKn5o7Su5l4YU8rMF+2C7udhm9gSeg9nvd
         SiXb2/2En/tOP8r6OLHN0kzVk5hStJglrXfzViDaQY8uPNCYitHnjNa56TLV8Y1keda7
         OyG8Q7rQqAHUXyKkwfFOkz2YWrDFLEilYAevp/eNoghwT/5ZSC8DfXGKxTyR94pvpY5O
         rhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hdLRKsT0cs+98+3MV9OcAfaAjHpVtLRfYHo+ZXFC1FA=;
        b=boJZQVW50Z+X6Piyq2v3Gv1iGdlwWjBDF13b2LzMVwhZEX/UR8EomyfdhrqamDdy9u
         FO8zOdFgvTW2+8UGRkRU3DL+/CYQQFstEPWftO+1ad4JHJbr7mZk3E7i5L9RqzdeqsIv
         L0UaldMDxumtNku50LKPJDQyUJ1sdC6Ra05JyzB5+b+ST3Swb8mbGEulb5RTBt7sIOLQ
         ONJO++lp64zBgWMyXNnrQRND4AQYcie6BSKi8ITF4EHLqWYYlDliZ1E9k+DtN5zwo/es
         D/c9AP2GHRy9sUViANMaMRaG8Zi3k701c0l4ItfIBoiUHEZ5liRs8fAyrD37t9R5e/9s
         drUQ==
X-Gm-Message-State: AHQUAubyDuMpyLAsXluQ6ZL/Kx00fCbKJt/zj36CcXVA3FcGt3OTtYSI
        6ZYyzhkWunGIqQiYeHF3PEeR5w==
X-Google-Smtp-Source: AHgI3IalWBXXlp+s6SpQ/ZWrOAM8eAQhPBr1gxNgD/HIwegcCFi8bJKcuKh6LHTKM2oTeZipQzquSw==
X-Received: by 2002:a63:d301:: with SMTP id b1mr1688134pgg.61.1550115682006;
        Wed, 13 Feb 2019 19:41:22 -0800 (PST)
Received: from localhost.localdomain ([103.240.171.178])
        by smtp.gmail.com with ESMTPSA id y66sm1460087pfy.66.2019.02.13.19.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 19:41:21 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH 0/5] soc: qcom: Add SoC info driver
Date:   Thu, 14 Feb 2019 09:11:11 +0530
Message-Id: <cover.1550114271.git.vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds SoC info driver which can provide information
such as Chip ID, Chip family and serial number about Qualcomm SoCs
to user space via sysfs. Furthermore, it allows userspace to get
information about custom attributes and various image version
information via debugfs.

The patchset cleanly applies on top of v5.0-rc6.

Vaishali Thakkar (5):
  base: soc: Add serial_number attribute to soc
  soc: qcom: Add socinfo driver
  soc: qcom: socinfo: Expose custom attributes
  soc: qcom: socinfo: Expose image information
  base: soc: Export soc_device_register/unregister APIs

 Documentation/ABI/testing/sysfs-devices-soc |   7 +
 drivers/base/soc.c                          |   9 +
 drivers/soc/qcom/Kconfig                    |   8 +
 drivers/soc/qcom/Makefile                   |   1 +
 drivers/soc/qcom/smem.c                     |   8 +
 drivers/soc/qcom/socinfo.c                  | 610 ++++++++++++++++++++
 include/linux/sys_soc.h                     |   1 +
 7 files changed, 644 insertions(+)
 create mode 100644 drivers/soc/qcom/socinfo.c

-- 
2.17.1

