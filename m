Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1358616-1525295321-2-507033539502869137
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525295320; b=hCGP0V1oaLnplnEUeLSqjXIbI5/x1gFgXuG/2Aeu/2ZI47yeL6
    8b3OEDrGmKRjGq2sOwEkVHHqZZF5sksB0NtwcFLwwPYWH4vlCQa0RkWKFhJc8GU8
    2ClugSuRc/4egfroWF/GgjoqaNZBn08qRy6Jlkc+P0QC6wf+S64NDmDM8G/CIoFh
    iihWTL0MBO/UsCl3ScOXcGaj0/xrQ0MIO+XiyKGNIF+OVP4BLUikkb0KNRgcdJY7
    j/dTaxyUCyQ/iJE0kOXjNYoXkLaUmTtqS8D05NynUJCDHRl7J+J7OICzikob/l3N
    b5bFlfNEuQ3i2GG7m2f13HgvHxqvf0V7Smzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295320; bh=
    BZiGREMIG/r42ppzB7PBPzKLDT12aLnE4Szxb/hX4bo=; b=PJ1xDc0JDrBBsP+s
    wV7mNhFt8Hp4DrcF4UmugcEITBHhbTxKDxZ6xzSN5/2OO/xc2cF23JOKaqQ00R9B
    14s6psmFuO1YkPUegAKavNqzYNtkh0oGtGbz2XQ+aWzqV6PAyBpvb6i+HMn/IBaN
    WdiFFU7n7Fvkvghzu/igwWs/L1MpGS7w5Go/EaWtGhiVxFhpSM+gK7F70Ms6gO0J
    cMXCF27VpXSswLlzjDSPiBLYY4Qc6wDbhzItIcDXwzO5BGD/FRjsP9zr8HomRjTO
    Lgaae+dGYvGgI/+Ma2CZbsmrFZ4InNhyLAVxeRy2/6Pq4RWJig7JZ7wxiAsOKfxI
    86upkw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=BossQlqh
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=BossQlqh
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=BossQlqh
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=BossQlqh
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
X-CM-Envelope: MS4wfI8xSsddIS2zV1Oio6RqwjzuMyDWZ+RLOp0koScaPRoeiNv9LHNZ9AJ2wGJzx2iQWNnvYOeXXof4jqmRQy3zidvxyadPKK4+eM2T2mrAZftxU0XnASGu
    MKnc2hQJkWPaJ4eRwzSFDn3lw5v5aqn9NoTgTd+Z6S0QYa/mVskwYRzICNAXdzwVqqYAWlbFadgfIGzotnmubnEGdgnnsmR4+YO1CD2Zx7D/D2OnussfSsag
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8
    a=VwQbUJbxAAAA:8 a=_G8kjDvXgOUUA3mkzmEA:9 a=x8gzFH9gYPwA:10
    a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeEBVIb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:08:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59450 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeEBVGg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 17:06:36 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88239607E4
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
Subject: [PATCH v5 1/7] clk: msm8996-gcc: Mark halt check as no-op for USB/PCIE pipe_clk
Date: Thu,  3 May 2018 02:36:08 +0530
Message-Id: <1525295174-15995-2-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The USB and PCIE pipe clocks are sourced from external clocks
inside the QMP USB/PCIE PHYs. Enabling or disabling of PIPE RCG
clocks is dependent on PHY initialization sequence hence
update halt_check to BRANCH_HALT_SKIP for these clocks so
that clock status bit is not polled when enabling or disabling
the clocks. It allows to simplify PHY client driver code which
is both user and source of the pipe_clk and avoid error logging
related status check on clk_disable/enable.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8996.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 3d64529..b73e7f1 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -1418,6 +1418,7 @@ enum {
 
 static struct clk_branch gcc_usb3_phy_pipe_clk = {
 	.halt_reg = 0x50004,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x50004,
 		.enable_mask = BIT(0),
@@ -2472,6 +2473,7 @@ enum {
 
 static struct clk_branch gcc_pcie_0_pipe_clk = {
 	.halt_reg = 0x6b018,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x6b018,
 		.enable_mask = BIT(0),
@@ -2547,6 +2549,7 @@ enum {
 
 static struct clk_branch gcc_pcie_1_pipe_clk = {
 	.halt_reg = 0x6d018,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x6d018,
 		.enable_mask = BIT(0),
@@ -2622,6 +2625,7 @@ enum {
 
 static struct clk_branch gcc_pcie_2_pipe_clk = {
 	.halt_reg = 0x6e018,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x6e018,
 		.enable_mask = BIT(0),
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

