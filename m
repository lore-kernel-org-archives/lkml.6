Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB21C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9A520989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKergtra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfBYGux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:50:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38875 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfBYGux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:50:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so4032708pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 22:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vcxyvMdCKoKGwGTCgKezJeqS5FtacHOSZRLzqewsh4c=;
        b=HKergtraUE1giB198djAHB+nvw36wJJivf1eSoGU1i859FxtU6f4pWDq3rVJvu4xBO
         XLkuRUdz/PjNX2vf/es3QgP2GepSFaQrRHzlfF/djkl7Dt/Kte1v/oxuJPHtG6yRioCG
         491WAXgHed1AMWwIRhyFK+Ou4xJLL7PLbxCw3Z1ap+/ZUbucUGmyJydsGO/wXrMuG0cZ
         O9TzioJSr1rldmU7LV97+I2c5vxul1tih/8nKRarG8jPP2bya8A4HzquDtuUY6omkczF
         5U+6ASg3yl4kVpT44XLwjDGQqwGk76U5T8lPx6DkVVzUVbbfjCCUiwflA+e6Flyl1vE1
         9UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vcxyvMdCKoKGwGTCgKezJeqS5FtacHOSZRLzqewsh4c=;
        b=NfU5D3KATTmgB7IaKLikUJtG+q73vn+wrGHvAboDQ0PE0TIvA6j8/GN3N2OuGLidcr
         +JhwCayvtZGuJZd5DfRh7C68OtASK9l+KP4lb0V8//2CQsTO9+bt578O95m4+QCRb53S
         1so+5XCewJf22zxC78DYfx7cVsgb1TBrvwkyg8AfhhHRKL7JnB+cV/iAq138xwjQ8+Fu
         MMHAdjjSSbZj06EIp8YA8JUpyqes0eoXnuG6qdqSxCO0rnrivD+9a7I09Ud7MfHJIFOK
         /fIYxgBwCrBvIsdMMYurIcXCDTp4D4aLtmDFGEDielbGkmUJicmULFsLl4+0BsDAkj6G
         fHxg==
X-Gm-Message-State: AHQUAubD4gDFIWjlBsSgfd5wEWBBDCe4y5iliPkzFag/yzS02HLhmtDV
        aTTO2RKIursVmFLlwFaTXMviVQ==
X-Google-Smtp-Source: AHgI3IbiAowIhMSdJ7EkwfjI9n8NBbQGsn17uCo2NUJbHvfqjGON/78MC899O2YOPgRVeuRttRpOQg==
X-Received: by 2002:a62:fc10:: with SMTP id e16mr18839766pfh.83.1551077452548;
        Sun, 24 Feb 2019 22:50:52 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id f16sm9990021pgg.20.2019.02.24.22.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 22:50:51 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v4 0/5] soc: qcom: Add SoC info driver
Date:   Mon, 25 Feb 2019 12:20:39 +0530
Message-Id: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
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

Changes since v1:
        - Align ifdefs to left, remove unnecessary debugfs dir
          creation check and fix function signatures in patch 3
        - Fix comment for teh case when serial number is not
          available in patch 1
Changes since v2:
        - Reorder patches [patch five -> patch two]

Changes since v3:
	- Add reviewed-bys from Greg
	- Fix build warning when debugfs is disabled
	- Remove extra checks for dir creations in patch 5

Vaishali Thakkar (5):
  base: soc: Add serial_number attribute to soc
  base: soc: Export soc_device_register/unregister APIs
  soc: qcom: Add socinfo driver
  soc: qcom: socinfo: Expose custom attributes
  soc: qcom: socinfo: Expose image information

 Documentation/ABI/testing/sysfs-devices-soc |   7 +
 drivers/base/soc.c                          |   9 +
 drivers/soc/qcom/Kconfig                    |   8 +
 drivers/soc/qcom/Makefile                   |   1 +
 drivers/soc/qcom/smem.c                     |   8 +
 drivers/soc/qcom/socinfo.c                  | 573 ++++++++++++++++++++
 include/linux/sys_soc.h                     |   1 +
 7 files changed, 607 insertions(+)
 create mode 100644 drivers/soc/qcom/socinfo.c

-- 
2.17.1

