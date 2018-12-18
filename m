Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59130C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB8A218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba6STcNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbeLRSfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:35:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51464 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbeLRSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:35:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so3613448wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 10:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amuON1W5B6KrHHSGLUNGq2frpY8ho5Bv4GUjP7uCZ44=;
        b=Ba6STcNgYR652ZOJYvS5vuw1uC0cFSoVjm6rAPh76YPL5DZWWQz7zEaxJcSk6dIFls
         Q5pYXtpWPiL5CHrdRBtU6Ll/sCeF4xj2zHmlsudMP5hRBCO8d2+kK82Lt2KI1MAfo67f
         P2ELaBkCiyF+cltiIrr3GDfjGCYv0p6NJc+mFfWM/6CWpIFBAVz7t65NR6PZpDKsYese
         ST8CSEf0issIxFzbO8PyTcxLl2lIqH76XLggoYXkf5RuPWnPmZzGkZAAgQbwGMht/n+t
         Isql4eFFUdGJSYeZX05gn6VnSgLIp0PqAAqDRw5gIi5u0ZWH2thG9MCzuTPF7pvy74/D
         f1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amuON1W5B6KrHHSGLUNGq2frpY8ho5Bv4GUjP7uCZ44=;
        b=N31wZ5nxAIdHPbgI1kpuJ88x4fYoVG+sHICvblMFKux4PyLyTsuWOZojvYuDTcTjWW
         XEQH/X5kKYcFmaPXcXs5TOSftZEO8miLE/1b3O7xJ4HSCC+gU1bMB6/M5ZCBi/T7JgpS
         JusY+Yn/VCX70Waa/KaMMEZK7EnhwuE4xlVsFxG1QNzDyYj9BU/mKshsxggp2txhuXfj
         x/vS3Lynu0qAtcgerdSuHtuW7p07Zz04ab526J8H3P6LPQbMHw3FM4F5sojZz+PiHJum
         Vceb+uEv2NnWXoQCm2fsktxD1KoCPOtBJhI2rLHbbU4VFoZN39ujYFJPNpTBH/3j3yvR
         GPPQ==
X-Gm-Message-State: AA+aEWaaMjMX4fjnnUvR5vc5pigi27UbWrPVHxUR7N7MFrohIqpW4VEN
        JB83r9/yWy7IQ2zpTUzn5yo=
X-Google-Smtp-Source: AFSGD/XFxidrhlWFDPcoTTHXj3I1Fiu9jr7rJQrdDY2jrksvyCvLDu5fgCxDwXC+DmF6IwWSgutCcQ==
X-Received: by 2002:a1c:87cc:: with SMTP id j195mr4232623wmd.2.1545158122131;
        Tue, 18 Dec 2018 10:35:22 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id 202sm3614535wmt.8.2018.12.18.10.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:35:21 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 15/17] staging: rtl8188eu: change return type of is_basicrate() to bool
Date:   Tue, 18 Dec 2018 19:34:49 +0100
Message-Id: <20181218183451.18692-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218183451.18692-1-straube.linux@gmail.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is_basicrate() returns true or false, so change the
return type from int to bool.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index d18ce3a76c95..5f9c9de1f1da 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -156,7 +156,7 @@ static unsigned char ratetbl_val_2wifirate(unsigned char rate)
 	}
 }
 
-static int is_basicrate(struct adapter *padapter, unsigned char rate)
+static bool is_basicrate(struct adapter *padapter, unsigned char rate)
 {
 	int i;
 	unsigned char val;
-- 
2.20.1

