Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A3BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B6C20869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLDlVSuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B6C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeJZVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:25:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35774 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeJZVZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:25:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id w186-v6so1322815wmf.0;
        Fri, 26 Oct 2018 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ikqsq9ZUpMujcy+3AmTZ9BuDC8qNpDrPi8MCzltixcI=;
        b=fLDlVSuO8+uOMwiCwGzwpcSvpZ6Fmb1PcXFM/wb4uRFKrGICLHAZIzPSMxK3KXP/HA
         tKpfnMy2GW2FL+0BSkElb00Ny1606kYyxW1uCxGWKy9LxJbi+QLy8C0n1PyjnFaJ1ijf
         Inull5hpR17yAGQwoGk6wz11xYtEfC5tkNtcr505q2GAiT1IvXBplwCOHE3p6p7La6T+
         9EhqrT9bZ+gcL9iVN+3U9+6BbcbY8k+hdjQ8dFnLECMJUZ8XahulxRV8m2p9qq0/ZHLx
         F83Rmo9rOI+3BSXIZ1PKHUi1jREvGLsDcEj9ZeoGY4YM89/tyhqeItTkOf5lfOJHjXDa
         FD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ikqsq9ZUpMujcy+3AmTZ9BuDC8qNpDrPi8MCzltixcI=;
        b=BBTFh2LCqBCHdq6G9V7Hr3krKjCv/psJlQIQ8rGtYxZuAuptKnBBgY+fBHKh716lu+
         e7pO4yuxPyGXDGAlNjbScE3D5E7qZGE7l9ARjx+qSVAfLwXfPr5kuw0bM3yGP71E49fw
         vqpzvmeXfF4wR08oy+KDgmTzM+JxfPUj9/fFDowAhIJdW0xAY8THzC5tCUg3zM8IfffX
         VjhV6G7KvZT+bob6hD7iERCpZzYWh151gUrEkavATIL6pZiAVve2XpuXYuI/35NcjgcS
         lRJEfVDL6gWaLKRH3ykK4NTP7dKE2/AcwBZIlEb+TMPVEI0AI6f5Vw0gvkAR/EO0LK6N
         TAQQ==
X-Gm-Message-State: AGRZ1gL2eGjunZF5arOgROiYBx6DFfiplTva456sQj8QOAHBuMxM9qJh
        eGAYAW18m33eCHK2yFe9v2M=
X-Google-Smtp-Source: AJdET5dsGsUoROHDb08vEDz9m7/X4CXLgHc7v+0mPF4XvwiUFvJjc5frIh4eQVT4WaG1D7Myr/jwZA==
X-Received: by 2002:a1c:894d:: with SMTP id l74-v6mr3336671wmd.81.1540558091097;
        Fri, 26 Oct 2018 05:48:11 -0700 (PDT)
Received: from pc-emmanuel.ealp-net.at (84-114-207-129.cable.dynamic.surfer.at. [84.114.207.129])
        by smtp.gmail.com with ESMTPSA id y138-v6sm2602362wmd.2.2018.10.26.05.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 05:48:10 -0700 (PDT)
From:   Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB
Date:   Fri, 26 Oct 2018 14:48:09 +0200
Message-Id: <20181026124809.2825-1-emmanuelpescosta099@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
Corsair K70 LUX RGB keyboards also require the DELAY_INIT quirk to
start correctly at boot.

Dmesg output:
usb 1-6: string descriptor 0 read error: -110
usb 1-6: New USB device found, idVendor=1b1c, idProduct=1b33
usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-6: can't set config #1, error -110

Signed-off-by: Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 178d6c6063c0..2632d86fd75e 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -391,6 +391,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
 	  USB_QUIRK_DELAY_CTRL_MSG },
 
+	/* Corsair K70 LUX RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b33), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
 
-- 
2.19.1

