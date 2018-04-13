Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4100528-1523638389-2-14033660047847817258
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
    1523638388; b=d27KTClfMUzS5jYGd5UgXLgn+Hz2nV6PY/fmj5mJ8Ek2/zAu6B
    36VjiUeEWckwgQ5jdLahK5zsIqG8kvx2JdcZKXovOKkhwfIdqwF2w5/GSQD1eaR4
    z6ywoHsX8OfLCo0jMyMDPoB1submT7brEC+64SY4KHW2u6sGwB5+vtsTvonMsHrQ
    28Z/YI3yHFi35EeRMbnv/Ez0wRAcTh81dUkRC5PV30y5zuREaI0RRsuLSAa/MZs8
    /8gChxPqtEQTvctPErcql5oeL951bUEFZgSZRzrHtW9ikk/eSRnQjoaxVissyphq
    noj9zpf7xgD/81H3Sokqg/8RbJaQNN5UE2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523638388; bh=GgJPOoSCvu3krf3BZMF88XudoXRcgK
    8DlbFuGp0dOgA=; b=UEI8N9cEDor4yr00/K+xyd/KcEG9r+wIoKcbqXcK92CJfc
    gMCDNX5cxUH6MhUuRoNJCMeIhYdN2QtpH/47w3avM7pePJEalBNC5J/LdGnMu/Y5
    QuWo58mUM7v3lr/kG5OZx161cScD38paXZKkuIgaiBmaSsoN7oGVA/CROxbjFDOf
    DKonJq7ffE2u08lIO+vP5lWqAzhTziAa9l50f7wtDQWBgA7HQeeHw2gOn95r3mDd
    IoywbHVsCKKJFU4ly4YWe2ZO8QyRuVMHm8Dwt5FLmpMpU1oxtV+Uu6WmnhzU+dGg
    5hpk8x8X2H8c4KhbUTX9eFmUOkG3/YoKRQ5ryZhg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=TZr6D33o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Z5zUPgLX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=TZr6D33o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=Z5zUPgLX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB+eK3l8iUFW0FIk4GD2gXUgDLzdjzDbpgv8EbALRWrB7kcrqtRrjhAtf4qc6pasBHTQyXzKD5uzu1mSefYQXQm6rPS+qZK3GIo3sXQ1w3gA4j3R0kpa
    qvjRvhkfym5Yr1/Oc+Gj3dUyAnPRA1tL8SjxJi5UecWFF3aoUpQqU5gN24DBL4Fl1oS4JE+A+F8ntRBieEtMHYeXxk66em8/4yBOuGhbMVZZC/4xgfm6I2zk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=8287THB72YZbVCV3DXIA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbeDMQv7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 12:51:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38890 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDMQv5 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 12:51:57 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1F0A6081A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: balbi@kernel.org, robh@kernel.org, andy.gross@linaro.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v2 0/3] usb: dwc3: support for Qualcomm DWC3 glue
Date: Fri, 13 Apr 2018 22:21:21 +0530
Message-Id: <1523638285-5742-1-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add separate dwc3-qcom glue driver for Qualcomm SOCs having dwc3 core.
It is needed to support peripheral mode.
Patches also add support to invoke PHY runtime PM functions on host
mode bus-suspend.

Changes since v1:
 - Move dwc3 core register accesses from glue driver to dwc3 core as
   per review comment from Felipe.
 - Addressed other review comments from Felipe and Rob.
 - Some other minor code changes related to redability.
 - Add reset_control assert in driver probe to ensure core registers
   are reset to POR value in case of any initalization by boot code. 

Manu Gautam (3):
  dt-bindings: usb: Update documentation for Qualcomm DWC3 driver
  usb: dwc3: Add Qualcomm DWC3 glue driver
  usb: dwc3: core: Suspend PHYs on runtime suspend in host mode

 .../devicetree/bindings/usb/qcom,dwc3.txt          |  78 ++-
 drivers/usb/dwc3/Kconfig                           |  12 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            |  36 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |   1 -
 drivers/usb/dwc3/dwc3-qcom.c                       | 618 +++++++++++++++++++++
 6 files changed, 721 insertions(+), 25 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-qcom.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

