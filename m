Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516977-1525459780-2-16986164871853374005
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525459779; b=kanp6b9k9GtKa8k+ZdqSPXIGVnAHTA09pIv7CtCynPH81kH4Xa
    S+zktJusE4eM5ckVIOo+oFGxN+BSCItbGgoYgRndvULA4iZRG21cQuVkf5auWtqr
    9GDTvnsBMN/RVDYpQM3okirkjaLPtbt4HIobONCpIXVe+CuAGhK1tLnX1TGdf/EO
    22erXJvzU3dlBtrhdN+vVGxPiB0/Lb21GUxQGdNwJfyA1DbjXOjYsVix/KJTJjG9
    2DTrcBEoOTFI6qLS9OM0MLGF6aUe8dLD05Zo4QfZd5RJTFCW82kf7dirnJuPOpjf
    dfLbRJ13vsoG937Oh21xOSja+oRfsPcyKvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525459779; bh=ICTDpEYRBX1nR0kM/Vl9Z6DkHM/O63
    zPwQi2mB1t+cc=; b=C5HPg48AaZ2vSKJek9LVhswgqpvbD1oSp1Swa26GYuyyNL
    CoD8Q5isc6WfY7lKPzDu2ZVVYWydWdMqx6MEBn9MHm7wFpCpbOumV0kQJ51iE9ME
    /U48p0qEHPc26NwD8DDy9EDqrcb9T7NQO8ZcECHBp3xw7u9OLjtpCJGGhTURI+WF
    p6/rIJQlOA/WfmXdGge95DynA4zH4oLmm/bsu2+fdCNiRJ2qfNu9RmHgyF6v/fsg
    5nPjTowpBvkGcZ56i9GTt3bRTYL4ZGTIAEpRrI9P9e79smNhDP6tjzyHz7IV6H2U
    N8L5YGVXzBX0tvvRgksH1v6r0c9aGM4tM5G3r/DA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=lszC80Ui
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=lszC80Ui
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
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=lszC80Ui
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=lszC80Ui
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIeX3SDJFaSoyytMdYDZWtGNWh0zoCT9a7GBCy0vTBEMo1pzrnWL7Y3XAf0SLl38VckCLjruJd6XpET6Nb6P1lJphng0HF38/Z5k9g2AA+akpPx46NSq
    CFfTNedSrfzlRRxZIwLhQvmwgjzMX1AXA+S26ECFcBB2caekJ79faszByK/VquvKM1yRraSMM9CbHjHJIc9rxC1Ixeb+SuWdBrvKXnHbNg0KtS/eLksmdPE8
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=8287THB72YZbVCV3DXIA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeEDSsY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 14:48:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34592 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeEDSsX (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 14:48:23 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B7616085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: balbi@kernel.org, robh@kernel.org, andy.gross@linaro.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v3 0/3] usb: dwc3: support for Qualcomm DWC3 glue
Date: Sat,  5 May 2018 00:18:06 +0530
Message-Id: <1525459689-1358-1-git-send-email-mgautam@codeaurora.org>
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

Changes since v2:
 - Addressed Rob's comments for DT binding documentation.

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

 .../devicetree/bindings/usb/qcom,dwc3.txt          |  85 ++-
 drivers/usb/dwc3/Kconfig                           |  12 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            |  36 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |   1 -
 drivers/usb/dwc3/dwc3-qcom.c                       | 618 +++++++++++++++++++++
 6 files changed, 727 insertions(+), 26 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-qcom.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

