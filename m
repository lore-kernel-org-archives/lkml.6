Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D125C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B6220824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHrqb2/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B6220824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbeKXH1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:27:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36828 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeKXH1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:27:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id s11so13066145wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4305aQZ2hYGUTvWB+m45+05Kk2AkdD0uOEyGH+Rrqnk=;
        b=NHrqb2/d/FEd5yBxfE0nl6XF5sAO0X2XsNwSi7o0OuWZk9jRPwcjA4XJd43JlP+HeD
         b+UKfgVtR7ZvtY9hk3uqo69IT6ZsIXPPHj6HzO+CRJ2dnl7j5QqYCQXf2JqAMdQDVe8T
         dgqvhXX6ly6ot/3o/hLjyv8ViCor3yfkKcoLujk4L+K0er0BJMWA/GCER7i+89OsarzK
         AyxIVqZQ0oXbKytr/yjT3yyxTstZ/Tf5VeUBR0BGBLrMLQsb94pCZEgYFxbquz1n3kvi
         47hmGo+3BQX9rVqSOLreDchytyTHmkEmWqL5qFycFWmQSS7Ld6YB4pIybU1Me5SB/c0H
         +oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4305aQZ2hYGUTvWB+m45+05Kk2AkdD0uOEyGH+Rrqnk=;
        b=lN3GQjWLErWWA7YDBR313AQVxtStS6/NCisvGG/cHU40r4/oJnPyF8qW/LdtNte0X2
         Jv9BRlI6/ZdjS9VlXihBLfCbKGnuFqJuzhWrp3h0+bG4BR2nlHDLjf094EduNYKdMqSH
         /bh8+/511nAtK9rT/YyBmUmm2AYdg1MJ3tYCZjh6nGRswElmXn3EkvpsTh5LQ+JeEQVp
         GgPSAwKd6UULOw9B9dhhLOJ2/9ohhXmtwXF7POcpbqg8yLhigRUCHjG0vOTrrRbu8Ft+
         nLktOOhzrbkYO5schbsjADDOq0Ybo33b79xY73OwvR2SI3WtSLWoijJsicuX2EEaM57x
         vzAA==
X-Gm-Message-State: AA+aEWZjEMh7r9cBvSsNXIch9M/hdS3MoDZ3ldnKhGdk+2y0+1F7l1BH
        PtEhBrLDGM6Uqnd/N1Mziz0MKMp2
X-Google-Smtp-Source: AJdET5cPynIjdCTZBzOBrfz6UV4D8r0hCPMoqjQv2cNzpxJYUcr0gafekxrOXLxvuAIE83y/szK1jw==
X-Received: by 2002:a1c:1dce:: with SMTP id d197mr15868493wmd.66.1543005685216;
        Fri, 23 Nov 2018 12:41:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id i9sm24598906wrs.34.2018.11.23.12.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 12:41:24 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/9] staging: rtl8188eu: correct indentation
Date:   Fri, 23 Nov 2018 21:41:05 +0100
Message-Id: <20181123204106.2284-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123204106.2284-1-straube.linux@gmail.com>
References: <20181123204106.2284-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct indentation to clear a checkpatch warning.
WARNING: suspect code indent for conditional statements (8, 24)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 824e3c669a46..b048a3b633a9 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -1739,7 +1739,7 @@ int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	ielength = 12;
 	if ((ndisauthmode == Ndis802_11AuthModeWPA) ||
 	    (ndisauthmode == Ndis802_11AuthModeWPAPSK))
-			authmode = _WPA_IE_ID_;
+		authmode = _WPA_IE_ID_;
 	if ((ndisauthmode == Ndis802_11AuthModeWPA2) ||
 	    (ndisauthmode == Ndis802_11AuthModeWPA2PSK))
 		authmode = _WPA2_IE_ID_;
-- 
2.19.2

