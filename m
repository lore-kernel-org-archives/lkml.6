Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6737AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3862B218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="npY8QLr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfBZXu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:50:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34914 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfBZXuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:50:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id y15so3909861wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BM8nxqePtW8yUbGgVleoRab2+GDxVKfZwcAD9uD2/qU=;
        b=npY8QLr40tS7ci9LDD5MbViS5SwM6ZFX8AybilEXA0gEK08huNHyE22Qegw1T6tkd6
         0uB9rBy+fn5CXlwgf4v5HKYr2PGbos/GuyRxNuMY0oSwKRB6gDUBKPDfgfxEsmdo1CiL
         m8dLS8u4UDiFYTN00NRtAwVPUMK8VGqXprwNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BM8nxqePtW8yUbGgVleoRab2+GDxVKfZwcAD9uD2/qU=;
        b=C26eFe2n1cC9Sm3TnOWJDKBOnCxG5Rs2lR/zRy3ckQL5n5vTPLvK4l2cb9sUivH4CA
         1I0bM0ldBVVut+r39JERxovB7pOwG2ZjzJQAcxt+aKZwSMAbHBV8uGfbrHnuNeGaw1co
         WLRdPHeOf/rxE2oReTr+YK2aXf126J8XkMQ4r8rK0LoprgBt2aXsFyhw019kcZ8spqn2
         Eqbwy+uMUiTnGf7zgKY7bUicY1qFal0BuzDoswTg/2iVbvaiW663DEbA18m4s18ZbOf1
         D8027Thc7XfEAHMqbS/ppOX72pIII9xftavezcqK3jRSgWkLVqc9WM/+BnheuD3zvGDU
         EXBg==
X-Gm-Message-State: APjAAAXsdkky3hJGFnN9GRb6E2axlKAM9nyCMKpUM8Ph9WWLR2LEfo75
        YdlciBveE06tdokmm1iGTs0DMg==
X-Google-Smtp-Source: AHgI3IYM14uGxbzlEGY4NUyTSvwEw+BuZqbr1paXQ5AD/t32ScEIy8pAkws+28YU/WGbG2/ObnrPug==
X-Received: by 2002:a7b:c017:: with SMTP id c23mr347234wmb.50.1551225023288;
        Tue, 26 Feb 2019 15:50:23 -0800 (PST)
Received: from localhost.localdomain ([95.149.160.3])
        by smtp.gmail.com with ESMTPSA id s3sm19044303wrt.81.2019.02.26.15.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 15:50:22 -0800 (PST)
From:   Louis Taylor <louis@kragniz.eu>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        ndesaulniers@google.com, Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] HID: quirks: use correct format chars in dbg_hid
Date:   Tue, 26 Feb 2019 23:48:53 +0000
Message-Id: <20190226234853.20441-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wformat, clang warns:

drivers/hid/hid-quirks.c:1075:27: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  bl_entry->driver_data, bl_entry->vendor,
					 ^~~~~~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
drivers/hid/hid-quirks.c:1076:4: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  bl_entry->product);
		  ^~~~~~~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
drivers/hid/hid-quirks.c:1242:12: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  quirks, hdev->vendor, hdev->product);
			  ^~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
drivers/hid/hid-quirks.c:1242:26: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  quirks, hdev->vendor, hdev->product);
					^~~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
4 warnings generated.

This patch fixes the format strings to use the correct format type for unsigned
ints.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 drivers/hid/hid-quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 94088c0ed68a..b4e49e1b6f4a 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -1071,7 +1071,7 @@ static struct hid_device_id *hid_exists_dquirk(const struct hid_device *hdev)
 	}
 
 	if (bl_entry != NULL)
-		dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%hx:0x%hx\n",
+		dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%x:0x%x\n",
 			bl_entry->driver_data, bl_entry->vendor,
 			bl_entry->product);
 
@@ -1238,7 +1238,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
 		quirks |= bl_entry->driver_data;
 
 	if (quirks)
-		dbg_hid("Found squirk 0x%lx for HID device 0x%hx:0x%hx\n",
+		dbg_hid("Found squirk 0x%lx for HID device 0x%x:0x%x\n",
 			quirks, hdev->vendor, hdev->product);
 	return quirks;
 }
-- 
2.20.1

