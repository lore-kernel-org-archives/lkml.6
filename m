Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1358616-1525295300-2-11443843847543455225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525295300; b=jsI2lCE5hyBdkapoZ8WohzJHUI2KdTupW28UwFa0bgzeXA9NaS
    TI8IyQL7+HNqvWeoS/2szY+87sDOVK3DopAg+aMqVNj3Q5G6+3lVwE7zEd5EkJzv
    uYnlarIdGGCUy6P+yVXG7lcsMmawbe0pdAAMyEUIllTqr/+aDPCtGrS18ooWle5j
    bNEnU71iuxnmzKgH+9qu1nyndgezQMdUq7ajPTYb/1fSNVx2k/bWw60cnsGv4AWX
    rNo3uCia5VIm/TSPqH0UgECH7v+mxouXgXkH07yERNHdf3B5IMhut4IAP9BaqtkG
    LF+G8AvUBsIPXlk9sE5a5rWfFVwBxonJC5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525295300; bh=
    yEF/W/VScRmOCj9wktXbxhV9Fd2zqjoHVuWGMlbAlBo=; b=W7RS3tXWl17ebY2n
    4DwFBHmXyHn0TID2PD/SCBejklcsHx/EGjGamOMdKPCycou8r9MohrZiQLNYBnpO
    H6WfPYfZrxu/M44dCIR5eM8hsLBYe7YbIRztAmubz9PqmIOp8fvo9ZZTQktRrlF2
    vGm4qH9xjWH/ZzfsOHoLZjhPqorYr1Jufi/5Hn6qdjhFqQXJbNU2x0kQrrN7uDHx
    5cDouc6kZs1uVLArc4gfd3+NfpTxBDzWZvB7b7lg+YSiOaixJsemdagK/eKrP0nq
    uwNp9NlOd2pABT8uozVlJeONVh6ImOBNenPLA9klXHHEu3M13a5Mizc1YkzXE8Wx
    M433Uw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=I34S0OlB
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=codeaurora.org header.i=@codeaurora.org header.b=MVKpCW50
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
      header.d=codeaurora.org header.i=@codeaurora.org header.b=I34S0OlB
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=codeaurora.org header.i=@codeaurora.org header.b=MVKpCW50
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
X-CM-Envelope: MS4wfAYCUkMbHRZ9+CUeNPpSAIpby0YmSyXleaKmNHSmHWWtVpihDDwz7Fq/ICkn0QLNUm4Hx4fpANt96HM7bhS4Htp4x3oTgy2XcEB2sbkAFxh84fykH6zA
    a4SJklRG1K9yDtZBDXeICgHs53c0tN5YNf2JJpl9h2VKAzPhIWOWGZZ/T1qx0U75e9ty5otIfIBmqcLStkDSCAjSbgTNyB7PKtLQqBNmDSyJ6/IEnaa8pn2U
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=f9Bc9jwrbPSyHNToSH4A:9 a=x8gzFH9gYPwA:10
    a=pioyyrs4ZptJ924tMmac:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeEBVIH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:08:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeEBVGp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 17:06:45 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 098766090E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>, robh@kernel.org,
        sboyd@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, evgreen@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH v5 3/7] phy: qcom-qusb2: Fix crash if nvmem cell not specified
Date: Thu,  3 May 2018 02:36:10 +0530
Message-Id: <1525295174-15995-4-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
References: <1525295174-15995-1-git-send-email-mgautam@codeaurora.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Driver currently crashes due to NULL pointer deference
while updating PHY tune register if nvmem cell is NULL.
Since, fused value for Tune1/2 register is optional,
we'd rather bail out.

Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips")
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Cc: stable <stable@vger.kernel.org> # 4.14+
Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 94afeac..40fdef8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -315,6 +315,10 @@ static void qusb2_phy_set_tune2_param(struct qusb2_phy *qphy)
 	const struct qusb2_phy_cfg *cfg = qphy->cfg;
 	u8 *val;
 
+	/* efuse register is optional */
+	if (!qphy->cell)
+		return;
+
 	/*
 	 * Read efuse register having TUNE2/1 parameter's high nibble.
 	 * If efuse register shows value as 0x0, or if we fail to find
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

