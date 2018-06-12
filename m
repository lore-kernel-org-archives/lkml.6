Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4C3E4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59FD208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfNckSnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59FD208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754238AbeFLDSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:18:53 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38366 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeFLDSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:18:51 -0400
Received: by mail-pg0-f66.google.com with SMTP id c9-v6so10747576pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vkv0zEh+5vEfXB38QeN4K+VfY7Mvie1rV49quym6l9M=;
        b=QfNckSnDKA3qRKm96Jp11NJk9YbYc27Uj8h1tW94sN0zTzARKPfJV+wajCa/Q2qpm8
         H/Q1RYMBCmINV6P6I9aqTHTwbNoEo9i51ewXWaZg2D3BozKMVYKfwru9NmUuG0S/4+Rz
         oue8h4ppjYGxlnECakr/vYV2j0roiM1WlWsl2mGxBPl5PvxuiIJL+wHrI7g3raL0bK0L
         6sE8VagjY71uKdQWpmoHXeBR2a7oCe5E3h/r5B5SIHxmfmh41kIvqChzHuhTVS0qCiwp
         aBeLGs+BIR/gH2GMubwtZ9lt2nD0lwtIIXdqRo1jUQOtbORwcRZfuu6hrYlwe1LxVR7p
         s7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vkv0zEh+5vEfXB38QeN4K+VfY7Mvie1rV49quym6l9M=;
        b=Nm9g/wHeWjd9HIAtymBbLOqZVm4xyUSuJIh8RbYBIhCdK3yaNKoDVHFmNTt5fPioKL
         faNXUnXkNjMTKjvi+++bnr1FEwJpnM1MAssKeuee7EVdpUdzgbsTPXVBCV7mhZhMXkE5
         ki/3Cn7+O/mzIDvUxN7osh9jwZC4AaiZfr34Ne2KvHtGTOBrvhKTfDyqjN4Z/ZUUrMGp
         o9C+KBmfazml3hBQjowCNRBfYypYHlobX0aOjwFO9hV5ZeT1X0ZfoRKFMnpbTeP0MQjV
         zUAhRdiVC0cHJxB1VPNvywRVwAWiIviaXdx9hIGqylj45HQAUT2PTPu6Y4fGF70kovYv
         uIZw==
X-Gm-Message-State: APt69E1cHEfYEFDpZlDdyPU7HbMqfWT8LmRku7PTKFK0p4qb2KEI1kaf
        2ZieVcO1BJnT4YDqghCZbnk=
X-Google-Smtp-Source: ADUXVKLdN9dCfOpRbpH2vsZWkcXnsFeEi/suIf8RyPklQCmfKzT643XaQ+RsI/YNAznmUeNNXORSlQ==
X-Received: by 2002:a63:980a:: with SMTP id q10-v6mr1592594pgd.50.1528773531376;
        Mon, 11 Jun 2018 20:18:51 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id z82-v6sm54973325pfk.30.2018.06.11.20.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:18:50 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Ryan <liamryandev@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: add error handling for register_netdev
Date:   Tue, 12 Jun 2018 11:18:43 +0800
Message-Id: <1528773525-37564-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When register_netdev fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling register_netdev.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 2a3f074..2b47e75 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -40,6 +40,7 @@
 static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 {
 	struct _adapter *padapter = context;
+	int rc;
 
 	complete(&padapter->rtl8712_fw_ready);
 	if (!firmware) {
@@ -53,7 +54,12 @@ static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 	}
 	padapter->fw = firmware;
 	/* firmware available - start netdev */
-	register_netdev(padapter->pnetdev);
+	rc = register_netdev(padapter->pnetdev);
+	if (rc) {
+		struct usb_device *udev = padapter->dvobjpriv.pusbdev;
+
+		dev_err(&udev->dev, "r8712u: Unable to register netdev\n");
+	}
 }
 
 static const char firmware_file[] = "rtlwifi/rtl8712u.bin";
-- 
2.7.4

