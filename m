Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ODBsC2c0HltMEgAAmS7hNA
	; Mon, 11 Jun 2018 08:35:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C4484607E4; Mon, 11 Jun 2018 08:35:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jylQT2nv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2A128602FC;
	Mon, 11 Jun 2018 08:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A128602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeFKIf5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:35:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34019 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeFKIfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:35:55 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so11923577plq.1;
        Mon, 11 Jun 2018 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FTG8gJcA3AxjC8olL8p2LVHe6D4TEDxeNdhHMYDuNuc=;
        b=jylQT2nv1tua9+02t8mzyqwLBgg7N5Vb2JH0rVHpL3l+7sdKiJcieKVmyf33/IF5Un
         9NQ1rCooxP90h7cHtEfju+ZubEH9NCa1zdT/5PGGeyZ0CDO/jLiitiDN9LSgml1m9BHm
         nfx88g4UKcIpCiggCuLuc3F0NVrzMU/kVIMVFw5crvU1NWhzQUtqQF6GL5MJYjZ/okVx
         JDDIKIX5MR9AdbhUT42be248MtOGY2L8+fy9UG5uNpnRQRkltKxWkwlV3hgr8st4NCNc
         rJwjIUPdoeyiSI4k374TmiBR8Un1iYhcMmadtuyeibKm7rHz61M2Xf84e2M84H/aKgu7
         CULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FTG8gJcA3AxjC8olL8p2LVHe6D4TEDxeNdhHMYDuNuc=;
        b=pO2Tt2nAlkg+n2gPjk0XCAXHtWj5oiLui3sQADu2ZkoFwvPYC7gTloimplmDGoy6c6
         TcQiO8B+/JvGQrYNpKoQ9nI1U0a99oWKBOddjhuAXITUOL6MbAW4Aeq97EJPAQvFJFLV
         kvVZPrsQEM0pDm0hJ3ltNQkLFbUzgyYc8E/OZ6jSwVa1HiBuh6LiuNWHQ6OLubpnIbvz
         HidMNHolM6NJnUCfO0rZYCBpO0zkmM2FeWbXD6ZqQQpMN0tnZW/oGLylJ8MRwOWGIb1h
         q7PYYAdh/uVeIuYQELW8Z+NdZgMv5u8uon0loDAV2POsiF5itOb6DMH2SkbqDAtVrNFg
         3+WA==
X-Gm-Message-State: APt69E1VU34tpa6XMtD92AaCIhh+WlhW9gjMuN4+SWmCJ5uYFP9j5VZ2
        fKe11ze8f3uquLwBFbbyhDA=
X-Google-Smtp-Source: ADUXVKIzBzE9SaKcoyf60lU48PKMatVwDPfM/g6IcCBfIobF+r2TEmPjKvxicrVx8vIhplCaDomU9w==
X-Received: by 2002:a17:902:ba87:: with SMTP id k7-v6mr17486767pls.271.1528706155215;
        Mon, 11 Jun 2018 01:35:55 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id y15-v6sm1939496pfm.136.2018.06.11.01.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:35:54 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Achim Leubner <achim_leubner@adaptec.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: gdth: add error handling for register_chrdev
Date: Mon, 11 Jun 2018 16:35:48 +0800
Message-Id: <1528706148-35044-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When register_chrdev fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling register_chrdev.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/scsi/gdth.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index 8560479..d5a2af8 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -5198,6 +5198,11 @@ static int __init gdth_init(void)
 	TRACE2(("gdth_detect() %d controller detected\n", gdth_ctr_count));
 
 	major = register_chrdev(0,"gdth", &gdth_fops);
+	if (major < 0) {
+		printk("GDT-HA: Unable to register char device gdth.\n");
+		return major;
+	}
+
 	register_reboot_notifier(&gdth_notifier);
 	gdth_polling = FALSE;
 	return 0;
-- 
2.7.4
