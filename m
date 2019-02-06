Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E108C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B51A20821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj8GCy93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfBFQOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:14:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38162 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbfBFQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:14:39 -0500
Received: by mail-lf1-f66.google.com with SMTP id j15so5770804lfh.5;
        Wed, 06 Feb 2019 08:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kjmvCeVc5JsxcIwlQcOrKqzediinYohj5UUHfKKjY3Q=;
        b=Zj8GCy93ecKfM5djNcd/ExBL8B6ItACh9goJHS/vrwSc5TH6WHcHwDNnK/CmL0keor
         lnzwZ8wvYras1vUYTsM8NtlRBJg01EIiqfWWl0TX50u+m5DfnG1t2s3zz4vtq12qtnAX
         phGW6QEBTz7CiBwKfr6Tid5Pf/QsJKoGazRH+fAItdU09s5EZZC4Ij12JMJllRVcmNeN
         0UtBHXgjFLtxZVltqDY/MVFwQBuJEGsnpVLdrSDP3uUsu4kZAFJfAetnIrwpaiA2jUPU
         MogxpSQY9KCJt3LpVoWxaHy5lZZDSuAMresSg/e4fTGbiNT8NeG0YEx+Bzi1mctPER3X
         Qu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kjmvCeVc5JsxcIwlQcOrKqzediinYohj5UUHfKKjY3Q=;
        b=hCy6JszzSlhx3CX9WCEPPf8w2k9npTcnCXn+tNwqogJ+lfJ49Np/dBaRhiCOAD3SJi
         s6pQ3BJQQy+BRUg9AbbYtcNhOsVt0+aHGuSBLQOPvW7T4zHHO0vTxsREMb8KynCPo81S
         GEBiFl3MCHJAEfxiIYaZhy4YNBrgNR3BRzDaarQyE0+hTUO7EB+OGpV8RdRQDBGjRUQ4
         8S2PDumx9eaC+nQ1JKEJydCnHRbeZbP/oiu/r/PycKaYLt1FQcj6HrhRlUfGhGGexpdj
         rdLCHpRfwrb6rJA4wWM8ooKxAhrP599FqBg500lpmHyJoXKR+X3fsuLSn8V69MEz+Apz
         aYcg==
X-Gm-Message-State: AHQUAuap9mC7bVF6CIwQ1ASNHdgIUxtMfoEtRmOq5CDotW8BJYKW0mOn
        U57h84n6ya6KWdehQvlBJIfRv1SMo1c=
X-Google-Smtp-Source: AHgI3IYUZWL0Y80qTtRn++nRqRKeear1U05/EjKQaeJVRuI7GhpdfYyZsJ2ccM583mzJ4w+87PmcnA==
X-Received: by 2002:a19:a345:: with SMTP id m66mr7134919lfe.84.1549469676768;
        Wed, 06 Feb 2019 08:14:36 -0800 (PST)
Received: from localhost.localdomain (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id b128sm4417632lfe.91.2019.02.06.08.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 08:14:35 -0800 (PST)
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Mironov <mironov.ivan@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] USB: serial: cp210x: Add ID for Ingenico 3070
Date:   Wed,  6 Feb 2019 21:14:13 +0500
Message-Id: <20190206161413.14536-1-mironov.ivan@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is how this device appears in kernel log:

	usb 3-1: new full-speed USB device number 18 using xhci_hcd
	usb 3-1: New USB device found, idVendor=0b00, idProduct=3070
	usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
	usb 3-1: Product: Ingenico 3070
	usb 3-1: Manufacturer: Silicon Labs
	usb 3-1: SerialNumber: 0001

Apparently this is a POS terminal with embedded USB-to-Serial converter.

Cc: stable@vger.kernel.org
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index c0777a374a88..3286ed462fc5 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -61,6 +61,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x08e6, 0x5501) }, /* Gemalto Prox-PU/CU contactless smartcard reader */
 	{ USB_DEVICE(0x08FD, 0x000A) }, /* Digianswer A/S , ZigBee/802.15.4 MAC Device */
 	{ USB_DEVICE(0x0908, 0x01FF) }, /* Siemens RUGGEDCOM USB Serial Console */
+	{ USB_DEVICE(0x0B00, 0x3070) }, /* Ingenico 3070 */
 	{ USB_DEVICE(0x0BED, 0x1100) }, /* MEI (TM) Cashflow-SC Bill/Voucher Acceptor */
 	{ USB_DEVICE(0x0BED, 0x1101) }, /* MEI series 2000 Combo Acceptor */
 	{ USB_DEVICE(0x0FCF, 0x1003) }, /* Dynastream ANT development board */
-- 
2.20.1

