Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2391998-1523860836-2-1222481750990255649
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523860835; b=J7uHtfSzTqeASkJj9U0WBbKUL9QVtV/5+WpvnhfZx8MFGy/pIf
    uEMlMW7hWSwz4kqvP50D6GhgfdliwHtWNW2Zi41SCI+ibKoEaWvVj/CDEnrFVgXd
    MTxhspJkJgzJFvN0J46xZjfSixGvHkToDsUhJnkDzMgwi8t7VSBlqOa7VCEStkOx
    uQOBpcseXkZQgrI7p81+2bmcb2IN7GRoPomDVpcXjuEkO6awTCJAP27bWiUlHWym
    BpYYPnKgiHIvLF3QqW2eqGW2QAUkhN/QBfBCc8mrFHC6Wbl4UC5+fdXwjRYpK3xh
    yDPxh4zOcXPGa6xY+/wTv24CLamKY2qbfdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523860835; bh=/2yx4ELcwl7HOar0oz7JanMSzAX7l5
    VBKt1bqqHdwBM=; b=Bs858hV9DC7UOVvY1fhobOL60Aj3/44fBvDqtn4rHVOKGH
    Gxc4qnAhCLLrRVJL6F/4ZyGblgBfBOf2Giay6fj5CDDjqMABd4SgrH8FWjGskZlL
    V73Zyn2vY+pJrV4hM1436+2JZmzMcMJ21IzUCV86GoaQbs7OZobpwjASLsbJy7Q2
    7uvfq/d19YvmNyogMx8erND+vYK7ihXA39pFJ27KJD8F67JJbHOOtPE8Zz6hkJeG
    mNHrjIKpd8FwbmFmXNbBUAjQiQ77nTd4S/kl27WDUqRscqC5tqivwVYXIv1XPTuj
    rxvpCmhWNU8wv/QpIkia9N8QZQYtkwPu6isRYfgA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=iWmStMTY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fjpAvdBk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=iWmStMTY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fjpAvdBk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDkKVWJXBpW4FLLL+2xJT42FVJm83hnXlylv4QAqV4JJntqpFiKeXajPFp003dVtZuCxsqqI0KifMZl1XxLwobN7zvbjBtX5BCN5ZWvRl9R8gCujp5/6
    VbE0w6vavEBXxYwrKVazIwGoeSsE9o2GGzdK5IG4qnnymWVGefB4E0ELXob9PKvD8fT+j1Y0AzUdUr38AUZ3TzbiUj1rc7mu8mqNl/pbwkPO1bhufIMcGUKw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=KKAkSRfTAAAA:8
    a=Dei6p5SHAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=RnMUjed7Kg96arKABpQA:9
    a=cvBusfyB2V15izCimMoJ:22 a=M-Yerj1wOn-OpK7r_3ei:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeDPGkc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 02:40:32 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38966 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeDPGkb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 02:40:31 -0400
X-Google-Smtp-Source: AIpwx4+1bkcywoZmFbL45eDvzRywVcnNMALa83lS91AffGT/MeGKcIy4QZc17UGgi9lfZZ0B9YD8Nw==
From: Amit Pundir <amit.pundir@linaro.org>
To: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: dragonboard@lists.96boards.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Stable <stable@vger.kernel.org>
Subject: [PATCH] Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw loader
Date: Mon, 16 Apr 2018 12:10:24 +0530
Message-Id: <1523860824-3392-1-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
Author: Amit Pundir <amit.pundir@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

AOSP use userspace firmware loader to load firmwares, which will
return -EAGAIN in case qca/rampatch_00440302.bin is not found.
Since there is no rampatch for dragonboard820c QCA controller
revision, just make it work as is.

CC: Loic Poulain <loic.poulain@linaro.org>
CC: Nicolas Dechesne <nicolas.dechesne@linaro.org>
CC: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 05ec530b8a3a..330e9b29e145 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -935,6 +935,12 @@ static int qca_setup(struct hci_uart *hu)
 	} else if (ret == -ENOENT) {
 		/* No patch/nvm-config found, run with original fw/config */
 		ret = 0;
+	} else if (ret == -EAGAIN) {
+		/*
+		 * Userspace firmware loader will return -EAGAIN in case no
+		 * patch/nvm-config is found, so run with original fw/config.
+		 */
+		ret = 0;
 	}
 
 	/* Setup bdaddr */
-- 
2.7.4
