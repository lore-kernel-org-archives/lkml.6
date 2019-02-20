Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A97C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB14921848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8/PVS+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfBTE6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:58:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45860 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbfBTE6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:58:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so8299405pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 20:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gTPZi45ZAAaKG7hCoM8NOE3/+aSCZy0SIwKgbcrQrcg=;
        b=V8/PVS+BmY+RYSxpCCKA7vGUOxr+YTi68f3ivtA2CeaWBW/45fgCPN+IF5MNYfvbEs
         IA4l2kz3cUVnS4W1fggitIBQTtEb5gAoagEZ1lVcqoDA1aKbbc37ccKRkB01MDmHf/0U
         Kn01AvKbLFl/3YsgP1vtVcf8ZMTEbfkJ+rRKM1AD4LLLitYF+Qlxx/1pRGco1XQu1nna
         eKV6ugTQ1qADLsPXs5YOZi+GJq54PMmrKDWxi0Q8ycF9VYkTpa6sQCis4gfQx3aH2zau
         sjMikD7WSvr+/TLpdOL/wSFAJbVFw0rBioa0DQs/AdTBsG2Xq7X6DgmJOCw/vNVmV8Wi
         Ib5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gTPZi45ZAAaKG7hCoM8NOE3/+aSCZy0SIwKgbcrQrcg=;
        b=Vwv79CPdxNoZW25VK2rxy6xus+2SVfJLDdGkSU5hjcBpsyER461Gbl2jfvOTo0/Geq
         JFjSbaflSEyrgQPOgWwM3U1d5SdsO5jPApmuhq8goOoQAFtThnE3V1ObyEXaI2b9v6AU
         fxZLLBiP8UUBqUi/pevO176PHjEGIEYkdI8heTVMNmK6AAcHUwT5fyXyrehm54g0BcaS
         Q8erIGYVGkUuK+OOSow0iu5TMTmDTPwilKgpy+HIIM6fURJZocfdPJKws2a6d6fl9LbT
         kV/nQ2g+KlpOTjtBBlEzL8uTvE7BkbmKXa4PW6ixPMFgVrD1PjyPNnERi7iCIDkEgsJf
         /4XQ==
X-Gm-Message-State: AHQUAuYeGUK9hRTZxzavbBbhopkiITSKgIi75QCKwuS0UeZVQ9Cf7Cpp
        V0r4WGUjxYgwJ/eneEFcUXs8lA==
X-Google-Smtp-Source: AHgI3IZOKJjbx4YMj+pM3INRSd10fua7UVyTPDDCfC698m/zGIRk9FzcAH3DlPGJWmhMp9d5XvSFGg==
X-Received: by 2002:a63:575d:: with SMTP id h29mr12777302pgm.442.1550638683446;
        Tue, 19 Feb 2019 20:58:03 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id n85sm6590683pfj.177.2019.02.19.20.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:58:02 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v2 0/5] soc: qcom: Add SoC info driver
Date:   Wed, 20 Feb 2019 10:27:55 +0530
Message-Id: <20190220045755.7293-1-vaishali.thakkar@linaro.org>
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
 drivers/soc/qcom/socinfo.c                  | 605 ++++++++++++++++++++
 include/linux/sys_soc.h                     |   1 +
 7 files changed, 639 insertions(+)
 create mode 100644 drivers/soc/qcom/socinfo.c

-- 
2.17.1

