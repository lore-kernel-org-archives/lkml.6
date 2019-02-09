Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B00C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2989520811
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVnkzdcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfBISFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:05:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46978 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBISFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:05:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so4823525lfc.13;
        Sat, 09 Feb 2019 10:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cRLknLu4A+g/g+wyKtIaxVWuB/kRPxqIzMmPn314zsc=;
        b=kVnkzdcpjllIK7cuO/ttSz1ktXQG5VczRC1iqOPB/ht6/O6soqTmqKTsFUCJpNIHsX
         6BJSgX+MYt9JS+FFnqeK3gJGyMY0pJV1IYzBVJKMHvfcZjnN9owpM5l0coUA09v9Qv7r
         g9WVUGabcnozYUPBfrRVaKzBwSQdOMgbbuDz2VszHP7CKKvtgz6QBZBxu2aZTO6YLdqk
         no+vDpzkLhGoW4CYzy3Z4Y+39hHZvzTz7zDIqbhou827tf3CkxX9vMUWi1cRR8kUUbMA
         BCxnFGjIL/YTqED4w4y1qBocghjZh1XtIBsYmhCAnkd9FgAzlIIPODprSC4oantlzR37
         ivug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cRLknLu4A+g/g+wyKtIaxVWuB/kRPxqIzMmPn314zsc=;
        b=M9jNvp3JP6TETRfgVIj+TcUgZ4WTxN6sthsLt8T1cTg52lyhoHOzSTtW0kKOqg2bQX
         PEjAbDZ6bWMUs/9Jc+mVX924lq+zuUasdTqv9jvdEi09AH7CSXV8qmK41rFFpDHq8s+r
         GseQnMKyAMKOUpEQrNIaJZrg/GMNcbavibS/sx2JPEUtU4BGPDjfjXw43Or8LuyxHnQO
         8hUxaj0Kh5gDhpw+tpQtgLmersnPDUYkeUf5uhL0Qo7eC4B+3oGDk2Nix1S8fFqVnXDE
         Hskpkp80vWlP9a6baZuEJqbrA4epKBQs5HGTb8STvOlJS/4JomnEn/AE5mW8xEUyNhfx
         1NjQ==
X-Gm-Message-State: AHQUAubL7oxxHsEMpWagxzH5IVfZRB9Cs5sKM7FwEnP7zlqVIGrH3lO1
        9q+SDNEgoBw2Q8vyOJPJjUQ=
X-Google-Smtp-Source: AHgI3IYStgIJYBxLn8WOT2Q3bJ8T9MJouuwIR4gr2pUU5Zl/f3tQGoYAbrrqqbbnYxOcQOM6MXrXqA==
X-Received: by 2002:a19:da1a:: with SMTP id r26mr9413537lfg.2.1549735535308;
        Sat, 09 Feb 2019 10:05:35 -0800 (PST)
Received: from localhost.localdomain (c80-216-88-47.bredband.comhem.se. [80.216.88.47])
        by smtp.gmail.com with ESMTPSA id f10-v6sm1143585ljc.31.2019.02.09.10.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 10:05:34 -0800 (PST)
From:   leakim.wikstrom@gmail.com
To:     Jiri Kosina <jikos@kernel.org>
Cc:     =?UTF-8?q?Mikael=20Wikstr=C3=B6m?= <leakim.wikstrom@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: multitouch: Lenovo X1 Tablet Gen3 trackpoint and buttons
Date:   Sat,  9 Feb 2019 19:05:26 +0100
Message-Id: <20190209180526.7564-1-leakim.wikstrom@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Wikström <leakim.wikstrom@gmail.com>

Add support for the trackpoint and three mouse buttons on the type cover
of the Lenovo X1 Tablet Gen3.

This is the same as with the 2nd generation Lenovo X1 Tablet.

Signed-off-by: Mikael Wikström <leakim.wikstrom@gmail.com>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f63489c882bb..500c8f64f7ae 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -703,6 +703,7 @@
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
+#define USB_DEVICE_ID_LENOVO_X1_TAB3	0x60b5
 
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f7c6de2b6730..03a69049ca52 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1780,6 +1780,12 @@ static const struct hid_device_id mt_devices[] = {
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X1_TAB) },
 
+	/* Lenovo X1 TAB Gen 3 */
+	{ .driver_data = MT_CLS_WIN_8_DUAL,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			   USB_VENDOR_ID_LENOVO,
+			   USB_DEVICE_ID_LENOVO_X1_TAB3) },
+
 	/* Anton devices */
 	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
 		MT_USB_DEVICE(USB_VENDOR_ID_ANTON,
-- 
2.20.1

