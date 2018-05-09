Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-699659-1525887643-2-12637405213843150173
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
    1525887642; b=JWOk9GSmYbw40XvU8bQhmqgtOa9iFlgZRQZ/LPIMws1JyygyAD
    gHL1iAoDkpOAcYxSU2ck5Sb1Fxjbp6GtzwYHWahou8Lq/apEObTtr6F+MJ4pq11U
    HjNw065LBWs6zd1wSJUcPKqUbRiu7mcxyoZlx4isMyhQUwa7A8MT2IBmWYXKSl2i
    VDtVgQ9vKfbOeG5rDyQgeTNEKkKzHyFhtNdVmHcCJy7Lls+Pi2Ek92La06Om5Z2A
    kSpIfB69MucHUAT+mrTDrUOIe1wA4XAJP/y6JQN8AR7vp3mBrKmqNF+8gciJi0iR
    LYsLFfUvUsRGFLiAadAhKkyP9UQvgQz/Kzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525887642; bh=iKEfwj/1gbyV0o0x8yWqgXODDOZ9TW
    mN+LBlhEbdswA=; b=bbEMCnj7OAwxZbOLP3Im6MosOryqXFMm1KCrg9INjj12RH
    N42TBVf7lSDNDLIDNW+BbC/FFnmIjjNMfplfzfmJkm0FfnPKp1c4ch8zvHkRhnRR
    BMxDZOLUc4875mQBGuTzqZjbs/nPbr4YqgNU8h3UnIfQhK8djOCD+wGtGpUaGNPD
    bsW52VPKq1OjVtF+Af1dzT2P7lMeIcNUwoh5g93zrvSkFzCBlXnhUcIOFoO3dPAk
    LDy2pxSyS6f9TXKvx9GMxSWNKyKM1W9jKtbrpO5UCxjrcef9ri+7+LBks6kt/jXv
    +7ruzuQjJpi/21O/kUP4vEgbwron+yxIS5wY3q8Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=HcB4cSYv
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=ehzhLGIn
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=HcB4cSYv
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=ehzhLGIn
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
X-CM-Envelope: MS4wfMf0g3m6VCws15FtQJ3ejtGamGUMjI7NehViR5pWR77GvfHJQ6tBgDCW+dMp0JJSLCUhx5GA3dW0Q7ADv1Fm0Ob07ZO0F3h51qJk///ffVg9PmCj0YZr
    7SdVaSjzytByA5C44SicBwJ1l16jMeKI6qntX1N6zLrhiuxX0ijxBtFtJpcoG008n+iMMPZr17kiz3XrJIsQf4P1vS20ucf9Wy7S8v3NkcwUeO0EvddMhJq4
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=8287THB72YZbVCV3DXIA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934972AbeEIRji (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 13:39:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbeEIRjg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 9 May 2018 13:39:36 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F7AD60712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: balbi@kernel.org, robh@kernel.org, andy.gross@linaro.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v4 0/3] usb: dwc3: support for Qualcomm DWC3 glue
Date: Wed,  9 May 2018 23:09:18 +0530
Message-Id: <1525887562-2687-1-git-send-email-mgautam@codeaurora.org>
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

Changes since v3:
 - Added SOC specific compatibles in driver.

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
 drivers/usb/dwc3/dwc3-qcom.c                       | 620 +++++++++++++++++++++
 6 files changed, 729 insertions(+), 26 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-qcom.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

