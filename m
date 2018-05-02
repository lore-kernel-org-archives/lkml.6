Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1358616-1525295204-2-10133615540660897259
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
    1525295199; b=bC8EteMadysIdXFg4fQUFEtKsJ/2iFWfVevL3+r2KUYp61iPz0
    v0725cZGGNFPELnsTpG04Z67pHil7lS4t4BVYLgmShk2YrUOKHCJ2lT8m6BQA3ds
    KzlDj3RgQx+OjBa3tJhWSGIwQ/MBsE+PhAyP4qwZhfE6mlj0sPP3OyLd+f1W8pap
    PO64zxNjdiuMtgiBInTtzctZacISlZswu0zQR0te44dHCSKZxbmSjaCFK4o5NgXr
    emucgTmZrVsAuMfnN6XZ+ExYOW9Qv0s4sAmp2jZ1Mg1cLAh5EdJ1yzxTXqYbTfz6
    PsrjZ6lh1TovVUVUHM8T+2EWaDR1UB5Lhqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525295199; bh=T8OZS0uJJnjKiqsvLZhP//zxeODeMc
    S0FcG221JihcU=; b=LNE3cz8X+FRwN+OXb1IigwbmDwQTxNfUvwhm3fFqZ92LDI
    tredKisWFUODpMg06VgQMW51x2JW9Z/KJe3k8iw1LceGbbXFkvnhdrKGePQw6IcE
    pXhK7QKEGrG5J9WkwdzHqip+l0nHYdvJ5QN9axUA/RAk1JOGc+LR5XS5vgYvfYS1
    Rmtkshgh+i4949wQ1wBD+Z5/iN2xMK7QA65kZVMjrpLvR+c35pT1PY5uYbnW4nrF
    lCULmeUw/7FegowoaDeHrI+bH28TAbyD5j52pl+o+cj/0+oKZmlIkDvbuxyb6oov
    gJxjIE48ivtNweh+EL2IJdSvx/PXQZeKY3fZZW4A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=POUc9qZV
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=haapEJ0q
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=POUc9qZV
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=haapEJ0q
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
X-CM-Envelope: MS4wfBi3WleKU63Fd42ePlOZFvHAwtizkHMM5wqS00cDiIYmLYbg64ychCYAemduMCpCs13LYvFJOltPOSDABXJkQRxW3e6Y/0GD8T/UugsgnUXXa6QbPGgQ
    BGuYG1v40QUZerv1wJiA1m3LrYDS6zAAvfQFhOELNOIv2iU7QvqfItvyI1i3nkUBsTRG1/RSu/8FQ7s8LuIF7hV+4G6o8/S3mBrlg8NYl0jhOmjFm2oMopnD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=kwsehtL-y21D_42V8LkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeEBVGf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:06:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59324 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeEBVGc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 17:06:32 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5182660710
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
Date: Thu,  3 May 2018 02:36:07 +0530
Message-Id: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
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

