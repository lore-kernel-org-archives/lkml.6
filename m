Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8CFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A3220827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebZooK1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A3220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeKFAht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:37:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43245 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbeKFAht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:37:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id g7-v6so2308776pfo.10;
        Mon, 05 Nov 2018 07:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XwpSaIuwiV66MBfVn/EfWwqxExuH378JZR7QWjpxJ+M=;
        b=ebZooK1dIaSQB72s/cyXDyOWpioKOFVgAqS+DQx43kOXZBKzTW3DShO1t9XtxYh8f8
         fGSoF73zLbCg9fE/pLau8PNFm1MYOLPwvvc/otiSmAIdtVxMqsTuD1R3iALZY4dEWosX
         P714VJra4mZ38K5uE1W7tmm+j4vqBR7rJkmlwUfOkUgeLM/s1Z9sDHernaGlOyKz7Jbs
         sDUaVQlaeBtu1di477M44XeONWs2aLfx834ldqJUM/LBt5ZvQ+thYY9oaPzNBEXvVii2
         zGONY6HYGljOMXKDIpdwzi77sGuEhPbHbrT8kc1N6CztUPT/zXKSIM+libCVfK+K3FvF
         YOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XwpSaIuwiV66MBfVn/EfWwqxExuH378JZR7QWjpxJ+M=;
        b=ikPStix5j922ymFYHJ+BXbUm42Kt/yVA3YOVWkWR1F2zxWwxiDk+ZXYs50V75zVJhT
         OIvy0yGUObViNmkMY4VZELlGRZ5Tepjl7S8TeBUlUupSDjcqbDbMpLrT3iI0T2hIFVoO
         y5d2mLD9aFamGwzyrjKB4oF590jbbgKNn3q4CEIFftxoM5Q+KWPwvd39m/txJ0Sr8fF4
         LFXPnnB3xy4pxlPN9n+EQfHSqE+MxncL/DQmjb4fGp8pfwfShGasDPGU9GB6znPC2cSu
         QbrfnAD3Ia4Yxhmukbj4gpYSIk9MC/IAyJ8fmyUMjZtaIDLq5fPKmJ0CdPwqypnfvDbu
         JwCQ==
X-Gm-Message-State: AGRZ1gKh4RatpZ4EbQhurH2ZZ22skoGqgxTW6LyOA5DMjbyNA88cvB8F
        RBz1+HpvUvOrmX3ZOI3yJ/M=
X-Google-Smtp-Source: AJdET5c8vWW+RjwWqx9d5O63JrBU+wFx0lpX9gNCJQCT8PNqh2a3hP20HCx5CFBLHEPtfTPFXfkptA==
X-Received: by 2002:a65:6447:: with SMTP id s7mr20300828pgv.226.1541431058105;
        Mon, 05 Nov 2018 07:17:38 -0800 (PST)
Received: from localhost.localdomain ([207.246.110.149])
        by smtp.gmail.com with ESMTPSA id 5-v6sm81736726pgt.83.2018.11.05.07.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 07:17:37 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] init/Kconfig: make CC_OPTIMIZE_FOR_DEBUGGING visible only for GCC
Date:   Mon,  5 Nov 2018 23:17:19 +0800
Message-Id: <20181105151719.4552-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CC_OPTIMIZE_FOR_DEBUGGING is only able to build with GCC.
For clang, -Og optimization level could break kernel build. So make
CC_OPTIMIZE_FOR_DEBUGGING visible only for GCC.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 0fb9c0b5f1a1..d5fb0ee1400a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1107,6 +1107,7 @@ config CC_OPTIMIZE_FOR_SIZE
 
 config CC_OPTIMIZE_FOR_DEBUGGING
 	bool "Optimize for better debugging experience (-Og)"
+	depends on CC_IS_GCC
 	depends on $(cc-option,-Og)
 	select NO_AUTO_INLINE
 	help
-- 
2.17.1

