Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C919C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0968D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc73amEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfAGR3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:29:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50927 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfAGR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:29:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so1645758wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XZHKnZCt8l8nz+voeCojKMakD/QEr9WaoXUI81GFJ8=;
        b=Qc73amEerCYhbm3xQUn0Dp6Zx/M+pETA8BB3OfP3JpWPnhGpH4WDI/xGc3ap9NfTPW
         zshz4t2dg/f01qTW7Zh1y5+tZB6fqLbcweE+q6tb/HalXiF/UqSAQuw74aNGjr8YxnqC
         s0GN2bF6eJMZh9gZgO2vZDt1aziZCQlWcl/sHclGPAwBxrKbjnSULmaokaKByxZMNj9K
         L36LhV8xCv+0iIR43v3MFyrtgCOiVo1azR3FI4dGzK1SgTAD5kgthd700zZN5XJxdWLV
         fRpzV+Z8+G4vKNxzw8eUSLZsRNKyM8JyJYgZeVQSPkAl7m49DNofvsEztkCog2C0FDqy
         5sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XZHKnZCt8l8nz+voeCojKMakD/QEr9WaoXUI81GFJ8=;
        b=WN+/QbAjw2sWse8jpsqjP9XBu9T5Ms3ko09nttEidh4x5pZrLsCnYBMTUtm6j8mAvb
         q0O7Q5843QzGtpP/Nmp4DXp4wB9c2ceFq7zhw7zme5bhDZjbzc00CCufjQPAPARpfIL7
         m26rImwTLKoodSpiRjQnE7JDXFfhxT315cfEZ7LZbM8WB8wifwS9T7SxySETVoWNG16J
         xp4aLAKIUJe2PM+tkfe1iYKOqV0/eoVAL+t9Fiw0YFE5tmRA9QJOWJyzzi5ALmWoWFWT
         bQzxS38hlKdXQMfyQqrqn238dGkc3jLMTi0G6kyf8Ux/PXRt7E7V8K75jyCB8HWTWr2T
         ez2A==
X-Gm-Message-State: AJcUukf9J5O5k7vwicikLVaBArFgS3LS3uN7073jR86Oei87KkNP9wiS
        is1V4He1upaWd7b4yhR+LPSH5bOM
X-Google-Smtp-Source: ALg8bN4Jr1+NanFf0/Mj/pcuQyHKmGlc6Fkt+ZDZM74eRad2ixuLXZwD9rTDbLCHwSnBGgbdYdrEvw==
X-Received: by 2002:a1c:578e:: with SMTP id l136mr9138485wmb.124.1546882169828;
        Mon, 07 Jan 2019 09:29:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id b18sm46074171wrr.43.2019.01.07.09.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 09:29:29 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1
Date:   Mon,  7 Jan 2019 18:28:58 +0100
Message-Id: <20190107172858.12110-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device was added to the stand-alone driver on github.
Add it to the staging driver as well.

Link: https://github.com/lwfinger/rtl8188eu/commit/a0619a07cd1e
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 28cbd6b3d26c..dfee6985efa6 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -35,6 +35,7 @@ static const struct usb_device_id rtw_usb_id_tbl[] = {
 	{USB_DEVICE(0x2001, 0x330F)}, /* DLink DWA-125 REV D1 */
 	{USB_DEVICE(0x2001, 0x3310)}, /* Dlink DWA-123 REV D1 */
 	{USB_DEVICE(0x2001, 0x3311)}, /* DLink GO-USB-N150 REV B1 */
+	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x2357, 0x010c)}, /* TP-Link TL-WN722N v2 */
 	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */
-- 
2.20.1

