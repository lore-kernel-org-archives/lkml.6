Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832063-2-61796235179676726
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832062; b=pqvzpUDuf/1WFxZlgujhwA5Y1nkleulumJr2y43HtRVogSP
    7i1YPeILRxqor3aWqiFN41gWTby6j6363lNj47CLXThMuELjyJFATyKr3/eMhh9J
    7MNHFDzlbnAH17ja8nTx3GvKvbKvbpNu+waM7aKivip+SWlxG+cMmMYkKx7C2k0d
    I7YJiIN1GZ6/K6sc/+/dMVd8cjvj/DzD7Y/2ADobpsMAH4maa3CKPNiLlnmDai2j
    J7uR9/9lhRM1tdzo6aK2INlCUcpxiee/bSeqIbBGOwjYlp8+xwv7Y0xgCN66AKr1
    ugJDUmF1bzBbb69/capUoPYsF6oHF2ciKcIGCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832062; bh=1xErdyYLfSBhdeFDrJG
    AuyPwTNcknWwpkJc+9cKPPDw=; b=CTXQuNlnl39nW7rJUkeDQRkkUhLhEpLoc1o
    Qese6jd/6xzvcSfUGP51S5/nfPIMSjo4pHPkXY8t74SLVLAsWVwpYfM3wiKbnO8Y
    ORR4jEjIDPC2YFeGh91HfkgvdOJ7GirAVgCK4WHnV6Oub46fPDmRc+lGqpqIrA5L
    Rk9nROx7qvQwucE/ZJ5UqjbfXAwNAMUKRNChtUaN+3hIe9/k/xoGrKpqqBtlXNXG
    JZpk9fJ6QngNTfWcdNQqC5nIwBBCIknsJuHHt0Ey6HH+/u2Zj6TG73lK9cEXRLT8
    EXsqyO1/M3VaDPcMqrqUCpk9lPqNieXqAio+i+HR63rXHEv4YQA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933041AbeB1PcX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:32:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33310 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752868AbeB1PWi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:38 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "=?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?="
        <sz.lin@moxa.com>, "Taiyi Wu" <taiyity.wu@moxa.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.644430292@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 056/140] USB: serial: option: adding support for YUGA
 CLM920-NC5
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: SZ Lin (林上智)
 <sz.lin@moxa.com>

commit 3920bb713038810f25770e7545b79f204685c8f2 upstream.

This patch adds support for YUGA CLM920-NC5 PID 0x9625 USB modem to option
driver.

Interface layout:
0: QCDM/DIAG
1: ADB
2: MODEM
3: AT
4: RMNET

Signed-off-by: Taiyi Wu <taiyity.wu@moxa.com>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/option.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -237,6 +237,8 @@ static void option_instat_callback(struc
 /* These Quectel products use Qualcomm's vendor ID */
 #define QUECTEL_PRODUCT_UC20			0x9003
 #define QUECTEL_PRODUCT_UC15			0x9090
+/* These Yuga products use Qualcomm's vendor ID */
+#define YUGA_PRODUCT_CLM920_NC5			0x9625
 
 #define QUECTEL_VENDOR_ID			0x2c7c
 /* These Quectel products use Quectel's vendor ID */
@@ -657,6 +659,10 @@ static const struct option_blacklist_inf
 	.reserved = BIT(1) | BIT(2) | BIT(3),
 };
 
+static const struct option_blacklist_info yuga_clm920_nc5_blacklist = {
+	.reserved = BIT(1) | BIT(4),
+};
+
 static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_COLT) },
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_RICOLA) },
@@ -1161,6 +1167,9 @@ static const struct usb_device_id option
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC15)},
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC20),
 	  .driver_info = (kernel_ulong_t)&net_intf4_blacklist },
+	/* Yuga products use Qualcomm vendor ID */
+	{ USB_DEVICE(QUALCOMM_VENDOR_ID, YUGA_PRODUCT_CLM920_NC5),
+	  .driver_info = (kernel_ulong_t)&yuga_clm920_nc5_blacklist },
 	/* Quectel products using Quectel vendor ID */
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC21),
 	  .driver_info = (kernel_ulong_t)&net_intf4_blacklist },
