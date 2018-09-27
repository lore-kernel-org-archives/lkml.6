Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAD0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6DC208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7r4oUes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6DC208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeI0Gr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:47:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33085 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeI0Gr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:47:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id f10-v6so715426wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 17:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEmkM2VsRxigB4Wvtb0g5YNYP3tOA2zk6d2oSMVQHUw=;
        b=Y7r4oUesjLJlEuhu1eHYV62p6p4PaIHmimMe08e79gMO+bJubuTGTGgfnRrxOYx20J
         TUOM5zaZdRYu7M6l6znQESjsl2cEhm7OZQyDyRCsH03SbfO/aARfDsMmDlD2tJ9AFtfG
         64dsG5SCywB8xxo9uW5JQYGLVFOrTnXH1L7WAqGsDVK9fWH7IE7X/KPkaf+9/6xS9H3I
         hfHV4DfGVLLh7Z3Q7IU5VgFgKEj25d8LtGJIiyQInliDiNWsnHuMgfZ69iJOkVqH7EPZ
         Gyyx4y6WzqHABuaSZnzvJFhxGQ4Y7RFzuOsw/4d4iymMpxzQ7+iiLTiAZtle+ZNzb8kt
         pqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QEmkM2VsRxigB4Wvtb0g5YNYP3tOA2zk6d2oSMVQHUw=;
        b=hiuRuH/X0Z7HqPoPwVU+aqw94R+k/c2LDEr4O0VFJp14G6uJ5pKGf+aF70ut4yoIPf
         39l1jNbSg+oAZvcSmOznilJEVIsYX6nkV6tpBjP5VtTm/bk3MO76HvH+PnDWvL7PUksn
         Bu/qF7vWXkiLw462ceZc+YUIe/YSM4lOEP33cOG5Y5UEhDl1lzT9m5N+iBcUdaPpuVmu
         rmZ/+YyG8kz4v5H1hNWgdhOlz39/IFTN760DLD79JSayDGJrg9AuWDefCeU+4eSOrgKB
         AS9dTbSJUvyM2bfmCY6QTIeuuUP3/XekbS+RH+hePLgxBqLTYHcZG5D2sSkM51L3fbM2
         DSTg==
X-Gm-Message-State: ABuFfohidFpaqJuv8tj5RNeesKgN6THP5qBMDi1HS0bK9ro4MRDLTvgv
        hTwBHrnBQMk/qsv3z2Vdhzw=
X-Google-Smtp-Source: ACcGV61x3fWmGOQYH8E1bgM/UbYfbr/73BJQPu9Dj/w3ER5c5ztMjnWgGMhE4j/EYMGLj/v7QuacNg==
X-Received: by 2002:adf:e752:: with SMTP id c18-v6mr252487wrn.143.1538008345350;
        Wed, 26 Sep 2018 17:32:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b74-v6sm1547868wma.8.2018.09.26.17.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 17:32:24 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtl8188eu: Use proper enum in rtl8188eu_config_rf_reg
Date:   Wed, 26 Sep 2018 17:32:01 -0700
Message-Id: <20180927003201.29659-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when an enumerated type is implicitly converted to another.

drivers/staging/rtl8188eu/hal/rf_cfg.c:180:25: warning: implicit
conversion from enumeration type 'enum rf90_radio_path' to different
enumeration type 'enum rf_radio_path' [-Wenum-conversion]
        rtl_rfreg_delay(adapt, RF90_PATH_A, addr | maskforphyset,
        ~~~~~~~~~~~~~~~        ^~~~~~~~~~~
1 warning generated.

Avoid this by using the equivalent value from the expected type,
rf_radio_path:

RF90_PATH_A = RF_PATH_A = 0

Link: https://github.com/ClangBuiltLinux/linux/issues/164
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rf_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/rf_cfg.c b/drivers/staging/rtl8188eu/hal/rf_cfg.c
index 0700d8bd448d..02aeb12c9870 100644
--- a/drivers/staging/rtl8188eu/hal/rf_cfg.c
+++ b/drivers/staging/rtl8188eu/hal/rf_cfg.c
@@ -177,7 +177,7 @@ static void rtl8188e_config_rf_reg(struct adapter *adapt,
 	u32 content = 0x1000; /*RF Content: radio_a_txt*/
 	u32 maskforphyset = content & 0xE000;
 
-	rtl_rfreg_delay(adapt, RF90_PATH_A, addr | maskforphyset,
+	rtl_rfreg_delay(adapt, RF_PATH_A, addr | maskforphyset,
 			RFREG_OFFSET_MASK,
 			data);
 }
-- 
2.19.0

