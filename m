Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2640917-1522928799-2-13288644560455823989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522928799; b=lgQKk1xIBNGrORZh2jO6nBsbWULTXJGaRBa+/LXNfR910ZMLNk
    gj7Q67LLNUvV94AAtqer5kA0UV0ZUlV1ByG162GlkZJbToYbUOA8yX6N2KKPWUQI
    Vu+QhEs8/15P4uQXeBMUly8FRHEztltEv/EeYgJlIsESdiR84Y4PJF+8nj7CUkTU
    Ct4zVwSzRH+86WjSyCPbffLfcxgMmWMTXpBVa2Y56esLvpZ8D0LRUkz4WJ1GlHHJ
    4HYLpcNMx2aru+5/raP60zipXaTjOSms8giZ/ODRblRPtsAa5FdwQUn5fQOoo6Vi
    jErRm5HplatCs0NnRBdnWmhqCnIOQxH9LCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1522928799;
    bh=hpAWR9je5ondZ7Apum8fVQLXzcW7AYaRcVZTCBTTKVM=; b=sl1rWV3cKW5u
    cB9Q+0LR5SPKYoV/U7yn9Bj2A0sfWhuS4y0jzUUCIKxPqKXs8NmOEKiYCnHpjyTu
    OunTM9lc2JwHHplX/2Wyq8Xsn+CbE9PXoLFU1qlpT3NvBiz7xvr4UnJ3ZO9XXmTK
    DLtyP7cDeuMOmSCEwyFUs/4K/9erK18bxe3PCVLvqTmGz4FA+hDpL7p25M6/Cwsw
    CgFWONny2AQQ4FbsWKEQb9SnMgz3281FL8Hi7YHaSUKd2kRfFIG4IEwDkBFaCNML
    3Ehf2jocC8KtRdhSQHL4Q63PwCEA1DX3emY5U0VbX0cFp31Lhn2XZ32K1LhYLjz2
    Ijf9iqtzyw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=gpAImhL3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=gpAImhL3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPcOaO6edxmO144nCUDBBXalTw9tYI6sogJMCOlZKK7tq4pBYzSdCS01/gBSOFiO0NhZuLzBSHLm8duFPCAtm4AWiJ40/Y2kW0VhvuqlVNzE6a1Pj3L3
    fFJzkX54kaf9JLPTnNyqff5AVz5dYtGrQB07NtNWuXvn67RzGPoa+PXQnEu2zEQdVkdhFsLhh/zkaqU2YTK53+mWCJs37pssvbZB0nsFMy7RHFHrQJ5OWoJO
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=sozttTNsAAAA:8
    a=VwQbUJbxAAAA:8 a=UyXOFP-E6qvagf5G3bUA:9 a=aeg5Gbbo78KNqacMgKqU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeDELqh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 07:46:37 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:14695 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeDELqg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 07:46:36 -0400
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <tony@atomide.com>, <lee.jones@linaro.org>
CC: <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hns@goldelico.com>, <stable@vger.kernel.org>
Subject: [PATCH] mfd: twl-core: Fix clock initialization
Date: Thu, 5 Apr 2018 14:46:36 +0300
Message-ID: <20180405114636.16294-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When looking up the clock we must use the client->dev as device since that
is the one which is probed via DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable@vger.kernel.org
Fixes: 7e2e6c5758de9 ("mfd: twl-core: Do not create dummy pdata when booted with DT")
---
 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index d3133a371e27..c649344fd7f2 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1177,7 +1177,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	twl_priv->ready = true;
 
 	/* setup clock framework */
-	clocks_init(&pdev->dev, pdata ? pdata->clock : NULL);
+	clocks_init(&client->dev, pdata ? pdata->clock : NULL);
 
 	/* read TWL IDCODE Register */
 	if (twl_class_is_4030()) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
