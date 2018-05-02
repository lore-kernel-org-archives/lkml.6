Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1358616-1525294846-2-10153027831300910459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525294846; b=H2G1MwubbbGFU2qozm0MoTOSnVTcHGHTFura+V5LBxQMOr5Stv
    /JPLTo4wCJBEJonCzhMzH4vd+MuqJTARUWFSIqoj0KMiV4FMOy1qGGzgrw7PNZKe
    ghzwTRuRCZutDCJm821PTyEEx3zNQiW733rgKcO/ZxrUHj2JDfzt2j7mEQp8UdBW
    I2QR1tHEofnsmFDK+7gDigFCHVr6JVp3Qs3TbyPsYV4LLwAu+iMA4DkHl6qzhUIF
    WY+FhwrZrZKQ8Wht5mQnWW/tEWrJrsOr1yATrowhNWmHar+Cf1r6SMJg9ZWY7rDi
    wpXBtmcRpIRig02FHsUT9d34PCyDq2nNdyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525294846; bh=T8OZS0uJJnjKiqsvLZhP//zxeODeMc
    S0FcG221JihcU=; b=cDcuAroN95r/L+e48Yy83RWo1Lw4+GHXHonMO8eqgz3VBF
    GbbNJROhKV5AWCUuSC7PELT2BSZ1IUo2+KvLi0FfIfhCAT+t0k4wDoCJvU+LzHR2
    2hI55qD5eg+Ud3B+Qhe7Rpsjofqk3yyiVS/5AcaEwyU/gCAR0PzENkvPGi6fd8Y8
    cOwKT/fBHLjNsww+b1477UxVKQr3qmSiubsE5agaa7RJ+CHh3SmVEvR3QSjU0RCo
    NSAXpGaqUzdzTXSGBXJ9h5qG/1/m0UqK/eGOsdmLveFV60eWPQuRE9NG6hfc1uWE
    zz6tQnQRtFDuYeXi6UzbCQmI/CWMzOaKNILcmc/Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=QDkOxHe2
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=WM9Vgvv3
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codeaurora.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=QDkOxHe2
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=WM9Vgvv3
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codeaurora.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIsMDD1tYDwI439g0Hgjnng6ayPuNQYu6y/xpeYJ7IULhadkynjh8soVEyQOz5MxSZl51wb/PDNzrLYZ2qJg7A2lQe1y7F4SuvYBjOt7SpkCZ85JdLxm
    WgLW5X/t+ZMbxqoh76AxGGPf/8VZVxVkb8hkm9dtrrtXicHlz7pcAk8di1RgX56En+kRkILrCaDC4lhfziZy1IyIwa6Yx5ljfsSkh9iDfW50kSYcwfWRmwPX
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=kwsehtL-y21D_42V8LkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeEBVAb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:00:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53596 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeEBVA3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 17:00:29 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DC7760555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>, robh@kernel.org,
        sboyd@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v5 0/7] phy: qcom: Updates for USB PHYs on SDM845
Date: Thu,  3 May 2018 02:30:06 +0530
Message-Id: <1525294813-15225-1-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SDM845 has two USB instances each with QUSB2 and QMP PHYs.
One of the QMP PHY is USB-DP (DisplayPort) combo PHY where
as other one is single lane UNI-PHY (without DP support).
Changes are related to PHY configuration for electrical
parameters tuning to improve eye-diagram and some fixes.

First gcc-msm8996 driver patch is dependent on following
patch which is now applied by Stephen.
https://patchwork.kernel.org/patch/10375043/


Changes since v4:
 - Addressed Doug's review comments to have QUSB2 PHY tuning
   values in header file.
 - Updated msm8996-gcc patch to use BRANCH_HALT_SKIP flag
   added by patch - https://patchwork.kernel.org/patch/10375041/
   
Changes since v3:
 - As per Doug's review comments added device tree parameters
   to handle board level differences in PHY tuning values instead
   of adding separate device tree bindings.
 - Replace PHY version specific bindings names with SOC name as
   no one is going to use generic binding names.
 - Update halt_check to not check for pipe clock status that
   allows to simplify pipe_clk handling in QMP driver.

Changes since v2:
 - Use separate phy_ops for USB to not register power_on op.
 - And other minor changes as per review comments from Stephen.

Changes since v1:
 - Updated qusb2 compatibility name as per comment from Vivek.

Manu Gautam (7):
  clk: msm8996-gcc: Mark halt check as no-op for USB/PCIE pipe_clk
  phy: qcom-qmp: Enable pipe_clk before PHY initialization
  phy: qcom-qusb2: Fix crash if nvmem cell not specified
  dt-bindings: phy-qcom-qmp: Update bindings for sdm845
  phy: qcom-qmp: Add QMP V3 USB3 UNI PHY support for sdm845
  dt-bindings: phy-qcom-usb2: Add support to override tuning values
  phy: qcom-qusb2: Add QUSB2 PHYs support for sdm845

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   3 +-
 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |  23 ++-
 drivers/clk/qcom/gcc-msm8996.c                     |   4 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 169 +++++++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   5 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              | 130 +++++++++++++++-
 include/dt-bindings/phy/phy-qcom-qusb2.h           |  37 +++++
 7 files changed, 346 insertions(+), 25 deletions(-)
 create mode 100644 include/dt-bindings/phy/phy-qcom-qusb2.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

