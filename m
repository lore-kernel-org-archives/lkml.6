Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488755-1524650126-2-8778532006493210583
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES daensk.us-ascii, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524650125; b=ZTdxRw9FucSWSHG1euftx13J+HJB6i4ULTgcm5rK692iI+vG4g
    3Vsk3y5bo+ygiyD363jIorjrwo1GyiCaKgEHu6excQrlu9SMhZi9H898xJAOakBR
    Hs3ZuCLM2GmJC9VVGiZAsCWKK7s1EzUpeH5FsFIZJ9N14NvMheSj3COmyXDAfYmK
    8Ngj4TkmCrAi818n6L6DALwvHYt6beh9wG0Ou4efjfQlCx8lu0AAdvp4TVptnUoE
    CqxyokdGCAlC1t6oNBTJyoQVoFScxr7Fz3TPFCB/CmIWh9v/qlryrFB1Nu4stZJk
    pDxghn3qx5GQFCyLE1X87jgvpRyV2D+jYYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524650125; bh=32MSsSM2a4fZSXFCV2sy8SIP6cio7X
    CfxtlEJJd4Sko=; b=TOj2CrWjk50a4UmUkVEr9XyokJXzigIbumo3Zs6YKSKn4W
    ANb5IO98WoH0ECdFC3uMpyeDuwFTOHg+Aoaid0ftRm5zIJpa4bvgigyOSPnvUwC4
    iRxGMlmdHj7UHXf4jrvLlrNwXS0/ftqkmjHQ3NYScd22ParRBGVKXzL8bHpE0L8P
    DTH4tfb+cLZ2sGRdT2tuRwvP2NN4Ls8wgbwH8IwSKBumZVK81KpajAOXSPnAxKAU
    AV4ZgJ1MDUXtKiZ+Mf6m1WcjIyQkqQE6nL29pbykc5IxKH4J1ktXfvcMG1QFVAAg
    6GvoykfSKC+zcRiYMSDl/Enz4IsiJjHXBmi6JkAA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHQl20s24aly+WObDLg7yAcwTCjFw5z8Lh+AHRGviFtMFWyv5TCRcOAa0rNHvPE++9CyaFDyqnjtrIgTeg5K9ycdnZlT5OeRoDWJylyUFWwAV6z+Rr9s
    +b4pCA0Paq2f1y+VxZYrFLKB53wPDyy0c49BqlgjjPgu5MEQT4nHWlwNjGtr1kZ4HBT+j2QQRmQU0gjovU+2rR6swwN2T52Hyy+FpVkshz3Euq2534u4RU6P
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=cm27Pg_UAAAA:8
    a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8 a=klMEnJxAS6LMxW2AEbgA:9 a=x8gzFH9gYPwA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeDYJyt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 05:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbeDYJyn (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39741217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Grant Grundler <grundler@chromium.org>
Subject: [PATCH stable v4.4+] r8152: add Linksys USB3GIGV1 id
Date: Wed, 25 Apr 2018 11:54:37 +0200
Message-Id: <1524650077-13270-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 90841047a01b452cc8c3f9b990698b264143334a upstream

This linksys dongle by default comes up in cdc_ether mode.
This patch allows r8152 to claim the device:
   Bus 002 Device 002: ID 13b1:0041 Linksys

Signed-off-by: Grant Grundler <grundler@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
[krzk: Rebase on v4.4]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/net/usb/cdc_ether.c | 10 ++++++++++
 drivers/net/usb/r8152.c     |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 6578127db847..f71abe50ea6f 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -461,6 +461,7 @@ static const struct driver_info wwan_info = {
 #define REALTEK_VENDOR_ID	0x0bda
 #define SAMSUNG_VENDOR_ID	0x04e8
 #define LENOVO_VENDOR_ID	0x17ef
+#define LINKSYS_VENDOR_ID	0x13b1
 #define NVIDIA_VENDOR_ID	0x0955
 #define HP_VENDOR_ID		0x03f0
 
@@ -650,6 +651,15 @@ static const struct usb_device_id	products[] = {
 	.driver_info = 0,
 },
 
+#if IS_ENABLED(CONFIG_USB_RTL8152)
+/* Linksys USB3GIGV1 Ethernet Adapter */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(LINKSYS_VENDOR_ID, 0x0041, USB_CLASS_COMM,
+			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
+	.driver_info = 0,
+},
+#endif
+
 /* Lenovo Thinkpad USB 3.0 Ethernet Adapters (based on Realtek RTL8153) */
 {
 	USB_DEVICE_AND_INTERFACE_INFO(LENOVO_VENDOR_ID, 0x7205, USB_CLASS_COMM,
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 89950f5cea71..b2c1a435357f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -506,6 +506,7 @@ enum rtl8152_flags {
 #define VENDOR_ID_REALTEK		0x0bda
 #define VENDOR_ID_SAMSUNG		0x04e8
 #define VENDOR_ID_LENOVO		0x17ef
+#define VENDOR_ID_LINKSYS		0x13b1
 #define VENDOR_ID_NVIDIA		0x0955
 
 #define MCU_TYPE_PLA			0x0100
@@ -4376,6 +4377,7 @@ static struct usb_device_id rtl8152_table[] = {
 	{REALTEK_USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7205)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x304f)},
+	{REALTEK_USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff)},
 	{}
 };
-- 
2.7.4

