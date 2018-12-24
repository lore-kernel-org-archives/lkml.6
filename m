Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1369CC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB99521850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="p654omlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbeLXQr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:47:57 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:56606 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:47:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 964FD9C3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 16:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P0aES3vZqm37 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 10:47:55 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 5F33C981
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:47:55 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id y86so14414111ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 08:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dIiMlFqq3yfGqtUmr9AeypgYkhhcCc490/DLplCG8h8=;
        b=p654omlb+WQ199ZgbjIqQ/oakm5gVck9aI960EjkMdAF6h6hi0LjemPS/IBIAjdHrG
         0n6BmuARObtafD+89zTT6cTPLI+mlTgCn1gQyFNUjlUSH18GzQkYbJwxBorxWoObFKr/
         eCf2yFWC7O8k/aywIKVfvhOrKF1qRFsjMXDSlhaWuHc9eeSiH+mDVnCpG37IfWJtNv7O
         f4X5ZLOS9uCORCN0yZiXlhNPXWm3DrLowbErlTdjrlcYfgpvwLIRe5ZH73zNtxoSZ8hZ
         2rlTIoW9YfRQq+vZAQ+lk9qvPCAvxm5JZF5KklG5DnajVGyfUo4jRq/l9bIyDFeO8ddo
         /wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dIiMlFqq3yfGqtUmr9AeypgYkhhcCc490/DLplCG8h8=;
        b=gR3iCWsbtZ9XBccMzh8rsCYRyIWFvLFgGM34tvQ7TD9RXM1kewdNibiktU9SOXcBB5
         NGqeJnFlTtUkqJd73YLyodocwj8IBZ6EpodWBvvrSWOPM0XjwOgzFbRjj76RZS242LSs
         774XwXmPaDwNvY239F5gZ65otDlMykJlzF/HatEWGxLXuViKiFmN4Q0UzMljOnXs7dhG
         PYCjRwfTnqtVOph/MDoyr5rbSCT8vUMnrb117auXxY0kyzSTGqq4qYgZZeeEnE0jbP6u
         7ZaiRRAjmSI5aIN2rleCN9wpsel8FDY2Hi4LosMtavJbzLg/WLlA3Xr5WPT24YdsaYIW
         ozPA==
X-Gm-Message-State: AA+aEWbSQ61NsX3c4AAG9goxlyl9i0wzxuT1ewezyQ5TNRC3zYT3+X4g
        8ggKARj6VEl5R2PYDzRWvsv3V2z/ZFj2O/LGvyRYQ9kCEOjFnnAIctwYFx2guaqjdiLK7K0Sjbf
        5vT2Hb3B20vWIBwMRPEgs7XaQhAw2
X-Received: by 2002:a02:a315:: with SMTP id q21mr8361596jai.94.1545670074967;
        Mon, 24 Dec 2018 08:47:54 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VcIEfupmuRwH9IpzcyuKBumIvKuez1x91nJkbV9st1gM87m843Mg4YyDOe/k2dgIrkdk4u8A==
X-Received: by 2002:a02:a315:: with SMTP id q21mr8361591jai.94.1545670074709;
        Mon, 24 Dec 2018 08:47:54 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id c68sm10895578itd.19.2018.12.24.08.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 08:47:54 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/intel-mid: Add pr_warn when platform_device_add() fails
Date:   Mon, 24 Dec 2018 10:47:37 -0600
Message-Id: <20181224164738.17973-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_device_add() may fail in intel_scu_devices_create and
sfi_handle_ipc_dev. The fix checks for the return value in these cases
and displays the failed device.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 arch/x86/platform/intel-mid/sfi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/intel-mid/sfi.c b/arch/x86/platform/intel-mid/sfi.c
index 7be1e1fe9ae3..e69511bafec5 100644
--- a/arch/x86/platform/intel-mid/sfi.c
+++ b/arch/x86/platform/intel-mid/sfi.c
@@ -278,9 +278,13 @@ static void __init intel_scu_i2c_device_register(int bus,
 void intel_scu_devices_create(void)
 {
 	int i;
+	int ret;
 
-	for (i = 0; i < ipc_next_dev; i++)
-		platform_device_add(ipc_devs[i]);
+	for (i = 0; i < ipc_next_dev; i++) {
+		ret = platform_device_add(ipc_devs[i]);
+		if (ret)
+			pr_warn("can't add device %s\n", ipc_devs[i]);
+	}
 
 	for (i = 0; i < spi_next_dev; i++)
 		spi_register_board_info(spi_devs[i], 1);
@@ -330,6 +334,7 @@ static void __init sfi_handle_ipc_dev(struct sfi_device_table_entry *pentry,
 {
 	struct platform_device *pdev;
 	void *pdata = NULL;
+	int ret;
 
 	pr_debug("IPC bus, name = %16.16s, irq = 0x%2x\n",
 		pentry->name, pentry->irq);
@@ -360,8 +365,11 @@ static void __init sfi_handle_ipc_dev(struct sfi_device_table_entry *pentry,
 	pdev->dev.platform_data = pdata;
 	if (dev->delay)
 		intel_scu_ipc_device_register(pdev);
-	else
-		platform_device_add(pdev);
+	else {
+		ret = platform_device_add(pdev);
+		if (ret)
+			pr_warn("can't add device %s\n", pdev);
+	}
 }
 
 static void __init sfi_handle_spi_dev(struct sfi_device_table_entry *pentry,
-- 
2.17.1

