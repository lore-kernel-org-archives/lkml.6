Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1D4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE557208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="BSyJqfku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE557208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeGLKcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:32:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32882 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeGLKcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:32:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id x5-v6so17798923edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TkDlPn+ZgA7bOzS0GnyvTFWQPgO4nbXYZPzfNILOZsM=;
        b=BSyJqfkuhxbsby2ibLm/Vwu0Jil4S25uAAfcLIKGM4zAHskJJfO0ZN7Y/20YRvmBI+
         SdCUGB2w/I/8nS5/lj+4goh5BlyvLGXf44GnMcHasvJ0g3FEXd9xsQSiZsCgZNKGTbAa
         /I+JWBBOB/lAOHNOQRRTBveKCY7OElyDe/nri4FTq7Rz2co8e/CkQ1d5BtTyTXjldSRg
         qb4ZwmOX2KB3eSzrudwzV+bfmr3tcn5XOYXL5INHJmfaxhDoiyLn4JHsl9e0bmg+UNzw
         Pzf28RJLDzBGuu7YuqDL5KWGKT7oift/S6oh26rG3SOySXnLsdHIbQ3W2yBIa0MpQJER
         Y8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TkDlPn+ZgA7bOzS0GnyvTFWQPgO4nbXYZPzfNILOZsM=;
        b=ql4fvCpYrVbfgFPtyMch1WLS+06EQY4IZnXEPG3HwK+gZuIC8tKr0pMJVQa5wLKuQK
         t6QgMYKEeNHib7ckY7MDqI/lxA0Wf60JKXngEt3pFghNke0kERKCxio/XZulYYFyX5Xx
         39XQ7Y6pDo1cCfJmwyhu1A9pTYaCnTmD/4jNKXkXclSXYC3S6B9Gzj7s9LUDELDAGmul
         qcedMmjL08Qa0R+qwvNXYQDWDP1Csq4wpY8gdo5JkzU1Ha4vusFQz/ZJx42jl0ryKk6a
         R5hEiHVHe3sdGxyanjwk2xXbzvtTl+3zNccWfraoMR+euExtLcebBA7zr3xMmwie54Qn
         8Qiw==
X-Gm-Message-State: AOUpUlFgR1jkVQmVolBAISAX9qdu5oRvxaqvu500r5Kg0VQ4NnzlOwFc
        a7uORtUeLG4q3fVOyVSuINFRMA==
X-Google-Smtp-Source: AAOMgpeC6KmOBFyZX0bJV7LFDkIO+7oZDqL43QOIXtVh4avxV50L0LaiNSERuYYPKTmdvoiTpeiT5g==
X-Received: by 2002:a50:95ab:: with SMTP id w40-v6mr1869895eda.33.1531391017029;
        Thu, 12 Jul 2018 03:23:37 -0700 (PDT)
Received: from localhost ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id i12-v6sm13236795edf.26.2018.07.12.03.23.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 03:23:36 -0700 (PDT)
From:   Koen Kooi <koen@dominion.thruhere.net>
To:     linux-omap@vger.kernel.org
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] ARM: dts: am3355: add support for the Sancloud Beaglebone Enhanced
Date:   Thu, 12 Jul 2018 12:23:23 +0200
Message-Id: <1531391007-29552-1-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 2.0.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone Black,
but with the following differences:

 * Gigabit capable PHY
 * Extra USB hub, optional i2c control
 * lps3331ap barometer connected over i2c
 * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
 * 1GiB DDR3 RAM
 * RTL8723 Wifi/Bluetooth connected over USB

This series adds the Sancloud vendor prefix as well as the actual dts.

v3: Drop 1GHz Opp tweak
v2: * Add missing #include <dt-bindings/interrupt-controller/irq.h>
    * Fix barometer compatible string
v1: Initial submission, not the dts actually tested :/

Also double checked if the kbuild error has been fixed:

koen@beast:/build/pkg/linux-torvalds$ git describe
v4.18-rc4-71-gd69088d
koen@beast:/build/pkg/linux-torvalds$ ARCH=arm CROSS_COMPILE=arm-angstrom-linux-gnueabi- make am335x-sancloud-bbe.dtb
  DTC     arch/arm/boot/dts/am335x-sancloud-bbe.dtb
koen@beast:/build/pkg/linux-torvalds$ 

Same successful result on tmlind/for-next (which has v2 already) and robh/for-next

Koen Kooi (2):
  dt-bindings: Add vendor prefix for Sancloud
  ARM: dts: am335x: add am335x-sancloud-bbe board support

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/am335x-sancloud-bbe.dts          | 146 +++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-sancloud-bbe.dts

-- 
2.0.1

