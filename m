Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE44C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2422620685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8XD+YiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2422620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeJaUMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:12:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52343 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeJaUMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:12:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so14723311wmw.2;
        Wed, 31 Oct 2018 04:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=tsgv3WQBZ2I6seLCRLLpO5OKzY9VtH1tw8lEKALvuP4=;
        b=P8XD+YiIfVkhSSw/zc8qa8DZQjIl9917TMcy1F+0JtRO53o8hBNicEa5UpayOZOFbM
         u6Eb0FeZ+DLxSmv0dpwrzEufM8c5G4cG5YByI9a12Gc3Sdiuerv6SdY5QZPenr8j3EnF
         4blcMTFr3ho9ToFyd5I2wPRQuxhJ8BIUB8DzVDpuU4JwpWanFpdFMftvHjY0W5MVETjC
         3P+rG8Wy11PFB9uSm5k4w5+KhNAE7twQcl6A7AY30HQZmk6mt9O/5HQzkb3ha1HANB4g
         +mTHXtDUG9slpgsYNDae0+XQGi3+wB1+9pEzSG8c6Q+RJ/SFktuHajFqcAEKixxfmX8d
         ymKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=tsgv3WQBZ2I6seLCRLLpO5OKzY9VtH1tw8lEKALvuP4=;
        b=AJjg2sRirKTHvYLVkphvmmg7+HoOqFqeBPDrysALuwsZtWRtI5R9TCHQu1zZArGNte
         fGCROYuggXyWhIj01bPG8Zha7bX+n8jH3uknfNlAv8GzBL5XbER/NbA8SN8/Sm4ElLAQ
         4sfaHbJt055TmT4GpM+VZuvhHmgXbt59+xVaQNzonaDwJ0osq3g3DE+1ow9kjbe1hEHu
         eMHXbk+3cN2X3vTP8MKw4ea0q75vxMp8zqUDeDaCuXjdrgNd/GH5fcqy5CN24FgjLMvI
         +A1shhfXAZEfvv0eLmp5kg/C5l1sX3MIQ/99hcB/+2Kbq7/sN989OuYXicIIxV1ACvRS
         CY0Q==
X-Gm-Message-State: AGRZ1gLr99XvwracfigiSL0D2+wtY6uCscHwl8DfqKmy2DNnfBXmzYxJ
        cdZKsjvDXIqTNT8xX3VOjU0u+NeR
X-Google-Smtp-Source: AJdET5coNgYIj3kLylS4eFhw4KtjsO09QsBFXDLTEaaeLnuhcsAic2PNyU0Ea4C7RApfTztuMAdyEg==
X-Received: by 2002:a1c:7815:: with SMTP id t21-v6mr2129040wmc.13.1540984503275;
        Wed, 31 Oct 2018 04:15:03 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id m2-v6sm22950937wrj.80.2018.10.31.04.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 04:15:02 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id D9A66114230D; Wed, 31 Oct 2018 12:15:00 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remove old GCC version implementation
Date:   Wed, 31 Oct 2018 12:14:43 +0100
Message-Id: <20181031111444.3472-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 4.6 is the minimum supported now.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 scripts/mod/file2alias.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 28a61665bb9c..4b59564d4706 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -83,11 +83,7 @@ extern struct devtable *__start___devtable[], *__stop___devtable[];
 #endif /* __MACH__ */
 
 #if !defined(__used)
-# if __GNUC__ == 3 && __GNUC_MINOR__ < 3
-#  define __used			__attribute__((__unused__))
-# else
-#  define __used			__attribute__((__used__))
-# endif
+#define __used			__attribute__((__used__))
 #endif
 
 /* Define a variable f that holds the value of field f of struct devid
-- 
2.11.0

