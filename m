Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2215319-1521708792-3-11931912834927120291
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES endafr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521708792; b=Qips9UWwcHSa3K9SmwGPc/mSCMkt4OB7nQ3l0UeIdDDo2jn
    zdUpCk2ygoF7OgCMInthqX1GCtRYqdbm1OrGRDFKkidUAUDYqOXlaFJf7uS6nx5w
    YGRfvKNCJMDa43G+N1WZSQc8SHETMQah56y6tizxiHQhJm8g3vsqidCrNwDILAyk
    oEiQMldKq2oYS9nPfnLc4kPO27cvhNs0ig3grPmJJoKGplabqsJoi2tWNwo7LyHI
    PFn6lY36K7CrtkjSaGmmL+3vrnt2kfeMdCW5MIbyoeWnSz6Oc90WJeFF0nE2kyV3
    tth8gVLKJDXUnRfzhbItdhpi5Rj+hZrpQLOuwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521708792;
    bh=UTLuM80Xd6Km0jCWARKu0BQF5NDckMBWyOdKU/Wy7cQ=; b=OmjnE+Ce76ev
    GmdzXalgXGN8cVSXWrg9g/9ZEekI/N3gy3z+gyvm5ArdQK8Y/ZLMu8ynsqEN+XGj
    O1hDmojhyV7gR04dp9FUJmL9SFb4Qf8ZjEAYF3wnyiHg/5Se4Vc7qR/JLbUPeWC4
    2oWIPV5+p1YEXJFrEtXDRs0nHxAQQt0FQjlwbsD6vxCtib3TrIi/SYGDBJeSKH13
    Hd5/gbMjhU0rSzw1Q8PjFdHFWhg9yVJbEztlKFhvVoUCOfb4I3ogGlDp+78TNDec
    iIqATZlGptny0B5E1LH3syur/xf/6IgRhoJblhwZGXgGiFb2+eSwJi8W9NZJOU1K
    oBgCQqEUJw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=KaRyFQUl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=T24e9leR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=KaRyFQUl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=T24e9leR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeCVIv0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 04:51:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeCVIvU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 04:51:20 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 100D660314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From: Manu Gautam <mgautam@codeaurora.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        stable <stable@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 2/6] phy: qcom-qusb2: Fix crash if nvmem cell not specified
Date: Thu, 22 Mar 2018 14:20:42 +0530
Message-Id: <1521708646-5379-3-git-send-email-mgautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521708646-5379-1-git-send-email-mgautam@codeaurora.org>
References: <1521708646-5379-1-git-send-email-mgautam@codeaurora.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Driver currently crashes due to NULL pointer deference
while updating PHY tune register if nvmem cell is NULL.
Since, fused value for Tune1/2 register is optional,
we'd rather bail out.

Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips")
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
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
