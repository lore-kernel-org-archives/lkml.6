Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37550C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C062086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 11:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZiNAIpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfASLQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 06:16:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39309 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfASLQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 06:16:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so7511079pld.6;
        Sat, 19 Jan 2019 03:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ihgfkq4eR+s+3kpq93hmo+cYzoH4VL4Bnoc/ppAZGHY=;
        b=fZiNAIpfxicEqkk8nt3IL/QXpGoVuauCP8ASti80+lk3YQdPbdtpd0deQfU+od1hsn
         1aqBh5Z7B2e4nQ2UGvv0AbyPtepZ9pHygrbcnJN1PisdmICNjR9qLGDIoT2wK8HcmHlS
         mg/7/2759Syymjxh1oSJ4kXmxri5cPc4mOdWIrkhhs35iySfJTgb6iUROvHuWNI1cpsG
         ifDuu84ViCMYSj94mbQPs1dot/nvB5v/soYSa9KS9Ic6CXHvMa9DAXIQUfDGDX1NslTt
         3UT2rcPX4TJD2zRe+GAeS67MDOptN0ydUdrTZJ9ph5rqzLDM5nYFGyRcfBurzKsUxLbb
         bKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ihgfkq4eR+s+3kpq93hmo+cYzoH4VL4Bnoc/ppAZGHY=;
        b=jxQBkma3twIq171RYH3/qc0XAVVTiMBiQwhdMyCC08+BSdLxS0bP2rBMo37coDb9mq
         SjMcRCXgbee8XtI2Te3LBS/P/tUs6O49koEapyfsdQsMjDjhwlvjQgWffDkrxzmVbG77
         C1eduJQiEJjLiqFrqIflHrCcWGj64SpqspKGx7z8H1lk6VH3yaeTx3a2TgOyvuuGFGM5
         PrY85q/TvTaulZkwEfyh5tH6ZNvz6clGErDe9TUD7/FXrLP81XH7aCquVx2RUqXJPKHL
         pTHZik/H4vm0pTIuWqN6UJfWrMzVDDXZPDa5bASuyofn6N7MvHL2Y2ERMM+i2eHj/LOv
         1j6A==
X-Gm-Message-State: AJcUukcI1WIgq41YT6fknYRrvl1n6YbXqPfwIneFb5aDrRDkK5PAqsSr
        4meRYcozbOiGDr5L+HPoimQ=
X-Google-Smtp-Source: ALg8bN7Qx2NVoIEm0LDYAL6Fyhs/keApplT6Rk1z0OQwn8HN4Sm5lRBeEr/bY53Ms7xc1R8GeNiFMQ==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr22436034pld.240.1547896606065;
        Sat, 19 Jan 2019 03:16:46 -0800 (PST)
Received: from [0.0.0.0] (static.31.23.203.116.clients.your-server.de. [116.203.23.31])
        by smtp.gmail.com with ESMTPSA id 7sm13660184pfm.8.2019.01.19.03.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 03:16:45 -0800 (PST)
To:     ike.pan@canonical.com, dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        nullptr.cpp@gmail.com
From:   Yang Fan <nullptr.cpp@gmail.com>
Subject: [PATCH v2] platform/x86: ideapad-laptop: Fix no_hw_rfkill_list for
 Lenovo RESCUER R720-15IKBN
Message-ID: <d4974133-580d-9166-f554-7e03bb1948b9@gmail.com>
Date:   Sat, 19 Jan 2019 19:16:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ae7c8cba3221 ("platform/x86: ideapad-laptop: add lenovo RESCUER 
R720-15IKBN to no_hw_rfkill_list") added
    DMI_MATCH(DMI_BOARD_NAME, "80WW")
for Lenovo RESCUER R720-15IKBN.

But DMI_BOARD_NAME does not match 80WW on Lenovo RESCUER R720-15IKBN, 
thus cause Wireless LAN still be hard blocked.

On Lenovo RESCUER R720-15IKBN:
    ~$ cat /sys/class/dmi/id/sys_vendor 
    LENOVO
    ~$ cat /sys/class/dmi/id/board_name 
    Provence-5R3
    ~$ cat /sys/class/dmi/id/product_name 
    80WW
    ~$ cat /sys/class/dmi/id/product_version 
    Lenovo R720-15IKBN

So on Lenovo RESCUER R720-15IKBN:
    DMI_SYS_VENDOR should match "LENOVO",
    DMI_BOARD_NAME should match "Provence-5R3",
    DMI_PRODUCT_NAME should match "80WW",
    DMI_PRODUCT_VERSION should match "Lenovo R720-15IKBN".

Fix it, and in according with other entries in no_hw_rfkill_list, 
use DMI_PRODUCT_VERSION instead of DMI_BOARD_NAME.

Fixes: ae7c8cba3221 ("platform/x86: ideapad-laptop: add lenovo 
RESCUER R720-15IKBN to no_hw_rfkill_list")
Signed-off-by: Yang Fan <nullptr.cpp@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 1589dffab9faf..8b53a9ceb897c 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -989,7 +989,7 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
 		.ident = "Lenovo RESCUER R720-15IKBN",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_BOARD_NAME, "80WW"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo R720-15IKBN"),
 		},
 	},
 	{
