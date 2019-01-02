Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC38C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30005218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT1e4HvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfABSi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:38:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38867 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfABSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:38:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so31410786wrw.5;
        Wed, 02 Jan 2019 10:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TA7D7NPf3a7RzRwyunv0cgrRhUIXRKrTDkbL04mAHDo=;
        b=BT1e4HvF9al1/cNjC6Pm/bjrO3l/W7Bb5j6DseDA0igBqzzaixdy0vRPlBG4fny6aj
         TZvsiLNc6vU0vWUALKVgNmCViSKFxnjOar/m0BwHV3C9fqWh6XDesQudFTjg12/pfzck
         P+hjenrgvWc401YXEYOLHLMDbGEB02O0eq9H6BBl0kYzzlnP/xykfW4XJDAbb1Q2Er+z
         YjY7sDt7WsBTNaqubZwvf4joPJ4TUvPwE6oHU4xoranVPDuocR+FiK3sLGGVLL0fca9v
         Zb8jD/QnZUmJaXqdA2QqLkMPbXupQhyvYABG5eM1nsCqaCZZovhA0QwH14B+Vjaj2/w9
         qKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TA7D7NPf3a7RzRwyunv0cgrRhUIXRKrTDkbL04mAHDo=;
        b=AKkcaIQHXBLT0cACwOoRA3ligfZYP23/Hn6EZo7Av1kXQKvd37luOiZsbyAf/0J43R
         WuY9g6ePX6odoj9Nefir3VDwg9sqC5FHl0xjkXtTpLXrCDOXFWR0D5eCrzcztia7PdTq
         D3aSPA2fFwpf4cRrUc7Khqy+PUsRaEP0PX0A1BR6lGxQo9EWmRmzEvcB5atW0ETd16a8
         N8eqz7Mus8AYk05PgMjOmL3ZnrF3wwxwNnh3yM+vYtELgQ+WH6ivTf2LXE0G+6DzVwMt
         DhRCY8M6Qsgq8TW0XBsBwzmyPaWOZpF3JaiXgrFUwm6Pv0WwhEek0YIyQmSVV0EhoyFt
         O2MA==
X-Gm-Message-State: AJcUukdLSCo8b6LuhnGtL/iOkSklx6ADtNfZ/envHhsTpudL8RROBPO+
        FAhEwBdg2PLo53DScmzs5WE=
X-Google-Smtp-Source: ALg8bN4NHjE7yjlUe1fw1LVsJB0i6Hryzfv5Tm5TZ68lCg0Pxm7NtN61mIaGeEtZ7QZK8yFIQwkW8Q==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr37856892wrx.134.1546454303987;
        Wed, 02 Jan 2019 10:38:23 -0800 (PST)
Received: from jack-All-Series.home (12.221.208.46.dyn.plus.net. [46.208.221.12])
        by smtp.gmail.com with ESMTPSA id z206sm42517530wmc.18.2019.01.02.10.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 10:38:23 -0800 (PST)
From:   Jack Stocker <jackstocker.93@gmail.com>
Cc:     Jack Stocker <jackstocker.93@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Harry Pan <harry.pan@intel.com>,
        Kamil Lulko <kamilx.lulko@intel.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB
Date:   Wed,  2 Jan 2019 18:37:44 +0000
Message-Id: <1546454264-11561-1-git-send-email-jackstocker.93@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To match the Corsair Strafe RGB, the Corsair K70 RGB also requires
USB_QUIRK_DELAY_CTRL_MSG to completely resolve boot connection issues
discussed here: https://github.com/ckb-next/ckb-next/issues/42.
Otherwise roughly 1 in 10 boots the keyboard will fail to be detected.

Signed-off-by: Jack Stocker <jackstocker.93@gmail.com>
---
 drivers/usb/core/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 7909262..4a9267d 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -377,7 +377,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
 	/* Corsair K70 RGB */
-	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
 
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
-- 
2.7.4

