Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FB2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CC32084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJmBzCsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfBUQY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:24:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36347 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfBUQY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:24:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id k2so5066167plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hRhNcU5Kxzb3ye41qDF1QRlQgTevtLPFcvrdezho2BE=;
        b=xJmBzCsYwkndyEVaNZdOa4zzAELyn7hCvWEB3r6qlmVGAdjP1mEekWbdcR02zmMqDk
         h3zJup5EV+TkjLr+9O1Q1to5T8G0mlSgq3yzS2JK+8vj8wpDRLvDeS3uP/+OwUDGi4fe
         h3fLdB9M4Yen5ix90Sk5k9v+hM520vCYIaRr3tF7pz5713uxS1lEj6Vzz/tJzDME49Ka
         5B/VSlBbz9yByJoCA9jiIXQ2bcfxa41aOildeAqlz/MH7073wDsV05PQ/Wkne6g+B+Rd
         inHsmEoIW4w7N6H+mhg+usG7RDl+esu/gHK46RZHR092MUVNfsFDrZ2iagugiQySKLFo
         Y6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hRhNcU5Kxzb3ye41qDF1QRlQgTevtLPFcvrdezho2BE=;
        b=XrQ+jkoiIP0PqOnxLHtSwAjVBxeJFftH881GNEZtcpBS18DMsJoGeIZyFtoqQ6tP6X
         Ymiirol/CgyTHiDNQtwA6DS2C3JDezqaM5OsQfRIOg1dJw4nWicSU8AhXBIDZqgytXIZ
         5nuxe/yCKpNwBE7FUpUt8gkWS+3q02dXee8eV4uWMqz+JWn/ow7+AosgZZS/vmS16QUT
         efoucB33rN9gnqb+WLHxP7KiuaqG9cm7TExO8WAxEjorG2p5vNnwCQVJIm7KILmC5Dq6
         Q/+yCN1zvJgsDGv/4xIaaoY+re3ljQD/PDCO8wgHtQLl3kXRdhrO+Tf/qFMB6PS/c9TL
         o6cQ==
X-Gm-Message-State: AHQUAuZmHzQKM2aP7etITYNn36xnhYw0PAoi1DeNzyxCT09MB6wzw/u1
        0ezLE61PMF9kERntFj1J+vVEWnAK/+I=
X-Google-Smtp-Source: AHgI3IZGgahsmPMUU1AlpgeIguUP9Gn4ay+S/UKYE4KYqy/8canMDeaQIASJPrXRVuIfWxUgIfxrfA==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr43680442plr.15.1550766267655;
        Thu, 21 Feb 2019 08:24:27 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id 20sm21382910pfs.182.2019.02.21.08.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 08:24:27 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v3 0/5] soc: qcom: Add SoC info driver
Date:   Thu, 21 Feb 2019 21:54:14 +0530
Message-Id: <20190221162419.32384-1-vaishali.thakkar@linaro.org>
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
 drivers/soc/qcom/socinfo.c                  | 605 ++++++++++++++++++++
 include/linux/sys_soc.h                     |   1 +
 7 files changed, 639 insertions(+)
 create mode 100644 drivers/soc/qcom/socinfo.c

-- 
2.17.1

