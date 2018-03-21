Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-193552-1521648658-2-5082354771693358041
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521648657; b=LWryyy4nHVRemp5C/qpvKaBxpYjAkU0bwNo/3Shf5aX1uV/
    6WfINXkDu0vzC4Toa1LsxHayiRWRvePOuZHSWp3DMWT/NJwLyj09rc9zFUT80nxE
    01v1wu4fOd26Rd8L3FmGvX2eZRT3r2JvQEjGxRFkM4CGTdHNYPgtgP0zHROwJogq
    7lTT9ZELN54sed10HQrVBeRT68Nxa5U05z+GQdermWkmIAY/kIa5DWhHbysk5Qps
    F8wSBtSWRG4BEX/hfHUxHmWfuXXDafGLRqizaNowj5gyeqIS8JQSYsX1TEV/0sZZ
    C9rQIOZIfDOybEnLR8WJsHdKIIbziZUoLXxr8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521648657; bh=PjuxEBvStn/ce7yDjTg1O3fVBe
    iRE+GmI5/cMdJsc9A=; b=edPkQlHoVpe7f+Dnd4oP+ah/gS449nbbm6MWXRj52B
    3Z3VlxCXrrS5eF91+iHEU3N0H2inQg2Wml749NqC5gZGWY3yVWKO44ObPIqq1FfF
    FDIeRVPFhVcQ7v/NIssuqjo2WK+3sP4U4mw8nU6q5IMqC/XAd1kpMMB/iw1YY2Of
    1GZpQWuDaMhhyESRRtcS/ZzgYb1f8q05pZfSvyDGzkF33+wdrHDxyVTQx6OnVDt0
    S0B5bXqDuRTrz5EEaeaMH9XAp0/yhMbWGPmIG5z52TKgYrukbPeKhypJYq7sZr6T
    IJRkGLh+FGMo1hW214PVKG89VapkH+N/9+cpDY6pJWkw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=mX2j9ieu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=mX2j9ieu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=mX2j9ieu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=mX2j9ieu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeCUQKy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 12:10:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCUQKm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 12:10:42 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B37636025C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vwei@codeaurora.org
From: Vic Wei <vwei@codeaurora.org>
To: marcel@holtmann.org, linux-kernel@vger.kernel.org,
        majordomo@vger.kernel.org
Cc: stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@vger.kernel.org, kumo@qti.qualcomm.com,
        vwei@qti.qualcomm.com, Vic Wei <vwei@codeaurora.org>
Subject: [PATCH 1/1] Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_QCA_ROME
Date: Wed, 21 Mar 2018 09:09:57 -0700
Message-Id: <1521648597-2642-1-git-send-email-vwei@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

QCA Rome controllers can do both LE scan and BR/EDR inquiry at once.

Change-Id: I89e1412d635f4cd7b2500f7492f37430ea139f0c
Signed-off-by: Vic Wei <vwei@codeaurora.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 60bf04b..b94ff37 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3050,6 +3050,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	}
 
 #ifdef CONFIG_BT_HCIBTUSB_RTL
-- 
1.9.1
